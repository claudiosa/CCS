:- use_module(library(bounds)).

paulino(Horarios) :-
  Horarios = [WakeUp,TakeBus1,StartWork,
              TakeBus2,TurnTVOn,FallASleep],
  /*domain(Horarios,1,24),*/
  Horarios in 1 .. 24,
  WakeUp #>= 6,
  WakeUp #=< TakeBus1 -1,
  StartWork #=< TakeBus2 - 8,
  TakeBus1 #=< StartWork - 1,
  TakeBus2 #=< StartWork + 8,
  TurnTVOn #=< TakeBus2 + 1,
  FallASleep #=< TurnTVOn + 3,
  labeling( [ff] , Horarios). 
  
