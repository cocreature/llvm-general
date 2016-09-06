-- | Relocations, used in specifying TargetMachine
module LLVM.General.CodeModel where

import Data.Data

-- | <http://llvm.org/doxygen/namespacellvm_1_1CodeModel.html>
data Model
    = Default
    | JITDefault
    | Small
    | Kernel
    | Medium
    | Large
    deriving (Eq, Read, Show, Typeable, Data)
