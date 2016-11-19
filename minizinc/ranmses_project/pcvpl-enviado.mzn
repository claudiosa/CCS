%%%%%% PCV-PL com funcao objetivo antiga
%%%%%% ranmses@gmail.com
%%%%%% 11/2016
%% 
include "globals.mzn";

%% aparentemente nao hah o que mexer exceto onde ha dominios ints e floats
%% troque isto por dominio FACTIVEIS ... reais e esperados de fato
%% troque rode tudo novamente e veja os resultados em tempo
% o exemplo aqui rodou IMEDIATO
%% no mais estah um boa codificacao 
%% 

%%%%% Caracteristicas da instancia
int : n;    % qtde cidades
int : p;    % qtde passageiros
int : c;    % capacidade do veiculo
int : q;    % qtde arestas tipo hov
float : desconto;  % percentual de desconto para arestas percorridas com carro cheio
float : tmax;      % tarifa maxima por passageiro

%%% PROCURE especificar o dominio deste float ...algo como
%% CCS: 0.0 .. 1000.0 eh muito melhor que float puro

array[1..q, 1..2] of int : H;      % arestas tipo hov
%% CCS: idem int ... diminua este dominio

array[1..n, 1..n] of var int : G;  % matriz de distancias
%% CCS: idem int ... diminua este dominio

array[1..p] of int : P;   % P[i] = j se o passageiro deseja ir da cidade i ate a cidade j
%% CCS: idem int ... diminua este dominio algo como 1 .. 100 onde 100 eh o maximo de cidades

%%%%% Variaveis de decisao
array[1..n] of var 1..n : x_ROTA= [1, 2, 10, 4, 3, 8, 6, 9, 7, 5]; % 01-01
array[1..n] of var 0..1 : x_EMBQ;% = [0, 1, 1, 0, 0, 1, 0, 0, 0, 0] ; % 01-01
%% CCS: OK AQUI nada o que fazer


%%%%% Funcao objetivo - custo motorista 
var float : custo;
%%% CCS:  idem aqui 

%%%%% Funcoes
% true se a aresta i-j eh do tipo hov, valido em ambos os sentidos
function var bool:
          eh_hov(var int: i, var int: j) =
              exists(k in 1..q)((i == H[k,1] /\ j == H[k,2]) \/ (j == H[k,1] /\ i == H[k,2]) );
%%% CCS: legal a funcao ... o detalhe a var int : j ... tem dominio nao?
%% veja um disjuntive nesta funcoa em particular


% retorna a quantidade de passageiros que desembarcam no y-esimo vertice da rota
function var int :
          desemb(var int: y) =
            if exists(j in 1..n)(P[j] == x_ROTA[1 + y mod n]) then
              sum( [ x_EMBQ[k] | k in 1..y, j in 1..n where x_ROTA[k] == j /\ P[j] == x_ROTA[1 + y mod n] ]) 
            else
              0
            endif;

%%% CCS:  IDEM

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
%%% CCS: IDEM 

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

%%%% FINALMENTE UMA DAS PARTES MAIS IMPORTANTES ... explorar o search
%%% como estah eh BB classico sem NENHUM melhoramanto
%%%  ALGO COMO .... ADAPTE O SEU CASO ALGO COMO FIZ ABAIXO para o problema das rainhas

%%% Anotacao -- ann de codigo ou procedimento 
ann : search_EXPLORE;
%solve :: search_EXPLORE  maximize somaTotal;
%%solve :: search_EXPLORE satisfy; 



%% SELECT_VAR_INT={input_order, anti_first_fail, first_fail, smallest, largest, max_regret}
%% DOMAIN_VAR_INT={indomain, indomain_split, indomain_random, indomain_median, indomain_max, indomain_min}
%% DETAILS in http://www.minizinc.org/g12_www/zinc/doc-2.0/html/zinc-manual.html#htoc17

%% em arquivo separado
%search_EXPLORE = int_search( rainha, anti_first_fail, indomain_split, complete);
%search_EXPLORE = int_search( rainha, first_fail, indomain_min, complete );
%search_EXPLORE = int_search( rainha, first_fail, indomain_max, complete );
%search_EXPLORE = int_search( rainha, first_fail, indomain_median, complete ) ;
%search_EXPLORE = int_search( rainha, first_fail, indomain_random, complete );

%%
%search_EXPLORE = int_search( rainha, input_order, indomain_median, complete );
%search_EXPLORE = int_search( rainha, input_order, indomain_max, complete );
%search_EXPLORE = int_search( rainha, anti_first_fail, indomain_median, complete );
%search_EXPLORE = int_search( rainha, anti_first_fail, indomain_random, complete ) ;
%search_EXPLORE = int_search( rainha, anti_first_fail, indomain_split, complete );

%%solve :: bool_search([LIST OF VARS], SELECT_VAR, DOMAIN_VAR, complete) minimize   COST_FUNCTION;
% EXAMPLE
%solve :: bool_search([ x[i,j] | i,j in 1..N ], input_order, indomain_min, complete) minimize  peso_tabuleiro;
%solve :: int_search([ x[i,j] | i,j in 1..N ], input_order, indomain_min, complete) minimize  peso_tabuleiro;
%%% SAIDA









