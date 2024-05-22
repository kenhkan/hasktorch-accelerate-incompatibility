module Main (main) where

import Data.Array.Accelerate                    as A
import qualified Data.Array.Accelerate.LLVM.PTX as PTX
import qualified Foreign.CUDA.Driver            as C

dotp :: Acc (Vector Float) -> Acc (Vector Float) -> Acc (Scalar Float)
dotp xs ys = A.fold (+) 0 (A.zipWith (*) xs ys)

main = do
  C.initialise []
  dev0 <- C.device 0
  dev0Props <- C.props dev0
  ptx <- PTX.createTargetForDevice dev0 dev0Props []
  let xs = fromList (Z:.10) [0..]   :: Vector Float
      ys = fromList (Z:.10) [1,3..] :: Vector Float
  putStrLn $ show $ A.toList $ PTX.runWith ptx (dotp (use xs) (use ys))
  putStrLn "*** complete ***"
