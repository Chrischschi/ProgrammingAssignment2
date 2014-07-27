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

## NOTE: this implementation is heavily inspired by the example code provided 
## The functions "makeVector" from the example and "makeCacheMatrix" are roughly
## comparable. The same goes for the functions "cachemean" from the example and
## the function "cacheSolve" from here.

## Creates a list that encapsulates a matrix together with it's cached inverse 
## matrix and getters and setters for both the original matrix and the inverse.
## Parameter: ma - A matrix. 
## Returns: A list of 4 stateful functions named get, set, inverse.get, inverse.set
## which allow access to the the matrix and its cached inverse matrix.

makeCacheMatrix <- function(ma = matrix()) {
    ## set the variables that need to be encapsulated
    inv <- NULL ## declare the variable of the cache for the inverse matrix
    
    ## ma was already defined in the function header
    
    ## define the getters and setters 
    
    ## Gets the matrix that was encapsulated.
    ## Returns: A matrix. 
    get <- function() {
        ma
    }
    ## Sets the matrix that was encapsulated.
    ## Returns: NULL.
    set <- function(new_ma) {
        ma <<- new_ma #set the matrix
        
        ## The matrix might have a different inverse matrix now,
        ## so we have to invalidate the cache.
        inv <<- NULL #invalidate by setting it to its inital state
    }
    ## Gets the cached inverse matrix. 
    ## Returns: A matrix.
    inverse.get <- function() {
        inv
    }
    ## Sets the cached inverse matrix.
    ## Returns: the value that was assigned as the inverse
    inverse.set <- function(new_inv) {
        inv <<- new_inv 
    }
    
    ## Create the list (contents: the getters and setters)and give the functions
    ## the same names as the variables in which the functions were defined in
    list(get = get, set = set, inverse.get = inverse.get, inverse.set = inverse.set)
}


## Computes or retrieves the inverse of a matrix that was encapsulated using 
## makeCacheMatrix. If the inverse had to be computed, the function will 
## add the computed inverse matrix to the cache of the encapsulated matrix.
## Parameters: 
## l - A list with 4 stateful functions named get, set, inverse.get, inverse.set 
## ... - the additional arguments to be passed to the the solve function 
## that is used to compute the inverse matrix. 
## Returns: A matrix that is the inverse of the matrix stored in l.

cacheSolve <- function(l, ...) {
    inv <- l$inverse.get() ## try to get the cached inverse matrix
    if(!is.null(inv)) { ## our attempt to read from the cache was successful 
        message("getting cached data")
        return(inv) ## early exit from the function
    }
    
    ## our attempt was not successful 
    ## we will have to compute the inverse now
    
    ## retrieve the matrix data from the encapsulation
    matrix <- l$get() 
    
    ## use solve to compute the inverse of a matrix
    inv <- solve(matrix,...)
    
    ## update the cache of the encapsulation
    l$inverse.set(inv)
    
    
    ## Return a matrix that is the inverse of the matrix in 'l'
    inv
}
