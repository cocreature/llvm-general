{-# LANGUAGE
  ForeignFunctionInterface
  #-}

module LLVM.General.Internal.FFI.DataLayout where

import Foreign.C.String
import Foreign.Ptr

import LLVM.General.Internal.FFI.LLVMCTypes

data DataLayout

-- Oooh those wacky LLVM C-API coders: C API called DataLayout TargetData.
-- Great. Just great.

createDataLayout :: CString -> IO (Ptr DataLayout)
createDataLayout = undefined

disposeDataLayout :: Ptr DataLayout -> IO ()
disposeDataLayout = undefined

dataLayoutToString :: Ptr DataLayout -> IO (OwnerTransfered CString)
dataLayoutToString = undefined
