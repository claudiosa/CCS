include "globals.mzn";
int: n_machines = 3;               % num de  maquinas
int: n_jobs = 3;                   % The num de tarefas

set of int: jobs = 1 .. n_jobs;
set of int: machines = 1 .. n_machines;

%% ENTRADA de DADOS: no fim deste codigo
% job_duration[j, k] eh a duracao da tarefa j na maquina K
array [jobs, machines] of int: job_time;

%% SEQUENCIA OU ROTA das TAREFAS ...
array [jobs, machines] of 0 .. n_machines: job_sequence; 

%% um limite para todos as tarefas tenham terminado
int: END_TIME= sum([job_time[j,k] | j in jobs, k in machines]) + 100;     

%% USADO PARA SAIDA
array[jobs, machines] of var 0..END_TIME: job_start; %% Tempo INICIO
array[jobs, machines] of var 0..END_TIME: job_end; %% Tempo FINAL
%%------
% A menor duracao eh o maior tempo das tarefas
var 0..END_TIME: 
   min_duration = 
     max([job_end[j, k] | j in jobs, k in machines]);
        
constraint %%
   forall(j in jobs, k in machines )
         (job_start[j,k] >= 0  );

constraint
 forall(j in jobs, k in machines )
    (job_end[j,k] = job_start[j,k] + job_time[j,k]);

constraint    %% Restricao-chave: PRECEDENCIA (again)
  forall( j in  jobs) 
  (forall( k1, k2  in  machines where k1 < k2) 
    (if( job_sequence[j,k1] < job_sequence[j,k2])
       then 
         job_end[j,k1] <= job_start[j, k2] 
       %% tempo final de J1 eh menor ou igual o tempo de inicio de J2
       else
         job_end[j,k2] <= job_start[j, k1] 
       endif
     ));

%% Disjuncao entre todas as tarefas sobre uma maquina
constraint %%%% para cada MAQUINA cada JOB sera DISJUNTIVO
 forall( k in machines ) 
  (disjunctive([job_start[j,k] | j in jobs  ] , 
               [job_time[j,k]  | j in jobs ])  );

%constraint 
%    min_duration < 13;
% Objective.

%%%% 
solve minimize  min_duration;

output [
    "job_start = \n", show2d(job_start), "\n",
    "job_end = \n", show2d(job_end), "\n",
    "job_sequence = \n", show2d(job_sequence), "\n",
    "job_duration = \n", show2d(job_time), "\n",
    "t_end = ", show(min_duration), "\n" ]  
     ++ [ "\n SAIDA DETALHADA: \n"] ++
[
  if machine = 1 then "\n" ++ show("JOB ") ++ 
       show(job) ++ " : "  else " " endif ++
       show(job_start[job,machine]) ++ ".." ++ 
       show(job_end[job,machine]) ++ " "
    | job in jobs, machine in machines
];
%--------------------------------------------%
job_sequence = array2d(jobs, machines, 
 [
	1, 2, 3,
	1, 3, 2,
	2, 1, 3]);
job_time = array2d(jobs, machines, 
 [
	3, 3, 3,
	2, 3, 4,
	3, 2, 1]);
%-----------------------------------------------%
