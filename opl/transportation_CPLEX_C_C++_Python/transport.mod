/*********************************************
 * OPL 12.9.0.0 Model
 * Author: ccs
 * Creation Date: 10 de jun de 2019 at 19:24:22
 *********************************************/
/*
    C = 3, % Demands or consumers --- COLUNS
    S = 3,  % Suppliers or sources -- ROWS
    %% see the figures in the site 
    % https://www.me.utexas.edu/~jensen/models/network/net8.html

*/

// came from a file . dat
int Sources = ...; 
int Destination = ...;

range R_rows = 1..Sources;
range R_cols = 1..Destination;

int LARGE = 9999;
// other modelling stractegy
// int Demand[Destination]= ...;
// int Output[Sources]= ... ;
int Shipcost[i in R_rows][j in R_cols]= ...;

//assert sum(s in R_rows) Output[s] == sum (d in R_cols) Demand[d];
// Decision VAR
dvar int VAR_Ship[i in R_rows][j in R_cols] in 0..LARGE;

dvar int objetive_function;

minimize 
objetive_function;

subject to 
{

//forall( d in R_rows )
// ALL SOURCES MUST BE CONSUMED and be respected
//sum([X_Matrix[1,J] : J in 1..C]) #= 5,
 sum(d in R_rows) VAR_Ship[1][d] == 5;
//    sum([X_Matrix[2,J] : J in 1..C]) #= 7,
sum(d in R_rows) VAR_Ship[2][d] == 7;
//    sum([X_Matrix[3,J] : J in 1..C]) #= 3,
sum(d in R_rows) VAR_Ship[3][d] == 3;

// All the consumers/demands MUST respect their reception capacity
//sum([X_Matrix[I,1] : I in 1..S]) #<= 7,
sum(s in R_rows)  VAR_Ship[s][1] <= 7;
// sum([X_Matrix[I,2] : I in 1..S]) #<= 3,
sum(s in R_rows)  VAR_Ship[s][2] <= 3;
//   sum([X_Matrix[I,3] : I in 1..S]) #<= 5,
sum(s in R_rows)  VAR_Ship[s][3] <= 5;    

forall( s in R_cols , d in  R_rows )
    sum (s in R_cols , d in R_rows )
       VAR_Ship[s][d]>=0;

objetive_function ==  sum(s in R_rows, d in R_cols) Shipcost[s][d] * VAR_Ship[s][d];

/*
forall( s in R_cols , d in R_rows )
     sum(d in Destination)
      VAR_Ship[s][d]<=Output[s];

forall( s in R_cols , d in R_rows )
sum(s in R_cols)
VAR_Ship[s][d]>=Demand[d];
*/
}   

  
execute DISPLAY
{
writeln("Objetive Function = ", objetive_function);
writeln("DECISION MATRIX =", VAR_Ship);           
writeln();

for(var i in R_rows)
 {for(var j in R_cols)
    write("\t Goes_TO[", i, "][", j, "] = ", VAR_Ship[i][j] );
    writeln();
  }    

writeln("==== THE END ===");           
  
}
 
/*

// solution (optimal) with objective 46
Objetive Function = 46
DECISION MATRIX = [[2 3 0]
         [5 0 2]
         [0 0 3]]

	 Goes_TO[1][1] = 2	 Goes_TO[1][2] = 3	 Goes_TO[1][3] = 0
	 Goes_TO[2][1] = 5	 Goes_TO[2][2] = 0	 Goes_TO[2][3] = 2
	 Goes_TO[3][1] = 0	 Goes_TO[3][2] = 0	 Goes_TO[3][3] = 3
==== THE END ===
*/ 
 
 