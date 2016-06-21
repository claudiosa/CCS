%Caroline Sala TA .... ORIGINAL
%Entrada: modelo(L)
%Saída: L = [(vermelho, maria, tales, 7, pedemoleque, ceara), (verde, luciana, francisco, 10, cuzcuz, sergipe), (azul, valentina, luiz, 8, arrozdoce, bahia), (amarelo, eduarda, jose, 9, suspiro, alagoas), (branco, fatima, roberto, 11, pamonha, paraiba)]

%%% CORRIGIDO CCS
%% 
/*
['sol_FESTADO_a_Junina.ecl'].
CONSOLE
$ eclipse --help  
$eclipse -f sol_FESTADO_a_Junina.ecl  -g main
*/
%%%mae(vestido,nome,filho,idade,comida,estado)

main :-
    cputime(T1),
    modelo(L), 
    cputime(T2),
    imprime_lista(L),
    T is (T2 - T1),
    nl,
    writeln( esta_resposta_Gastou: T  : segundos),
    fail  .

main :- 
        nl, 
        writeln('..... AQUI SOH PODE VIR UMA RESPOSTA ....'),
        writeln('........ FIM OK apos o fail .......'). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

modelo(
       [ (VESTIDO_1, NOME_1, FILHO_1, ID1, COMIDA_1, ESTADO_1),
         (VESTIDO_2, NOME_2, FILHO_2, ID2, COMIDA_2, ESTADO_2),
         (VESTIDO_3, NOME_3, FILHO_3, ID3, COMIDA_3, ESTADO_3),
         (VESTIDO_4, NOME_4, FILHO_4, ID4, COMIDA_4, ESTADO_4),
         (VESTIDO_5, NOME_5, FILHO_5, ID5, COMIDA_5, ESTADO_5)
        ])    
          :-

    %%%%%%%%%%%%%%%%%%%%%%%% estado
    estado(ESTADO_1), 
    estado(ESTADO_2), 
    estado(ESTADO_3), 
    estado(ESTADO_4), 
    estado(ESTADO_5), 

    alldifferent([ESTADO_1, ESTADO_2, ESTADO_3, ESTADO_4, ESTADO_5]),

  %A mulher que nasceu no Ceará ESTADO_á exatamente à esquerda da mulher que nasceu no estado sergipe
    (
	(ESTADO_4==ceara,ESTADO_5==sergipe);
	(ESTADO_3==ceara,ESTADO_4==sergipe);
	(ESTADO_2==ceara,ESTADO_3==sergipe);
	(ESTADO_1==ceara,ESTADO_2==sergipe)
    ),

    %%%%%%%%%%%%%%%%%%%%%%%% filho
    filho(FILHO_1),
    filho(FILHO_2),
    filho(FILHO_3),
    filho(FILHO_4),
    filho(FILHO_5),

    alldifferent([FILHO_1,FILHO_2,FILHO_3,FILHO_4,FILHO_5]),
	
    %Luiz ESTADO_á na terceira posição
    (FILHO_3==luiz),
	
    %A mãe de Francisco ESTADO_á exatamente à esquerda da mãe de Luiz
    (FILHO_2==francisco),
   
    %%%%%%%%%%%%%%%%%%%%%%%% vestido
    vestido(VESTIDO_1), 
    vestido(VESTIDO_2),
    vestido(VESTIDO_3),
    vestido(VESTIDO_4),
    vestido(VESTIDO_5),

    alldifferent([VESTIDO_1, VESTIDO_2, VESTIDO_3, VESTIDO_4, VESTIDO_5]),

    %A mulher do vestido Verde ESTADO_á exatamente à esquerda da mulher que nasceu na Bahia
    (
	(VESTIDO_4==verde,ESTADO_5==bahia);
	(VESTIDO_3==verde,ESTADO_4==bahia);
	(VESTIDO_2==verde,ESTADO_3==bahia);
	(VESTIDO_1==verde,ESTADO_2==bahia)
    ),
	
  %A mulher do vestido Vermelho ESTADO_á ao lado da mulher que nasceu em Sergipe 
    (	
	
	(ESTADO_5==sergipe,VESTIDO_4==vermelho);
	(ESTADO_4==sergipe,(VESTIDO_3==vermelho;VESTIDO_5==vermelho));
	(ESTADO_3==sergipe,(VESTIDO_2==vermelho;VESTIDO_4==vermelho));
	(ESTADO_2==sergipe,(VESTIDO_1==vermelho;VESTIDO_3==vermelho))
    ),

    %%%%%%%%%%%%%%%%%%%%%%%% nome
    nome(NOME_1), 
    nome(NOME_2), 
    nome(NOME_3), 
    nome(NOME_4), 
    nome(NOME_5),

    alldifferent([NOME_1, NOME_2, NOME_3, NOME_4, NOME_5]),

    %A Valentina ESTADO_á na terceira posição
    (NOME_3==valentina),
	
    %Valentina ESTADO_á exatamente à esquerda de Eduarda
    (NOME_4==eduarda),
	
    %Luciana ESTADO_á ao lado da mãe de Tales
    (
	(FILHO_1==tales,NOME_2==luciana);
	(FILHO_4==tales,NOME_5==luciana)
    ),
    
    %Fátima ESTADO_á ao lado da mãe que nasceu em Alagoas e por outras regras
    (
	(ESTADO_3==alagoas,NOME_2==fatima);
	(ESTADO_4==alagoas,NOME_5==fatima)
	),
    
    
    %%%%%%%%%%%%%%%%%%%%%%%% idade
    idade(ID1),
    idade(ID2),
    idade(ID3),
    idade(ID4),
    idade(ID5),

    alldifferent([ID1, ID2, ID3, ID4, ID5]),

    %O filho da Luciana tem 10 anos.
    (
	(NOME_2==luciana,ID2==10);
	(NOME_5==luciana,ID5==10)
    ),

    %A mulher do vestido Azul ESTADO_á ao lado da mãe do filho de 9 anos
    (
	(VESTIDO_4==azul,ID5==9);
	(VESTIDO_3==azul,(ID2==9;ID4==9));
	(VESTIDO_2==azul,(ID1==9;ID3==9));
	(VESTIDO_1==azul,ID2==9)
    ),
	
  %A mãe do garoto de 11 anos ESTADO_á em algum lugar à direita da mulher do vestido Azul
    (	
	(VESTIDO_4==azul,ID5==11);
	(VESTIDO_3==azul,(ID4==11;ID5==11));
	(VESTIDO_2==azul,(ID3==11;ID4==11;ID5==11));
	(VESTIDO_1==azul,(ID2==11;ID3==11;ID4==11;ID5==11))
    ),
	
   %A mãe do José ESTADO_á em algum lugar à direita da mulher do vestido Verde
    (
	(VESTIDO_4==verde,FILHO_5==jose);
	(VESTIDO_3==verde,(FILHO_4==jose;FILHO_5==jose));
	(VESTIDO_2==verde,(FILHO_4==jose;FILHO_5==jose));
	(VESTIDO_1==verde,(FILHO_4==jose;FILHO_5==jose))
    ),   

   %A mulher do vestido Amarelo ESTADO_á exatamente à esquerda da mãe do filho de 11 anos
    (
	(ID5==11,VESTIDO_4==amarelo);
	(ID4==11,VESTIDO_3==amarelo);
	(ID3==11,VESTIDO_2==amarelo);
	(ID2==11,VESTIDO_1==amarelo)
    ),
   
   %A mãe do filho de 8 anos ESTADO_á em algum lugar à direita da mulher do vestido Verde
    (
	(VESTIDO_4==verde,ID5==8);
	(VESTIDO_3==verde,(ID4==8;ID5==8));
	(VESTIDO_2==verde,(ID3==8;ID4==8;ID5==8));
	(VESTIDO_1==verde,(ID2==8;ID3==8;ID4==8;ID5==8))
    ),
        
    %%%%%%%%%%%%%%%%%%%%%%%% comida
    comida(COMIDA_1),
    comida(COMIDA_2),
    comida(COMIDA_3),
    comida(COMIDA_4),
    comida(COMIDA_5),

    alldifferent([COMIDA_1, COMIDA_2, COMIDA_3, COMIDA_4, COMIDA_5]),

    %Quem levou Cuzcuz ESTADO_á na segunda posição
    (COMIDA_2==cuzcuz),
    
	%A mãe que levou Suspiro para a fESTADO_a nasceu no estado Alagoas
    (
	(COMIDA_3==suspiro,ESTADO_3==alagoas);
	(COMIDA_4==suspiro,ESTADO_4==alagoas)
    ),
	
	%A mãe de Roberto levou Pamonha para a fESTADO_a
    (
	(FILHO_1==roberto,COMIDA_1==pamonha);
	(FILHO_4==roberto,COMIDA_4==pamonha);
	(FILHO_5==roberto,COMIDA_5==pamonha)
    ),
    
   %Quem levou Arroz doce ESTADO_á exatamente à esquerda da mãe que nasceu em Alagoas
    (COMIDA_3==arrozdoce),
   %Roberto ESTADO_á exatamente à direita de quem levou Suspiro para a fESTADO_a
    (
	(FILHO_5==roberto,COMIDA_4==suspiro)
    ),
   
    nl,
    write('CHEGAMOS AO FIM DO MODELO ... UFA')
    . %%% <== NAO ESQUECA O PONTO FINAL
