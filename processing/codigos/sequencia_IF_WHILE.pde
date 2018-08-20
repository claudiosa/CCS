// A partir deste exemplo os ALUNOS criam seus próprios experimentos
// tem-se a noção de SEQUENCIA, CONDICIONAL e REPETICAO
// Isto na 8a. aula ... inicio da 4a. semana
// sob LINUX

// DECLARACAO DE  VARIAVEIS
  int x, y, i; // coordenadas do retangulo
  int largura, altura; // VARIAVEIS
  int d = 5; // distancia foi criada e ATRIBUIDA
// ATRIBUICAO  
  x = 15;
  y = 25;
  largura = 35;
  altura = 35;

  size(840, 360); // janela 640 x 360
 
 // laco(cond inicial ; TESTE LOGICO; INCREMENTOS/ DECs)
// for(i = 1; i< 10 ; )
 // OU LACO COM WHILE
i = 1; // CONTADOR de VOLTAS
while( i< 15 )
  {
    
   if( i % 2 == 0)  // estrutura condicional
   {  // SE VERDADE executa este bloco
   fill (  #F44ED7   );
   rect(x,y, largura,   altura);
   fill(0);
   textSize(14);
 //  text( i , 0.9*(x+(largura/2)), 0.9*(y+(altura/2)));
   text( i , (x+(largura/2))-2, (y+(altura/2))+2     );
   }
   else
   {  // SE FALSO executa este bloco
   fill (  #F1F515  );
   rect(x,y, largura,   altura);
   //ellipse(x,y, largura,   altura);
   fill(0);
   textSize(14);
 //  text( i , 0.9*(x+(largura/2)), 0.9*(y+(altura/2)));
   text( i , (x+(largura/2))-2, (y+(altura/2))+2     );
   }
   
   
    x = x + largura + d;
    //delay(300);
    i = i + 1;
  } // FIM DO WHILE SEM PONTO ;
 
  fill(0);
  textSize(45);
  text("FIMZAO " ,100, 100);
