% Este problema é uma variação do anterior, exceto, que o valor K é desconhecido. Ou seja,
% K variável. Assim, 1 ≤ K ≤ N .


int: N; % = 7; % Tamanho da lista de valores

% Variáveis de Decisão
var 1..N : i;
var 1..N : j;
%  %  %

array[1..N] of int: list_; % = [3, 4, 5, -9, -6, -42, 100]; % Lista de valores

constraint j >= i; % Garantindo que a janela será contígua

solve maximize sum (k in i..j) (list_[k]); % quer-se o maior valor possível

output[show([list_[k] | k in i..j])];

/* output 1 :

[100]
----------
==========

   output 2 :

[30]
----------
==========

   output 3 :

[15, -14, 5, 4, -2, 11]
----------
==========

   output 4 :

[3, -2, 5, 14]
----------
==========