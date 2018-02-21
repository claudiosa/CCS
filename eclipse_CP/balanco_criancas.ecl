/*  
   Problem
   
   A: Abel -- 36 KG
   B: Beatriz -- 32 KG
   C: Carlos  -- 16 KG
   D1 = { 36, 32, 16}
   D2 = { -5, -4, .... 0 .... 4, 5}
   
   dist(|A-B|) >= 2
   dist(|C-B|) >= 2
   .........
   A \= 0,
   B \= 0,
   C \= 0,
   A*36 + B*32 + C*16 == 0
   
*/   

:- lib(ic).
%:- lib(gfd).
:- lib(cpviz).

sol :- balanco([A,B,C]),
	   writeln([A,B,C]).

balanco([A,B,C]) :-
  Variaveis = [A,B,C] ,   
  Variaveis #:: [-5  .. 5],
   
   %%% INCLUIR ISTO
   create_visualization([output:"Viz_RESULTADOS_balanco" ,
                         ignore_fixed:no],Handle),   
   add_visualizer(Handle,
                       vector(Variaveis),
                       [display:expanded]),
 
   draw_visualization(Handle), 
   %%% ATEH AQUI
   A #>  0,  %% Break simetry
   A #<  5,  %% Filtering the domain
   A #\= 0,  %% 
    
   %%% INCLUIR ISTO ... testar com e removendo as partes abaixo 
   draw_visualization(Handle),
   B #\= 0,
   C #\= 0,
  
  % get_domain(A,Dominio_A),
  % writeln(Dominio_A),
   draw_visualization(Handle),
   abs(A-B) #> 2, 
   abs(A-C) #> 2, 
   abs(B-C) #> 2, 
   draw_visualization(Handle),
   36*A + 32*B + 16*C #= 0,  
   draw_visualization(Handle),
    
   %%% INCLUIR ISTO 
   %%name_variables(Handle,Variaveis,['Abel','Beatriz','Carlos'],Pairs),
   name_variables(Handle,Variaveis,['A','B','C'],Pairs),          
   %%labeling(Variaveis),
   root(Handle),
   /* FOR ALL SOLUTIONS */
     findall(x,
                (search(Pairs,1,input_order,tree_indomain(Handle,_),
                       complete,[]),
                 solution(Handle)),
                _),
        
     /* 
        FOR ONLY ONE SOLUTION OR FIRST
        search(Pairs,1,input_order,tree_indomain(Handle,_), complete,[]),
        solution(Handle),
      */    
        close_visualization(Handle),
        viz(Handle, _).

  
/*************************
1 .. 4
[4, -5, 1]
[4, -4, -1]
[4, -2, -5]
*********/
