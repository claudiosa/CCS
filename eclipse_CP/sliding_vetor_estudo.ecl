:-lib(ic).   
:- lib(branch_and_bound).   


/*
This is the basic rule for a constraint program:
1. first deterministic constraint setup
2. then nondeterministic search (possibly with b&b)

So, move your member/2 call inside minimize/2:

       minimize((
               member(L_X , All_contiguities),
               search(L_X,0,first_fail,indomain,complete,[])
          ), Zneg).

In your code, you don't actually need search/6, because L_X is already
fully instantiated.  It is a bit strange to precompute a list of all
possibilities, and then search over it.  It would be more elegant to
nondeterministically generate the different combinations directly and
do this instead of the member/2.
*/    
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
go :- 
	  Size_Window is 5,
	 
	 %model(i   , o, o, o, o)
	  model(Size_Window, V, X, N, TOTAL), 
 
         %%% PRINTINGS
            ( for(J, 1, N), param( X,V ) do
              (
                XX is X[J],
                YY is V[J],
                (XX == 1 -> printf(output,"\n Index VALUEs : %d %d ",[J,YY]) ; write(""))
              )     
            ),    
            
            printf(output,"Solution = %d",[TOTAL]).  
          

model(Size_Window, V, X, N, TOTAL ) :-
		v_unidim(V),
        dim(V,[N]),
        dim(X,[N]),  	%% array decisao com apenas 1 numero "1"
        X :: 0..1, 
        dim(Cost,[N]),     
        
        building_slidings( N, Size_Window , All_contiguities),
        writeln("PATTERNS CONSTRAINTS " : All_contiguities),
        
        %% L_X: apenas padroes de janela

        ( for( I, 1, N), param( X, V, Cost) do
          (   
            Cost[I] #= V[I] * X[I]
              %%multiplicacao ddas somas pela decisoria
          )   
        ),   
              
      sum(Cost[1..N])#= TOTAL,  
      Zneg #= -TOTAL,   
      flatten_array(X , L_X), 
       
      minimize(
      (
       member(L_X , All_contiguities),
       search(L_X,0,first_fail,indomain,complete,[])
       ),
       Zneg
      )
      .   
      %% THE END of the MODEL  
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 %%vetor unidimensional da questao 1    
v_unidim(
		[]( 60, 60, 60, 25, 30, 47, 65, 55, 71, 95,
        28, 27, 82, 83, 74, 93, 35, 63, 85, 46  ,   
        74, 97, 71, 96, 70, 10, 73, 13, 43, 96 ,   
        2, 55, 3, 69, 61, 1, 5, 73, 59, 56 ,   
        46, 96, 59, 83, 4, 42, 22, 29, 67, 59 ,   
        42, 22, 29, 67, 59, 46, 96, 59, 83, 4 ,  
        1, 5, 73, 59, 56, 2, 55, 73, 69, 61 ,   
        10, 73, 13, 43, 96, 74, 97, 71, 96, 70,   
        93, 35, 63, 85, 46, 28, 27, 82, 83, 74,   
        47, 65, 55, 71, 95, 20, 24, 11, 25, 300 )
).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% AUXILIARIES CONSTRAINTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
building_slidings( Lins, Max_in_line, All_contiguities):-

        dim(Array_Zeros, [Lins] ), %% Aux Array with Zeroes
        Array_Zeros :: 0 ,
      
        dim(Array_Uns, [Max_in_line] ), %% Aux Array with ONEs
        Array_Uns :: 1 ,  
        !,
        flatten_array(Array_Zeros , L_Zeros),
	    %%writeln("L_Zeros OK  " : L_Zeros),
  	    %%% a list with 0 ...
	    flatten_array(Array_Uns , L_Uns),
	    %%writeln("L_Uns OK  " : L_Uns),
	    %% a list with 1's ...
	    
	    %%%  building the templates for sliding constraints
        %%%  sliding_const( L_UNS, N_ZEROS, L_all)
	    N_ZEROS is (Lins - Max_in_line),
        sliding_const( L_Uns , N_ZEROS, All_contiguities).
  
        %%% incluir esta ultima linha se quiser uma sequencia de zeros
        %%%inclui_L_Zeros(L_Zeros, L_all, All_contiguities).

building_slidings(_, _, _):-   writeln("Any troubles in building_slidings").    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Segue uma lista de UNS ... e quantidade de ZEROS 
    sliding_const(X , Y , _ ):- (X==[] ; Y==[]),  
                                writeln("Any troubles in sliding_const"),!.    
    sliding_const( L_UNS, N_ZEROS, L_all):-
 	monta_listas( L_UNS , N_ZEROS, L_all, N_ZEROS).

%% ideia do algoritmo ... MONTAR LISTAS  com N_ZEROS ao fim da lista
%% de uns ... ateh uma ultima lista com N_ZEROS na frente desta lista.
/* ************************************************************************ */   
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
Do it:
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

