module Controle_Estoque where

import IO
import System
import Char (toUpper,isDigit,toLower)

---------------------------------------------------------------
-- Main, Menus e 					     --
---------------------------------------------------------------

main = do{
          menu;
          }

-- Funcao que pega a opcao do usuario

menu=
  do{
    putStrLn "<MENU PRINCIPAL>";
    putStrLn "\n\n\n";
    putStrLn "A - Inserir Novo Produto";
    putStrLn "B - Alterar Quantidade";
    putStrLn "C - Alterar Preco de Compra";
    putStrLn "D - Alterar Preco de Venda";
    putStrLn "E - Excluir Produto";
    putStrLn "F - Excluir todo o Banco de Dados";
    putStrLn "G - Busca por Produto";
    putStrLn "H - Busca por Fornecedor";
    putStrLn "I - Emitir Relatorio";
    putStrLn "J - Fazer Backup";
    putStrLn "K - Recuperar dados";
    putStrLn "L - Sair";
    putStrLn "\n\n";
    opcao;
  }

-- Faz a escolha do menu

opcao=
  do{
    putStr "Escolha uma das opcoes: ";
    op <- getChar;
    escolha_menu (toUpper op);
  }

pause = do{
	  putStrLn "\n\n\t\t<<Aperte alguma tecla>>";
	  getChar;
        }

escolha_menu i =
  do{
    case i of {
      'A' -> m_inserir;
      'B' -> m_alterar_quant;
      'C' -> m_alterar_compra;
      'D' -> m_alterar_venda;
      'E' -> m_excluir;
      'F' -> m_excluir_tudo;
      'G' -> m_procurar_prod;
      'H' -> m_procurar_forn;
      'I' -> m_relatorio;
      'J' -> m_backup;
      'K' -> m_recuperar;
      'L' -> m_sair;
      otherwise -> erro;
    };
    if not(i=='L') then menu else putStr "";
  }

m_inserir =
  do{
    putStrLn "\n\n\nMENU DE INSERCAO DE PRODUTOS\n\n";
    putStr "Nome do Produto: ";
    produto <- getLine;
    putStr "Fornecedor: ";
    forn <- getLine;
    qtde <- pega_quantidade;
    compra <- pega_compra;
    venda <- pega_venda;
    arquivo <- openFile "Dados.txt" AppendMode;
    hPutStr arquivo (produto++";"++forn++";"++qtde++";"++compra++";"++venda++";"++"\n");
    hClose arquivo;
    putStrLn "Insercao Concluida";
    pause;
    }

m_alterar_quant =
  do{
    putStrLn "\nALTERACAO DE PRODUTO";
    arquivo <- openFile "Dados.txt" ReadMode;;
    conteudo <- hGetContents arquivo;
    l <- recuperar_dados [] conteudo;
    putStrLn "Produtos Disponiveis: ";
    imprimeNome 'A' l;
    putStr "Nome do Produto: ";
    prod <- getLine;
    busca <- buscarProduto prod l;
    lreduzida <- reduz l busca;
    hClose arquivo;
    excluir_tudo;
    lnew <- alterar_qtde busca [];
    gravar lnew;
    gravar lreduzida;
    putStrLn "Alteracao Concluida";
    pause;
  }

m_alterar_compra =
  do{
    putStrLn "\nALTERACAO DO VALOR DE COMPRA";
    arquivo <- openFile "Dados.txt" ReadMode;
    conteudo <- hGetContents arquivo;
    l <- recuperar_dados [] conteudo;
    putStrLn "Produtos Disponiveis: ";
    imprimeNome 'A' l;
    putStr "Nome do Produto: ";
    prod <- getLine;
    busca <- buscarProduto prod l;
    lreduzida <- reduz l busca;
    hClose arquivo;
    excluir_tudo;
    lnew <- alterar_compra busca [];
    gravar lnew;
    gravar lreduzida;
    putStrLn "Alteracao Concluida";
    pause;
  }

