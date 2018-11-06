%%		Alunos: Jonathan de Oliveira Cardoso	
%%				Eduardo de França Hofelmann
%%R_1: A moça que quer viajar está ao lado de quem tem 24 anos.
%%R_2: A Clarissa está em algum lugar à esquerda de quem tem 23 anos.
%%R_3: A Vivian está exatamente à direita da mulher mais velha.
%%R_4: A namorada do Otávio é a mulher mais nova do grupo.
%%R_5: A moça que namora o Daniel está na última posição.
%%R_6: A Fabiana está em algum lugar entre quem tem 20 anos e quem quer viajar, nessa ordem.
%%R_7: Quem namora o Marcelo está ao lado da Vivian.
%%R_8: A Vivian está em algum lugar à esquerda de quem pretende economizar dinheiro.
%%R_9: Quem quer ler mais no ano novo está ao lado da Vivian.
%%R_10: Quem gostaria de emagrecer está na segunda posição.
%%R_11: A Thaís está ao lado da mulher que namora o Otávio.
%%R_12: A moça de bolsa amarela está exatamente à esquerda da Ana.
%%R_13: A mulher de 19 anos está ao lado da mulher de bolsa verde.
%%R_14: Quem tem a bolsa branca está em algum lugar entre a moça de 20 anos e a de 26 anos, nessa ordem.
%%R_15: A cor da bolsa da Ana é vermelha.
%%R_16: A Thaís está ao lado da Fabiana.
%%R_17: A mulher de 26 anos está exatamente à esquerda da mulher que namora o Alexandre.
%%R_18: A mulher de bolsa verde está em algum lugar à direita da Thaís.

main :- modelo([ N1, N2, N3, N4, N5]),
	    imprime_lista([ N1, N2, N3, N4, N5]), 
	    fail.

main:- nl,
	   write(' DEVE EXISTIR APENAS UMA UNICA SOLUCAO  ACIMA '),
	   nl.



