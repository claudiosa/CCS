
include "globals.mzn";

int : colors= 3;

var 1 .. colors : wa; var 1 .. colors : nt; var 1 .. colors : sa;  var 1 .. colors : q;
var 1 .. colors : nsw; var 1 .. colors : v;  var 1 .. colors : t;


constraint
       wa != nt     /\          wa != sa  /\  
	q != nt       /\          nt != sa    /\
	q != nsw    /\          q != sa /\
	sa != v       /\           nsw != sa    /\ 
        nsw != v    /\   	       sa != q       
        ;

solve satisfy;
%%solve minimize sum([wa, nt, sa, q, nsw, v,t]);
%%% LOOK here

output [
	"WA = " , show(wa), "\t",
	"NT = " , show(nt), "\t",
	"SA = " , show(wa), "\t",
	"NSW = " , show(nsw), "\t",
	"V = " , show(v), "\t",
	"Q = " , show(q), "\t",
       	"T = " , show(t), "\n",
          show("Ve  MAPA da Australia ")
         ];
