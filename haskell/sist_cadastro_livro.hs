module Cadastro where
import IO
import System
import Numeric
import Char (toUpper)
--import Hugs.Prelude

-- Função Principal --
{-- Antes do menu de opções ser exibido, deve ser realizada uma
checagem a fim de verificar se o arquivo é vazio ou não. Se o arquivo está vazio
é necessário que a inclusão de uma lista vazia ([]) seja realizada para
que as demais operações possam ser realizadas com sucesso.
--}
--

-- Menu de Opções --
menu::IO()
menu =
    do
        putStrLn " "
        putStrLn " ___________________________________________"
        putStrLn "|                                           |"
        putStrLn "|           CADASTRO DE PESSOAS             |"
        putStrLn "|                                           |"
        putStrLn "|   a -  Insere cadastro                    |"
        putStrLn "|   b -  Imprime cadastro                   |"
        putStrLn "|   c -  Busca por nomes                    |"
        putStrLn "|   d -  Soma das idades                    |"
        putStrLn "|   e -  Média das alturas                  |"
        putStrLn "|   f -  Busca por sexo                     |"
        putStrLn "|   g -  Excluir um cadastro                |"
        putStrLn "|   h -  Excluir todos cadastros            |"
        putStrLn "|   i -  Sair do Sistema                    |"
        putStrLn "|___________________________________________|"
        putStr "Digite uma das opções:"
        le_opcao

le_opcao :: IO ()
le_opcao=
       do   {
            -- opção do bloco do.... só aceita tipos
            -- monádicos .... onde I/O é uma sub-classe
            opcao <- getChar;
            putStr "\n";
            f_menu (toUpper opcao); -- veja o tipo de f_menu
        }
f_menu :: Char -> IO()
f_menu i =
      do
        case i of
            'A' -> insere_cadastro
            'B' -> imprime_cadastros
            'C' -> busca_p_nomes
            'D' -> soma_d_idades
            'E' -> media_d_alturas
            'F' -> busca_p_sexo
            'G' -> excluir_um_cadastro
            'H' -> excluir_todos_cadastros
            otherwise -> sair i
        putStrLn "\n Operacao Concluida"
        if not(i=='I') then menu else putStr ""


insere_cadastro :: IO ()
insere_cadastro=
        do
            putStrLn "Nome: "
            nm <- getLine
            putStrLn "Idade: "
            id <- getLine
            putStrLn "Altura: "
            alt <- getLine
            putStrLn "M -Masculino |F -Feminino"
            putStrLn "Sexo: "
            sex <- getChar
            let cadastro = nm++"#"++id++"#"++alt++"#'"++[(toUpper sex)]++"'"
            pt_arq <- abreArquivo "dados.txt" AppendMode
            hPutStrLn pt_arq cadastro
            fechaArquivo pt_arq

imprime_cadastros :: IO ()
imprime_cadastros =
         do
            putStrLn ""
            putStrLn "----------------------------------------------------"
            pt_arq <- abreArquivo "dados.txt" ReadMode
            conteudo <- (hGetContents pt_arq)
            cadastros <- (converteConteudo (conteudo))
            imprime cadastros
            fechaArquivo pt_arq
            putStrLn "----------------------------------------------------"


busca_p_nomes :: IO ()
busca_p_nomes =
         do
            putStrLn ""
            putStrLn "Digite o nome desejado: "
            nome <- getLine
            busca_p_algo busca_por_nome nome

soma_d_idades :: IO()
soma_d_idades =
        do
            pt_arq <- abreArquivo "dados.txt" ReadMode
            conteudo <- (hGetContents pt_arq)
            cadastros <- (converteConteudo (conteudo))
            putStrLn (show (soma_d_idade cadastros))
            fechaArquivo pt_arq

media_d_alturas :: IO()
media_d_alturas =
        do
            pt_arq <- abreArquivo "dados.txt" ReadMode
            conteudo <- (hGetContents pt_arq)
            cadastros <- (converteConteudo (conteudo))
            putStrLn (show (media_d_altura cadastros))
            fechaArquivo pt_arq


busca_p_sexo :: IO ()
busca_p_sexo =
         do
            putStrLn ""
            putStrLn "Digite o sexo desejado: "
            sexo <- getChar
            busca_p_algo busca_por_sexo sexo


excluir_um_cadastro :: IO ()
excluir_um_cadastro =
            do
                putStrLn "O cadastro será apagado pelo nome."
                putStrLn "Digite o nome desejado:"
                nome <- getLine
                pt_arq <- abreArquivo "dados.txt" ReadMode
                conteudo <- (hGetContents pt_arq)
                cadastros <- (converteConteudo (conteudo))
                let novo_conteudo = apaga_p_nome cadastros nome
                aux_pt_arq <- abreArquivo "auxiliar.txt" WriteMode
                hPutStr aux_pt_arq novo_conteudo
                fechaArquivo aux_pt_arq
                fechaArquivo pt_arq
                copiar "auxiliar.txt" "dados.txt"


