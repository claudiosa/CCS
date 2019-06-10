// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2013. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------

// This OPL uses experimental Javascript support for benders annotations.
// The model is a toy model just in order to show how to use the annotation api.

execute{
	cplex.bendersstrategy = 3;
}

int d1 = ...;
int d2 = ...;

range R1 = 1..d1;
range R2 = 1..d2;

range dim  = 1..d1*d2;
int Costs[i in R2][j in R1] = ...;

dvar float X[R2][R1];

dvar boolean Y[R1];

int bendersPartition[i in R2][j in R1] = i;
int bendersPartition2[i in R2] = i;

minimize sum(i in R2, j in R1) Costs[i][j]*X[i][j] + sum(i in R1) Y[i];
subject to{
forall(i in R2)
  sum(j in R1) X[i][j] ==1;
forall(i in R2, j in R1)
  X[i][j] - Y[j] <= 0;
}

