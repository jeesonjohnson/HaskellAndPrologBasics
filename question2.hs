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

What happens is when the foldl function takes place, say on ["3","7","+"]
we pass in head . foldl (sorter) [] ["3","7","+"]
1)    sorter [] "3"         so first pass the sorter function is passed in the value 3

2)    sorter [3] "7"        is what the function evaluates to after the first pass
                            thus replacing the initially empty array with the value 3
                            this is done, as due to gurad checking 3 is not a element of the
                            operations, so it is read and returned to the initally empty array.
                            Now the foldl function moves onto the next element in the result,
                            leading to the need for the sorter function to evaluate "7"

3)    sorter [3,7] "+"      Now again since 7 is not a value of the operations, the sorter
                            function adds 7 to the inital array, leading to the initally array
                            being [3,7]. The sorter function now has to evaluate the value of "+"

4)     [10]                 Since "+" is a supported opperation, the sorter function defualt to
                            applying the step function with appropriate arguments being
                            step [3,7] "+", resulting in inital array storing the result
                            [10]

5) 10                      The value 10 is returned as the final answer, using the head
                           fucntion on the array that returns the first element of the array.


-}

calcRPN :: [String] -> Int
calcRPN = head . foldl sorter []
  where
    sorter numbers testingVal
      | testingVal `elem` ["+","-","*"] = step numbers testingVal
      | otherwise = read testingVal:numbers

--WORKING BUT COPPIED FROM WEBSITE https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Haskell


{-
Question 2.1.c ##PRBABLY NEED TO CFHANGE THIS!!! SINCE ITS KIND DOING TI IN A CHEAT WAY....

-}

rpnRec :: [String] -> Int
rpnRec = head . customfolder sorter []
  where
    sorter numbers operation
      | operation `elem` ["+","-","*"] = step numbers operation
      | otherwise = read operation:numbers
    customfolder _ a [] = a
    customfolder f a (x:xs) =customfolder f (f a x) xs


{-
Question 2.2 A polish notation Elevator
Example test ["+", "3", "4"]
-}

pn :: [String] -> [Int]
pn userInput= foldr sorter [] userInput
  where
    sorter testVal arr
      | testVal `elem` ["+","-","*"] = step arr testVal
      | otherwise = read testVal:arr
