

{-

/* sum(Is,S) is true if S is the sum of the list of integers Is.  
*/
sum([],0).
sum([I|Is],S):-
  sum(Is,S0),
  plus(I,S0,S).
-}


{-
/* double(Xs,Ys) is true if every element in the list Xs appears twice in  */
/*   the list Ys.                                                          */
double([],[]).
double([X|Xs],[X,X|Ys]):-double(Xs,Ys)
-}


{-
/* select(X,Xs,Ys) is true if Ys is the result of removing the first       */
/*   occurrence of X from Xs.                                              */
select(X,[X|Xs],Xs).
select(X,[Y|Ys],[Y|Zs]):-X\=Y,select(X,Ys,Zs).
-}


{-
/* adjacent(X,Y,Zs) is true if the elements X and Y are adjacent in the    */
/*   list Zs.                                                              */
adjacent(X,Y,[X,Y|Zs]).
adjacent(X,Y,[Z|Zs]):-adjacent(X,Y,Zs).
-}


{-
/* last(X,Xs) is true if X is the last element in the list Xs.  */
last(X,[X]).
last(X,[Y|Xs]):-last(X,Xs).
-}

{-- Alguns classicos  OBRIGATORIAMENTE a serem feitos: --}


{- A. Inverter uma lista -}

{- B. Ordenar uma lista -}

{- C. Uniao de duas listas -}

{- D. Dividir uma lista em duas outras listas:
   templates:
   [ .... ] -> [[..],[..]] ou
   [ .... ] -> ([..],[..]) ou 	
    tem que usar o "where" aqui

-}


{-
/* substitute(X,Y,Xs,Ys) is true if the list Ys is the result of           */
/*   substituting Y for all occurrences of X in the list Xs.               */
substitute(X,Y,[],[]).
substitute(X,Y,[X|Xs],[Y|Ys]):-substitute(X,Y,Xs,Ys).
substitute(X,Y,[Z|Xs],[Z|Ys]):-X\=Z, substitute(X,Y,Xs,Ys).
-}


{-
/* subtree(Subtree,Tree) is true if Subtree is a subtree of the binary     */
/*   tree Tree.                                                            */
subtree(T,T).
subtree(S,tree(X,L,R)):-subtree(S,L).
subtree(S,tree(X,L,R)):-subtree(S,R).
-}


{-
/* sum_tree(Tree,S) is true if S is the sum of the elements of the tree    */
/*   Tree.                                                                 */
sum_tree(void,0).
sum_tree(tree(X,L,R),S):-
  sum_tree(L,S1),
  sum_tree(R,S2),
  S is X+S1+S2.
-}


{-
/* tree_insert(X,Tree,Tree1) is true if Tree1 is the result of inserting   */
/*   the element X into the ordered tree Tree.                             */
tree_insert(X,void,tree(X,void,void)).
tree_insert(X,tree(X,L,R),tree(X,L,R)).
tree_insert(X,tree(Y,L,R),tree(Y,L1,R)):-
  X < Y,
  tree_insert(X,L,L1).
tree_insert(X,tree(Y,L,R),tree(Y,L,R1)):-
  X > Y,
  tree_insert(X,R,R1).
-}

import System.IO
f :: Integer
f = 1
g :: Integer
g = 2
h :: Integer
h = 3

main :: IO ()
main = do
		{ print (f);
		  putStr "\n";
		  print (f+g);
		  putStr "\n";
		  print (f+g+h)
	    } 
