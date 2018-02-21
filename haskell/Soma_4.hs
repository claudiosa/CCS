module  Soma_4    -- MESMO NOME DO ARQUIVO 
   where 

import    Soma_3 {-- tem que aparecer .... pois 
poderia ser carregado isoladamente --}
import    Soma_2 {- tem soma por lá -}

soma_4 x y z w = soma (soma_3 x y z) w