{-# LANGUAGE
  GeneralizedNewtypeDeriving
  #-}
-- | Define types which correspond cleanly with some simple types on the C/C++ side.
-- Encapsulate hsc macro weirdness here, supporting higher-level tricks elsewhere.
module LLVM.General.Internal.FFI.LLVMCTypes where

import LLVM.General.Prelude

#define __STDC_LIMIT_MACROS
#include "llvm-c/Core.h"
#include "llvm-c/Target.h"
#include "llvm-c/TargetMachine.h"
#include "llvm-c/Linker.h"
#include "LLVM/General/Internal/FFI/SMDiagnostic.h"
#include "LLVM/General/Internal/FFI/Target.h"
#include "LLVM/General/Internal/FFI/CallingConvention.h"
#include "LLVM/General/Internal/FFI/GlobalValue.h"
#include "LLVM/General/Internal/FFI/Type.h"
#include "LLVM/General/Internal/FFI/Module.h"
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

newtype Linkage = Linkage CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define LK_Rec(n) { #n, LLVM ## n ## Linkage },
#{inject LINKAGE, Linkage, Linkage, linkage, LK_Rec}

newtype Visibility = Visibility CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define VIS_Rec(n) { #n, LLVM ## n ## Visibility },
#{inject VISIBILITY, Visibility, Visibility, visibility, VIS_Rec}

newtype COMDATSelectionKind = COMDATSelectionKind CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define CSK(n) { #n, LLVM_General_COMDAT_Selection_Kind_ ## n },
#{inject COMDAT_SELECTION_KIND, COMDATSelectionKind, COMDATSelectionKind, comdatSelectionKind, CSK}

newtype DLLStorageClass = DLLStorageClass CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define DLLSC_Rec(n) { #n, LLVM ## n ## StorageClass },
#{inject DLL_STORAGE_CLASS, DLLStorageClass, DLLStorageClass, dllStorageClass, DLLSC_Rec}

newtype CallingConvention = CallingConvention CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define CC_Rec(l, n) { #l, LLVM_General_CallingConvention_ ## l },
#{inject CALLING_CONVENTION, CallingConvention, CallingConvention, callingConvention, CC_Rec}

newtype ThreadLocalMode = ThreadLocalMode CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define TLS_Rec(n) { #n, LLVM ## n },
#{inject THREAD_LOCAL_MODE, ThreadLocalMode, ThreadLocalMode, threadLocalMode, TLS_Rec}

newtype DiagnosticKind = DiagnosticKind CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define DK_Rec(n) { #n, LLVMDiagnosticKind ## n },
#{inject DIAGNOSTIC_KIND, DiagnosticKind, DiagnosticKind, diagnosticKind, DK_Rec}

newtype RelocModel = RelocModel CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define RM_Rec(n,m) { #n, LLVMReloc ## n },
#{inject RELOC_MODEL, RelocModel, RelocModel, relocModel, RM_Rec}

newtype CodeModel = CodeModel CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define CM_Rec(n) { #n, LLVMCodeModel ## n },
#{inject CODE_MODEL, CodeModel, CodeModel, codeModel, CM_Rec}

newtype CodeGenOptLevel = CodeGenOptLevel CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define CGOL_Rec(n) { #n, LLVMCodeGenLevel ## n },
#{inject CODE_GEN_OPT_LEVEL, CodeGenOptLevel, CodeGenOptLevel, codeGenOptLevel, CGOL_Rec}

newtype CodeGenFileType = CodeGenFileType CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define CGFT_Rec(n) { #n, LLVM ## n ## File },
#{inject CODE_GEN_FILE_TYPE, CodeGenFileType, CodeGenFileType, codeGenFileType, CGFT_Rec}

newtype FloatABIType = FloatABIType CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define FAT_Rec(n) { #n, LLVM_General_FloatABI_ ## n },
#{inject FLOAT_ABI, FloatABIType, FloatABIType, floatABI, FAT_Rec}

newtype FPOpFusionMode = FPOpFusionMode CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define FPOFM_Rec(n) { #n, LLVM_General_FPOpFusionMode_ ## n },
#{inject FP_OP_FUSION_MODE, FPOpFusionMode, FPOpFusionMode, fpOpFusionMode, FPOFM_Rec}

newtype TargetOptionFlag = TargetOptionFlag CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define TOF_Rec(n) { #n, LLVM_General_TargetOptionFlag_ ## n },
#{inject TARGET_OPTION_FLAG, TargetOptionFlag, TargetOptionFlag, targetOptionFlag, TOF_Rec}

newtype TypeKind = TypeKind CUInt
  deriving (Eq, Read, Show, Typeable, Data)
#define TK_Rec(n) { #n, LLVM ## n ## TypeKind },
#{inject TYPE_KIND, TypeKind, TypeKind, typeKind, TK_Rec}

#define COMMA ,
#define IF_T(z) z
#define IF_F(z)
#define IF2(x) IF_ ## x
#define IF(x) IF2(x)
#define OR_TT T
#define OR_TF T
#define OR_FT T
#define OR_FF F  
#define OR(x,y) OR_ ## x ## y

newtype LinkerMode = LinkerMode CUInt
  deriving (Eq, Read, Show, Bits, Typeable, Data, Num)
#define LM_Rec(n) { #n, LLVMLinker ## n },
#{inject LINKER_MODE, LinkerMode, LinkerMode, linkerMode, LM_Rec}

newtype LibFunc = LibFunc CUInt
  deriving (Eq, Read, Show, Bits, Typeable, Data, Num, Storable)
#define LF_Rec(n) { #n, LLVMLibFunc__ ## n },
#{inject LIB_FUNC, LibFunc, LibFunc, libFunc__, LF_Rec}
