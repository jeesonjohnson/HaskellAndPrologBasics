import           Data.List
import           System.IO
{-
Question 2.1.a
-}
--Step function definition
step :: [Int]-> String->[Int]--Rememebre to achnagain valurable names!!!!!!
step (x:y:ys) "*" = x * y:ys
step (x:y:ys) "+" = x + y:ys
step (x:y:ys) "-" = y - x:ys
--Validations for step function
step (x:ys) _     = x:ys
step _ word=      [read word::Int]

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
    customfolder _ a []     = a
    customfolder f a (x:xs) =customfolder f (f a x) xs


{-
Question 2.2 A polish notation Elevator
This function operats a similar way to Q2.1.b, however being altered to work with
folr and its right association property's.

  # In this function a custom step function had to be provided, this being as
    since the original step function is defined for a foldl function, when it
    comes to a negative operation, when we did say ["-","3","4"], the foldr
    function will interperate the values to pass into the step function as [4,3] "-"
    due to right assosiativity of the foldr function. Therefore resulting in an
    incorrect answer, as the step function is defined for input to be (for this question)
    to be [3,4] "-". There a custom guard was provided for the negation function, to
    account for the right assosiativity of the foldr function.
    We could have passed in a reversed array to the step function, so instead of [4,3]
    [3,4] would be passed however this deems incorrect results where say a multiple set
    of function are required. so say for example ["+","-","4","2","3","4"]. Here if
    we tried solving with reverse the value passed into the step function from [4,3,2,4]
    would be [4,2,3,4] "-" resulting in incorrect answers further down, when doing say "+"/

-}

pn :: [String] -> Int
pn = head . foldr sorter []
  where
    sorter testVal numbers
      | testVal == "-" = customNegativeStep numbers testVal
      | testVal `elem` ["+","*"] = step numbers testVal
      | otherwise = read testVal:numbers
    customNegativeStep (x:y:ys) "-" = x - y:ys --Needed due to explanation above



{-
Question 2.3.a

-}
Sucess :: Int -> RPNOut