modelo(
       [
        (Nome_1, Bolsa_1, Resolucao_1, Namorado_1, Idade_1),
        (Nome_2, Bolsa_2, Resolucao_2, Namorado_2, Idade_2),
        (Nome_3, Bolsa_3, Resolucao_3, Namorado_3, Idade_3),
        (Nome_4, Bolsa_4, Resolucao_4, Namorado_4, Idade_4),
        (Nome_5, Bolsa_5, Resolucao_5, Namorado_5, Idade_5)
        ] %%% 5 elementos na lista ...
        )
        :-
		
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BUSCA NA BASE DE FATOS DA >>>>>>>>>>>>>
        nome(Nome_1), 
        nome(Nome_2), 
        nome(Nome_3), 
        nome(Nome_4), 
        nome(Nome_5),
	    alldifferent([Nome_1, Nome_2, Nome_3, Nome_4, Nome_5]),
        %%% TODAS AS regras sobre Nome_ E mochila .....
		((==(Nome_1, thais) , ==(Nome_2, fabiana));
		 (==(Nome_2, thais) , ==(Nome_1, fabiana));
		 (==(Nome_2, thais) , ==(Nome_3, fabiana));
		 (==(Nome_3, thais) , ==(Nome_2, fabiana));
		 (==(Nome_3, thais) , ==(Nome_4, fabiana));
		 (==(Nome_4, thais) , ==(Nome_3, fabiana));
		 (==(Nome_4, thais) , ==(Nome_5, fabiana));
		 (==(Nome_5, thais) , ==(Nome_4, fabiana))
		), %%R_16
			

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BUSCA NA BASE DE FATOS DA >>>>>>>>>>>>>
        bolsa(Bolsa_1), 
        bolsa(Bolsa_2), 
        bolsa(Bolsa_3), 
        bolsa(Bolsa_4), 
        bolsa(Bolsa_5),
	    alldifferent([Bolsa_1, Bolsa_2, Bolsa_3, Bolsa_4, Bolsa_5]),
        %%% TODAS AS regras sobre bolsa, nome, mochila .....
		
		((==(Bolsa_1, amarela) , ==(Nome_2, ana));
		 (==(Bolsa_2, amarela) , ==(Nome_3, ana));
		 (==(Bolsa_3, amarela) , ==(Nome_4, ana));
		 (==(Bolsa_4, amarela) , ==(Nome_5, ana))
		), %%R_13
		
		((==(Bolsa_1, vermelha) , ==(Nome_1, ana));
		 (==(Bolsa_2, vermelha) , ==(Nome_2, ana));
		 (==(Bolsa_3, vermelha) , ==(Nome_3, ana));
		 (==(Bolsa_4, vermelha) , ==(Nome_4, ana));
		 (==(Bolsa_5, vermelha) , ==(Nome_5, ana))
		), %%R_15
		
        ((==(Nome_1, thais) , ==(Bolsa_2, verde));
		 (==(Nome_1, thais) , ==(Bolsa_3, verde));
		 (==(Nome_1, thais) , ==(Bolsa_4, verde));
		 (==(Nome_1, thais) , ==(Bolsa_5, verde));
		 (==(Nome_2, thais) , ==(Bolsa_3, verde));
		 (==(Nome_2, thais) , ==(Bolsa_4, verde));
		 (==(Nome_2, thais) , ==(Bolsa_5, verde));
		 (==(Nome_3, thais) , ==(Bolsa_4, verde));
		 (==(Nome_3, thais) , ==(Bolsa_5, verde));
		 (==(Nome_4, thais) , ==(Bolsa_5, verde))
		),%%R_18
		
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BUSCA NA BASE DE FATOS DA >>>>>>>>>>>>>
        resolucao(Resolucao_1), 
        resolucao(Resolucao_2), 
        resolucao(Resolucao_3), 
        resolucao(Resolucao_4), 
        resolucao(Resolucao_5),
	    alldifferent([Resolucao_1, Resolucao_2, Resolucao_3, Resolucao_4, Resolucao_5]),
        %%% TODAS AS regras sobre resolucao, bolsa, nome, mochila ....
			==( Resolucao_2, emagrecer), %%R_10
			
			((==(Nome_1, vivian) , ==(Resolucao_2, economizar));
			 (==(Nome_1, vivian) , ==(Resolucao_3, economizar));
			 (==(Nome_1, vivian) , ==(Resolucao_4, economizar));
			 (==(Nome_1, vivian) , ==(Resolucao_5, economizar));
			 (==(Nome_2, vivian) , ==(Resolucao_3, economizar));
			 (==(Nome_2, vivian) , ==(Resolucao_4, economizar));
			 (==(Nome_2, vivian) , ==(Resolucao_5, economizar));
			 (==(Nome_3, vivian) , ==(Resolucao_4, economizar));
			 (==(Nome_3, vivian) , ==(Resolucao_5, economizar));
			 (==(Nome_4, vivian) , ==(Resolucao_5, economizar))
			), %%R_8
			
			((==(Nome_1, vivian) , ==(Resolucao_2, ler));
			 (==(Nome_2, vivian) , ==(Resolucao_3, ler));
			 (==(Nome_2, vivian) , ==(Resolucao_4, ler));
			 (==(Nome_3, vivian) , ==(Resolucao_4, ler));
			 (==(Nome_3, vivian) , ==(Resolucao_5, ler));
			 (==(Nome_4, vivian) , ==(Resolucao_3, ler));
			 (==(Nome_4, vivian) , ==(Resolucao_5, ler));
			 (==(Nome_5, vivian) , ==(Resolucao_4, ler))
			), %%R_9
			
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BUSCA NA BASE DE FATOS DA >>>>>>>>>>>>>
        namorado(Namorado_1), 
        namorado(Namorado_2), 
        namorado(Namorado_3), 
        namorado(Namorado_4), 
        namorado(Namorado_5),	
	    alldifferent([Namorado_1, Namorado_2, Namorado_3, Namorado_4, Namorado_5]),
        %%% TODAS AS regras sobre namorado, resolucao, bolsa, nome, mochila .....
			==(Namorado_5, daniel), %%R_5
			
			((==(Namorado_1, marcelo), ==(Nome_2, vivian));
			 (==(Namorado_2, marcelo), ==(Nome_1, vivian));
			 (==(Namorado_2, marcelo), ==(Nome_3, vivian));
			 (==(Namorado_3, marcelo), ==(Nome_2, vivian));
			 (==(Namorado_3, marcelo), ==(Nome_4, vivian));
			 (==(Namorado_4, marcelo), ==(Nome_3, vivian));
			 (==(Namorado_4, marcelo), ==(Nome_5, vivian));
			 (==(Namorado_5, marcelo), ==(Nome_4, vivian))
			), %%R_7
			
			((==(Namorado_2, otavio), ==(Nome_1, thais));
			 (==(Namorado_1, otavio), ==(Nome_2, thais));
			 (==(Namorado_3, otavio), ==(Nome_2, thais));
			 (==(Namorado_2, otavio), ==(Nome_3, thais));
			 (==(Namorado_4, otavio), ==(Nome_3, thais));
			 (==(Namorado_3, otavio), ==(Nome_4, thais));
			 (==(Namorado_5, otavio), ==(Nome_4, thais));
			 (==(Namorado_4, otavio), ==(Nome_5, thais))
			), %%R_11
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BUSCA NA BASE DE FATOS DA >>>>>>>>>>>>>
		idade(Idade_1), 
		idade(Idade_2), 
		idade(Idade_3), 
		idade(Idade_4), 
		idade(Idade_5),
	    alldifferent([Idade_1, Idade_2, Idade_3, Idade_4, Idade_5]),
        %%% TODAS AS regras sobre idade, namorado, resolucao, bolsa, nome, mochila .....
			
			((==(Nome_1, clarissa) , ==(Idade_2, 23));
			 (==(Nome_1, clarissa) , ==(Idade_3, 23));
			 (==(Nome_1, clarissa) , ==(Idade_4, 23));
			 (==(Nome_1, clarissa) , ==(Idade_5, 23));
			 (==(Nome_2, clarissa) , ==(Idade_3, 23));
			 (==(Nome_2, clarissa) , ==(Idade_4, 23));
			 (==(Nome_2, clarissa) , ==(Idade_5, 23));
			 (==(Nome_3, clarissa) , ==(Idade_4, 23));
			 (==(Nome_3, clarissa) , ==(Idade_5, 23));
			 (==(Nome_4, clarissa) , ==(Idade_5, 23))
			), %%R_2
			
			((==(Nome_5, vivian) , ==(Idade_4, 26));
			 (==(Nome_4, vivian) , ==(Idade_3, 26));
			 (==(Nome_3, vivian) , ==(Idade_2, 26));
			 (==(Nome_2, vivian) , ==(Idade_1, 26))
			), %%R_3
			
			((==(Resolucao_1, viajar) , ==(Idade_2, 24));
			 (==(Resolucao_2, viajar) , ==(Idade_1, 24));
			 (==(Resolucao_2, viajar) , ==(Idade_3, 24));
			 (==(Resolucao_3, viajar) , ==(Idade_2, 24));
			 (==(Resolucao_3, viajar) , ==(Idade_4, 24));
			 (==(Resolucao_4, viajar) , ==(Idade_3, 24));
			 (==(Resolucao_4, viajar) , ==(Idade_5, 24));
			 (==(Resolucao_5, viajar) , ==(Idade_4, 24))
			), %%R_1
			
			((==(Namorado_1, otavio), ==(Idade_1, 19));
			 (==(Namorado_2, otavio), ==(Idade_2, 19));
			 (==(Namorado_3, otavio), ==(Idade_3, 19));
			 (==(Namorado_4, otavio), ==(Idade_4, 19));
			 (==(Namorado_5, otavio), ==(Idade_5, 19))
			), %%R_4
			
			
			((==(Idade_1, 20) , ==(Nome_2, fabiana), ==(Resolucao_3, viajar));
			 (==(Idade_1, 20) , ==(Nome_2, fabiana), ==(Resolucao_4, viajar));
			 (==(Idade_1, 20) , ==(Nome_2, fabiana), ==(Resolucao_5, viajar));
			 (==(Idade_2, 20) , ==(Nome_3, fabiana), ==(Resolucao_4, viajar));
			 (==(Idade_2, 20) , ==(Nome_3, fabiana), ==(Resolucao_5, viajar));
			 (==(Idade_3, 20) , ==(Nome_4, fabiana), ==(Resolucao_5, viajar))
			), %%R_6
			
			((==(Idade_1, 19) , ==(Bolsa_2, verde));
			 (==(Idade_2, 19) , ==(Bolsa_1, verde));
			 (==(Idade_2, 19) , ==(Bolsa_3, verde));
			 (==(Idade_3, 19) , ==(Bolsa_2, verde));
			 (==(Idade_3, 19) , ==(Bolsa_4, verde));
			 (==(Idade_4, 19) , ==(Bolsa_3, verde));
			 (==(Idade_4, 19) , ==(Bolsa_5, verde));
			 (==(Idade_5, 19) , ==(Bolsa_4, verde))
			), %%R_13
			
			((==(Idade_1, 26) , ==(Namorado_2, alexandre));
			 (==(Idade_2, 26) , ==(Namorado_3, alexandre));
			 (==(Idade_3, 26) , ==(Namorado_4, alexandre));
			 (==(Idade_4, 26) , ==(Namorado_5, alexandre))
			), %%R_17
			
			((==(Idade_1, 20) , ==(Bolsa_2, branca), ==(Idade_3, 26));
			 (==(Idade_1, 20) , ==(Bolsa_2, branca), ==(Idade_4, 26));
			 (==(Idade_1, 20) , ==(Bolsa_2, branca), ==(Idade_5, 26));
			 (==(Idade_2, 20) , ==(Bolsa_3, branca), ==(Idade_4, 26));
			 (==(Idade_2, 20) , ==(Bolsa_3, branca), ==(Idade_5, 26));
			 (==(Idade_3, 20) , ==(Bolsa_4, branca), ==(Idade_5, 26))
			), %%R_14
			
			
        nl,
        write(' => CHEGOU AO FINAL DO MODELO - LOGO HAH UMA SOLUCAO  <= ').


 % modelo(_) :-       
 %       nl,
 %       write(' .......... FIM DO PROGRAMA.  ..........').




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Base de FATOS  --- BD
nome(ana). 
nome(clarissa). 
nome(fabiana). 
nome(thais). 
nome(vivian).

bolsa(amarela). 
bolsa(azul). 
bolsa(branca). 
bolsa(verde). 
bolsa(vermelha).

resolucao(ingles).
resolucao(emagrecer).
resolucao(ler).
resolucao(economizar).
resolucao(viajar).

namorado(alexandre).
namorado(daniel).
namorado(julio).
namorado(marcelo).
namorado(otavio).

idade(19).
idade(20).
idade(23).
idade(24).
idade(26).




% DEFINICAO DE ALLDIFERENT  

alldifferent([]).
alldifferent([H|T]):- not(member(H,T)),
                      alldifferent(T).

imprime_lista([]):- write('\n\n FIM \n').
imprime_lista([H|T]):- write('\n.............\n'),
                       write(H),
                       imprime_lista(T).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%