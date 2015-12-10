% http://rachacuca.com.br/logica/problemas/laboratorio-de-informatica/

% Autor: Gabriel Mazzoleni Pinto
% Adaptado CCS
%% Originalmente este programa executava em 9 segundos

main :-  
   %% Tempo inicial
    statistics(cputime,T1),

    modelo(  [A1, A2, A3, A4,A5]  ),
    imprime_lista(  [A1, A2, A3, A4,A5]  ),

    %% Tempo final
    statistics(cputime ,T2),
    Tempo_BUSCA is T2 - T1,
    format('\n T1: ~f \t T2: ~f  msec', [T1, T2]),
    format('\n Tempo total: ~10f  msec', Tempo_BUSCA), 
    fail.

main :- 
        nl, 
        write('xxxx AQUI SOH PODE VIR UMA RESPOSTA ....'),
        nl, 
        write('........ UFA apos o fail .......'). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modelo([
    (Mochila_1, Nome_1, Mes_1, Jogo_1, Materia_1, Suco_1),
    (Mochila_2, Nome_2, Mes_2, Jogo_2, Materia_2, Suco_2),
    (Mochila_3, Nome_3, Mes_3, Jogo_3, Materia_3, Suco_3),
    (Mochila_4, Nome_4, Mes_4, Jogo_4, Materia_4, Suco_4),
    (Mochila_5, Nome_5, Mes_5, Jogo_5, Materia_5, Suco_5)
    ]):-


%%%%%%%%%%%%%%%%%%%%%%%% Mochila
mochila(Mochila_1), 
mochila(Mochila_2), 
mochila(Mochila_3), 
mochila(Mochila_4), 
mochila(Mochila_5),
alldifferent([Mochila_1, Mochila_2, Mochila_3, Mochila_4, Mochila_5]),

%%%%%%%%%
%%%%%%%%%%%%%%% Nome

    nome(Nome_1), 
    nome(Nome_2), 
    nome(Nome_3), 
    nome(Nome_4), 
    nome(Nome_5),

%% REGRAS ESPECIFICAS DEVEM VIR LOGO  
%Lenin está na quinta posição.
(Nome_5==lenin) ,
   
%Otávio está em uma das pontas. <- pela afirmação anterior 
(Nome_1==otavio) ,

alldifferent([Nome_1, Nome_2, Nome_3, Nome_4, Nome_5]),

%O garoto da mochila Branca está exatamente à esquerda de Will.

(
%%(Nome_5==will, Mochila_4==branca);
(Nome_4==will, Mochila_3==branca);
(Nome_3==will, Mochila_2==branca);
(Nome_2==will, Mochila_1==branca)
),
   
%%%%%%%%%%%%%%%%%%%%%%%% Mês
    mes(Mes_1), 
    mes(Mes_2), 
    mes(Mes_3), 
    mes(Mes_4), 
    mes(Mes_5),
    alldifferent([Mes_1, Mes_2, Mes_3, Mes_4, Mes_5]),

%O garoto da mochila Azul está em algum lugar à esquerda
% de quem nasceu em Maio.

(
(Mes_5==maio, (Mochila_4==azul ; Mochila_3==azul ; Mochila_2==azul ; Mochila_1==azul));
(Mes_4==maio, (Mochila_3==azul ; Mochila_2==azul ; Mochila_1==azul));
(Mes_3==maio, (Mochila_2==azul ; Mochila_1==azul));
(Mes_2==maio, Mochila_1==azul)
),

%O menino que nasceu em Janeiro está ao lado de quem nasceu em Setembro.

(
(Mes_1==jan , Mes_2==set);
(Mes_2==jan , (Mes_1==set ; Mes_3==set));
(Mes_3==jan , (Mes_2==set ; Mes_4==set));
(Mes_4==jan , (Mes_3==set ; Mes_5==set));
(Mes_5==jan , Mes_4==set)
),
    
%O dono da mochila Azul nasceu em Janeiro.
(
(Mochila_1==azul , Mes_1==jan);
(Mochila_2==azul , Mes_2==jan);
(Mochila_3==azul , Mes_3==jan);
(Mochila_4==azul , Mes_4==jan);
(Mochila_5==azul , Mes_5==jan)
),
   

