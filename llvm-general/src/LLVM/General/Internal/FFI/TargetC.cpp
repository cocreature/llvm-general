#define __STDC_LIMIT_MACROS
#include "llvm-c/Target.h"
#include "LLVM/General/Internal/FFI/LibFunc.h"
#include "LLVM/General/Internal/FFI/Target.h"
#include "llvm-c/Core.h"
#include "llvm-c/TargetMachine.h"
#include "llvm/ADT/Triple.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/ExecutionEngine/Interpreter.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/FormattedStream.h"
#include "llvm/Support/Host.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Target/TargetMachine.h"

using namespace llvm;

extern "C" {
LLVMBool LLVM_General_GetLibFunc(
	LLVMTargetLibraryInfoRef l,
	const char *funcName,
	LLVMLibFunc *f
) {
    return false;
}

}
