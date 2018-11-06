homem(carlos).
homem(rubem).
homem(dilson).
homem(fabricio).
homem(rogerio).
homem(joao).
homem(gabriel).
homem(jose).
homem(rodrigo).
homem(gabrielzinho).
homem(milton).
homem(marcos).
homem(luiz).
homem(celso).
homem(marcelo).
homem(marcio).
homem(gian).
homem(paulo).
homem(hipolito).

mulher(leonilda).
mulher(lourdes).
mulher(maria).
mulher(dagmar).
mulher(elizabeth).
mulher(luciana).
mulher(clea).
mulher(angelica).
mulher(dolores).
mulher(vanessa).
mulher(andressa).
mulher(sonia).
mulher(neura).
mulher(julia).
mulher(paula).
mulher(olga).
mulher(temis).

pai(carlos, dilson).
pai(carlos, dagmar).
pai(dilson, fabricio).
pai(dilson, rogerio).
pai(dilson, joao).
pai(rubem, maria).
pai(rubem, gabriel).
pai(rubem, clea).
pai(rubem, luiz).
pai(rubem, sonia).
pai(rubem, paulo).
pai(rubem, olga).
pai(gabriel, jose).
pai(gabriel, luciana).
pai(gabriel, rodrigo).
pai(gabriel, gabrielzinho).
pai(milton, angelica).
pai(milton, marcos).
pai(luiz, vanessa).
pai(luiz, andressa).
pai(celso, marcelo).
pai(celso, marcio).
pai(celso, gian).
pai(paulo, julia).
pai(paulo, paula).
pai(hipolito, temis).

casal(carlos, leonilda).
casal(dilson, maria).
casal(rubem, lourdes).
casal(gabriel, elizabeth).
casal(milton, clea).
casal(luiz, dolores).
casal(celso, sonia).
casal(paulo, neura).
casal(hipolito, olga).

mae(X,Y) :- mulher(X), pai(W,Y), casal(W,X).
avo(X,Y) :- homem(X), (pai(W,Y), pai(X,W)) ; (mae(W,Y), pai(X,W)).
avoh(X,Y) :- mulher(X), (pai(W,Y), mae(X,W)) ; (mae(W,Y), mae(X,W)).
irmao(X,Y) :- homem(X), pai(W,X), pai(W,Y), X\==Y.
irma(X,Y) :- mulher(X), pai(W,X), pai(W,Y), X\==Y.
irmaos(X,Y) :- irmao(X,Y) ; irma(X,Y).
tio(X,Y) :- homem(X), pai(W,Y), irmao(X,W) .
tio(X,Y) :- homem(X), mae(W,Y), irmao(X,W).
tio(X,Y) :- homem(X), pai(W,Y), irma(Z,W), casal(X,Z).
tio(X,Y) :- homem(X), mae(W,Y), irma(Z,W), casal(X,Z).
tia(X,Y) :- mulher(X), pai(W,Y), irma(X,W) .
tia(X,Y) :- mulher(X), mae(W,Y), irma(X,W).
tia(X,Y) :- mulher(X), pai(W,Y), irmao(Z,W), casal(Z,X).
tia(X,Y) :- mulher(X), mae(W,Y), irmao(Z,W), casal(Z,X).
primo(X,Y) :- homem(X), pai(W,X), pai(T,Y), irmao(W,T).
primo(X,Y) :- homem(X), pai(W,X), mae(T,Y), irmao(W,T).
primo(X,Y) :- homem(X), mae(W,X), pai(T,Y), irma(W,T).
primo(X,Y) :- homem(X), mae(W,X), mae(T,Y), irma(W,T).
prima(X,Y) :- mulher(X), pai(W,X), pai(T,Y), irmao(W,T).
prima(X,Y) :- mulher(X), pai(W,X), mae(T,Y), irmao(W,T).
prima(X,Y) :- mulher(X), mae(W,X), pai(T,Y), irma(W,T).
prima(X,Y) :- mulher(X), mae(W,X), mae(T,Y), irma(W,T).















