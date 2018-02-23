% :-lib(ic).
% :-lib(branch_and_bound).
% :-lib(ic_global).

% hakank: Using Gecode's solver instead
:- lib(gfd).


go :-
        % Size for sliding ....
        % Max_in_line is 2,
        Max_in_line is 3, % hakank
        % Total in the Matrix ...
        Tam_quadrado is Max_in_line^2, 
        
        %% or a square = Max_in_line x Max_in_line
       
		/******* PRINTING *******/
        map_cost(1, Mapa1),
		model(Max_in_line, Tam_quadrado, Mapa1, X1, TotalCost1),
		my_print(Max_in_line, Tam_quadrado, Mapa1, X1, TotalCost1),
		
		map_cost(2, Mapa2),
		model(Max_in_line, Tam_quadrado, Mapa2, X2, TotalCost2),
		my_print(Max_in_line, Tam_quadrado, Mapa2, X2, TotalCost2).
		
		
my_print(Max_in_line, Tam_quadrado, Mapa, X, TotalCost):-		
		/******* PRINTING *******/
		writeln("Total Sum ": TotalCost),
        % writeln("PRINT X - Decision Matrix - but with STOPs due  WHAT ? "),
        pretty_print(X),
%%      writeln("The BRANCH BOUND should be exaustive? It is stopping in a first solution !!!! WHY ... "),
        writeln("....................................................").
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 model(Max_in_line, Tam_quadrado, Mapa, X, TotalCost2) :-        
               
        % obtendo as dimensoes do problema - veja formato da MATRIX
        dim(Mapa,[Lins,Cols]),  %% MAPA is static 
 
	    building_slidings(Lins, Max_in_line, All_contiguities),
	    writeln("All_contiguities": All_contiguities),
        	     
		% Criando uma matriz com variaveis de decisao:  0..1 
        % do mesmo tamanho que a matrix Custo
        dim(X, [Lins,Cols] ), %% Decision matrix
        X :: 0..1,
        

     %% C1 O numero da matriz decisao eh 9 ao total
     %%  0 or Max_in_line 1's 
     
     ( for(I, 1, Lins),  %% EXTERNO nao esqueca da virgurla
        param( X, Cols, Max_in_line)
        do
        (
         % sum( X[I , 1..Cols ] ) #= 0 ; %% OR
         % sum( X[I , 1..Cols ] ) #= Max_in_line
         % hakank:
         sum( X[I , 1..Cols ] ) #= 0 
         or 
         sum( X[I , 1..Cols ] ) #= Max_in_line
        )
	  ),

     %% C2
     %%  0 or Max_in_line 1's 
     ( for(J, 1, Cols),  %% EXTERNO nao esqueca da virgurla
        param( X, Lins, Max_in_line)
        do
        (
         % sum( X[ 1..Lins , J] ) #= 0 ;
         % sum( X[ 1..Lins , J] ) #= Max_in_line
         % hakank:
         sum( X[ 1..Lins , J] ) #= 0 
         or 
         sum( X[ 1..Lins , J] ) #= Max_in_line
         ) 
   	  ),
    
      %%writeln("All_slides" :  All_contiguities),
    
      %% C3
       % The 1's must be contigous
        (for(L, 1, Lins),
         param(X,Cols,  All_contiguities) do
           Line is X[L , 1..Cols],   %% Line comes like a list
           %flatten_matrix( X[L , 1..Cols], L_Line),
           %% writeln("X[L , 1..Cols] " : X[L , 1..Cols]),
           %%% Please check this constraint
           % member( Line , All_contiguities)
           % memberchk( Line, All_contiguities) % hakank          
           table(Line, All_contiguities) % hakank
          
        ),
       
	 %% C4	
        (for(C, 1, Cols),
         param(X, Lins, All_contiguities) do
             Col is X[1..Lins , C], %% Col comes like a list
             %% flatten_matrix( X[1..Lins , C], L_Col),
             % member( Col, All_contiguities)
             % memberchk( Col, All_contiguities) % hakank
             table(Col, All_contiguities) % hakank
        ),
     
     
      % write('y2........ debbugs reason '),
      %% C5 
      %% All Matrix must be equal ... 
      %% matrix_sum(X[ 1..Lins ,1..Cols ] ) #= (Max_in_line *  Max_in_line),

      flatten_array(X, L_X),
      sum(L_X) #= Tam_quadrado , %% total eh MxN ... M e N sao VARs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    
      % From classical covering by Hakan
      % C6: Total Cost 
      
       (for(I,1,Lins) * for(J,1,Cols), 
         fromto(0,In,Out,TotalCost2), 
         param(X, Mapa) do 
             Out #= In + X[I,J] * Mapa[I,J]
       ),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
      %%% a maximization eh sobre ....       
      ZNeg #= -TotalCost2,
  

      % minimize(search( L_X ,0 ,first_fail, indomain , complete,[]),ZNeg )
      % search( L_X ,0 ,first_fail, indomain , complete,[])
      % hakank (using gfd):
      % search(L_X, 0, occurrence, indomain_split, bb_min(ZNeg),[])
      search(L_X, 0, first_fail, indomain_max, bb_min(ZNeg),[backtrack(Backtracks)])
      ,writeln(backtracks:Backtracks)
      .   %% <== THE END
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pretty_print(X) :-
        dim(X, [N,N]),
        ( for(I, 1, N), param(X, N) do
            ( for(J, 1, N), param(X, I) do
                XIJ is floor(X[I,J]),
                write(XIJ), write(" ")
            ),
            nl
        ).             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 map_cost(1, 
        []([]( 20, 2, 11, 25, 30, 47, 65, 55, 71, 5 ), 
           []( 28, 27, 82, 3, 74, 93, 35, 3, 85, 6 ),
           []( 74, 9, 71, 96, 70, 10, 73, 13, 43, 9 ),
           [](  2, 55, 73, 9, 61, 1,  5, 73, 59, 6 ),
           []( 46, 6, 9, 83,  4, 42, 22, 29, 67, 59 ),
           []( 42, 22, 29, 67, 59, 46, 9, 59, 83,  4 ),
           [](  1,  5, 73, 59, 6,  2, 5, 3, 6, 61 ),
           []( 10, 73, 13, 43, 6, 4, 7, 1, 6, 0),
           []( 93, 35, 3, 85, 1,  2, 2, 2, 3, 4),
           []( 47, 5, 55, 71, 5, 0, 2,  1, 2, 3 ))
           ).


 map_cost(2, 
        []([](  98 , 55, 71, 9 ), 
           [](  83 , 5, 700, 700 ), 
           [](  6  , 7, 700, 700 ), 
           [](  2  , 5,   1, 5 ))
           ).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
