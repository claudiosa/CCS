/* Representation of a tree */
/* choose initial state a   */
arc(a, b).
arc(a, f).
arc(b, c).
arc(b, d).
arc(b, e).
arc(f, g).
arc(f, i).
arc(i, j).
arc(i, k).

/* the goal */
goal(i).
