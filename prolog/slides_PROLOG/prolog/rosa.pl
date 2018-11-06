\documentstyle[portuges,isolatin1,11pt]{article}
%psfig,%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%epsf,%%%%%%%%%%%%

%\input epsf

\topmargin 0cm
\headheight 0pt
\headsep 0cm
\textheight 26cm
\textwidth 16.5cm 
\oddsidemargin 0.5cm
\evensidemargin 0.5cm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\begin{document}

\begin{verbatim}
/* 
Alexandra, Barbara, e Rosa tem roupas em
azul, verde, lilaz, vermelho e amarelo.
Nenhuma delas veste amarelo com vermelho.
Cada uma delas veste roupas com duas cores.
Alexandra está vestindo o azul.
Barbara está vestindo o amarelo mas nao o verde.
Rosa veste o verde mas nao se veste nem de azul e
nem lilaz.
Uma delas está de vermelho.
Uma das cores é usada tanto por Barbara como por Rosa.
Alexandra e Barbara ten 04 cores entre elas.
*/
    pessoa(rosa).
    pessoa(ale).     	/* Alexandra */
    pessoa(babe).  	/* Barbara */

    cor(azul).
    cor(verde).
    cor(lilaz).
    cor(vermelho).
    cor(amarelo).

    tem_uma_cor(ale,azul).    /*  esse compilador dá erro no caso de 
     tem_uma_cor    < nao aceita espaço em branco aqui>  (ale,azul).
    */
    tem_uma_cor(babe,amarelo).
    tem_uma_cor(rosa,verde).

    nao_veste(babe,verde).
    nao_veste(rosa,azul).
    nao_veste(rosa,lilaz).

    veste( X, Cor1, Cor2) :-
	    pessoa(X),
	    cor(Cor1),
	    cor(Cor2),
	    tem_uma_cor(X,Cor1),
	    /* not ===> \+ */
	    \+(  nao_veste(X, Cor2)  ),
	     \+(Cor1 = Cor2),
	    \+(   (Cor1 = vermelho , Cor2 = amarelo)
		;
		    ( Cor2 = vermelho , Cor1 = amarelo) 
		).
		

ache :- veste(X, C1, C2),
		write(X), write('  ===> '), write(C1), write('   '),
		write(C2), nl, fail.	
ache.			
/*#######################################		
?- ache.
rosa  ===> verde   vermelho
rosa  ===> verde   amarelo
ale  ===> azul   verde
ale  ===> azul   lilaz
ale  ===> azul   vermelho
ale  ===> azul   amarelo
babe  ===> amarelo   azul
babe  ===> amarelo   lilaz
Yes
?-  */
\end{verbatim}		 
\end{document}	    