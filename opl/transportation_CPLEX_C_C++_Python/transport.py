#!/usr/bin/python
# --------------------------------------------------------------------------
# File: examples/src/python/transport.py
# Version 12.9.0
# --------------------------------------------------------------------------
# Licensed Materials - Property of IBM
# 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55 5655-Y21
# Copyright IBM Corporation 2008, 2019. All Rights Reserved.
#
# US Government Users Restricted Rights - Use, duplication or
# disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
# --------------------------------------------------------------------------
"""
Model piecewise linear cost coefficients.

The problem is a simple transportation model.  Set the function argument
to 0 for a convex piecewise linear model and to 1 for a concave piecewise
linear model.

The user must choose the model type on the command line:
    python transport.py 0
    python transport.py 1
"""

from __future__ import print_function

import sys

import cplex
from cplex.exceptions import CplexError


def transport(convex):
    supply = [1000.0, 850.0, 1250.0]
    nbSupply = len(supply)
    demand = [900.0, 1200.0, 600.0, 400.0]
    nbDemand = len(demand)
    n = nbSupply * nbDemand

    if convex:
        pwl_slope = [120.0, 80.0, 50.0]
    else:
        pwl_slope = [30.0, 80.0, 130.0]

    def varindex(m, n):
        return m * nbDemand + n

    # The x coordinate of the last break point of pwl
    k = 0
    pwl_x = [[0.0] * 4] * n
    pwl_y = [[0.0] * 4] * n

    for i in range(nbSupply):
        for j in range(nbDemand):
            if supply[i] < demand[j]:
                midval = supply[i]
            else:
                midval = demand[j]

            pwl_x[k][1] = 200.0
            pwl_x[k][2] = 400.0
            pwl_x[k][3] = midval

            pwl_y[k][1] = pwl_x[k][1] * pwl_slope[0]
            pwl_y[k][2] = pwl_y[k][1] + \
                pwl_slope[1] * (pwl_x[k][2] - pwl_x[k][1])
            pwl_y[k][3] = pwl_y[k][2] + \
                pwl_slope[2] * (pwl_x[k][3] - pwl_x[k][2])

            k = k + 1

    # Build model
    model = cplex.Cplex()
    model.set_problem_name("transport_py")
    model.objective.set_sense(model.objective.sense.minimize)

    # x(varindex(i, j)) is the amount that is shipped from supplier i to
    # recipient j
    colname_x = ["x{0}".format(i + 1) for i in range(n)]
    model.variables.add(obj=[0.0] * n, lb=[0.0] * n,
                        ub=[cplex.infinity] * n, names=colname_x)

    # y(varindex(i, j)) is used to model the PWL cost associated with
    # this shipment.
    colname_y = ["y{0}".format(j + 1) for j in range(n)]
    model.variables.add(obj=[1.0] * n, lb=[0.0] * n,
                        ub=[cplex.infinity] * n, names=colname_y)

    # Supply must meet demand
    for i in range(nbSupply):
        ind = [varindex(i, j) for j in range(nbDemand)]
        val = [1.0] * nbDemand
        row = [[ind, val]]
        model.linear_constraints.add(lin_expr=row,
                                     senses="E", rhs=[supply[i]])

    # Demand must meet supply
    for j in range(nbDemand):
        ind = [varindex(i, j) for i in range(nbSupply)]
        val = [1.0] * nbSupply
        row = [[ind, val]]
        model.linear_constraints.add(lin_expr=row,
                                     senses="E", rhs=[demand[j]])

    # Add the PWL constraints
    for i in range(n):
        # preslope is the slope before the first breakpoint.  Since the
        # first breakpoint is (0, 0) and the lower bound of y is 0, it is
        # not meaningful here.  To keep things simple, we re-use the
        # first item in pwl_slope.
        # Similarly, postslope is the slope after the last breakpoint.
        # We just use the same slope as in the last segment; we re-use
        # the last item in pwl_slope.
        model.pwl_constraints.add(vary=n + i,
                                  varx=i,
                                  preslope=pwl_slope[0],
                                  postslope=pwl_slope[-1],
                                  breakx=pwl_x[i],
                                  breaky=pwl_y[i],
                                  name="p{0}".format(i + 1))

    # solve model
    model.solve()
    model.write('transport_py.lp')

    # Display solution
    print()
    print("Solution status :", model.solution.get_status())
    print("Cost            : {0:.2f}".format(
        model.solution.get_objective_value()))
    print()

    print("Solution values:")
    for i in range(nbSupply):
        print("   {0}: ".format(i), end='')
        for j in range(nbDemand):
            print("{0:.2f}\t".format(
                model.solution.get_values(varindex(i, j))),
                end='')
        print()


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Specify an argument to choose between convex and "
              "concave problems")
        print("Usage: python transport.py <model>")
        print(" model = 0 -> convex piecewise linear model")
        print(" model = 1 -> concave piecewise linear model")
        sys.exit(-1)
    convex = bool(int(sys.argv[1]))
    transport(convex)
