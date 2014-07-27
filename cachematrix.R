## cachematrix.R 

## Author: Christian Schirin
## Date: 2014-07-27

## Documentation 

## INTRODUCTION
## These functions provide an infrastructure for caching the inverse of a Matrix.
## The inverse M^-1 of a matrix M is the matrix for which following equation is
## valid: M %*% M^-1 = "Identity matrix that has the same size as M" 
## where `%*%` is operator for matrix multiplication. 
## Example (in R Code):
## mat <- matrix(1:4, nrow = 2, ncol = 2)
## > mat
## [,1] [,2]
## [1,]    1    3
## [2,]    2    4
## > solve(mat) ## The inverse of the matrix mat 
## [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
## > mat %*% solve(mat) 
## [,1] [,2]
## [1,]    1    0
## [2,]    0    1

## OUTLINE 
## The first function, makeCacheMatrix, encapsulates the matrix and its inverse
## matrix (once it has been computed by using the cacheSolve function) together 
## with functions that allow object-oriented style access on the matrix and its 
## inverse (so-called "getters" and "setters"). 
## The second function, cacheSolve, takes one of these encapsulations and
## either retrieves the cached inverse from it or, if no inverse had been cached 
## before, computes that inverse and stores it in the encapsulation.

## HOW TO USE 
## First you call makeCacheMatrix on a matrix you want to have a cached inverse for
## and then you call cacheSolve on the list that makeCacheMatrix returned.

## Functions 

## Creates an list that encapsulates a matrix together with it's cached inverse 
## matrix and getters and setters for both the original matrix and the inverse.
## Parameter: m - A matrix. 
## Returns: A list of 4 stateful functions named get, set, inverse.get, inverse.set
## which allow access to the the matrix and its cached inverse matrix.

makeCacheMatrix <- function(m = matrix()) {

}


## Computes or retrieves the inverse of a matrix that was encapsulated using 
## makeCacheMatrix. If the inverse had to be computed, the function will 
## add the computed inverse matrix to the cache of the encapsulated matrix.
## Parameters: 
## l - A list with 4 stateful functions named get, set, inverse.get, inverse.set 
## ... - the additional arguments for the solve function that is used to compute 
## the inverse matrix. 

cacheSolve <- function(l, ...) {
        ## Return a matrix that is the inverse of matrix in 'l'
}
