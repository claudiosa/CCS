{-
  Problema cl�ssico dos VASOS ou Jarras 
  Autor: claudio
  Finalidade: Did�tica de Ensino (20/02/2004)
 -}

module VASOS where

--import IO
--import System

--Funcaode inicio

inicio =  wrt_lst vasos tab_acao  

--(qt_A, qt_B, Regra selecionada)
vasos = busca (0,0,0) [(0,0,0)]
-- vasos=  busca (4,3,0) [(4,3,0)]
-- eh necess�rio este ..... pois....por casamento de padr�es nao funcao adiciona

--Funcaode aplica��o da funcaoacao

-- Parada da busca ... caso um dos vaso contenha 2 Lts.
-- A lista corrente serah devolvida

busca (x_cor, y_cor, _ ) l_corrente 
    |((x_cor == 2) || (y_cor == 2)) =  l_corrente
{- Se x_cor ou y_cor = 2 ent�o devolve a lista de tuplas e chegou ao  fim -}
-- Caso contr�rio...    
busca (x_cor, y_cor, z_cor  ) l_corrente    
     =
     busca (x_new, y_new,  reg_new) l_new 
     {-Busca com x_new, y_new e l_new  n�o atualizados -}
     where
     (x_new, y_new, reg_new) = acao ( x_cor, y_cor, z_cor ) l_corrente 
     {- Chama a funcaoacao com os valores correntes -}
       
     l_new =  adiciona (x_new, y_new,  reg_new) l_corrente 
       
        {- Se a tupla n�o estah na lista,  ela ah adicionada a
           lista  corrente e devolvida atualizada / new
        -}
---------------------------------------------------------------------
--Encher o vaso B 
-- regra 1
acao (x, y, _ ) l
    |(y<3) && not(pertence (x ,3) l) = (x, 3, 1) 

--Encher o vaso A 
-- regra 2
acao (x,y, _ ) l
    |(x<4) &&  not(pertence (4,y) l) = (4,y,2) 

--Esvaziar o vaso B 
-- regra 3
acao (x,y, _ ) l
    |(y>0) && not (pertence (x,0) l) = (x,0,3) 

--Esvaziar o vaso A 
-- regra 4
acao (x,y, _ ) l
    |(x>0) && not (pertence (0,y) l) = (0,y,4) 

--Encher o vaso B usando o A, sem sobras em A =>
-- regra 5
acao (x,y, _ ) l
    |(x+y<=3) && (x>0) && not (pertence (0,(x+y)) l) = (0,(x+y),5) 

--Encher o vaso A usando o B, sem sobras em B
-- regra 6
acao (x,y , _ ) l
    |(x+y<=4) && (y>0) && not (pertence ((x+y),0) l) = ((x+y),0, 6) 

--Encher o vaso A usando o B, com sobras em B
-- regra 7
acao (x,y , _ ) l
    |(x+y>4) && (y>0) && not (pertence (4,(y-(4-x))) l) = (4,(y-(4-x)), 7) 

--Encher o vaso B usando o A, com sobras em A
-- regra 8
acao (x,y ,_ ) l
    |(x+y>3) && (x>0) && not (pertence ((x-(3-y)),3) l) = ((x-(3-y)),3, 8) 


-- OPCIONALMENTE ... A��es finais ==> se desejar um conteudo 2....
-- regra 9
-- acao (x,2 , _ ) l = (x,2, 9) 
-- regra 10
--acao (2,y , _ ) l = (2,y, 10)

--Funcaoque pertence se uma tupla jah existe em uma lista de tuplas
-- False ... nao estah na lista  ... com o not da
-- a��o serah inclu�do..
pertence (a , b ) [] = False

-- True ... nao adiciona ... ja estah na lista
pertence (a , b)  (x : cauda)
    | (a == prim(x)) && (b == segu(x)) = True   
    -- jah estah na lista
    |otherwise = pertence (a, b) cauda

-- primeiro, segundo e terceiro ...
prim (x,_,_) = x
segu (_,x,_) = x
terc (_,_,x) = x


--Funcao que adiciona uma tupla em uma lista ...
-- adiciona no final da lista....
adiciona (a,b, num_regra) [] = [(a,b, num_regra)] 
adiciona (a,b, num_regra) (cabeca : cauda) = 
           cabeca : adiciona (a,b,num_regra) cauda

tab_acao = 
     [(0, "Ambos vasos estaoh vazios !"),
      (1, "Encheu o vaso B ... com a torneira "),
      (2, "Encheu o vaso A ... com a torneira "),
      (3, "Esvaziou o vaso B "),
      (4, "Esvaziou o vaso A "),
      (5, "Derramou no vaso B o conteudo do vaso A, sem sobras em A "),
      (6, "Derramou no vaso A o conteudo do vaso B, sem sobras em B "),
      (7, "Encheu o vaso A usando o vaso B, com sobras em B "),
      (8, "Encheu o vaso B usando o vaso A, com sobras em A ")
    ]
      

{-  RELEMBRANDO...
a: qt. do vaso A
b: qt. do vaso B
c: num da regra....
-}

wrt_lst [] _ = putStr "\n"
wrt_lst ((a,b,c):l_cauda) tabela = 
          do {
           --str_retorno <- busca_tab tabela c;
           print (busca_tab tabela (a,b,c));
           wrt_lst l_cauda tabela;
           }
           
busca_tab _ (a,b,c) 
    | c < 0 = (a,b," Algum erro ")            
    | c > 8 = (a,b," Um outro erro ")         

busca_tab ((num,mensagem): resto_tab) (a,b,c)
    | c == num = (a, b, mensagem)
    | otherwise =  busca_tab    resto_tab    (a,b,c) 
    
    
