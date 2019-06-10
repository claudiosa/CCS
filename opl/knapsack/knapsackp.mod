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

int NbRows = ...;
int NbColumns = ...;

range Rows = 1..NbRows;
range Columns = 1..NbColumns;

int b[Rows] = ...;
int c[Columns] = ...; 
int Coef[Rows][Columns] = ...;
int MaxValue = max(i in Rows)  b[i];
int MaxCoef[j in Columns] = max(i in Rows) Coef[i][j];

dvar int x[Columns] in 0..MaxValue;   
execute setting_mipsearch {
  for(var j in Columns) {
     cplex.setPriority(x[j],c[j]/MaxCoef[j]);
     cplex.setDirection(x[j],"BranchDown");
  }
  /* ALTERNATIVE use properties
  for(var j in Columns) {
     x[j].priority = c[j]/MaxCoef[j];
     x[j].direction = "BranchDown";
  }
  */
}


maximize
  sum( j in Columns ) 
    c[j] * x[j];

subject to {
  forall( i in Rows )
    ct:
      sum( j in Columns ) 
        Coef[i][j] * x[j] <= b[i];
}


