{-# LANGUAGE
  GeneralizedNewtypeDeriving
  #-}
-- | Define types which correspond cleanly with some simple types on the C/C++ side.
-- Encapsulate hsc macro weirdness here, supporting higher-level tricks elsewhere.
module LLVM.General.Internal.FFI.LLVMCTypes where

import Data.Data

#define __STDC_LIMIT_MACROS
#include "llvm-c/Core.h"
#include "llvm-c/Target.h"
#include "llvm-c/TargetMachine.h"
#include "llvm-c/Linker.h"
#include "LLVM/General/Internal/FFI/Target.h"
#include "LLVM/General/Internal/FFI/LibFunc.h"

import Language.Haskell.TH.Quote

import Data.Bits
import Foreign.C
import Foreign.Storable

#{
define hsc_inject(l, typ, cons, hprefix, recmac) { \
  struct { const char *s; unsigned n; } *p, list[] = { LLVM_GENERAL_FOR_EACH_ ## l(recmac) }; \
  for(p = list; p < list + sizeof(list)/sizeof(list[0]); ++p) { \
    hsc_printf(#hprefix "%s :: " #typ "\n", p->s); \
    hsc_printf(#hprefix "%s = " #cons " %u\n", p->s, p->n); \
  } \
  hsc_printf(#hprefix "P = QuasiQuoter {\n" \
             "  quoteExp = undefined,\n" \
             "  quotePat = \\s -> dataToPatQ (const Nothing) $ case s of"); \
  for(p = list; p < list + sizeof(list)/sizeof(list[0]); ++p) { \
    hsc_printf("\n    \"%s\" -> " #hprefix "%s", p->s, p->s); \
  } \
  hsc_printf("\n    x -> error $ \"bad quasiquoted FFI constant for " #hprefix ": \" ++ x"); \
  hsc_printf(",\n" \
             "  quoteType = undefined,\n" \
             "  quoteDec = undefined\n" \
             " }\n"); \
} 
}

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

newtype ICmpPredicate = ICmpPredicate CUInt
  deriving (Eq, Ord, Show, Typeable, Data)
#{enum ICmpPredicate, ICmpPredicate,
 iCmpPredEQ = LLVMIntEQ,
 iCmpPredNE = LLVMIntNE,
 iCmpPredUGT = LLVMIntUGT,
 iCmpPredUGE = LLVMIntUGE,
 iCmpPredULT = LLVMIntULT,
 iCmpPredULE = LLVMIntULE,
 iCmpPredSGT = LLVMIntSGT,
 iCmpPredSGE = LLVMIntSGE,
 iCmpPredSLT = LLVMIntSLT,
 iCmpPredSLE = LLVMIntSLE
}

newtype FCmpPredicate = FCmpPredicate CUInt
  deriving (Eq, Ord, Show, Typeable, Data)
#{enum FCmpPredicate, FCmpPredicate,
 fCmpPredFalse = LLVMRealPredicateFalse,
 fCmpPredOEQ = LLVMRealOEQ,
 fCmpPredOGT = LLVMRealOGT,
 fCmpPredOGE = LLVMRealOGE,
 fCmpPredOLT = LLVMRealOLT,
 fCmpPredOLE = LLVMRealOLE,
 fCmpPredONE = LLVMRealONE,
 fCmpPredORD = LLVMRealORD,
 fCmpPredUNO = LLVMRealUNO,
 fCmpPredUEQ = LLVMRealUEQ,
 fCmpPredUGT = LLVMRealUGT,
 fCmpPredUGE = LLVMRealUGE,
 fCmpPredULT = LLVMRealULT,
 fCmpPredULE = LLVMRealULE,
 fCmpPredUNE = LLVMRealUNE,
 fcmpPredTrue = LLVMRealPredicateTrue
}

newtype MDKindID = MDKindID CUInt
  deriving (Storable)

newtype FloatABIType = FloatABIType CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define FAT_Rec(n) { #n, LLVM_General_FloatABI_ ## n },
#{inject FLOAT_ABI, FloatABIType, FloatABIType, floatABI, FAT_Rec}

newtype LibFunc = LibFunc CUInt
  deriving (Eq, Read, Show, Bits, Typeable, Data, Num, Storable)
#define LF_Rec(n) { #n, LLVMLibFunc__ ## n },
#{inject LIB_FUNC, LibFunc, LibFunc, libFunc__, LF_Rec}
