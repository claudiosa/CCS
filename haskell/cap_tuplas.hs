-- Ex1
type Seq_Caract = String     -- Uma sequência de caracteres
type Nomes = (Seq_Caract, Seq_Caract, Seq_Caract, Seq_Caract)

f_nomes_est = ("Inverno", "Outono", "Primavera", "Verao")

selec_inv  ( x , _ , _ , _ ) = x
selec_outono  ( _ , x , _ , _ ) = x
selec_prima  ( _ , _ , x , _ ) = x
selec_verao  ( _ , _ , _ , x ) = x

{-
Main> f_nomes_est
("Inverno","Outono","Primavera","Verao")
Main> selec_inv f_nomes_est
"Inverno"
Main> selec_verao f_nomes_est
"Verao"
Main> selec_outono ("Joao", "Pedro", "Augusto", "Marcio")
"Pedro"

-}
-- Ex 2
type Peso = Float
type Idade = Int
type Pessoa = (String , Idade , Peso , String)

f_joao, f_maria :: Pessoa
f_joao = ("Joao Pedro", 19, 75.789 ,"Basquete")
f_maria  = ("Maria Fernanda", 18, 65.432, "Volei")

selec_nome :: Pessoa -> String
selec_idade :: Pessoa -> Idade
selec_peso :: Pessoa -> Peso
selec_esporte :: Pessoa -> String

selec_nome (n,i,p,e) = n
selec_idade (n,i,p,e) = i
selec_peso (n,i,p,e) = p
selec_esporte (n,i,p,e) = e

{-
Main> f_joao
("Joao Pedro",19,75.789,"Basquete")
Main> f_maria
("Maria Fernanda",18,65.432,"Volei")
Main> selec_nome f_joao
"Joao Pedro"
Main> selec_peso f_maria
65.432
Main> selec_idade f_joao
19
Main> selec_esporte f_maria
"Volei"
-}
