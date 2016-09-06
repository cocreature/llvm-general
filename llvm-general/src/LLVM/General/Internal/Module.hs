{-#
  LANGUAGE
  TemplateHaskell,
  ScopedTypeVariables,
  MultiParamTypeClasses
  #-}
-- | This Haskell module is for/of functions for handling LLVM modules.
module LLVM.General.Internal.Module where

import Control.Exception
import Control.Monad.AnyCont
import Control.Monad.Error.Class
import Control.Monad.Trans.Except
import Control.Monad.Trans

import Foreign.Ptr

import qualified LLVM.General.Internal.FFI.LLVMCTypes as FFI
import qualified LLVM.General.Internal.FFI.MemoryBuffer as FFI
import qualified LLVM.General.Internal.FFI.Module as FFI

import LLVM.General.Internal.Coding
import LLVM.General.Internal.Context
import LLVM.General.Internal.Inject
import qualified LLVM.General.Internal.MemoryBuffer as MB
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

getTargetTriple :: Ptr FFI.Module -> IO (Maybe String)
getTargetTriple m = do
  s <- decodeM =<< liftIO (FFI.getTargetTriple m)
  return $ if s == "" then Nothing else Just s
