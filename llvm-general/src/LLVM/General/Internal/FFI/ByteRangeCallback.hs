{-# LANGUAGE
  ForeignFunctionInterface
  #-}
module LLVM.General.Internal.FFI.ByteRangeCallback where

import Foreign.C
import Foreign.Ptr

type ByteRangeCallback = Ptr CChar -> CSize -> IO ()
foreign import ccall "wrapper" wrapByteRangeCallback :: 
  ByteRangeCallback -> IO (FunPtr ByteRangeCallback)

