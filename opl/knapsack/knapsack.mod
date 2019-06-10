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

int NbItems = ...;
int NbResources = ...;
range Items = 1..NbItems;
range Resources = 1..NbResources;
int Capacity[Resources] = ...;
int Value[Items] = ...;
int Use[Resources][Items] = ...;
int MaxValue = max(r in Resources) Capacity[r];


dvar int Take[Items] in 0..MaxValue;

maximize
  sum(i in Items) Value[i] * Take[i];
  
subject to {
  forall( r in Resources )
    ct:
      sum( i in Items ) 
        Use[r][i] * Take[i] <= Capacity[r];
}


tuple TakeSolutionT{ 
	int Items; 
	int value; 
};
{TakeSolutionT} TakeSolution = {<i0,Take[i0]> | i0 in Items};
execute{ 
	writeln(TakeSolution);
}
