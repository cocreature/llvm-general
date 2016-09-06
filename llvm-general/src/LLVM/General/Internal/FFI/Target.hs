{-# LANGUAGE
  ForeignFunctionInterface,
  GeneralizedNewtypeDeriving
  #-}
module LLVM.General.Internal.FFI.Target where

import Foreign.Ptr
import Foreign.C

import LLVM.General.Internal.FFI.LLVMCTypes
import LLVM.General.Internal.FFI.Module
import LLVM.General.Internal.FFI.RawOStream

data Target

data TargetOptions

data TargetMachine

data TargetLowering

data TargetLibraryInfo

foreign import ccall unsafe "LLVM_General_GetLibFunc" getLibFunc ::
  Ptr TargetLibraryInfo -> CString -> Ptr LibFunc -> IO LLVMBool
