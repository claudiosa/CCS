int: N = 4;
int: Kte = ceil(N*(N*N +1 )/2); %% Coercao float -> int ou floor
%int : Kte = 34 ... valor magico para N=4;
set of int : Index = 1..N;

array[Index, Index] of var 1 .. (N*N): mat;

constraint forall(i in Index) %% LINHAS
	(mat[i,1] + mat[i,2] + mat[i,3] + mat[i,4] == Kte);

constraint forall(j in Index) %% COLUNAS
	(mat[1,j] + mat[2,j] + mat[3,j] + mat[4,j] == Kte);

constraint % Diagonal 1...
   mat[1,1] + mat[2,2] + mat[3,3] + mat[4,4] == Kte;

constraint % Diagonal 2 ...
   mat[4,1] + mat[3,2] + mat[2,3] + mat[1,4] == Kte;

%% TODAS CELULAS COM CONTEUDOS DIFERENTES ENTRE SI
constraint %% EQUIVALENTE A restricao  alldifferent 
 forall(i in Index, j in Index, k in Index, l in Index)
   (if (i!= k \/ j != l)  
     then mat[i,j] != mat[k,l] 
     else 
     true 
     endif);
% Comparativo cartesiano TODOS COM TODOS exceto IGUAIS!

solve satisfy;

%%% obs na formatacao
output[show_int(5,mat[i,j]) ++ 
       if j==N then "\n" else " " endif |
          i in 1..N, j in 1..N];