% Same using * to avoid nesting:
flatten_matrix(Mat, Xs) :-
    dim(Mat, [M,N]),
    (
	for(I, 1, M) * for(J, 1, N),
	foreach(X, Xs),
	param(Mat)
    do
	subscript(Mat, [I,J], X)
    ).

/*
%% achatamento bidimensional FUNCIONA
%?- flatten_array([]([](20, 24, 11), [](28, 27, 82)), L).
%L = [20, 24, 11, 28, 27, 82]
%Yes (0.00s cpu)
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
building_slidings( Lins, Max_in_line, All_contiguities):-

        dim(Array_Zeros, [Lins] ), %% Aux Array with Zeroes
        Array_Zeros :: 0 ,
      
        dim(Array_Uns, [Max_in_line] ), %% Aux Array with ONEs
        Array_Uns :: 1 ,  
        !,
        flatten_array(Array_Zeros , L_Zeros),
	    writeln("L_Zeros OK  " : L_Zeros),
  	    %%% a list with 0 ...
	    flatten_array(Array_Uns , L_Uns),
	    writeln("L_Uns OK  " : L_Uns),
	    %% a list with 1's ...
	    
	    %%%  building the templates for sliding constraints
        %%%  sliding_const( L_UNS, N_ZEROS, L_all)
	    N_ZEROS is (Lins - Max_in_line),
        sliding_const( L_Uns , N_ZEROS, L_all),
        inclui_L_Zeros(L_Zeros, L_all, All_contiguities).

building_slidings(_, _, _):-   writeln("Any troubles in building_slidings").    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Segue uma lista de UNS ... e quantidade de ZEROS 
    sliding_const(X , Y , _ ):- (X==[];Y==[]),  
                                writeln("Any troubles in sliding_const"),!.    
    sliding_const( L_UNS, N_ZEROS, L_all):-

 	monta_listas( L_UNS , N_ZEROS, L_all, N_ZEROS).

%% ideia do algoritmo ... MONTAR LISTAS  com N_ZEROS ao fim da lista
%% de uns ... ateh uma ultima lista com N_ZEROS na frente desta lista.
/* *************************************************** */   
/*	
monta_listas(L1 ,0, [L4], Fixo) :- 
	ins_n_z_i(L1, Fixo, L2),  %%%INSERE 000 no inicio DA LISTA
	ins_n_z_f(L1, 0, L3),  %%%% INSERE NENHUM 0 NO FINAL DA LISTA
	aPPEND(L2,L3,L4).
	
	ALGO EQUIVALENTE A PARADA ABAIXO ....
*/

monta_listas(_ , -1 , [], _) :- !.

monta_listas(L1, N_Zeros, [L4|L5] , Fixo):-
	NO_INI is Fixo - N_Zeros,  /* CONTADORES FIXO >= N_Zeros*/
	NO_FIM is N_Zeros,        /* CONTADORES*/    
	ins_n_z_i(L1, NO_INI, L2),  %%%INSERE 000 no inicio DA LISTA
	ins_n_z_f(L1, NO_FIM, L3),  %%%% INSERE 000NO FINAL DA LISTA
	aPPEND(L2,L3,L4),
	N_Zeros_New is (N_Zeros - 1),
%%%	writeln(" L4 " : L4),
	monta_listas(L1, N_Zeros_New , L5 , Fixo ).
	
%%% insere N 0s na frente de uma lista de 1's	
ins_n_z_i(X, 0 , X):- !.
ins_n_z_i(_, X ,_):- X < 0, writeln(" BUG ..." : X).
ins_n_z_i(L1, N, [0 | L2 ]):-
	N2 is (N-1),
	ins_n_z_i(L1 , N2, L2 ).

/*
Do it:
?- ins_n_z_i([1, 1], 4, L2).
L2 = [0, 0, 0, 0, 1, 1]
*/
	
ins_n_z_f(L1,N,L2):-        %%%%% USA O ANTERIOR E INVERTE
	ins_n_z_i(L1,N,L3), 
	reverse(L3,L2).

/*
Faz isto:
?- ins_n_z_f([1, 1], 4, L2).
L2 = [1, 1, 0, 0, 0, 0]
*/

%%% um append um pouco diferente 
aPPEND([] , L2, L2 ).
aPPEND([A|_] , [B|L2], [B | L2 ]) :- A == B, !.
aPPEND([A|L1] , [B|L2], [A | L3 ]) :-
       A \== B,
       aPPEND(L1 , [B|L2], L3 ).


inclui_L_Zeros(L_Zeros, [A|L_all], [L_Zeros, A |L_all]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% AUXs
list2array(L,A) :-
                length(L, Size),
                dim(A,[Size]),
                (foreacharg(X,A),
		        foreach(X,L) do true). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
