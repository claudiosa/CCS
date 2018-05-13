% Autor: Marcelo Rodrigues de Sousa
% Data: 03/05/2018


resolve(Sol) :-
    Sol = supermercado(_,_,_,_,_),
    % Quem esqueceu o Pão está exatamente à esquerda de
    % quem veio fazer compras com a Irmã
    exatamente_a_esquerda(A,B,Sol),
    esqueceu(A,pao),
    veio(B,irma),
    % A mulher com a blusa Azul está em algum caixa
    % à esquerda de quem trouxe o Filho.
    a_esquerda(C,D,Sol),
    blusa(C,azul),
    veio(D,filho),
    % A moça que veio com o Marido vai pagar as compras
    % usando Vale
    caixa(E,Sol),
    veio(E,marido),
    pagamento(E,vale),
    % O Namorado está acompanhando a mulher
    % que está no caixa 1
    primeiro_caixa(F,Sol),
    veio(F,namorado),
    % Quem vai pagar usando o cartão de Crédito está no caixa 4
    quarto_caixa(G,Sol),
    pagamento(G,credito),
    % A moça do último caixa vai pagar usando Dinheiro
    ultimo_caixa(H,Sol),
    pagamento(H,dinheiro),
    % Quem veio com o Marido está exatamente à esquerda
    % de quem esqueceu de comprar Pão
    exatamente_a_esquerda(I,J,Sol),
    veio(I,marido),
    esqueceu(J,pao),
    % Quem vai pagar com Cheque está no primeiro caixa
    primeiro_caixa(K,Sol),
    pagamento(K,cheque),
    % A cliente que vai pagar com Cartão de Crédito
    % esqueceu de comprar Presunto
    caixa(L,Sol),
    pagamento(L,credito),
    esqueceu(L,presunto),
    % Quem esqueceu de comprar Leite vai pagar as
    % compras com Dinheiro
    caixa(M,Sol),
    esqueceu(M,leite),
    pagamento(M,dinheiro),
    % A mulher que esqueceu de comprar Amaciante
    % está em um dos caixas das pontas
    caixa_das_pontas(N,Sol),
    esqueceu(N,amaciante),
    % A Fernanda está usando uma blusa Branca
    caixa(O,Sol),
    nome(O,fernanda),
    blusa(O,branca),
    % Quem veio de blusa Verde está em algum lugar à
    %esquerda de quem veio com a blusa Azul
    a_esquerda(P,Q,Sol),
    blusa(P,verde),
    blusa(Q,azul),
    % A Aline veio fazer compras com o Marido
    caixa(R,Sol),
    nome(R,aline),
    veio(R,marido),
    % A Carol está no caixa exatamente à direita
    % de quem veio com o Marido
    exatamente_a_direita(S,T,Sol),
    nome(S,carol),
    veio(T,marido),
    % A Natália está no último caixa
    ultimo_caixa(U,Sol),
    nome(U,natalia),
    % A Juliana está exatamente à esquerda
    % de quem veio com a blusa Amarela
    exatamente_a_esquerda(V,X,Sol),
    nome(V,juliana),
    blusa(X,amarela),
    % A moça de blusa Branca esqueceu de
    % comprar Presunto
    caixa(Y,Sol),
    blusa(Y,branca),
    esqueceu(Y,presunto),
    % A mulher da blusa Vermelha trouxe o
    %Filho para o supermercado
    caixa(Z,Sol),
    blusa(Z,vermelha),
    veio(Z,filho),
    % complemento - faltou: pagamento - debito
    caixa(A1,Sol),
    pagamento(A1,debito),
    % complemento - faltou: esqueceu - frutas
    caixa(A2,Sol),
    esqueceu(A2,frutas),
    % complemento - faltou: veio - mae
    caixa(A3,Sol),
    veio(A3,mae).

%fatos que definem os caixas (5 possibilidades)
caixa(X,supermercado(X,_,_,_,_)).
caixa(X,supermercado(_,X,_,_,_)).
caixa(X,supermercado(_,_,X,_,_)).
caixa(X,supermercado(_,_,_,X,_)).
caixa(X,supermercado(_,_,_,_,X)).

%fatos que definem os atributos do caixa
blusa(caixa(X,_,_,_,_),X).
nome(caixa(_,X,_,_,_),X).
esqueceu(caixa(_,_,X,_,_),X).
pagamento(caixa(_,_,_,X,_),X).
veio(caixa(_,_,_,_,X),X).

primeiro_caixa(X,supermercado(X,_,_,_,_)).
segundo_caixa(X,supermercado(_,X,_,_,_)).
quarto_caixa(X,supermercado(_,_,_,X,_)).
ultimo_caixa(X,supermercado(_,_,_,_,X)).

caixa_das_pontas(X,supermercado(X,_,_,_,_)).
caixa_das_pontas(X,supermercado(_,_,_,_,X)).

% o caixa X está exatamente a esquerda de Y no supermercado
% 4 possibilidades
exatamente_a_esquerda(X,Y,supermercado(X,Y,_,_,_)).
exatamente_a_esquerda(X,Y,supermercado(_,X,Y,_,_)).
exatamente_a_esquerda(X,Y,supermercado(_,_,X,Y,_)).
exatamente_a_esquerda(X,Y,supermercado(_,_,_,X,Y)).

% o caixa X está exatamente a direita de Y no supermercado se
% o caixa Y está exatamente a esquerda de X no supermercado
exatamente_a_direita(X,Y,Supermercado) :-
    exatamente_a_esquerda(Y,X,Supermercado).

% o caixa X está a esquerda de Y no supermercado
% 10 possibilidades
a_esquerda(X,Y,supermercado(X,Y,_,_,_)).
a_esquerda(X,Y,supermercado(X,_,Y,_,_)).
a_esquerda(X,Y,supermercado(X,_,_,Y,_)).
a_esquerda(X,Y,supermercado(X,_,_,_,Y)).
a_esquerda(X,Y,supermercado(_,X,Y,_,_)).
a_esquerda(X,Y,supermercado(_,X,_,Y,_)).
a_esquerda(X,Y,supermercado(_,X,_,_,Y)).
a_esquerda(X,Y,supermercado(_,_,X,Y,_)).
a_esquerda(X,Y,supermercado(_,_,X,_,Y)).
a_esquerda(X,Y,supermercado(_,_,_,X,Y)).

