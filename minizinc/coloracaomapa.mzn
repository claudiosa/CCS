int: nc = 5;

var 1..nc: wa;
var 1..nc: nt;
var 1..nc: sa;
var 1..nc: q;
var 1..nc: nsw;
var 1..nc: t;
var 1..nc: v;

constraint wa != nt;
constraint wa != sa;
constraint nt != q;
constraint nt != sa;
constraint sa != q;
constraint sa != nsw;
constraint sa != v;
constraint q != nsw;
constraint nsw != v;

solve satisfy;

output ["wa = ", show(wa),"\nnt = ", show(nt), "\nsa = ", show(sa), "\nq = ", show(q), "\nnsw = ", show(nsw), "\nt = ", show(t), "\nv = ", show(v)];