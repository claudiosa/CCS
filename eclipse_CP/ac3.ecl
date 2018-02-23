Input:
    A set of variables X and their domains D
    A set of unary constraints R1(x) on variable x that must be satisfied
    A set of binary constraints R2(x, y) on variables x and y that must be satisfied

function ac3 (X, D, R1, R2)
    for each x in X
        D(x) := { x in D(x) | R1(x) }   

    worklist := { (x, y) | there exists a relation R2(x, y) 
        or a relation R2(y, x) -- a constraint  }

    do
        select any arc (x, y) from worklist
        worklist := worklist - (x, y)
        if arc-reduce (x, y)
            if D(x) is empty 
                return failure
            else
                worklist := worklist + { (z, x) | z != y and 
                    there exists a relation R2(x, z) or 
                    a relation R2(z, x) }
    while worklist not empty
    
function arc-reduce (x, y)
    bool change = false
    for each vx in D(x)
        find a value vy in D(y) such that vx and vy satisfy the constraint R2(x, y)
        if there is no such vy 
            D(x) := D(x) - vx
            change := true
    
    return change
