{-# LANGUAGE
  ForeignFunctionInterface
  #-}

-- | Functions to read and write LLVM bitcode
module LLVM.General.Internal.FFI.Bitcode where

import LLVM.General.Internal.FFI.RawOStream
import LLVM.General.Internal.FFI.Context 
import LLVM.General.Internal.FFI.MemoryBuffer
import LLVM.General.Internal.FFI.Module
import LLVM.General.Internal.FFI.LLVMCTypes

import Foreign.C
import Foreign.Ptr

parseBitcode :: Ptr Context -> Ptr MemoryBuffer -> Ptr (OwnerTransfered CString) -> IO (Ptr Module)
parseBitcode = undefined

writeBitcode :: Ptr Module -> Ptr RawOStream -> IO ()
writeBitcode = undefined