/*
modelo(_) :- writeln('Houston .... we have a problem HERE'),
                    writeln('Check all the rules again......').
*/
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    %%%%BASE DE DADOS%%%%

    %vestido
    vestido(amarelo).
    vestido(azul).
    vestido(branco).
    vestido(verde).
    vestido(vermelho).

    %nomeS
    nome(eduarda).
    nome(fatima).
    nome(luciana).
    nome(maria).
    nome(valentina).

    %filho
    filho(francisco).
    filho(jose).
    filho(luiz).
    filho(roberto).
    filho(tales).
    

    %IDADE
    idade(7).
    idade(8).
    idade(9).
    idade(10).
    idade(11).

    %comida
    comida(arrozdoce).
    comida(cuzcuz).
    comida(pamonha).
    comida(pedemoleque).
    comida(suspiro).

    %estado
    estado(alagoas).
    estado(bahia).
    estado(ceara).
    estado(paraiba).
    estado(sergipe).
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DEFINICAO DE ALLDIFERENT  
	alldifferent([]).
	alldifferent([H|T]) :- not(member(H,T)),
	                      alldifferent(T).
	
	imprime_lista([]). %%%% :- write('\n FIM \n').
	imprime_lista([H|T]) :- 
                write('\n ............................................................... \n'),
	   write(' : '), write(H),
	   imprime_lista(T).

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	


