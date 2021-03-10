/* representation of a graph - has loops */
/* choose initial state a                */
arc(a, b).
arc(a, f).
arc(b, c).
arc(b, d).
arc(b, e).
arc(f, g).
arc(f, i).
arc(i, j).
arc(i, k).
arc(j, e).
arc(j, m).
arc(c, a).
arc(i, f).

/* goals */
goal(d).
goal(i).
goal(m).
