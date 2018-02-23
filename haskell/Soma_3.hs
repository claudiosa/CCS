module  Soma_3 (soma_3)    -- MESMO NOME DO ARQUIVO
-- (soma3) nome da funcao a ser exportada neste arquivo SOMA_3
   where 
import    Soma_2 {-- tem que aparecer .... pois 
poderia ser carregado isoladamente --}

soma_3 x y z = soma (soma x y) z