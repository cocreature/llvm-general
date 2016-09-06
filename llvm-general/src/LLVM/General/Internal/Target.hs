{-# LANGUAGE
  TemplateHaskell,
  MultiParamTypeClasses,
  RecordWildCards,
  UndecidableInstances
  #-}
module LLVM.General.Internal.Target where

import Control.Monad
import Control.Monad.AnyCont
import Control.Monad.IO.Class

import Foreign.Ptr
import Foreign.C.String

import LLVM.General.Internal.Coding
import LLVM.General.Internal.String ()
import LLVM.General.Internal.LibraryFunction

import qualified LLVM.General.Internal.FFI.LLVMCTypes as FFI
import qualified LLVM.General.Internal.FFI.Target as FFI

import qualified LLVM.General.Target.Options as TO

genCodingInstance [t| TO.FloatABI |] ''FFI.FloatABIType [
  (FFI.floatABIDefault, TO.FloatABIDefault),
  (FFI.floatABISoft, TO.FloatABISoft),
  (FFI.floatABIHard, TO.FloatABIHard)
 ]

-- | <http://llvm.org/doxygen/classllvm_1_1Target.html>
newtype Target = Target (Ptr FFI.Target)

-- | e.g. an instruction set extension
newtype CPUFeature = CPUFeature String
  deriving (Eq, Ord, Read, Show)
                       
-- | <http://llvm.org/doxygen/classllvm_1_1TargetMachine.html>
newtype TargetMachine = TargetMachine (Ptr FFI.TargetMachine)

-- | <http://llvm.org/docs/doxygen/html/classllvm_1_1TargetLibraryInfo.html>
newtype TargetLibraryInfo = TargetLibraryInfo (Ptr FFI.TargetLibraryInfo)

-- | Look up a 'LibraryFunction' by its standard name
getLibraryFunction :: TargetLibraryInfo -> String -> IO (Maybe LibraryFunction)
getLibraryFunction (TargetLibraryInfo f) name = flip runAnyContT return $ do
  libFuncP <- alloca :: AnyContT IO (Ptr FFI.LibFunc)
  name <- (encodeM name :: AnyContT IO CString)
  r <- decodeM =<< (liftIO $ FFI.getLibFunc f name libFuncP)
  forM (if r then Just libFuncP else Nothing) $ decodeM <=< peek