m_alterar_venda =
  do{
    putStrLn "\nALTERACAO DO VALOR DE VENDA";
    arquivo <- openFile "Dados.txt" ReadMode;
    conteudo <- hGetContents arquivo;
    l <- recuperar_dados [] conteudo;
    putStrLn "Produtos Disponiveis: ";
    imprimeNome 'A' l;
    putStr "Nome do Produto: ";
    prod <- getLine;
    busca <- buscarProduto prod l;
    lreduzida <- reduz l busca;
    imprimeNome 'A' l;
    hClose arquivo;
    excluir_tudo;
    lnew <- alterar_venda busca [];
    gravar lnew;
    gravar lreduzida;
    putStrLn "Alteracao Concluida";
    pause;
  }

m_excluir =
  do{
    putStrLn "\n\nEXCLUSAO\n";
    arquivo <- openFile "Dados.txt" ReadMode;
    conteudo <- hGetContents arquivo;
    l <- recuperar_dados [] conteudo;
    putStrLn "Produtos Disponiveis: ";
    imprimeNome 'A' l;
    putStr "Digite o nome do produto a ser excluido: ";
    prod <- getLine;
    busca <- buscarProduto prod l;
    lreduzida <- reduz l busca;
    hClose arquivo;
    excluir_tudo;
    lnew <- excluir busca [];
    gravar lnew;
    gravar lreduzida;
    putStrLn "Exclusao Concluida";
    pause;
  }

m_excluir_tudo =
  do{
    excluir_tudo;
    putStrLn "O banco de dados foi todo excluido\n";
    pause;
  }

m_procurar_prod =
  do{
    putStrLn "\n\nBUSCA POR PRODUTO";
    arquivo <- openFile "Dados.txt" ReadMode;
    conteudo <- hGetContents arquivo;
    l <- recuperar_dados [] conteudo;
    putStrLn "Produtos Disponiveis: ";
    imprimeNome 'A' l;
    putStr "Nome do Produto: ";
    prod <- getLine;
    hClose arquivo;
    imprimeRelatorio 0 (buscaProduto prod l);
    pause;
  }

m_procurar_forn =
  do{
    putStrLn "\n\nBUSCA POR FORNECEDOR";
    arquivo <- openFile "Dados.txt" ReadMode;
    conteudo <- hGetContents arquivo;
    l <- recuperar_dados [] conteudo;
    putStrLn "Fornecedores Disponiveis: ";
    imprimeNome 'B' l;
    putStr "Digite o fornecedor: ";
    forn <- getLine;
    hClose arquivo;
    imprimeRelatorio 0 (buscaFornecedor forn l);
    pause;
  }

m_relatorio =
  do{
    putStrLn "\nRELATORIO";
    arquivo <- openFile "Dados.txt" ReadMode;
    conteudo <- hGetContents arquivo;
    l <- recuperar_dados [] conteudo;
    hClose arquivo;
    imprimeRelatorio 0 l;
    pause;
  }

m_backup =
  do{
    putStrLn "\nFAZENDO BACKUP";
    arquivo <- openFile "Dados.txt" ReadMode;
    conteudo <- hGetContents arquivo;
    l <- recuperar_dados [] conteudo;
    excluir_backup;
    backup l;
    hClose arquivo;
    putStrLn "Backup Concluido";
    pause;
  }

m_recuperar =
  do{
    putStrLn "\nRECUPERANDO O BACKUP";
    arquivo <- openFile "Backup.txt" ReadMode;
    conteudo <- hGetContents arquivo;
    l <- recuperar_dados [] conteudo;
    excluir_tudo;
    gravar l;
    hClose arquivo;
    putStrLn "Recuperado os dados";
    pause;
  }

m_sair = do{
	   m_backup;
	   putStrLn "Saindo do programa";
	   pause;
         }

erro =
  do{
    putStrLn "\nOpcao Invalida";
    opcao;
    pause;
  }

