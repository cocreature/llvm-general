{-# LANGUAGE
  ForeignFunctionInterface
  #-}
module LLVM.General.Internal.FFI.RawOStream where

import Foreign.Ptr
import Foreign.C
import LLVM.General.Internal.FFI.LLVMCTypes

data RawOStream
data RawPWriteStream

type RawOStreamCallback = Ptr RawOStream -> IO ()
type ByteRangeCallback = Ptr CChar -> CSize -> IO ()

withFileRawOStream :: CString -> LLVMBool -> LLVMBool -> Ptr (OwnerTransfered CString) -> RawOStreamCallback -> IO LLVMBool
withFileRawOStream p ex bin err c = undefined

withBufferRawOStream :: ByteRangeCallback -> RawOStreamCallback -> IO ()
withBufferRawOStream oc c = undefined