%%%%%%%%%%%%%%%%%%%%%%%% Jogo
jogo(Jogo_1), jogo(Jogo_2), jogo(Jogo_3), jogo(Jogo_4), jogo(Jogo_5),

%%% REGRA ESPECIFICA
%Na terceira posição está o menino que gosta do Jogo da Forca
(Jogo_3 == forca),

alldifferent([Jogo_1, Jogo_2, Jogo_3, Jogo_4, Jogo_5]),

%REGRA MAIS ESPECIFICA QUE AS PROXIMA
%Em uma das pontas está o menino que adora jogar Cubo Vermelho.
(Jogo_1==cubo ; Jogo_5==cubo),

    
%Will está ao lado do menino que gosta de Problemas de Lógica.
(
(Jogo_1==logica, Nome_2==will);
(Jogo_2==logica, (Nome_1==will ; Nome_3==will));
%%%%(Jogo_3==logica, (Nome_2==will ; Nome_4==will));
(Jogo_4==logica, (Nome_3==will ; Nome_5==will));
(Jogo_5==logica, Nome_4==will)
),
    
%O garoto que gosta do Jogo da Forca está ao lado do que gosta do 3 ou Mais.

(
(Jogo_1==tmais, Jogo_2==forca);
(Jogo_2==tmais, (Jogo_1==forca ; Jogo_3==forca));
%%%%(Jogo_3==tmais, (Jogo_2==forca ; Jogo_4==forca));
(Jogo_4==tmais, (Jogo_3==forca ; Jogo_5==forca));
(Jogo_5==tmais, Jogo_4==forca)
),

    
%Quem gosta do Jogo da Forca está ao lado do dono da mochila Vermelha.
(
(Mochila_2==vermelha , Jogo_3==forca);
(Mochila_4==vermelha ,  Jogo_3==forca)
),
    
%Quem curte Problemas de Lógica está ao lado do menino da mochila Amarela.
(
(Jogo_1==logica , Mochila_2==amarela);
(Jogo_2==logica , (Mochila_1==amarela ; Mochila_3==amarela));
(Jogo_3==logica , (Mochila_2==amarela ; Mochila_4==amarela));
(Jogo_4==logica , (Mochila_3==amarela ; Mochila_5==amarela));
(Jogo_5==logica , Mochila_4==amarela)
),
    
%O garoto que nasceu em Setembro está ao lado de quem gosta de jogar Cubo Vermelho.
(
(Mes_1==set , Jogo_2==cubo);
(Mes_2==set , (Jogo_1==cubo ; Jogo_3==cubo));
(Mes_3==set , (Jogo_2==cubo ; Jogo_4==cubo));
(Mes_4==set , (Jogo_3==cubo ; Jogo_5==cubo));
(Mes_5==set , Jogo_4==cubo)
),
   

%%%%%%%%%%%%%%%%%%%%%%%% Matéria
materia(Materia_1), materia(Materia_2), materia(Materia_3), materia(Materia_4), materia(Materia_5),
alldifferent([Materia_1, Materia_2, Materia_3, Materia_4, Materia_5]),

%João gosta de história.
%% INTERESSANTE MAS JAH SE SABE O NOME DE ALGUNS MENINOS
%% LOGO CORTAR ALGUMAS DESTAS REGRAS
(
(Nome_1==joao , Materia_1==hist);
(Nome_2==joao , Materia_2==hist);
(Nome_3==joao , Materia_3==hist);
(Nome_4==joao , Materia_4==hist);
(Nome_5==joao , Materia_5==hist)
),
    
%O menino que gosta de Matemática nasceu em Dezembro.
(
(Materia_1==mat , Mes_1==dez);
(Materia_2==mat , Mes_2==dez);
(Materia_3==mat , Mes_3==dez);
(Materia_4==mat , Mes_4==dez);
(Materia_5==mat , Mes_5==dez)
),
 
%%%%%%%%%%%%%%%%%%%%%%%% Suco
suco(Suco_1), suco(Suco_2), suco(Suco_3), suco(Suco_4), suco(Suco_5),

