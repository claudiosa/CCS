
:-lib(ic).
%:-lib(ic_global).
%:-lib(ic_search).
:-lib(branch_and_bound).
%:-lib(propia).


custo(1, [](21,11,23,35,38,20)).


go :- 
    custo(1,Custo),
    dim(Custo,[N]),
    dim(V_Dec,[N]),
    V_Dec :: 0 .. 1,
    
	(for(I,1,N),
		param(Custo, V_Dec ),
		fromto(0,In,Out, TotalCost)
    	do
		Out #= In + Custo[I] * V_Dec[I]
	),
 
 writeln(Out),
 writeln(TotalCost),
    /* apenas um valor serah selecionado */
      %(  
        %for(I,1,N), 
        %param(V_Dec) do
         %),
        sum( V_Dec[1 .. N]) #= 3, %% um valor escolhido
       
 
       % prepare for maximization (if needed)
         TotalCostNeg #= -TotalCost,
  
		% search
        % 
        
        flatten_array(V_Dec,V_Dec_List),        
        minimize(search(V_Dec_List,0,first_fail,indomain,complete,[]), TotalCostNeg),
		writeln(V_Dec).

		

/*

        writeln(assignments: Assignments), %%%write(Assignments),
        writeln("Matriz custo inicial:"),
        pretty_print(Cost),
        writeln(total_cost: TotalCost2).


go :-
     mapa(1, X),
     dim(X,[Lin,Col]),
     writeln(lin: Lin),   writeln(col: Col), %%%OK
     Vars = [P, Po, Pl, Pn, Ps],
     Vars :: 0..99,
   %%  Lin_custo is (Lin-2), Col_custo is (Col-2),
   %  dim(Custo, [ Lin_custo,  Col_custo] ), %%% um array com todos os custos
   %	 writeln(lin: Lin_custo),   writeln(col: Col_custo), %%%OK
       dim(Custo, [Lin,  Col] ),
       
       (  for(I, 2 , (Lin-1), 1 ),
           % param(Col, X, Custo, P,Po,Pl,Pn,Ps) do
            param(Col, X, Custo) do
              ( for(J, 2, (Col-1), 1 ),
                %%param(I, X, Custo, P,Po,Pl,Pn,Ps) do
                  param(I, X, Custo) do
                    P  is X[I,J],    %%% aqui nao eh constraint
                    Pn is X[I-1 ,J],
                    Ps is X[I+1 ,J], %% sul
                    Po is X[I, J-1],
                    Pl is X[I, J+1], %% leste
                    % Custo[I,J]  #= sum([P,Po,Pl,Pn,Ps]),
                    Custo[I,J]  #= sum([P,Po,Pl,Pn,Ps]),
                    Sum is sum([P,Po,Pl,Pn,Ps]),
                    write([P,Po,Pl,Pn,Ps]), write(Sum)
              ) ,
              nl              
        ),
        
        
            
        %
        % objective: minimize 
        %
        
       %%flatten_array(X, Vars),
        flatten_array(Custo, Vars),
        %%%Z #= sum(Vars),

      minimize(search(Vars,0,first_fail,indomain,complete,[backtrack(Backtracks)]),Custo),
      %writeln(z:Z),
      %writeln(x:X),
      writeln(backtracks:Backtracks),
	  pretty_print(X).
*/


% pretty prints a matrix
pretty_print(X) :-
        dim(X, [Rows,Cols]),
        ( for(I, 1, Rows), param(X, Cols) do
            ( for(J, 1, Cols), param(X, I) do
                XX is X[I,J],
                printf("%3d", XX),
                write("  ")
            ),
            nl
        ).        

