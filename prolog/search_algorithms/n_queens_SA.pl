/* 
Est� no LPA ... tem que refazer alguns predicados....
This is the procedure to be invoked by the application program, in      */
/*   which size/1, perturb/2, energy/2 and output/3 must be defined.       */
anneal:-
  size(Size),
  N is 10 * Size,             /* Number of iterations per temperature      */
  MaxSucc is 1 * Size,        /* Maximum number of changes per temperature */
  repeat,
    perm_rand(Size, Xs),
    energy(Xs, EnergyXs),
  EnergyXs =\= 0, !,          /* Avoid division by zero in oracle/3        */
  Temp is EnergyXs / Size,    /* Initial temperature                       */
  anneal_1(100, N, Temp, 0.90, MaxSucc, s(Xs,EnergyXs), s([],32767), 
           s(Ys, EnergyYs), Result),
  output(Result, Ys, EnergyYs).

/* anneal_1(M, N, Temp, Factor, MaxSucc, State, s([],32767), Best, Result) */
/*   is true if Best is the best state (a list and its energy) obtained by */
/*   annealing the State at M different temperatures (or after no changes  */
/*   have been made at a given temperature, or if the energy becomes zero),*/
/*   with N iterations per temperature (or after the state has been        */
/*   changed MaxSucc times at this temperature).  Temp is the initial      */
/*   temperature, and it is multiplied by Factor at each iteration. Result */
/*   indicates the result of the annealing: optimal - an optimal solution  */
/*   has been found; iterations - all iterations have been executed        */
/*   without finding an optimal solution; nochanges - no changes were made */
/*   at a given temperature and an optimal solution has not been found.    */
anneal_1(_, _, _, _, _, _, s(Xs, 0), s(Xs, 0), optimal):-!.
anneal_1(0, _, _, _, _, _, Best, Best, iterations):-!.
anneal_1(M, TempIters, Temp, Factor, MaxSucc, State0, Best0, Best, Res):-
  anneal_2(TempIters, MaxSucc, MaxSucc, Temp, State0, State1, Best0, Best1),
  !,
  M1 is M - 1,
  Temp1 is Temp * Factor,
  anneal_1(M1, TempIters, Temp1, Factor, MaxSucc, State1, Best1, Best, Res).
anneal_1(_, _, _, _, _, _, Best, Best, nochanges).

/* anneal_2(N, MaxSucc, MaxSucc, Temp, State0, State, Best0, Best) is true */
/*   if State0 (a list and its energy) is transformed into State after N   */
/*   iterations at this Temp, or after the state has been changed MaxSucc  */
/*   times. Best0 is the previous best-so-far, and Best is the new best-   */
/*   so-far state.  It fails if, at the end of N iterations, no changes    */
/*   have been made.                                                       */
anneal_2(0, Success, MaxSucc, _, State, State, Best, Best):-!,
  Success < MaxSucc.
  /* All iterations have been performed and at least one change made */
anneal_2(_, 0, _, _, State, State, Best, Best):-!.
  /* The specified number of changes have been made */
anneal_2(N, Success, MaxSucc, Temp, s(Xs0, Energy0), State, Best0, Best):-
  perturb(Xs0, Xs1),
  energy(Xs1, Energy1),
  oracle(Energy0, Energy1, Temp), !,
  better(Best0, s(Xs1, Energy1), Best1),
  Success1 is Success - 1,
  N1 is N - 1,
  anneal_2(N1, Success1, MaxSucc, Temp, s(Xs1, Energy1), State, Best1, Best).
anneal_2(N, Success, MaxSucc, Temp, State0, State, Best0, Best):-
  N1 is N - 1,
  anneal_2(N1, Success, MaxSucc, Temp, State0, State, Best0, Best).

/* oracle(EnergyXs, EnergyYs, Temp) is true if EnergyYs < EnergyXs         */
/*   or Random < exp((EnergyYs - EnergyXs) / -Temp).                       */
oracle(EnergyXs, EnergyYs, _):-
  EnergyYs < EnergyXs, !.
oracle(EnergyXs, EnergyYs, Temp):-
  ln(rand(1)) < (EnergyXs - EnergyYs) / Temp.

/* better(State0, State1, State) is true if State is the better of State0  */
/*   and State1.  (The state with the lower energy is the better state.)   */
better(s(_, Energy0), s(Xs1, Energy1), s(Xs1, Energy1)):-
  Energy1 < Energy0, !.
better(State, _, State).

/* perm_rand(N, Perm) is true if Perm is a pseudo-random permutation of    */
/*   the integers 0 to N-1 inclusive.                                      */
perm_rand(N, Perm):-
  N >= 0,
  perm_rand_1(N, N, [], Perm).

perm_rand_1(0, _, Perm, Perm):-!.
perm_rand_1(M, N, Perm0, Perm):-
  repeat,
    random(N, Rand),
  not(member(Rand, Perm0)), !,
  M1 is M - 1,
  perm_rand_1(M1, N, [Rand|Perm0], Perm).

/* random(I, J) is true if J is a pseudo-random integer in the range       */
/*   0..J-1.                                                               */
random(I, J):-J is int(rand(I)).

/* member(X, Ys) is true if the element X is contained in the list Ys.     */
% member(X, [X|_]).
% member(X, [_|Ys]):-member(X, Ys).

/* repeat/0 always succeeds.                                               */
% repeat.
% repeat:-repeat.

