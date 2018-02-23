% Aluno: 	    Rafael Giordano Vieira 
% 
% Disciplina:   Lógica Matemática (LMA) - 2013/2
% Data: 		01/12/2012
% UMA MODELAGEM AVANCADA PARA MEDIA DOS ALUNOS DE LMA
% Como solicitado, os nomes dos homens foram alterados da seguinte maneira
%
% 1. farfinelli -> rafael
% 2. rui        -> fernanda
% 3. milton     -> paulo
% 4. walter     -> claudio
% 5. nascimento -> rogerio
%
% Para rodar o codigo, vá até o terminal e digite: 
%
% 1. swipl
% 2. ['esquadrilha_avioes.pl'].
% 3. solucao(S).	
%
% Protinho :)


% Abordagem um pouco diferente do primeiro exercício (fila do banco).

% 1) Primeiro passo: Definindo novas regras para o problema

% Verifica se X é vizinho de Y (nextto verifica se X aparece depois de Y na lista e vice-versa)
vizinho(X, Y, S) :- nextto(X, Y, S) ; nextto(Y, X, S).

% Verifica se o primeiro elemento de uma lista S é A e o terceiro elemento da lista é B
entre(A, B, [A, _, B | _]).


% p(Piloto, Cor, Anomalia, Bebida, Esporte)
% 2) Gerando solução para o Problema
solucao2(S) :-
	S = [_, _, _, _, _], % Singleton variables: [P1,P2,P3,P4,P5]
	%gera(P1), gera(P2), gera(P3), gera(P4), gera(P5),
	%todas_dif(P1, P2, P3, P4, P5),
	
	% O avião do Cel. Milton (paulo) solta fumaça vermelha.
	member(p(paulo, vermelha, _, _, _), S), 

	% O rádio transmissor do Ten. Walter (claudio) está com problemas.
	member(p(claudio, _, radio, _, _), S),

	% O piloto do avião que solta fumaça verde adora pescar.
	member(p(_, verde, _, _, pesca), S),

	% O Major Rui (fernanda) joga futebol nos finais de semana.
	member(p(fernanda, _, _, _, futebol), S),

	% O avião que solta fumaça verde está imediatamente à direita do avião que solta fumaça branca.
	vizinho(p(_, branca, _, _, _), p(_, verde, _, _, _), S),

	% O piloto que bebe leite está com o altímetro desregulado.
	member(p(_, _, altimetro, leite, _), S),

	% O piloto do avião que solta fumaça preta bebe cerveja.
	member(p(_, preta, _, cerveja, _), S),

	% O praticante de natação pilota o avião que solta fumaça vermelha.
	member(p(_, vermelha, _, _, natacao), S),

	% O Cap. Farfarelli (rafael) está na ponta esquerda da formação.
	[p(rafael, _, _, _, _) | _] = S, 

	% O piloto que bebe café voa ao lado do avião que está com pane no sistema hidráulico.
	vizinho(p(_, _, _, cafe, _), p(_, _, hidraulico, _, _), S),

	% O piloto que bebe cerveja voa ao lado do piloto que enfrenta problemas na bússola.
	vizinho(p(_, _, _, cerveja, _), p(_, _, bussola, _, _), S),

	% O homem que pratica equitação gosta de beber chá.
	member(p(_, _, _, cha, equitacao), S),

	% O Cap. Nascimento (rogerio) bebe somente água.
	member(p(rogerio, _, _, agua, _), S), 

	% O Cap. Farfarelli (rafael) voa ao lado do avião que solta fumaça azul.
	vizinho(p(rafael, _, _, _, _), p(_, azul, _, _, _), S),

	% Na formação, há um avião entre o que tem problema hidráulico e o com pane no altímetro.
	entre(p(_, _, hidraulico, _, _), p(_, _, altimetro, _, _), S),

	% Preenchendo ultimas 2 lacunas
	member(p(_, _, _, _, tenis), S),
	member(p(_, _, temperatura, _, _), S),

	!.
