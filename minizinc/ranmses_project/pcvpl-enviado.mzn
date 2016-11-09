%%%%%% PCV-PL com funcao objetivo antiga
%%%%%% ranmses@gmail.com
%%%%%% 11/2016

include "globals.mzn";


%%%%% Caracteristicas da instancia
int : n;    % qtde cidades
int : p;    % qtde passageiros
int : c;    % capacidade do veiculo
int : q;    % qtde arestas tipo hov
float : desconto;  % percentual de desconto para arestas percorridas com carro cheio
float : tmax;      % tarifa maxima por passageiro
array[1..q, 1..2] of int : H;      % arestas tipo hov
array[1..n, 1..n] of var int : G;  % matriz de distancias
array[1..p] of int : P;   % P[i] = j se o passageiro deseja ir da cidade i ate a cidade j


%%%%% Variaveis de decisao
array[1..n] of var 1..n : x_ROTA= [1, 2, 10, 4, 3, 8, 6, 9, 7, 5]; % 01-01
array[1..n] of var 0..1 : x_EMBQ;% = [0, 1, 1, 0, 0, 1, 0, 0, 0, 0] ; % 01-01


%%%%% Funcao objetivo - custo motorista 
var float : custo;


%%%%% Funcoes
% true se a aresta i-j eh do tipo hov, valido em ambos os sentidos
function var bool:
          eh_hov(var int: i, var int: j) =
              exists(k in 1..q)((i == H[k,1] /\ j == H[k,2]) \/ (j == H[k,1] /\ i == H[k,2]) );

% retorna a quantidade de passageiros que desembarcam no y-esimo vertice da rota
function var int :
          desemb(var int: y) =
            if exists(j in 1..n)(P[j] == x_ROTA[1 + y mod n]) then
              sum( [ x_EMBQ[k] | k in 1..y, j in 1..n where x_ROTA[k] == j /\ P[j] == x_ROTA[1 + y mod n] ]) 
            else
              0
            endif;

% termos da funcao objetivo - calculo de quanto cada ocupante vai pagar na k-esima aresta
function var float :
          hovcost(var int: k) =
            let{  
                  var int: i = x_ROTA[k],  % k-esima cidade da rota
                  var int: j = x_ROTA[1+(k)mod n],  % proximo vertice da rota, mod n para a ultima aresta x_ROTA[n]-x_ROTA[1]
                  var int: o = 1 + x_EMBQ[1] + sum(i in 2..k)(x_EMBQ[i]-desemb(i-1))  % ocupacao da aresta
               } in
                       
            if eh_hov(i, j) /\ o == c then
              G[i,j]*(1-desconto)/o
            else
              G[i,j]/o
            endif;


%%%%% Restricoes
% TSP: ciclo hamiltoniano, somente o que preciso -- mega simplificacao do TSP -- builtin alldifferent  
constraint
          (x_ROTA[1] = 1)
          /\
          alldifferent(x_ROTA);

% veiculo: a quantidade de passageiros embarcados eh no maximo c-1 por conta do motorista
constraint
          forall(k in 2..n)
            ((sum(i in 1..k)(x_EMBQ[i]) - sum(j in 1..k-1)(desemb(j))) < c );
            
% passageiro: sentido compativel
constraint
          forall(i, d in 1..n where x_ROTA[ d ] == P[ x_ROTA[i] ])
            ( x_EMBQ[i] == 1 /\ ( d < i /\ d != 1 ) -> x_EMBQ[i] = 0 );
               
% passageiro: restricao de tarifa max -- vertice P[i], desembarque do passageiro i, é o d-esimo da rota
constraint
          forall(e, d in 1..n where x_ROTA[d] == P[ x_ROTA[e] ] )(
             if d != 1 then
               (sum(l in e..d-1)(hovcost(l)) > tmax ) -> x_EMBQ[e] = 0  
             else
               (sum(l in e..n)(hovcost(l)) > tmax ) -> x_EMBQ[e] = 0 
             endif
             );  
         
% funcao objetivo
constraint 
          custo = sum([ hovcost(k) | k in 1..n ]);

% minimizacao
solve minimize custo;