% REGRAS ESPECIFICAS
%Na primeira posição está quem gosta de suco de Limão.
Suco_1==limao,

%Na terceira posição está quem gosta de suco de Morango.
Suco_3==morango,

%%% ELIMINE O QUE DESCREVA SOBRE ESTES DOIS SUCOS
%%% pois jah se sabe limao eh Suco_1 e morango eh Suco_3

alldifferent([Suco_1, Suco_2, Suco_3, Suco_4, Suco_5]),

      
%Quem nasceu em Setembro está ao lado de quem gosta de suco de Laranja.

(
(Mes_1==set, Suco_2==laranja);
%%%(Mes_2==set, (Suco_1==laranja ; Suco_3==laranja));
(Mes_3==set, (Suco_2==laranja ; Suco_4==laranja));
(Mes_4==set, Suco_5==laranja);
(Mes_5==set, Suco_4==laranja)
),

%Quem gosta de suco de Uva gosta de Problemas de Lógica.   
(
%%%%%(Suco_1==uva , Jogo_1==logica);
(Suco_2==uva , Jogo_2==logica);
%%%%(Suco_3==uva , Jogo_3==logica);
(Suco_4==uva , Jogo_4==logica);
(Suco_5==uva , Jogo_5==logica)
),
      
%O menino que gosta de suco de Uva está em algum lugar à direita do garoto da mochila Azul.
(
(Mochila_1==azul , (Suco_2==uva ;  Suco_4==uva ; Suco_5==uva));
(Mochila_2==azul , (Suco_4==uva ; Suco_5==uva));
(Mochila_3==azul , (Suco_4==uva ; Suco_5==uva));
(Mochila_4==azul , Suco_5==uva)
),
        
%O garoto que gosta de Biologia gosta de suco de Morango.
(
%%%(Materia_1==bio , Suco_1==morango);
%%%(Materia_2==bio , Suco_2==morango);
(Materia_3==bio , Suco_3==morango)
%%%(Materia_4==bio , Suco_4==morango);
%%%(Materia_5==bio , Suco_5==morango)
),
    
    
%Quem gosta de suco de Uva está exatamente à esquerda de quem gosta de Português.
(
(Materia_5==port , Suco_4==uva);
%%% (Materia_4==port , Suco_3==uva);
(Materia_3==port , Suco_2==uva)
%%%(Materia_2==port , Suco_1==uva)
),
        
    
%Quem gosta de Matemática gosta também de suco de Maracujá.
(
%%%% (Materia_1==mat, Suco_1==maracuja);
(Materia_2==mat, Suco_2==maracuja);
%%% (Materia_3==mat, Suco_3==maracuja);
(Materia_4==mat, Suco_4==maracuja);
(Materia_5==mat, Suco_5==maracuja)
),

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FINALMENTE
nl,
write('CHEGAMOS AO FIM DO MODELO')

. %%% <== NAO ESQUECA O PONTO FINAL
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fatos    
   
%%%%BASE DE DADOS%%%%

%MOCHILAS
mochila(amarela).
mochila(azul).
mochila(branca).
mochila(verde).
mochila(vermelha).

%NOMES
nome(denis).
nome(joao).
nome(lenin).
nome(otavio).
nome(will).

%MÊS
mes(ago).
mes(dez).
mes(jan).
mes(maio).
mes(set).


%JOGOS
jogo(tmais).
jogo(cacap).
jogo(cubo).
jogo(forca).
jogo(logica).

%MATÉRIAS
materia(bio).
materia(geo).
materia(hist).
materia(mat).
materia(port).

%SUCOS
suco(laranja).
suco(limao).
suco(maracuja).
suco(morango).
suco(uva).

% DEFINICAO DE ALLDIFERENT  
	alldifferent([]).
	alldifferent([H|T]):- not(member(H,T)),
	                      alldifferent(T).
	
	imprime_lista([]):- write('\n\n FIM do imprime_lista \n').
	imprime_lista([H|T]):- 
		write('\n......................................\n'),
	        write(H), write(' : '),
	        imprime_lista(T).

/**********************************************************/
	



    
    
