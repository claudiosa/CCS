
include "globals.mzn";

int : colors = 4;

var 1 .. colors : SC;
var 1 .. colors : RS; 
var 1 .. colors : PR;  
var 1 .. colors : SP;
var 1 .. colors : MS;

constraint
    RS  != SC    /\
    SC  != PR    /\
    PR  != SP   /\
    PR  != MS   /\
    SP  != MS  ;

solve satisfy;


output 
   [
	"RS = " , show(RS), "\t",
	"SC = " , show(SC), "\t",
	"PR = " , show(PR), "\t",
	"SP = " , show(SP), "\t",
	"MS = " , show(MS), "\n"];
   

