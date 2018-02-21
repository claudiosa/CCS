     
/*     
	  Segue um exemplo da solução de um problema usando programações 
	  por restrições. Neste problema aparentemente simples: temos 
	  6kg de açúcar, 5kg de trigo, 670 ovos e 18 colheres de 
	  fermento e queremos saber quantas cucas podemos fazer com 
	  esses produtos baseado na receita de cuca da vovó: (200g 
	  açúcar, 300g trigo, 4 ovos,1 colher fermento)

++++++++++++++++++++++++++++++++++++++++++++++++++

import javax.constraints.impl.Problem;
import javax.constraints.Var;
import javax.constraints.Solver;
import javax.constraints.Solution;

    public static void main(String[] args) {

        Var acucar = variable(“Açucar(g)”, 0, 6000);
        Var trigo = variable(“Trigo(g)”, 0, 5000);
        Var ovos = variable(“Ovos”, 0, 670);
        Var fermento = variable(“Fermento”, 0, 18);
        Var cuca = variable(“Cuca Pronta”, 0, 1000000);

        // Modelagem Receita de Cuca:
        // Ingrediente 200g de açúcar, 300g de trigo, 4 ovos, 1 colher fermento

        post(acucar, “=”, mult(200, cuca));
        post(trigo, “=”, mult(300, cuca));
        post(fermento, “=”, mult(1, cuca));
        post(ovos, “=”, mult(4, cuca));       

        Solution solution = getSolver().findOptimalSolution(cuca);
        if (solution != null) {
            solution.log();
        }
    }

Resultado do programa: 

- Solution #1 found. Objective: 0, 1 Solutions, 0 Time (ms), 2 Nodes, 0 Backtracks, 0 Restarts.  Açucar(g):0, Trigo(g):0, Ovos:0, Fermento:0, Cuca Pronta:0,

- Solution #2 found. Objective: 1, 2 Solutions, 0 Time (ms), 4 Nodes, 0 Backtracks, 1 Restarts.  Açucar(g):200, Trigo(g):300, Ovos:4, Fermento:1, Cuca Pronta:1,

- Solution #3 found. Objective: 2, 3 Solutions, 0 Time (ms), 6 Nodes, 0 Backtracks, 2 Restarts.   Açucar(g):400, Trigo(g):600, Ovos:8, Fermento:2, Cuca Pronta:2,

- Solution #4 found. Objective: 3, 4 Solutions, 0 Time (ms), 8 Nodes, 0 Backtracks, 3 Restarts.   Açucar(g):600, Trigo(g):900, Ovos:12, Fermento:3, Cuca Pronta:3,

- Solution #5 found. Objective: 4, 5 Solutions, 0 Time (ms), 10 Nodes, 0 Backtracks, 4 Restarts..

………………. (continuando busca …)

- Solution #15 found. Objective: 14, 15 Solutions, 0 Time (ms), 30 Nodes, 0 Backtracks, 14 Restarts.  Açucar(g):2800, Trigo(g):4200, Ovos:56, Fermento:14, Cuca Pronta:14,

- Solution #16 found. Objective: 15, 16 Solutions, 0 Time (ms), 32 Nodes, 0 Backtracks, 15 Restarts.   Açucar(g):3000, Trigo(g):4500, Ovos:60, Fermento:15, Cuca Pronta:15, -

- Solution #17 found. Objective: 16, 17 Solutions, 0 Time (ms), 33 Nodes, 0 Backtracks, 16 Restarts.   Açucar(g):3200, Trigo(g):4800, Ovos:64, Fermento:16, Cuca Pronta:16,

- Search completed
  Maximize: Cuca Pronta:16  Solutions: 17   Time (ms): 46
*/

:- lib(ic).
:- lib(branch_and_bound).

go:-
    cputime(T1), %write(T1), nl,
	statistics(event_time, Tcpu1), %writeln( tcpu1: Tcpu1),
	
	%% DOMINIOS
    Acucar #:: [0..6000],
	Trigo #:: [0..5000],
	Ovos  #:: [0..670],
	Fermento #:: [0..18],
	
	%% POSTANDO AS RESTRICOES 
	/* para fins de impressao final */
	QtA  #= Acucar/200 ,
	QtT  #= Trigo/300 ,
	QtO  #= Ovos/4 ,
	QtF  #= Fermento/1 ,
		
	/* TRUQUE AQUI */
	QtA #= QtT   ,  
	QtT #= QtO   ,
	QtO #= QtF   ,
		
	QtA + QtT + QtO + QtF #= Temp,
	%% MAXIMIZAR O Num de cucas
	Num_cucas #= (-1)*Temp,	
	
	minimize(search([Acucar, Trigo, Ovos, Fermento], 0, first_fail, indomain, complete, []), Num_cucas ),
	
	writeln( qtidades_dos_ingredientes_GASTA : [Acucar, Trigo , Ovos , Fermento]) ,
	writeln( num_porcoes_QTIDADES : [QtA, QtT , QtO , QtF] ),
	writeln( minimizacao_Total :  [Temp]),
	/* o num maximo de cucas ... o menor de cada elemento */
	minlist([Acucar, Trigo , Ovos , Fermento], Num_cucas_2 ),
	writeln( total_e_num_de_cucas:  Num_cucas_2),
	
	cputime(T2), %write(T2), nl,
	statistics(event_time, Tcpu2), %writeln( tcpu2: Tcpu2),
	T is (T2 - T1),
	Tstatistics is (Tcpu2 - Tcpu1),
	writeln( esta_resposta_Gastou: T  ; segundos),
	writeln( via_statistics: Tstatistics ; segundos).
	

