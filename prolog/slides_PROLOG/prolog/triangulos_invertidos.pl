/**
 * Programa desenvolvido na disciplina de IIA - Introducao a Inteligencia Artificial
 *  do programa de Mestrado em Engenharia Eletrica da UDESC - Universidade para o 
 *  Desenvolvimento do Estado de Santa Catarina - 28/04/2004, sob orientacao do Prof. Dr. Claudio Cesar Sá.
 *  Autor: Valmor Adami Junior.
 *  Este fonte eh de domínio publico. Pode ser utilizado para fins de ensino e
 *  em projetos privados desde que seja citado o nome do autor bem como este cabecalho.
 *  www.joinville.udesc.br/ ,  www.joinville.udesc.br/claudio 
 */


/*Imprime uma linha de *'s, sem pular linha. */
ast(1):- write('*'). /*alterar para writeln para pular linha.*/
ast(N2):- write('*'), is(N1 , (N2-1)), ast(N1).

/* Imprimir brancos.*/

brco(0).
brco(N):-  is(N1, (N-1)), brco(N1), write(' '). 

/* Imprime uma linha de 1 triangulo.*/
/* N1 - asteristicos, N2 - espaços em branco.*/
linBasica(N1, N2):- ast(N1), brco(N2).


/*Repete uma linBasica, asteristicos e espacos em branco, para cada Triangulo que haverah numa
    linha de triangulos. A linBasica refere-se a uma parte de um triangulo. */
/* N1 - asteristicos, N2 - espaços em branco.*/
lin(0, _, _).
lin(Cont, N1, N2):-  is(Cont1, (Cont-1)), 
                                lin(Cont1, N1, N2),
		linBasica(N1, N2).


/* Repete uma linha Cont vezes recalculando o numero de asteristicos e de espacos em branco,
     ou seja, escreve uma linha de Triangulos.
     N1 sao os *'s e N3 os espaços em branco (Base - Cont).
     P/ N = 3 , 1st:  3*'s  e 0 espacos;
                       2nd: 2*'s e 1 espaco;
                       3nd: 1*'s e 2 espacos;
*/
linTriang(0, _, _).
linTriang(Cont, Base, N1):- 	is(N3, (Base - Cont)), 
                                             	is(Cont1, (Cont -1)), 
			is(N4, (N1-1)),
                               		linTriang(Cont1, Base, N4), 
		  lin(Base, N1, N3),  writeln('').


/* BASE eh a base dos triangulos, 
    portanto o numero de vezes a repetir as linhas de triangulos e o numero 
    inicial de *'s nas linhas básicas da primeira linha de triangulos.
*/
tri(Base):- linTriang(Base, Base, Base).

/*clausula Inicial. 
    BASE eh a base dos triangulos.
    Criar um triangulo de triangulos.
*/
piramide(0).
piramide(Base):- 	is(Cont1, (Base-1)), 
		piramide(Cont1),
		tri(Base).

/*Mneumonico*/
pir(N):- piramide(N).
