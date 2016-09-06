{-# LANGUAGE
  ForeignFunctionInterface
  #-}
module LLVM.General.Internal.FFI.MemoryBuffer where

import Foreign.Ptr
import Foreign.C

import LLVM.General.Internal.FFI.LLVMCTypes

data MemoryBuffer
