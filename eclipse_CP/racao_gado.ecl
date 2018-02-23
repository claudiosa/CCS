

/*
Do prof Carlos Vetorazzi

Uma fazenda deve comprar graos para compor uma racao para o gado.
Existem 3 tipos de graos. Cada tipo de grao apresenta
uma quantidade especifica de nutrientes. As necessidades minimas
de nutrientes, os niveis desses nutrientes em cada tipo de grao
e seus custos estao na tabela. Determe a composicao da mistura
de graos para satisfazer as necessidade minimas dos nutrientes
ao custo minimo.

----------------------------------------------------------------------
							Racao/Unidade
----------------------------------------------------------------------
		     Grao 1      Grao 2       Grao 3        Necessidade Minimas
----------------------------------------------------------------------
Nutri A        2           3            7                1250
Nutri B        1           1            0                250
Nutri C        5           3            0                900
Nutri D        0.6         0.25         1                232
----------------------------------------------------------------------
Custo/Unid      41         35           96
----------------------------------------------------------------------

minimizar: 41*G1 + 35*G2 + 96*G3
para que o lucro seja MAXIMO
Sujeito a:
           2*G1  + 3*G2 + 7*G3 >= 1250
           G1  +  G2  >= 250
           5*G1  + 3*G2  >= 900
           0.6*G1 + 0.25*G2 + G3 >= 232

Basicamente quanto de cada grao deve-se comprar?

Falta implementar: Facil

*/

:- lib(ic).
:- lib(branch_and_bound).
%:- lib(eplex).

go :-	
       modelo_racao([G1,G2,G3],   TOTAL) ,
%       otimiza_bb([G1,G2,G3],  TOTAL ),
       printf("\n [G1,G2,G3]: %w %w %w", [G1,G2,G3]),
       printf("\n LUCRO : %w ", [ TOTAL]).
/*
REAL ... INCOMPLETO

modelo_racao([G1,G2,G3],    TOTAL) :-
        [G1,G2,G3]  $::  0.0 .. 1000,

	2.0*G1  + 3.0*G2 + 7.0*G3 $>= 1250.0,
         G1  +  G2  $>= 250.0,
         5.0*G1  + 3.0*G2  $>= 900.0,
         0.6*G1 + 0.25*G2 + G3 $>= 232.0,
        get_domain(G1, Dx1), nl, writeln( dx_dominioDX1: Dx1),
        get_domain(G2, Dx2), nl, writeln( dx_dominioDX2: Dx2),
        get_domain(G3, Dx3), nl, writeln( dx_dominioDX3: Dx3),
    
%%	 TOTAL $= 41.0*G1 + 35.0*G2 + 96.0*G3,
          optimize(min(41.0*G1 + 35.0*G2 + 96.0*G3)  , TOTAL).
%         get_var_bounds(TOTAL, XL, XH),
%         writeln(xl : XL ; xh :  XH ).

%%       breal_from_bounds(XL, XH, TOTAL).
*/

modelo_racao([G1,G2,G3],    MAX ) :-
        [G1,G2,G3]  ::  0 .. 1000,

	 2*G1  + 3*G2 + 7*G3 #>= 1250,
         G1  +  G2  #>= 250,
         5*G1  + 3*G2  #>= 900,
      %%   0.6*G1 + 0.25*G2 + G3 #>= 232,     x 100 ... INTEGER
           60*G1 + 25*G2 + 100*G3 #>= 23200,
    	 TOTAL #= 41*G1 + 35*G2 + 96*G3,
         MAX  #=  TOTAL,  
%%%  para MINIMIZAR #=  -TOTAL,        
 	 bb_min(search( [G1,G2,G3], 0, first_fail, indomain, complete, []), MAX, bb_options{strategy:continue} ),

         get_domain(G1, Dx1), nl, writeln( dx_dominio_DX1: Dx1),
        get_domain(G2, Dx2), nl, writeln( dx_dominio_DX2: Dx2),
        get_domain(G3, Dx3), nl, writeln( dx_dominio_DX3: Dx3)
        .
 

 otimiza_bb([G1,G2,G3],  TOTAL ) :-
          MINIMIZAR #=  -TOTAL,  
 	 minimize(search( [G1,G2,G3], 0, first_fail, indomain, complete, []), MINIMIZAR ).
%        Options = bb_options{strategy:continue},
  %      bb_min(search( [G1,G2,G3], 0, first_fail, indomain, complete, []),  MINIMIZAR,  Options).

     
	% Options = bb_options{strategy:dichotomic, timeout:60},
	% Options = bb_options{delta:0.1},
	% Options = bb_options{strategy:continue, from: (-50000), to: 1000},
	% Options = bb_options{strategy:restart},
	% 
	% bb_min( modelo_racao( [G1,G2,G3] , MINIMIZAR),  MINIMIZAR , Options ).
	%%minimize(search( [G1,G2,G3], 0, first_fail, indomain, complete, []), MINIMIZAR ).

     
/*
Found a solution with cost 19544
Found a solution with cost 19539
Found no solution with cost 0.0 .. 19538.0

dx_dominioDX1 : 201
dx_dominioDX2 : 54
dx_dominioDX3 : 98
 [G1,G2,G3]: 201 54 98
 LUCRO : 19539 

*/
