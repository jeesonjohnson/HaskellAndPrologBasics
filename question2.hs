import           Data.Maybe

{-
Question 2.1.a
  This question uses appropraite pattern matching to solve pass in values into
  the function and evaluate the said results.
-}
--Step function definition
step :: [Int]-> String->[Int]
step (x:y:ys) "*" = x * y:ys
step (x:y:ys) "+" = x + y:ys
step (x:y:ys) "-" = y - x:ys
--Validations for step function
step arr word = arr ++ [read word::Int]


-- #########################################################################################

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


-- #########################################################################################


{-
Question 2.1.c
  This function works by implementing a foldl function within the defintion of
  the definition of the overall function through recurrsion, to solve the said
  problem.

-}

rpnRec :: [String] -> Int
rpnRec = head . customfolder sorter []
  where
    sorter numbers operation
      | operation `elem` ["+","-","*"] = step numbers operation
      | otherwise = read operation:numbers
    customfolder _ a []     = a
    customfolder f a (x:xs) =customfolder f (f a x) xs



-- #########################################################################################

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


-- #########################################################################################
{-
Question 2.3.a
  Whereas the similar output could be achived by the following
  -- data RPNOut = Success Int | Stuck [Int] [String] | Incomplete [Int] deriving (Show)
  the better implemention was to use haskell's record syntax, which allows the definition of
  a given return statment, along with appropraite methods to extract specific data
  from each assosication process outcome if needed. Say by doing "answer Success 10" we
  would be able to extract the speifc value of answer, rather than a general show statment
-}
data RPNOut = Success { answer :: Int}| Stuck {inputNumbers::[Int], currentOperation :: [String]} |
              Incomplete {finalNumberArray :: [Int]} deriving (Show)

-- #########################################################################################
{-
Question 2.3.b
  This operation ensures that the the validation of inputs, and the possability of said
  operations, and if an operation is not possible, an error is thrown. For example the
  validations are such that:
    1)Ensure that the number of elements to perform an operation is greater than or equal to 2.
      This being as at a minimum the operation must have 2 numbers to operate on, so e.g [2] "+" is
      not possible, since you need 2 numbers to compelte an addition.
    2)Validation is done to ensure that the MaxSize of an Integer is NOT reached by any of the operations,
      if reached Nothing is returned.
    3)Validation is provided on the type of values passed into the array, as such an operation could only
      be done on integers, adn with the predefined operation set of "+","-" and "*".
-}

step3 :: [Int] -> String -> Maybe [Int]
step3 array word
  | length(array) <2 = Nothing -- Validation for when an operation is not possible, for instance, if [1] "+" that operation
                               -- cannot be completed, as a operation must have 2 numeric arguments.
-- --Actual operation
step3 (x:y:ys) "*" = if ( (x*y /= (maxBound ::Int )) || (x*y /=(negate (maxBound ::Int ))) ) then Just (x * y:ys) else Nothing
step3 (x:y:ys) "+" = if ( (x+y /= (maxBound ::Int )) || (x+y /=(negate (maxBound ::Int ))) ) then Just (x + y:ys) else Nothing
step3 (x:y:ys) "-" = if ( (y-x /= (maxBound ::Int )) || (y-x /=(negate (maxBound ::Int ))) ) then Just (y-x:ys) else Nothing
--Validations for step function
step3 array word
      --The below validation ensures that only numbers or operations are passed into the string condition
      --of the function, otherwise an Nothing is returned.
      |  not $ null (reads word :: [(Integer,String)])= Just (array ++ [(read word::Int)])
      |  otherwise = Nothing


-- #########################################################################################

{-
Question 2.3.c
  Regarding rpn3
  This function is ordered on the basis of where errors may ocur within the function.
  This builds upon the idea of having a custom implementation of the foldl function
  using recurrsion, that breaks out if an input data is incorrect. This implementation
  depends on the sorter function to actuall call the step function and carry out the
  operation as expplained in previous questions.

  Firstly the guards check if the length of array of to be done operations are empty,
  and if the there are more than 1 value in list of parsed numbers, then the operation
  is stuck. Since 2 numbers must have an operation to reduce further down into an integer.

  Secondly the guards check if the there are no remaining operations, and thus due to
  the order of operations(first checking Incomplete results), we can be sure the result
  is final, and the result cant be further reduced.

  Thirdly, we arrive at a stuck situation when there are less than 1 numbers in the array
  of numbers, and we try and conduct an operation on that singular number,  this would
  arrive at a failure since at a minium you need 2 numbers to complete an operation in
  our domain.

  Finally the guard calls a reursive step to the function, further reducing the operations
  that remain.



-}
rpn3 :: [String] -> RPNOut
rpn3 userInput = customfolder sorter [] userInput
  where
    sorter numbers testingVal
      | testingVal `elem` ["+","-","*"] = step numbers testingVal
      | otherwise = read testingVal:numbers
    customfolder function numbers arr
      | length(arr)==0 && length(numbers)>=2 = Incomplete numbers
      | length(arr)==0 = Success (head numbers)
      | (length (numbers)<=1) && (head(arr) `elem` ["+","-","*"] ) = Stuck (numbers) [last(arr)]
      | otherwise = customfolder function (function numbers (head arr)) (tail(arr))


-- #########################################################################################
{-
  Question 2.4.a
  The below function works by passing values into the function decider, which
  determins which type of operation should take place, if the operation is defined
  in the function being passed in then the appropriate method is applied to said
  values. if however the wrong values are passed in, the defaults to the oringinal
  operations which perform "+", "-" and "*".
  Therefore this implemenation allows the opeator function to overide the default
  functions "+", "-" and "*", provided it is defined in the function being passed in.
 -}
rpn4 :: (String -> Maybe ([Int] -> [Int])) -> [String] -> [Int]
rpn4 func userInput = (foldl (functionDecider func) [] userInput)
  where
    functionDecider func numbers testingVal =
      if (not (isNothing (func testingVal))) then (fromJust (func testingVal )) numbers
      else originalOperations numbers testingVal
    originalOperations numbers testingVal
      | testingVal `elem` ["+","-","*"] = step numbers testingVal
      | otherwise = read testingVal:numbers

-- #########################################################################################

{-
  Question 2.4.b, extensions to Q2.4.a
  The following method functions by passing in a string, and depending on the
  value of said string, the associatied function is called, where each function
  can then be applied partially in the rpn4 function. Each appropirate method
  has appropraite function, and method for parsing, this being needed as to ensure
  the returning function is of a partial type.
  P.s method was implmented without using guards to make it easy to read function
-}

exts :: String -> Maybe ([Int] -> [Int])
exts "fib" = Just fib
  where
    --Defining the fib function handler
   fib (x:xs) = (fibCalc x):xs
   --Defining method to calcuate actual fib values
   fibCalc 0 = 0
   fibCalc 1 = 1
   fibCalc n = fibCalc (n-1) + fibCalc(n-2)
exts "!" = Just factorial
  where
   --Defining function for factorial
   factorial (x:xs) = (factorialCalc x):xs
   --Defining actual factorial function
   factorialCalc 0 = 1
   factorialCalc n = n * factorialCalc (n-1)
exts "sum" = Just customSum
  where customSum x = [(foldl (+) 0 x)]
exts "prod" = Just customProd
  where customProd x = [(foldl (*) 1 x)]
exts _ = Nothing
