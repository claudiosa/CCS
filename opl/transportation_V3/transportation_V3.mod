/*********************************************
 * OPL 12.9.0.0 Model
 * Author: ccs
 * Creation Date: 10 de jun de 2019 at 19:24:22
 *********************************************
    %% see the figures in the site 
    % https://www.me.utexas.edu/~jensen/models/network/net8.html
    % this model is in PICAT also
*/

using CP; // comment it otherwise, it will be considered an MP model solved by the CPLEX engine.

// came from a file .dat file
int Sources = ... ; 
int Destination = ... ;

int LARGE = ... ;
// INDEX 
range R_rows = 1..Sources;
range R_cols = 1..Destination;

// sources and demands
int Output[i in R_rows]= ... ; // SOURCE
int Demand[j in R_cols]= ...; // DESTINATION

// Cost of transportation
int Cost_Matrix[i in R_rows][j in R_cols]= ...;

// Decision VAR
dvar int VAR_Ship[i in R_rows][j in R_cols] in 0..LARGE;

// 
dvar int objective_function;

minimize 
//solve
objective_function;

subject to 
{

// ALL SOURCES MUST BE CONSUMED <==> respected
forall( s in R_rows )
   sum(d in R_rows) VAR_Ship[s][d] == Output[s];
  

// All the consumers/demands MUST respect their reception capacity
forall( d in R_cols )
     sum(s in R_rows)  VAR_Ship[s][d] <= Demand[d];

// NON NEGATIVE
forall( s in R_cols , d in  R_rows )
    sum (s in R_cols , d in R_rows )
       VAR_Ship[s][d] >= 0;

objective_function ==  sum(s in R_rows, d in R_cols) Cost_Matrix[s][d] * VAR_Ship[s][d];

}   


execute DISPLAY
{
// POINTER TO OUTPUT FILE
var pt_file = new IloOplOutputFile("output_model_RUN.txt");

// OUTPUTS ....
pt_file.writeln("Objetive Function = ", objective_function);
pt_file.writeln("DECISION MATRIX = \n", VAR_Ship);           
pt_file.writeln();

// FOR INSTANCE
for(var i in R_rows)
 {for(var j in R_cols)
    pt_file.write("\t Goes_TO[", i, "][", j, "] = ", VAR_Ship[i][j] );
    pt_file.writeln();
  }    

pt_file.writeln("\n ======= THE END =======");           
  
}


/*  

execute DISPLAY
{
// OUTPUTS ....
writeln("Objetive Function = ", objective_function);
writeln("DECISION MATRIX =", VAR_Ship);           
writeln();

// FOR INSTANCE
for(var i in R_rows)
 {for(var j in R_cols)
    write("\t Goes_TO[", i, "][", j, "] = ", VAR_Ship[i][j] );
    writeln();
  }    

writeln("==== THE END ===");           
  
}

*/

/*
// TO WRITE DIRECTLY TO A FILE 
main {
  thisOplModel . generate();
  cplex.solve(); 
  var ofile = new IloOplOutputFile("modelRun.txt");
  ofile.writeln(thisOplModel.printExternalData());
  ofile.writeln(thisOplModel.printInternalData());
  ofile.writeln(thisOplModel.printSolution());
  ofile.close();
}

*/

