{-# LANGUAGE GeneralizedNewtypeDeriving #-}
-- | Define types which correspond cleanly with some simple types on the C/C++ side.
-- Encapsulate hsc macro weirdness here, supporting higher-level tricks elsewhere.
module LLVM.General.Internal.FFI.LLVMCTypes where

import Data.Data


import Language.Haskell.TH.Quote

import Data.Bits
import Foreign.C
import Foreign.Storable

deriving instance Data CUInt

newtype LLVMBool = LLVMBool CUInt

newtype OwnerTransfered a = OwnerTransfered a
  deriving (Storable)

newtype NothingAsMinusOne h = NothingAsMinusOne CInt
  deriving (Storable)

newtype NothingAsEmptyString c = NothingAsEmptyString c
  deriving (Storable)

newtype CPPOpcode = CPPOpcode CUInt
  deriving (Eq, Ord, Show, Typeable, Data)

newtype MDKindID = MDKindID CUInt
  deriving (Storable)

newtype FloatABIType = FloatABIType CUInt
  deriving (Eq, Read, Show, Typeable, Data)

floatABIDefault :: FloatABIType
floatABIDefault = FloatABIType 0
floatABISoft :: FloatABIType
floatABISoft = FloatABIType 1
floatABIHard :: FloatABIType
floatABIHard = FloatABIType 2
floatABIP = QuasiQuoter {
  quoteExp = undefined,
  quotePat = \s -> dataToPatQ (const Nothing) $ case s of
    "Default" -> floatABIDefault
    "Soft" -> floatABISoft
    "Hard" -> floatABIHard
    x -> error $ "bad quasiquoted FFI constant for floatABI: " ++ x,
  quoteType = undefined,
  quoteDec = undefined
 }

newtype LibFunc = LibFunc CUInt
  deriving (Eq, Read, Show, Bits, Typeable, Data, Num, Storable)
