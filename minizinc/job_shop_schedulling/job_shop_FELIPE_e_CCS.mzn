/*
Academico: Felipe Lucas Weber Pasini
Job Shop Generico

Código inicial fornecido pelo professor Claudio Cesar de Sá

Alterado e concluido(?) por Felipe Lucas Weber Pasini
NAO PASSA EM CASOS MAIORES DEVIDO O DISJUNTIVO
ccs@gerzat:/home/ccs/Dropbox/CCS/minizinc/job_shop_schedulling$ mzn-g12fd job_shop_FELIPE_e_CCS.mzn -d input_jbs_06.dzn 
ccs@gerzat:/home/ccs/Dropbox/CCS/minizinc/job_shop_schedulling$ mzn-gecode job_shop_FELIPE_e_CCS.mzn -d input_jbs_06.dzn
*/

% The job-shop scheduling problem.
% --------------------------------
%
% A job shop has some machines, each performing a different operation.
% There are some jobs to be performed.
% A job is a sequence of tasks.
% A task involves processing by a single machine for some duration.
% A machine can operate on at most one task at a time.
% Tasks cannot be interrupted.
%
% The goal is to schedule each job to minimise the finishing time.
%
%-----------------------------------------------------------------------------%

/*

Eu removi ou alterei quase todos os comentarios anteriores do codigo, 
eles eram muitos e estavam me distraindo enquanto eu tentava ler/entender o codigo. 

Agora os comentarios estão mais do meu estilo, o qual ja estou acostumado e não me tiram a atenção do codigo.

*/


include "globals.mzn";

int: n_machines; % O numero de maquinas
int: n_jobs; % O numero de jobs (trabalhos).

set of int: jobs = 1 .. n_jobs;
set of int: machines = 1 .. n_machines; %% OK here

% job_task_machine[j, k] é que maquina pode realizar a tarefa k do trabalho j
array [jobs,  machines] of 0 .. n_machines: job_sequence;

% job_time[j, k] é a duração da tarefa k do trabalho j
array [jobs, machines] of int: job_time;

% job_start[j,k] é o tempo de inicio da tarefa k do trabalho j
array[jobs, machines] of var int: job_start;
% job_end[j,k] é o tempo de termino da tarefa k do trabalho j
array[jobs, machines] of var int: job_end;

% é o tempo de termino total, ou seja, o maior dentre os terminos
var int: end_time = max([job_end[j,k] | j in jobs, k in machines]); 

% a maior das somas de duração é o mais cedo em que pode terminar
var int: min_duration = max( [sum([job_time[j, k] | j in jobs] ) | k in machines]); 


constraint
end_time >= min_duration; % apenas para garantir que o termino nunca sera antes do minimo possivel


constraint
forall(j in jobs, k in machines )
(% estava faltando forçar o tempo inicial para 0 ou maior (por isso os negativos estranhos)
    job_start[j,k] >= 0 
);


constraint
forall(j in jobs, k in machines )
(
    % Simplesmente colocando o inicio + duração em uma variavel a parte
    job_end[j,k] = job_start[j,k] + job_time[j,k] 
);

%%% esta restricao nao respeita a sequencia ... força uma sequencia UNICA ...
constraint
forall(j in jobs, k in 1 .. (n_machines-1) ) % (restrição horizontal, ou seja afeta as linhas da matriz)
(
    job_end[j,k] <= job_start[j, k+1] % só alterei um pouco como é feito, mas é exatamente o que ja estava 
% ou seja, o inicio de uma tarefa não pode ser antes do termino da anterior em um mesmo job
);

%%% bug aqui .....
constraint % (restrição global-vertical, ou seja afeta uma linha com relação as outras)
forall ( j_1 in jobs, j_2 in (j_1 + 1)..n_jobs, k_1, k_2 in machines) (
    if
           job_sequence[j_1, k_1]  =  job_sequence[j_2, k_2] % quando a mesma maquina é usada por mais de um job
    then
           (job_end[j_1, k_1] <= job_start[j_2, k_2]) \/ % uma deve acabar antes da outra
           (job_end[j_2, k_2] <= job_start[j_1, k_1])    % ou a outra acabar antes da uma
    else
           true
    endif
);


constraint
forall( j in jobs ) % assim as linhas estão disjuntivas %% acredito que seja isto que queremos
(
  disjunctive([ job_start[j,k] | k in machines where (job_sequence[j,k] > 0) \/   (job_time[j,k] > 0)] ,
                [ job_time[j,k] | k in machines where (job_sequence[j,k] > 0) \/ (job_time[j,k] > 0)] )
);

/*
  disjunctive([ job_start[j,k] | k in machines where (job_sequence[j,k] > 0) \/   (job_time[j,k] > 0)] ,
                [ job_time[j,k] | k in machines where (job_sequence[j,k] > 0) \/ (job_time[j,k] > 0)] 
*/
%-----------------------------------------------------------------------------%
% Objective.
%

% coloquei para testar se fazia diferença, mas não faz muita não
ann : search_EXPLORE;
search_EXPLORE = int_search( array1d(job_end), first_fail, indomain_min, complete );


%solve minimize end_time;
%solve minimize min_duration; % min_duration é apenas o menor tempo possivel considerando apenas as durações de cada tarefa, 
solve :: search_EXPLORE minimize end_time;
%solve :: search_EXPLORE minimize min_duration;

output [
"job_start = \n", show2d(job_start), "\n",
"job_time = \n", show2d(job_time), "\n",
"job_SEQUENCE = \n", show2d(job_sequence), "\n",
"job_end = \n", show2d(job_end), "\n",
"tempo de termino = ", show(end_time), "\n"
];

%-----------------------------------------------------------------------------%
