%-----------------------------------------------------------------------------%
%-----------------------------------------------------------------------------%
%% 
% The job-shop scheduling problem.
% --------------------------------
%
% A job shop has some machines, each performing a different operation.
% There are some jobs to be performed.
% A job is a sequence of tasks or machines to visit
% A task involves processing by a single machine for some duration.
% A machine can operate on at most one task at a time.
% Tasks cannot be interrupted.
% SOME JOBS COULD BE NOT REQUEST SOME TASKIES OR MACHINES ... i.e. the sequence
% could be less the machine number
% The goal is to schedule each job to minimise the finishing time.
%
%-----------------------------------------------------------------------------%

% Model parameters.
%
include "globals.mzn";

int: n_machines;                        % The number of machines.
int: n_jobs;                            % The number of jobs.
%%% I will modified this part .... neither ALL jobs need of ALL machines
%% TASKS = MACHINES 

set of int: jobs = 1 .. n_jobs;
set of int: machines = 1 .. n_machines; %% OK here
%% At least one TASK per one MACHINE

%% DATA
% job_duration[j, k] is the duration of job j in machine K or task k
array [jobs, machines] of int: job_time;

%% SEQUENCE OR ROUTE ...
array [jobs, machines] of 0 .. n_machines: job_sequence; %% by CCS

%%% A LIMIT TIME FOR ALL JOBS had been finished 
int: END_TIME= sum([job_time[j,k] | j in jobs, k in machines]) + 100;        %% LIMIT   

%% OUTPUT -- 
array[jobs, machines] of var 0..END_TIME: job_start; %% when which job will start
array[jobs, machines] of var 0..END_TIME: job_end; %% when which job will stop
%%------

% minimal/maximal duration : bounds on end time
var 0..END_TIME: 
    min_duration = 
         max([job_end[j, k] | j in jobs, k in machines]);


constraint
forall(j in jobs, k in machines )
  (% estava faltando forçar o tempo inicial para 0 ou maior (por isso os negativos estranhos)
    job_start[j,k] >= 0 
  );



%% The end time of all jobs
constraint
 forall(j in jobs, k in machines ) %%%% para cada MAQUINA cada JOB sera DISJUNTIVO
    (
	   job_end[j,k] = job_start[j,k] + job_time[j,k] 
    );
%%% obviously things, just for a nice and clearly output

%%%%
constraint %% precedences ... the jobs in order of all the k machines
%%% FROM HAKAN CODE
  forall( j in  jobs) 
  (
   forall( k1, k2  in  machines where k1 < k2) 
    (
      if( job_sequence[j,k1] < job_sequence[j,k2] )
       then 
         job_end[j,k1] <= job_start[j, k2] 
         %% the END time of J1 is less or equal or START time of J2
       else
         job_end[j,k2] <= job_start[j, k1] 
       endif
     )
    );

%% disjuntive between all jobs over each machine simulatneously
constraint
 forall( k in machines ) %%%% para cada MAQUINA cada JOB sera DISJUNTIVO
   (
    disjunctive([job_start[j,k] | j in jobs  ] ,  [job_time[j,k] | j in jobs ])
   );

   /* disjunctive([job_start[j,k] | j in jobs  where (job_time[j,k] > 0) \/ (job_sequence[j,k] > 0) ], 
    [job_time[j,k] | j in jobs  where (job_time[j,k] > 0) \/   (job_sequence[j,k] > 0)])
  */

%-----------------------------------------------------------------------------%
% Objective.
%
%ann : search_EXPLORE;
%search_EXPLORE = int_search( array1d(job_end), first_fail, indomain_min, complete );
%solve :: search_EXPLORE minimize min_duration;

%%%% or 
solve minimize  min_duration;

output [
    "job_start = \n", show2d(job_start), "\n",
    "job_end = \n", show2d(job_end), "\n",
    "job_sequence = \n", show2d(job_sequence), "\n",
    "job_duration = \n", show2d(job_time), "\n",
    "t_end = ", show(min_duration), "\n"
]++
[ "\n Output detailed: \n"]
++
[
  if machine = 1 then "\n" ++ show("JOB ") ++ show(job) ++ " : "  else " " endif ++
       show(job_start[job,machine]) ++ ".." ++ 
       show(job_end[job,machine]) ++ " "
  | job in jobs, machine in machines
];

%-----------------------------------------------------------------------------%
%-----------------------------------------------------------------------------%
