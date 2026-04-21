-- Church's Booleans
--
-- Tested with GHC 9.12.2.
--
-- Creation date: 2025-08-19
--
-- Version 0.1

{-# LANGUAGE Haskell2010       #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE Rank2Types        #-}
{-# LANGUAGE TypeOperators     #-}

module Main where

-- We define the type of Church's Booleans.
-- A Church Boolean is a function that takes two arguments and returns one of them.
-- It encodes True and False using λ-calculus.
type CB = forall a. a -> a -> a

-- A @show@ instance for printing Church's Booleans.
-- Applies the Boolean to the strings "cTrue" and "cFalse" to display its identity.
instance a ~ String => Show (a -> a -> a) where
  show cb = cb "cTrue" "cFalse"

-- The true value as a polymorphic function returning the first
-- argument.
-- λx.λy.x
cTrue :: CB
cTrue = \x y -> x

-- The false value as a polymorphic function returning the second
-- argument.
-- λx.λy.y
cFalse :: CB
cFalse = \x y -> y

-- The if_then_else using a Church's Boolean.
-- Applies the Boolean to the two branches.
-- If cb is cTrue, returns x; if cb is cFalse, returns y.
cIf :: CB -> b -> b -> b
cIf cb x y = cb x y

-- Negation.
-- Applies the Boolean to cFalse and cTrue.
-- If input is cTrue, returns cFalse; if input is cFalse, returns cTrue.
cNot :: CB -> CB
cNot b = b cFalse cTrue

-- Conjunction.
-- Returns cFalse unless both inputs are cTrue.
-- Equivalent to: p q cFalse
cAnd :: CB -> CB -> CB
cAnd p q = p q cFalse

-- Disjunction.
-- Returns cTrue if either input is cTrue.
-- Equivalent to: p cTrue q
cOr :: CB -> CB -> CB
cOr p q = p cTrue q

-- Test cases to verify correctness of Church Boolean operations.
testing :: IO ()
testing = do
  putStrLn $ "cIf cTrue 42 24 =\t\t " ++ show (cIf cTrue 42 24)
  putStrLn $ "cIf cFalse cTrue cFalse =\t " ++ show (cIf cFalse cTrue cFalse)
  putStrLn $ "cNot cTrue =\t\t\t " ++ show (cNot cTrue)
  putStrLn $ "cAnd cTrue cFalse =\t\t " ++ show (cAnd cTrue cFalse)
  putStrLn $ "cOr cTrue cFalse =\t\t " ++ show (cOr cTrue cFalse)

-- Main function to run the test suite.
main :: IO ()
main = testing