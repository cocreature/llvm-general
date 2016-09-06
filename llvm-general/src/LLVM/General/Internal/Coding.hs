{-# LANGUAGE
  TemplateHaskell,
  MultiParamTypeClasses,
  FunctionalDependencies,
  UndecidableInstances
  #-}
module LLVM.General.Internal.Coding where

import Data.Data
import Language.Haskell.TH
import Language.Haskell.TH.Quote

import Control.Monad.AnyCont
import Control.Monad.IO.Class

import Foreign.C
import Foreign.Ptr
import Foreign.Storable
import Foreign.Marshal.Alloc
import Foreign.Marshal.Array

import qualified LLVM.General.Internal.FFI.LLVMCTypes as FFI

class EncodeM e h c where
  encodeM :: h -> e c

class DecodeM d h c where
  decodeM :: c -> d h

genCodingInstance :: (Data c, Data h) => TypeQ -> Name -> [(c, h)] -> Q [Dec]
genCodingInstance ht ctn chs = do
  let n = const Nothing
  [d| 
    instance Monad m => EncodeM m $(ht) $(conT ctn) where
      encodeM h = return $ $(
        caseE [| h |] [ match (dataToPatQ n h) (normalB (dataToExpQ n c)) [] | (c,h) <- chs ] 
       )

    instance Monad m => DecodeM m $(ht) $(conT ctn) where
      decodeM c = return $ $(
        caseE [| c |] [ match (dataToPatQ n c) (normalB (dataToExpQ n h)) [] | (c,h) <- chs ]
       )
   |]

alloca :: (Storable a, MonadAnyCont IO m) => m (Ptr a)
alloca = anyContToM Foreign.Marshal.Alloc.alloca

peek :: (Storable a, MonadIO m) => Ptr a -> m a
peek p = liftIO $ Foreign.Storable.peek p

instance (Monad m, EncodeM m h c, Storable c, MonadAnyCont IO m) => EncodeM m [h] (CUInt, Ptr c) where
  encodeM hs = do
    hs <- mapM encodeM hs
    (anyContToM $ \x -> Foreign.Marshal.Array.withArrayLen hs $ \n hs -> x (fromIntegral n, hs))

instance (Monad m, DecodeM m h c, Storable c, MonadIO m) => DecodeM m [h] (CUInt, Ptr c) where
  decodeM (n, ca) = do
    cs <- liftIO $ Foreign.Marshal.Array.peekArray (fromIntegral n) ca
    mapM decodeM cs

instance Monad m => EncodeM m Bool FFI.LLVMBool where
  encodeM False = return $ FFI.LLVMBool 0
  encodeM True = return $ FFI.LLVMBool 1

instance Monad m => DecodeM m Bool FFI.LLVMBool where
  decodeM (FFI.LLVMBool 0) = return $ False
  decodeM (FFI.LLVMBool _) = return $ True

instance Monad m => EncodeM m (Maybe Bool) (FFI.NothingAsMinusOne Bool) where
  encodeM = return . FFI.NothingAsMinusOne . maybe (-1) (fromIntegral . fromEnum)

instance Monad m => EncodeM m (Maybe Word) (FFI.NothingAsMinusOne Word) where
  encodeM = return . FFI.NothingAsMinusOne . maybe (-1) fromIntegral

instance Monad m => EncodeM m Word CUInt where
  encodeM = return . fromIntegral
