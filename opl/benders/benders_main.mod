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


main{
thisOplModel.generate();


var masterDef = thisOplModel.modelDefinition;
var masterElts = thisOplModel.dataElements;
// standard solve
var subCplex0 = new IloCplex();
var subOpl0 = new IloOplModel(masterDef, subCplex0);
subOpl0.addDataSource(masterElts);
subOpl0.generate();
subCplex0.solve();

//--------------------------------------------------------
// standard solve + force benders strategy to full.
var subCplex1 = new IloCplex();
subCplex1.bendersstrategy = 3;
var subOpl1 = new IloOplModel(masterDef, subCplex1);
subOpl1.addDataSource(masterElts);
subOpl1.generate();
subCplex1.solve();


//--------------------------------------------------------
// use annotation with variables 1 by 1.
// if partitioning is bad, then an error will be raised by CPLEX...
var subCplex2 = new IloCplex();
var subOpl2 = new IloOplModel(masterDef, subCplex2);
subOpl2.addDataSource(masterElts);
subOpl2.generate();
subCplex2.bendersstrategy = 1;

subCplex2.newLongAnnotation("cpxBendersPartition");
for (var i in thisOplModel.R2){	
	for (var j in thisOplModel.R1){
			subCplex2.setLongAnnotation("cpxBendersPartition", subOpl2.X[i][j], subOpl2.bendersPartition2[i]);
	}	
}
subCplex2.solve();


//--------------------------------------------------------
// use annotation with blocks of variables.
// if partitioning is bad, then an error will be raised by CPLEX...
var subCplex3 = new IloCplex();
var subOpl3 = new IloOplModel(masterDef, subCplex3);
subOpl3.addDataSource(masterElts);
subOpl3.generate();
subCplex3.bendersstrategy = 1;

subCplex3.newLongAnnotation("cpxBendersPartition");

subCplex3.setLongAnnotations("cpxBendersPartition", subOpl3.X, subOpl3.bendersPartition);
subCplex3.solve();


//--------------------------------------------------------
cplex.exportModel("benders.lp");
subCplex2.writeBendersAnnotation("cplex2.ann");
subCplex3.writeBendersAnnotation("cplex3.ann");


//--------------------------------------------------------
var subCplex4 = new IloCplex();
subCplex4.importModel("benders.lp");
subCplex4.readAnnotations("cplex2.ann");
subCplex4.solve();

var subCplex5 = new IloCplex();
subCplex5.importModel("benders.lp");
subCplex5.readAnnotations("cplex3.ann");
subCplex5.solve();

//--------------------------------------------------------
writeln(subCplex0.getObjValue());
writeln(subCplex1.getObjValue());
writeln(subCplex2.getObjValue());
writeln(subCplex3.getObjValue());
writeln(subCplex4.getObjValue());
writeln(subCplex5.getObjValue());

//--------------------------------------------------------
subCplex2.delLongAnnotation("cpxBendersPartition");
subCplex3.delLongAnnotation("cpxBendersPartition");
subCplex4.delLongAnnotation("cpxBendersPartition");
subCplex5.delLongAnnotation("cpxBendersPartition");

//--------------------------------------------------------
//clean up of memory
subOpl3.end();
subOpl2.end();
subOpl1.end();
subOpl0.end();

subCplex5.end();
subCplex4.end();
subCplex3.end();
subCplex2.end();
subCplex1.end();
subCplex0.end();
}

