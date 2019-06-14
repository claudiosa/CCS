// -------------------------------------------------------------- -*- C++ -*-
// File: ilotransport.cpp
// Version 12.9.0
// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55 5655-Y21
// Copyright IBM Corporation 2000, 2019. All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
// --------------------------------------------------------------------------
//
// ilotransport.cpp - Simple transportation example with piecewise linear
//                    cost coefficients.

#include <ilcplex/ilocplex.h>

ILOSTLBEGIN

typedef IloArray<IloNumArray>    NumMatrix;
typedef IloArray<IloNumVarArray> NumVarMatrix;

int
main(int argc, char** argv)
{
   if (argc <= 1) {
      cerr << "Usage: " << argv[0] << " <model>" << endl;
      cerr << "  model = 0 -> convex piecewise linear model, " << endl;
      cerr << "  model = 1 -> concave piecewise linear model. [default]" << endl;
   }

   IloBool convex;
   if (argc <= 1)
      convex = IloFalse;
   else
      convex = atoi(argv[1]) == 0 ? IloTrue : IloFalse;

   IloEnv env;
   try {
      IloInt i, j;
      IloModel model(env);

      IloInt nbDemand = 4;
      IloInt nbSupply = 3;
      IloNumArray supply(env, nbSupply, 1000.0, 850.0, 1250.0);
      IloNumArray demand(env, nbDemand, 900.0, 1200.0, 600.0, 400.);

      NumVarMatrix x(env, nbSupply);
      NumVarMatrix y(env, nbSupply);

      for(i = 0; i < nbSupply; i++) {
         x[i] = IloNumVarArray(env, nbDemand, 0.0, IloInfinity, ILOFLOAT);
         y[i] = IloNumVarArray(env, nbDemand, 0.0, IloInfinity, ILOFLOAT);
      }

      for(i = 0; i < nbSupply; i++) {      // supply must meet demand
         model.add(IloSum(x[i]) == supply[i]);
      }
      for(j = 0; j < nbDemand; j++) {      // demand must meet supply
         IloExpr v(env);
         for(i = 0; i < nbSupply; i++)
            v += x[i][j];
         model.add(v == demand[j]);
         v.end();
      }
      if (convex) {
         for(i = 0; i < nbSupply; i++) {
            for(j = 0; j < nbDemand; j++) {
               model.add(y[i][j] == IloPiecewiseLinear(x[i][j],
                                       IloNumArray(env, 2, 200.0, 400.0),
                                       IloNumArray(env, 3, 30.0, 80.0, 130.0),
                                       0.0, 0.0));
            }
         }
      }
      else {
         for(i = 0; i < nbSupply; i++) {
            for(j = 0; j < nbDemand; j++) {
               model.add(y[i][j] == IloPiecewiseLinear(x[i][j],
                                       IloNumArray(env, 2, 200.0, 400.0),
                                       IloNumArray(env, 3, 120.0, 80.0, 50.0),
                                       0.0, 0.0));
            }
         }
      }

      IloExpr obj(env);
      for(i = 0; i < nbSupply; i++) {
         obj += IloSum(y[i]);
      }
      model.add(IloMinimize(env, obj));
      obj.end();

      IloCplex cplex(env);
      cplex.extract(model);
      cplex.exportModel("ilotransport.lp");
      cplex.solve();

      env.out() << "Solution status: " << cplex.getStatus() << endl;

      env.out() << " - Solution: " << endl;
      for(i = 0; i < nbSupply; i++) {
         env.out() << "   " << i << ": ";
         for(j = 0; j < nbDemand; j++) {
            env.out() << cplex.getValue(x[i][j]) << "\t";
         }
         env.out() << endl;
      }
      env.out() << "   Cost = " << cplex.getObjValue() << endl;
   }
   catch (IloException& e) {
      cerr << "ERROR: " << e.getMessage() << endl;
   }
   catch (...) {
      cerr << "Error" << endl;
   }
   env.end();
   return 0;
} // END main
