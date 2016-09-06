{-#
  LANGUAGE
  TemplateHaskell,
  ScopedTypeVariables,
  MultiParamTypeClasses
  #-}
-- | This Haskell module is for/of functions for handling LLVM modules.
module LLVM.General.Internal.Module where

import Control.Monad
import Control.Exception
import Control.Monad.AnyCont
import Control.Monad.Error.Class
import Control.Monad.Trans.Except
import Control.Monad.Trans

import Foreign.Ptr
import Foreign.C
import Data.IORef
import qualified Data.ByteString as BS

import qualified LLVM.General.Internal.FFI.Bitcode as FFI
import qualified LLVM.General.Internal.FFI.LLVMCTypes as FFI
import qualified LLVM.General.Internal.FFI.MemoryBuffer as FFI
import qualified LLVM.General.Internal.FFI.Module as FFI
import qualified LLVM.General.Internal.FFI.RawOStream as FFI
import qualified LLVM.General.Internal.FFI.Target as FFI

import LLVM.General.Internal.Coding
import LLVM.General.Internal.Context
import LLVM.General.Internal.Inject
import qualified LLVM.General.Internal.MemoryBuffer as MB
import LLVM.General.Internal.RawOStream
import LLVM.General.Internal.String
import LLVM.General.Internal.Target

-- | <http://llvm.org/doxygen/classllvm_1_1Module.html>
newtype Module = Module (Ptr FFI.Module)

-- | A newtype to distinguish strings used for paths from other strings
newtype File = File FilePath
  deriving (Eq, Ord, Read, Show)

class LLVMAssemblyInput s where
  llvmAssemblyMemoryBuffer :: (Inject String e, MonadError e m, MonadIO m, MonadAnyCont IO m)
                              => s -> m (FFI.OwnerTransfered (Ptr FFI.MemoryBuffer))

instance LLVMAssemblyInput (String, String) where
  llvmAssemblyMemoryBuffer (id, s) = do
    UTF8ByteString bs <- encodeM s
    encodeM (MB.Bytes id bs)

instance LLVMAssemblyInput String where
  llvmAssemblyMemoryBuffer s = llvmAssemblyMemoryBuffer ("<string>", s)

instance LLVMAssemblyInput File where
  llvmAssemblyMemoryBuffer (File p) = encodeM (MB.File p)

-- | parse 'Module' from LLVM assembly
withModuleFromLLVMAssembly :: LLVMAssemblyInput s
                              => Context -> s -> (Module -> IO a) -> ExceptT String IO a
withModuleFromLLVMAssembly (Context c) s f = flip runAnyContT return $ do
  mb <- llvmAssemblyMemoryBuffer s
  m <- anyContToM $ bracket undefined FFI.disposeModule
  liftIO $ f (Module m)

targetMachineEmit :: FFI.CodeGenFileType -> TargetMachine -> Module -> Ptr FFI.RawPWriteStream -> ExceptT String IO ()
targetMachineEmit fileType (TargetMachine tm) (Module m) os = flip runAnyContT return $ do
  msgPtr <- alloca
  r <- decodeM =<< (liftIO $ FFI.targetMachineEmit tm m fileType msgPtr os)
  when r $ throwError =<< decodeM msgPtr

emitToFile :: FFI.CodeGenFileType -> TargetMachine -> File -> Module -> ExceptT String IO ()
emitToFile fileType tm (File path) m = flip runAnyContT return $ do
  withFileRawPWriteStream path False False $ targetMachineEmit fileType tm m

emitToByteString :: FFI.CodeGenFileType -> TargetMachine -> Module -> ExceptT String IO BS.ByteString
emitToByteString fileType tm m = flip runAnyContT return $ do
  withBufferRawPWriteStream $ targetMachineEmit fileType tm m

-- | write target-specific assembly directly into a file
writeTargetAssemblyToFile :: TargetMachine -> File -> Module -> ExceptT String IO ()
writeTargetAssemblyToFile = emitToFile FFI.codeGenFileTypeAssembly

-- | produce target-specific assembly as a 'String'
moduleTargetAssembly :: TargetMachine -> Module -> ExceptT String IO String
moduleTargetAssembly tm m = decodeM . UTF8ByteString =<< emitToByteString FFI.codeGenFileTypeAssembly tm m

-- | produce target-specific object code as a 'ByteString'
moduleObject :: TargetMachine -> Module -> ExceptT String IO BS.ByteString
moduleObject = emitToByteString FFI.codeGenFileTypeObject

-- | write target-specific object code directly into a file
writeObjectToFile :: TargetMachine -> File -> Module -> ExceptT String IO ()
writeObjectToFile = emitToFile FFI.codeGenFileTypeObject

getTargetTriple :: Ptr FFI.Module -> IO (Maybe String)
getTargetTriple m = do
  s <- decodeM =<< liftIO (FFI.getTargetTriple m)
  return $ if s == "" then Nothing else Just s
