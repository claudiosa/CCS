

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
Sujeito a:
           2*G1  + 3*G2 + 7*G3 >= 1250
           G1  +  G2  >= 250
           5*G1  + 3*G2  >= 900
           0.6*G1 + 0.25*G2 + G3 >= 232

Basicamente quanto de cada grao deve-se comprar?

Falta implementar: Facil

*/
var float : g1;
var float : g2;
var float : g3;

var float: z =   41.0*g1 + 35.0*g2 + 96.0*g3;

constraint 
         2.0*g1  + 3.0*g2 + 7.0*g3 >= 1250.0
	 /\
         g1  +  g2  >= 250.0
	/\
        5.0*g1  + 3.0*g2  >= 900.0
	/\
        0.6*g1 + 0.25*g2 + g3 >= 232.0
        ;

solve minimize z;
%% solve satisfy;
/*
TESTAR EM BREVE
solve :: int_search(
   x, 
   smallest, 
   indomain_min, 
   complete) 
  minimize num_overlays;
*/

output
[
  "g1:" ++ show(g1)  ++ "\n" ++
 "g2:" ++ show(g2)  ++ "\n" ++
 "g3:" ++ show(g3)  ++ "\n" ++
  "Lucro z:" ++ show(z)  ++ "\n"
];
/*
This solver uses real ... it's cool
$ mzn-g12mip racao_gado.mzn 
g1:198.98550724637684
g2:51.01449275362316
g3:99.85507246376811
Lucro z:19530.0
----------
==========
*/

