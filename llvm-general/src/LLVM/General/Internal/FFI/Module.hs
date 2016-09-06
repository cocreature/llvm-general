{-# LANGUAGE
  ForeignFunctionInterface
  #-}
module LLVM.General.Internal.FFI.Module where

import Foreign.Ptr
import Foreign.C

data Module

disposeModule :: Ptr Module -> IO ()
disposeModule = undefined

getTargetTriple :: Ptr Module -> IO CString
getTargetTriple = undefined
