{-# LANGUAGE
  TemplateHaskell,
  ForeignFunctionInterface,
  CPP
  #-}

module LLVM.General.Internal.FFI.PassManager where

import qualified Language.Haskell.TH as TH

import Foreign.Ptr
import Foreign.C

import Control.Monad
import LLVM.General.Internal.FFI.LLVMCTypes
import LLVM.General.Internal.FFI.PtrHierarchy
import LLVM.General.Internal.FFI.Cleanup
import LLVM.General.Internal.FFI.Module
import LLVM.General.Internal.FFI.Target
import LLVM.General.Internal.FFI.DataLayout
import LLVM.General.Internal.FFI.Transforms

import qualified LLVM.General.Transforms as G

data PassManager

foreign import ccall unsafe "LLVMCreatePassManager" createPassManager ::
  IO (Ptr PassManager)

disposePassManager :: Ptr PassManager -> IO ()
disposePassManager = undefined

runPassManager :: Ptr PassManager -> Ptr Module -> IO CUInt
runPassManager = undefined

addDataLayoutPass :: Ptr DataLayout -> Ptr PassManager -> IO ()
addDataLayoutPass = undefined

addAnalysisPasses :: Ptr TargetMachine -> Ptr PassManager -> IO ()
addAnalysisPasses = undefined

$(do
  let declareForeign :: TH.Name -> [TH.Type] -> TH.DecsQ
      declareForeign hName extraParams = do
        let n = TH.nameBase hName
            passTypeMapping :: TH.Type -> TH.TypeQ
            passTypeMapping t = case t of
              TH.ConT h | h == ''Word -> [t| CUInt |]
                        | h == ''G.GCOVVersion -> [t| CString |]
              -- some of the LLVM methods for making passes use "-1" as a special value
              -- handle those here
              TH.AppT (TH.ConT mby) t' | mby == ''Maybe ->
                case t' of
                  TH.ConT h | h == ''Bool -> [t| NothingAsMinusOne Bool |]
                            | h == ''Word -> [t| NothingAsMinusOne Word |]
                            | h == ''FilePath -> [t| NothingAsEmptyString CString |]
                  _ -> typeMapping t
              _ -> typeMapping t
        foreignDecl 
          (cName n)
          ("add" ++ n ++ "Pass")
          ([[t| Ptr PassManager |]] 
           ++ map passTypeMapping extraParams)
          (TH.tupleT 0)
#if __GLASGOW_HASKELL__ < 800
  TH.TyConI (TH.DataD _ _ _ cons _) <- TH.reify ''G.Pass
#else
  TH.TyConI (TH.DataD _ _ _ _ cons _) <- TH.reify ''G.Pass
#endif
  liftM concat $ forM cons $ \con -> case con of
    TH.RecC n l -> declareForeign n [ t | (_,_,t) <- l ]
    TH.NormalC n [] -> declareForeign n []
    TH.NormalC n _ -> error "pass descriptor constructors with fields need to be records"
 )

data PassManagerBuilder
