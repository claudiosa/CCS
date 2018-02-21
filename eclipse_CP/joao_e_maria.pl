% Author:   Thiago Margarida
% Date: 7/6/2008
:- use_module(library(clpfd)).
:- use_module(library(clpr)).

/*Utilização: joao_maria(Joao,Maria).
Retorna Joao e Maria como sendo uma lista com 2 trabalhos, com valores de 1 a 4.*/

joao_maria([J1, J2],[M1, M2]) :-
   
   %define que cada trabalho (Joao1, Joao2, Maria1 e Maria2) pode assumir valores de 1 a 4 (4 trabalhos)
   J1 in 1..4,
   J2 in 1..4,
   M1 in 1..4,
   M2 in 1..4,


   %Cria lista com a duração de cada trabalho, para cada pessoa (Joao e Maria)
   TrabsJoao = [4.5, 7.8, 3.6, 2.9],
   TrabsMaria = [4.5, 7.8, 3.6, 2.9],

   %Pega o Tempo do trabalho (TempoJoao1 (TJ1), TempoMaria1 (TM1),...) na lista de durações dos trabalhos
   nth1(J1, TrabsJoao, TJ1),
   nth1(J2, TrabsJoao, TJ2),
   nth1(M1, TrabsMaria, TM1),
   nth1(M2, TrabsMaria, TM2),


   %Verifica se são todos diferentes (Cada trabalho é realizado uma vez, por uma pessoa)
   all_different([J1, J2, M1, M2]),
   

   %Computa o tempo total gasto por Maria e Joao, e salva o resultado em TotalMaria (TM) e TotalJoao (TJ)
   sumlist([TM1,TM2], TM),
   sumlist([TJ1,TJ2], TJ),
   

   %Verifica se a diferença do tempo total gasto por joão e maria não é maior que 3 horas
   TJ-TM =<3,
   TM-TJ =<3,
   
   %Verifica o tempo toatl gasto por Joao E Maria
   %Poderia ser feito com sumlis([TM, TJ], Sum),
   sumlist([TM1,TM2,TJ1,TJ2], Sum),
   Sum =< 19,

   %Executa o labeling para procurar respostas
   %Para minimizar o tempo total, deve ser colocado um minimize(Sum) no labeling
   labeling([ff],  [J1, J2, M1, M2]),

   %Imprime o tempo de Joao, Maria, e o tempo total
   format('Total Joao: ~w \t Total Maria: ~w\n',[TJ, TM]),
   format('Tempo Total: ~w', [Sum]),
   !.
