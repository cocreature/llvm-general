{-# LANGUAGE
  ForeignFunctionInterface
  #-}
module LLVM.General.Internal.FFI.Module where

import Foreign.Ptr
import Foreign.C

import LLVM.General.Internal.FFI.Context
import LLVM.General.Internal.FFI.LLVMCTypes
import LLVM.General.Internal.FFI.PtrHierarchy

data Module

disposeModule :: Ptr Module -> IO ()
disposeModule = undefined

getTargetTriple :: Ptr Module -> IO CString
getTargetTriple = undefined