---------------------------------------------------------------
-- Funcoes Auxiliares					     --
---------------------------------------------------------------
pega_quantidade =
  do{
    putStr "Quantidade: ";
    qtde <- pega_numero;
    return qtde;
    }

pega_compra =
  do{
    putStr "Valor de Compra: ";
    valor <- pega_numero;
    return valor;
  }

pega_venda =
  do{
    putStr "Valor de Venda: ";
    valor <- pega_numero;
    return valor;
  }

pega_numero =
  do{
    numero <- getLine;
    if valida_numero numero then return numero else do{
						   putStrLn "\nIsto nao eh um numero!";
						   putStr "Digite Novamente: ";
						   pega_numero;
    						 }
  }

pega_sn = do{
	    op <- getChar;
	    if (toUpper (op) == 'S') || (toUpper (op) == 'N') then return (toUpper (op)) else do{
												putStrLn "\nDigite S ou N: ";
                                                                                                pega_sn;
                                                                                              }
          }

valida_numero [ ] = False
valida_numero [a] = if isDigit a then True else False
valida_numero (a:x)
  | isDigit a = valida_numero x
  | otherwise = False

gravar [] = putStr ""
gravar l = do{
	     arquivo <- openFile "Dados.txt"  AppendMode;
	     hPutStr arquivo (tProduto (head l)++";"++tFornecedor (head l)++";"++tQuantidade (head l)++";"++ tCompra (head l)++";"++tVenda(head l)++";"++"\n");
             hClose arquivo;
	     gravar (tail l);
	   }

backup [] = putStr ""
backup l = do{
	     arquivo <- openFile "backup.txt"  AppendMode;
	     hPutStr arquivo (tProduto (head l)++";"++tFornecedor (head l)++";"++tQuantidade (head l)++";"++ tCompra (head l)++";"++tVenda(head l)++";"++"\n");
             hClose arquivo;
	     backup (tail l);
	   }



alterar_compra [] l = return l;
alterar_compra (x:xs) l = do{
			    imprimeDados x;
			    putStr "Alterar? <S/N> ";
			    op <- pega_sn;
			    putStrLn "\n";
			    if (op == 'S') then do {
						  valor <- pega_compra;
						  l <- insere (trocaCompra valor x) xs;
                                                  alterar_compra xs l;
						}
					   else do {
						l <- insere x xs;
						alterar_compra xs l;
					        }
                          }

alterar_qtde [] l = return l;
alterar_qtde (x:xs) l= do{
			 imprimeDados x;
			 putStr "Alterar? <S/N> ";
			 op <- pega_sn;
                         putStrLn "\n";
			 if (op == 'S') then do {
					       valor <- pega_quantidade;
                                               l <- insere (trocaQuantidade valor x) xs;
					       alterar_qtde xs l;
					     }
					else do{
					       l <- insere x xs;
                                               alterar_qtde xs l;
					     }
		       }

alterar_venda [] l = return l;
alterar_venda (x:xs) l= do{
			 imprimeDados x;
			 putStr "Alterar? <S/N> ";
			 op <- pega_sn;
                         putStrLn "\n";
			 if (op == 'S') then do {
					       valor <- pega_venda;
                                               l <- insere (trocaVenda valor x) xs;
					       alterar_venda xs l;
					     }
					else do{
					       l <- insere x xs;
					       alterar_venda xs l;
					     }
		       }


excluir [] l = return l
excluir (x:xs) l = do{
               imprimeDados x;
	       putStr "Excluir?<S/N> ";
	       op <- pega_sn;
	       putStrLn "\n";        
	       if (op == 'S') then do {
                                      excluir xs l;
				   }
			      else do {
				      l <- insere x l;
				      excluir xs l;
				   }
	       }

excluir_tudo =
  do{
    arquivo <- openFile "Dados.txt" WriteMode;
    hClose arquivo;
  }

