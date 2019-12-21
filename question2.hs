import Data.List
import System.IO
{-
Question 2.1.a
-}
--Step function definition
step :: [Int]-> String->[Int]--Rememebre to achnagain valurable names!!!!!!
step (x:y:ys) "*" = x * y:ys
step (x:y:ys) "+" = x + y:ys
step (x:y:ys) "-" = y - x:ys
--Validations for step function
step (x:ys) _ = x:ys
step _ word= [read word::Int]

{-
Question 2.1.b
-}

calcRPN :: [String] -> [Int]
calcRPN = foldl sorter []
  where
    sorter numbers operation
      | operation `elem` ["+","-","*"] = step numbers operation
      | otherwise = read operation:numbers

--WORKING BUT COPPIED FROM WEBSITE https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Haskell


{-
Question 2.1.c ##PRBABLY NEED TO CFHANGE THIS!!! SINCE ITS KIND DOING TI IN A CHEAT WAY....
-}

rpnRec :: [String] -> [Int]
rpnRec = customfolder sorter []
  where
    sorter numbers operation
      | operation `elem` ["+","-","*"] = step numbers operation
      | otherwise = read operation:numbers
    customfolder _ a [] = a
    customfolder f a (x:xs) =folder f (f a x) xs
