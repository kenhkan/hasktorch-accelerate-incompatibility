module Main (main) where

import Data.Array.Accelerate                    as A
import qualified Data.Array.Accelerate.LLVM.PTX as PTX
import qualified Data.Array.Accelerate.Interpreter as AI
import qualified Foreign.CUDA.Driver            as C

dotp :: Acc (Vector Float) -> Acc (Vector Float) -> Acc (Scalar Float)
dotp xs ys = A.fold (+) 0 (A.zipWith (*) xs ys)

main = do
  let xs = fromList (Z:.10) [0..]   :: Vector Float
      ys = fromList (Z:.10) [1,3..] :: Vector Float
  -- Commenting this out would get rid of the segfault.
  cuda xs ys
  noCuda xs ys
  putStrLn "*** complete ***"

cuda xs ys = do
  C.initialise []
  dev0 <- C.device 0
  dev0Props <- C.props dev0
  ptx <- PTX.createTargetForDevice dev0 dev0Props []
  putStrLn $ show $ A.toList $ PTX.runWith ptx (dotp (use xs) (use ys))

noCuda xs ys = do
  putStrLn $ show $ A.toList $ AI.run (dotp (use xs) (use ys))
