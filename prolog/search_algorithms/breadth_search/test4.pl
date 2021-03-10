/* representation of a graph - has loops */
/* choose initial state a                */
arc(a, b).
arc(a, c).
arc(a, d).
arc(a, e).
arc(b, f).
arc(b, g).
arc(g, e).
arc(e, h).
arc(e, i).
arc(i, a).
arc(i, k).

/* goals */
goal(g).
goal(h).
goal(k).