excluir_todos_cadastros :: IO ()
excluir_todos_cadastros =
           do
                putStrLn "Tem certeza que deseja apagar todos os dados do sistema?(s/n)"
                resp <- getChar
                if not((toUpper resp)=='S')
                  then putStrLn ""
                  else
                       do
                            pt_arq <- abreArquivo "dados.txt" WriteMode
                            fechaArquivo pt_arq
                            putStrLn "Apagando dados...."

sair :: Char -> IO ()
sair i  |i=='I'     = putStrLn "Saindo do sistema...."
    |otherwise  = putStrLn "Operacao Invalida..."

-- FUNCOES AUXILIARES DE CONSULTA

converteConteudo :: String -> IO [[String]]
converteConteudo conteudo = return (map (explodir '#') (explodir '\n' conteudo))

-- FUNCOES COM NUMEROS

media_d_altura :: [[String]] -> Float
media_d_altura [] = 0
media_d_altura x = (soma_d_alturas x) / (fromIntegral (length x))

soma_d_alturas :: [[String]] -> Float
soma_d_alturas []     = 0
soma_d_alturas (x:xs) = (read (altura x) :: Float) + (soma_d_alturas xs)

soma_d_idade :: [[String]] -> Integer
soma_d_idade []     = 0
soma_d_idade (x:xs) = (read (idade x) :: Integer) + (soma_d_idade xs)

-- FUNCOES UTEIS

explodir :: Eq a => a -> [a] -> [[a]]
explodir a [] = []
explodir a (x:xs)
       | (takeWhile (/= a) (x:xs)) == [] = explodir a xs
       | x == a  = (takeWhile (/= a) xs) : explodir a (dropWhile (/= a) xs)
       | otherwise = (takeWhile (/= a)(x:xs)) : explodir a (dropWhile (/= a) (x:xs))

nome,idade,altura,sexo :: [String] -> String

nome (a:b:c:d:[]) = a
idade (a:b:c:d:[]) = b
altura (a:b:c:d:[]) = c
sexo (a:b:c:d:[]) = d

copiar origem destino =
           do
                pt_arq <- abreArquivo origem ReadMode
                conteudo <- (hGetContents pt_arq)
                aux_pt_arq <- abreArquivo destino WriteMode
                hPutStr aux_pt_arq conteudo
                fechaArquivo aux_pt_arq
                fechaArquivo pt_arq


-- FUNCOES AUXILIARES DE BUSCA

busca_p_algo :: ([[String]] -> a -> IO b) -> a -> IO ()
busca_p_algo funcao filtro=
            do
                putStrLn " "
                putStrLn "----------------------------------------------------"
                pt_arq <- abreArquivo "dados.txt" ReadMode
                conteudo <- (hGetContents pt_arq)
                cadastros <- (converteConteudo (conteudo))
                funcao cadastros filtro
                fechaArquivo pt_arq
                putStrLn "----------------------------------------------------"


busca_por_nome :: [[String]] -> String -> IO ()
busca_por_nome [] nm      = putStrLn ""
busca_por_nome (x:xs) nm
              | (nome x) == nm  =
                         do
                            putStrLn ( foldl1 (\a b->a++" "++b) x)
                            busca_por_nome xs nm
              | otherwise       =  busca_por_nome xs nm

busca_por_sexo :: [[String]] -> Char -> IO ()
busca_por_sexo [] sx      = putStrLn ""
busca_por_sexo (x:xs) sx
              | (sexo x) == ("'"++[(toUpper sx)]++"'")  =
                               do
                                   putStrLn ( foldl1 (\a b->a++" "++b) x)
                                   busca_por_sexo xs sx
              | otherwise =  busca_por_sexo xs sx

-- FUNCOES AUXILIARES DE IMPRESSAO

imprime :: [[[Char]]] -> IO ()
imprime [] = putStrLn ""
imprime (x:xs) = do
                    putStrLn ( foldl1 (\a b->a++" "++b) x)
                    imprime xs

-- FUNCAO DE EXCLUSAO

apaga_p_nome :: [[String]] -> String -> String
apaga_p_nome [] nm = "\n"
apaga_p_nome (x:xs) nm
     | nm == (nome x) = (apaga_p_nome xs nm)
     | otherwise      = (foldl1 (\a b->a++"#"++b) x) ++ "\n" ++ (apaga_p_nome xs nm)
-- FUNCOES AUXILIARES DE ARQUIVOS

-- modo: AppendMode, WriteMode, ReadMode

abreArquivo :: String -> IOMode -> IO Handle
abreArquivo arquivo modo =
       catch (openFile arquivo modo)
             (\_ -> do {
                        putStrLn ("Impossivel abrir "++ arquivo);
                        putStrLn "Será aberto com um nome default: dados.txt e limpo" ;
                        pt_arq<-abreArquivo "dados.txt" WriteMode;
                        fechaArquivo pt_arq;
                        abreArquivo "dados.txt" ReadMode
                       }
             )


fechaArquivo :: Handle -> IO ()
fechaArquivo handle_arq = hClose handle_arq
