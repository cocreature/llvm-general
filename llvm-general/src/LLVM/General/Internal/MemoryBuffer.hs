{-# LANGUAGE
  MultiParamTypeClasses,
  UndecidableInstances
  #-}
module LLVM.General.Internal.MemoryBuffer where

import Control.Monad
import Control.Exception
import Control.Monad.AnyCont
import Control.Monad.Error.Class
import Control.Monad.IO.Class
import qualified Data.ByteString as BS
import qualified Data.ByteString.Unsafe as BS
import Foreign.Ptr

import LLVM.General.Internal.Coding
import LLVM.General.Internal.String
import LLVM.General.Internal.Inject
import qualified LLVM.General.Internal.FFI.LLVMCTypes as FFI
import qualified LLVM.General.Internal.FFI.MemoryBuffer as FFI

data Specification 
  = Bytes { name :: String,  content :: BS.ByteString }
  | File { pathName :: String }

instance (Inject String e, MonadError e m, Monad m, MonadIO m, MonadAnyCont IO m) => EncodeM m Specification (FFI.OwnerTransfered (Ptr FFI.MemoryBuffer)) where
  encodeM spec = undefined  

instance (Inject String e, MonadError e m, Monad m, MonadIO m, MonadAnyCont IO m) => EncodeM m Specification (Ptr FFI.MemoryBuffer) where
  encodeM spec = undefined

instance MonadIO d => DecodeM d BS.ByteString (Ptr FFI.MemoryBuffer) where
  decodeM p = undefined

instance MonadIO d => DecodeM d String (Ptr FFI.MemoryBuffer) where
  decodeM = decodeM . UTF8ByteString <=< decodeM
