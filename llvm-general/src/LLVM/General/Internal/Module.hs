{-#
  LANGUAGE
  TemplateHaskell,
  ScopedTypeVariables,
  MultiParamTypeClasses
  #-}
-- | This Haskell module is for/of functions for handling LLVM modules.
module LLVM.General.Internal.Module where

import LLVM.General.Prelude

import Control.Exception
import Control.Monad.AnyCont
import Control.Monad.Error.Class
import Control.Monad.Trans.Except
import Control.Monad.Trans

import Foreign.Ptr
import Foreign.C
import Data.IORef
import qualified Data.ByteString as BS

import qualified LLVM.General.Internal.FFI.Assembly as FFI
import qualified LLVM.General.Internal.FFI.Bitcode as FFI
import qualified LLVM.General.Internal.FFI.LLVMCTypes as FFI
import qualified LLVM.General.Internal.FFI.MemoryBuffer as FFI
import qualified LLVM.General.Internal.FFI.Module as FFI
import qualified LLVM.General.Internal.FFI.RawOStream as FFI
import qualified LLVM.General.Internal.FFI.Target as FFI

import LLVM.General.Internal.Coding
import LLVM.General.Internal.Context
import LLVM.General.Internal.EncodeAST
import LLVM.General.Internal.Inject
import qualified LLVM.General.Internal.MemoryBuffer as MB
import LLVM.General.Internal.RawOStream
import LLVM.General.Internal.String
import LLVM.General.Internal.Target

import LLVM.General.DataLayout

import qualified LLVM.General.AST.DataLayout as A

-- | <http://llvm.org/doxygen/classllvm_1_1Module.html>
newtype Module = Module (Ptr FFI.Module)

-- | A newtype to distinguish strings used for paths from other strings
newtype File = File FilePath
  deriving (Eq, Ord, Read, Show)

genCodingInstance [t| Bool |] ''FFI.LinkerMode [
  (FFI.linkerModeDestroySource, False)
 ]

-- | link LLVM modules - move or copy parts of a source module into a destination module.
-- Note that this operation is not commutative - not only concretely (e.g. the destination module
-- is modified, becoming the result) but abstractly (e.g. unused private globals in the source
-- module do not appear in the result, but similar globals in the destination remain).
linkModules ::
  Bool -- ^ True to leave the right module unmodified, False to cannibalize it (for efficiency's sake).
  -> Module -- ^ The module into which to link
  -> Module -- ^ The module to link into the other (and cannibalize or not)
  -> ExceptT String IO ()
linkModules preserveRight (Module m) (Module m') = flip runAnyContT return $ do
  preserveRight <- encodeM preserveRight
  msgPtr <- alloca
  result <- decodeM =<< (liftIO $ FFI.linkModules m m' preserveRight msgPtr)
  when result $ throwError =<< decodeM msgPtr

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
  msgPtr <- alloca
  m <- anyContToM $ bracket (FFI.parseLLVMAssembly c mb msgPtr) FFI.disposeModule
  when (m == nullPtr) $ throwError =<< decodeM msgPtr
  liftIO $ f (Module m)

-- | generate LLVM assembly from a 'Module'
moduleLLVMAssembly :: Module -> IO String
moduleLLVMAssembly (Module m) = do
  resultRef <- newIORef Nothing
  let saveBuffer :: Ptr CChar -> CSize -> IO ()
      saveBuffer start size = do
        r <- decodeM (start, fromIntegral size)
        writeIORef resultRef (Just r)
  FFI.withBufferRawOStream saveBuffer $ FFI.writeLLVMAssembly m
  Just s <- readIORef resultRef
  return s

-- | write LLVM assembly for a 'Module' to a file
writeLLVMAssemblyToFile :: File -> Module -> ExceptT String IO ()
writeLLVMAssemblyToFile (File path) (Module m) = flip runAnyContT return $ do
  withFileRawOStream path False True $ liftIO . FFI.writeLLVMAssembly m

class BitcodeInput b where
  bitcodeMemoryBuffer :: (Inject String e, MonadError e m, MonadIO m, MonadAnyCont IO m)
                         => b -> m (Ptr FFI.MemoryBuffer)

instance BitcodeInput (String, BS.ByteString) where
  bitcodeMemoryBuffer (s, bs) = encodeM (MB.Bytes s bs)

instance BitcodeInput File where
  bitcodeMemoryBuffer (File p) = encodeM (MB.File p)

-- | parse 'Module' from LLVM bitcode
withModuleFromBitcode :: BitcodeInput b => Context -> b -> (Module -> IO a) -> ExceptT String IO a
withModuleFromBitcode (Context c) b f = flip runAnyContT return $ do
  mb <- bitcodeMemoryBuffer b
  msgPtr <- alloca
  m <- anyContToM $ bracket (FFI.parseBitcode c mb msgPtr) FFI.disposeModule
  when (m == nullPtr) $ throwError =<< decodeM msgPtr
  liftIO $ f (Module m)

-- | generate LLVM bitcode from a 'Module'
moduleBitcode :: Module -> IO BS.ByteString
moduleBitcode (Module m) = do
  r <- runExceptT $ withBufferRawOStream (liftIO . FFI.writeBitcode m)
  either fail return r

-- | write LLVM bitcode from a 'Module' into a file
writeBitcodeToFile :: File -> Module -> ExceptT String IO ()
writeBitcodeToFile (File path) (Module m) = flip runAnyContT return $ do
  withFileRawOStream path False False $ liftIO . FFI.writeBitcode m

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

setTargetTriple :: Ptr FFI.Module -> String -> EncodeAST ()
setTargetTriple m t = do
  t <- encodeM t
  liftIO $ FFI.setTargetTriple m t

getTargetTriple :: Ptr FFI.Module -> IO (Maybe String)
getTargetTriple m = do
  s <- decodeM =<< liftIO (FFI.getTargetTriple m)
  return $ if s == "" then Nothing else Just s

setDataLayout :: Ptr FFI.Module -> A.DataLayout -> EncodeAST ()
setDataLayout m dl = do
  s <- encodeM (dataLayoutToString dl)
  liftIO $ FFI.setDataLayout m s

getDataLayout :: Ptr FFI.Module -> IO (Maybe A.DataLayout)
getDataLayout m = do
  dlString <- decodeM =<< FFI.getDataLayout m
  either fail return . runExcept . parseDataLayout A.BigEndian $ dlString