excluir_backup =
  do{
    arquivo <- openFile "backup.txt" WriteMode;
    hClose arquivo;
  }


reduz a x = return (reduzir a x)

reduzir x y = [a | a <- x, b <- y, a/=b ]

imprimeDados dados = do {
			putStr "Produto: ";
                        putStrLn (tProduto dados);
                        putStr "Fornecedor: ";
                        putStrLn (tFornecedor dados);
                        putStr "Quantidade: ";
			putStrLn (tQuantidade dados);
                        putStr "Valor de Compra: ";
			putStrLn (tCompra dados);
			putStr "Valor de Venda: ";
			putStrLn (tVenda dados);
			putStrLn "\n--------------------------------";
		     }

imprimeNome tipo [] = putStr ""
imprimeNome tipo (x:xs) = do {
			  case tipo of {
			    'A' -> do{
			         putStrLn (tProduto x);
			         imprimeNome tipo xs; 
			         };
			    'B' -> do{
	                 putStrLn (tFornecedor x);
	                 imprimeNome tipo xs;
			         };
			  };
			}		     
		

imprimeRelatorio n []  = putStr " "
imprimeRelatorio n (x:xs) = do{
		 if(n==3)then
		  do{
		   pause;
                   imprimeDados x;
                   imprimeRelatorio 1 xs; 
                  }
		 else
                   do{
                     imprimeDados x;
                     imprimeRelatorio (n+1) xs; 
                   }
		 }
buscarProduto a n = return (buscaProduto a n)
buscaProduto a [] = []
buscaProduto a (x:xs)
  | a==tProduto x   = x : buscaProduto a xs
  | otherwise       = buscaProduto a xs 

buscaFornecedor a [] = []
buscaFornecedor a (x:xs)
  | a==tFornecedor x= x: buscaFornecedor a xs
  | otherwise       = buscaFornecedor a xs

---------------------------------------------------------------
---- Tuplas 						     --
---------------------------------------------------------------
tProduto (x1,x2,x3,x4,x5) = x1
tFornecedor (x1,x2,x3,x4,x5) = x2
tQuantidade (x1,x2,x3,x4,x5) = x3
tCompra (x1,x2,x3,x4,x5) = x4
tVenda (x1,x2,x3,x4,x5) = x5

trocaQuantidade x (x1,x2,x3,x4,x5) = (x1,x2,x,x4,x5)
trocaCompra x (x1,x2,x3,x4,x5) = (x1,x2,x3,x,x5)
trocaVenda x (x1,x2,x3,x4,x5) = (x1,x2,x3,x4,x)

---------------------------------------------------------------
----- Trabalho com a manipulacao da string vinda do arquivo ---
---------------------------------------------------------------

carregaLista   []=[]
carregaLista (x:xs)
  |x==';'    =[]
  |otherwise =x:carregaLista xs


contaSeparador []=0
contaSeparador (x:xs)
  |x==';'    =1
  |otherwise =1+contaSeparador xs

contaBreak []=0
contaBreak (x:xs)
  |x==';'    =1
  |otherwise =1+contaBreak xs

decapitaLista [] n=[]
decapitaLista (x:xs) n
  |n<1       =x:xs
  |otherwise =decapitaLista xs (n-1)
  

lista x =return (carregaLista x)

decapita x n= return (decapitaLista x n)

insere x xs = return (x:xs)

recuperar_dados l []= return l
recuperar_dados l x = do{                   
	      produto <- lista x;
	      x <- decapita x (contaSeparador x);
	      fornecedor <- lista x;
	      x <- decapita x (contaSeparador x);
	      qtde <- lista x;
              x <- decapita x (contaSeparador x);
	      compra <- lista x;
	      x <- decapita x (contaSeparador x);
	      venda <- lista x;
	      x <- decapita x (contaBreak x);
	      l <- insere (produto,fornecedor,qtde,compra,venda) l;
	      recuperar_dados l (tail x);
	      }

