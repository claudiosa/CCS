;Criação de novos tipos de agente:
;Breed é declarado com o primeiro nome sendo o plural, utilizado quando se trabalha com todos os agentes,
;seguido do nome no singular, quando se trata de um agente específico. Eles herdam os atributos e funções
;de turtles. (ex: create-turtles -> create-canhotos)
;3 breeds diferentes, um para cada tipo de busca.
breed [canhotos canhoto]
breed [destros destro]
breed [galera pessoa]

;ALGUMAS OUTRAS FUNÇÕES:
;{sprout X ou sprout-breed X, ex: sprout-canhotos X} - Utilizada por patches para criar novos agentes.
;É seguida de um bloco de comando e/ou atribuições para esses novos agentes, e vem por default na 
;posição de quem chama a função:
;ex: sprout-canhotos 5 [set color green set shape "circle"]
;{hatch X ou hatch-breed X, ex: hatch-destros X} - Utilizada por agentes, turtles, para criar novos agentes.
;Funciona da mesma forma que sprout.

;Adição de uma nova variável aos novos agentes.
;Serão utilizados para controle de direção durante a função de busca.
;Own é declarado com o nome plural do breed (grupo de agentes) e o nome da variável.
canhotos-own [dir]
destros-own [dir]

;Adição de uma variável de marcação aos patches para controle da direção na função de movimento.
patches-own [pathList]

;SETUP E CRIAÇÃO
to setup
  ;Limpa a interface.
  ;{ ca ou clear-all }
  ca

  ;Reseta o contador de rodadas. (Tempo)
  reset-ticks

  ;Cria o contorno.
  addBox

  ;Adiciona o labitinto.
  addLabirinto

  ;Abre as saídas do labirinto.
  addSaidas

  ;A varíavel adicionada aos patches (chão) na declaração é aqui
  ;inicializada como um vetor de 4 elementos, sendo associado 0 para cada um deles.
  ask patches [set pathList [0 0 0 0]]

  ;Funções de criação dos buscadores.
  createDestros
  createCanhotos
  createGalera
end

to createCanhotos
  ;Semelhante a create-turtles, mas do breed específico e com quantidade
  ;associada ao slider da interface (BuscaEsquerda).
  create-canhotos BuscaEsquerda
  ;Posição inicial do agente: Calculada para ser dentro do labirinto, em qualquer um dos quadrantes.
  [setxy ((1 - boxTam) + round random ((2 * boxTam) - 2))
         ((1 - boxTam) + round random ((2 * boxTam) - 2))
  ;Ângulo inicial, múltiplo de 90 para garantir cima, baixo, direita e esquerda.
  set heading random 4 * 90
  set color 65
  ;Inicializa a variável dir = 0
  set dir 0
  ;Pen-down deixa o rastro por onde o agente passa na interface
  ;(Pen-up para não marcar e vem como default)
  pen-down]
end

to createDestros
  ;Semelhante à função createCanhotos (Ver acima).
  create-destros BuscaDireita
  [setxy ((1 - boxTam) + round random-float ((2 * boxTam) - 2))
         ((1 - boxTam) + round random-float ((2 * boxTam) - 2))
  set heading random 4 * 90
  set color 15
  pen-down]
  ;Código de busca diferente, não decessita da variável dir.
end

to createGalera
  ;Semelhante à função createCanhotos (Ver acima).
  create-galera buscaAleatoria
  [setxy ((1 - boxTam) + round random-float ((2 * boxTam) - 2))
         ((1 - boxTam) + round random-float ((2 * boxTam) - 2))
  set heading random 4 * 90
  set color 45
  pen-down]
  ;Não utiliza a variável dir.
end

;FUNÇÕES DE MOVIMENTO
to move
  ;Move: Função que move aleatoriamente os agentes.
  ;Calcula uma nova direção entre:
  ;Cima, baixo, esquerda e direita, logo após cada um dos movimentos.

  ;Ask é uma função que "Pede", seleciona cada um dos tipos descritos (Nesse caso, galera) a executar os comandos
  ;entre colchetes em ordem.
  ask galera [

    ;Função { ifelse (condições) [Caso True faz primeiro bloco] [Caso False realiza o segundo bloco] }
    ;{ can-move? X } é a função que detecta se o agente em questão pode se movimentar X casas adiante (1 no caso)
    ;sem chegar ao fim da interface, retorna True ou False.
    ifelse can-move? 1
    [
      ;Função { any? } retorna True caso exista pelo menos 1 agente do tipo descrito. ({ Not any? } retorna o inverso)
      ;{ Turtles-on } retorna a quantidade de turtles em um patch específico, no caso é utilizada ainda outra função
      ;para seleção desse patch:
      ;{ Patch-ahead X }, a qual se refere a um patch a uma distância X do agente em questão, seguinte em frente
      ;a seu heading (Direção para a qual está virado).
      ;RESUMO: Verifica se não há turtles uma casa à frente.
      if not any? turtles-on patch-ahead 1

      ;{ [pcolor] of } retorna a cor do patch desejado, nesse caso, patch logo a frente do agente e verifica
      ;se é diferente de azul (cor do labirinto).
      and [pcolor] of patch-ahead 1 != blue

      ;{ fd X ou forward X } movimenta o agente X patches para frente (Direção para a qual está virado).
      [fd 1]
    ]
    ;Mata o agente em questão.
    [die]
    ;Seta um novo ângulo para o agente.
    set heading random 4 * 90
  ]
end

to moveFD
  ;Semelhante a função move, diferença é que a mudança de direção ocorre apenas quando
  ;não é possível mover em frente, e não mais após cada movimento.
  ask galera [
    ifelse can-move? 1
    [ifelse not any? turtles-on patch-ahead 1
    and [pcolor] of patch-ahead 1 != blue [fd 1]
    [set heading random 4 * 90]]
    [die]
  ]
end

to moveFDL
    ;A ideia da busca é andar em frente com a mão esquerda na parede do labirinto (Seguir a parede esquerda).
    ;Seleciona os canhotos:
    ask canhotos [
      ;ESQUERDA E CIMA
      ;Serão quatro direções difentes, a primeira (0) é para esquerda e para cima, com preferência em ir para esquerda.
      if dir = 0 [
        ;Verifica se o patch a esquerda do agente é uma parede, se não, vira para esquerda e move um patch adiante.
        ;{ patch-at A B } faz referência ao patch à uma distância A no eixo X, e B no eixo Y de quem chama a função.
        ;Nesse caso retorna e compara a cor do patch.
        ifelse [pcolor] of patch-at -1 0 != blue [set heading -90 fd 1]

        ;Verifica se a diagonal esquerda e acima é azul, bem como o bloco logo acima, se nenhum dos dois forem,
        ;realiza um movimento em L, andando uma casa para cima e em seguida uma casa para esquerda.
        [ifelse [pcolor] of patch-at -1 1 != blue and [pcolor] of patch-at 0 1 != blue [set heading 0 fd 1 lt 90 fd 1

          ;Após realizar o movimento, verifica se o chão está marcado com a variável pathList (presente nos patches)
          ;a fim de controlar a direção. Se ainda não tiver sido alterada, irá alterar o primeiro valor do vetor pathList (pois dir = 0)
          ;para 1. Também irá alterar a direção para garantir o ciclo de busca. Caso não altere, ficaria em loop.
          ;{ replace-item X 'variável' Y } Troca o valor do item de um vetor na posição X para o novo valor Y.
          ifelse [item 0 pathList] of patch-at 0 0 = 0 [set dir 3 ask patch-at 0 0 [set pcolor black set pathList (replace-item 0 pathList 1)]]

          ;Caso o patch estivesse marcado, ele ignora a parede e segue em frente, pois significa que já
          ;completou uma volta e não encontrou a saída.
          [ask patch-at 0 0 [set pcolor black set pathList (replace-item 0 pathList 0)]]]

          ;Se não puder andar na diagonal, verifica se o bloco acima está livre, caso sim, anda para cima
          ;No entanto, mantem a mesma direção ainda, e no próximo passo, ainda tentará ir para esquerda.
          [ifelse [pcolor] of patch-at 0 1 != blue [set heading 0 fd 1]

            ;Caso também não possa ir para cima, verifica se a diagonal a cima e a direita está livre e
            ;se não há um bloco a direita (costas) e, se ambos estiverem livres, realiza o movimento de voltar uma
            ;casa (patch) e em seguida ir para cima.
            ;{ lt X ou left X} é um giro em X graus para esquerda a partir do heading (direção da seta) atual.
            [ifelse [pcolor] of patch-at 1 1 != blue and [pcolor] of patch-at 1 0 != blue [set heading 90 fd 1 lt 90 fd 1]
              ;Caso não seja possível realizar nenhum dos movimentos anteriores, significa que o agente chegou em um canto
              ;e portanto irá mudar de direção.
              [set dir 1
              ]
            ]
          ]
        ]
      ]
      ;CIMA E DIREITA
      ;O processo se repete, igual ao anterior, com excessão de que agora ele tentará ir para cima e para direita,
      ;dando preferência para cima, como se chegasse na parede superior do labirinto e tentasse achar a porta acima.
      if dir = 1 [
        ifelse [pcolor] of patch-at 0 1 != blue [set heading 0 fd 1]
        [ifelse [pcolor] of patch-at 1 1 != blue and [pcolor] of patch-at 1 0 != blue [set heading 90 fd 1 lt 90 fd 1 ifelse [item 1 pathList] of patch-at 0 0 = 0 [set dir 0 ask patch-at 0 0 [set pcolor black set pathList (replace-item 1 pathList 1)]][ask patch-at 0 0 [set pcolor black set pathList (replace-item 1 pathList 0)]]]
          [ifelse [pcolor] of patch-at 1 0 != blue [set heading 90 fd 1]
            [ifelse [pcolor] of patch-at 1 -1 != blue and [pcolor] of patch-at 0 -1 != blue [set heading 180 fd 1 lt 90 fd 1]
              [set dir 2
              ]
            ]
          ]
        ]
      ]

      ;DIREITA E BAIXO
      ;Processo semelhante aos anteriores, mas com foco na direita e para baixo.
      if dir = 2 [
        ifelse [pcolor] of patch-at 1 0 != blue [set heading 90 fd 1]
          [ifelse [pcolor] of patch-at 1 -1 != blue and [pcolor] of patch-at 0 -1 != blue [set heading 180 fd 1 lt 90 fd 1 ifelse [item 2 pathList] of patch-at 0 0 = 0 [set dir 1 ask patch-at 0 0 [set pcolor black set pathList (replace-item 2 pathList 1)]][ask patch-at 0 0 [set pcolor black set pathList (replace-item 2 pathList 0)]]]
            [ifelse [pcolor] of patch-at 0 -1 != blue [set heading 180 fd 1]
              [ifelse [pcolor] of patch-at -1 -1 != blue and [pcolor] of patch-at -1 0 != blue [set heading -90 fd 1 lt 90 fd 1]
                [set dir 3
                ]
              ]
            ]
          ]
        ]


      ;BAIXO E ESQUERDA
      ;Processo semelhante aos anteriores, mas com foco na direita e para baixo.
      if dir = 3 [
        ifelse [pcolor] of patch-at 0 -1 != blue [set heading 180 fd 1]
          [ifelse [pcolor] of patch-at -1 -1 != blue and [pcolor] of patch-at -1 0 != blue [set heading -90 fd 1 lt 90 fd 1 ifelse [item 3 pathList] of patch-at 0 0 = 0 [set dir 2 ask patch-at 0 0 [set pcolor black set pathList (replace-item 3 pathList 1)]][ask patch-at 0 0 [set pcolor black set pathList (replace-item 3 pathList 0)]]]
            [ifelse [pcolor] of patch-at -1 0 != blue [set heading -90 fd 1]
              [ifelse [pcolor] of patch-at -1 1 != blue and [pcolor] of patch-at 0 1 != blue [set heading 0 fd 1 lt 90 fd 1]
                [set dir 0
                ]
              ]
            ]
          ]
        ]
      ]
end

to moveFDR
  ;A ideia da busca é andar em frente com a mão direita na parede do labirinto (Seguir a parede direita).
  ;O algoritmo funciona da mesma forma que o de movimento para esquerda, no entanto, utiliza sempre a direção para
  ;o qual está virado e, portanto, não necessita da variável dir e é possível construir em apenas um bloco.
  ask destros [
    ;Verifica se pode ir para frente.
    ifelse [pcolor] of patch-ahead 1 != blue [fd 1]

      ;Verifica se a diagona esquerda e acima está livre (relativa ao ângulo), bem como o bloco logo a esquerda do agente,
      ;caso sim, vira 90 graus a esquerda, move-se para frente, 90 graus a direita, e move-se para frente novamente.
      ;(realiza o movimento diagonal)
      ;{ patch-left-and-ahead A X } faz a referência do patch num angulo A à esquerda e X casas (patches) de distância de quem chama a função.
      ;{ lt X ou left X} é um giro em X graus para esquerda a partir do heading (direção da seta) atual.
      ;{ rt X ou right X} é um giro em X graus para direita a partir do heading (direção da seta) atual.
      [ifelse [pcolor] of patch-left-and-ahead 45 1 != blue and [pcolor] of patch-left-and-ahead 90 1 != blue [lt 90 fd 1 rt 90 fd 1

          ;Verifica qual a direção em que olha, pois deve marcar o patch relativamente a ela,
          ;e altera a variável pathList de acordo. Semelhante à função moveFDL.
          ;{ replace-item X 'variável' Y } Troca o valor do item de um vetor na posição X para o novo valor Y.
          ifelse heading = 0 [ifelse [item 0 pathList] of patch-at 0 0 = 0 [rt 90 ask patch-at 0 0 [set pcolor black set pathList (replace-item 0 pathList 1)]]
            [ask patch-at 0 0 [set pcolor black set pathList (replace-item 0 pathList 0)]]]
          [ifelse heading = 90 [ifelse [item 1 pathList] of patch-at 0 0 = 0 [rt 90 ask patch-at 0 0 [set pcolor black set pathList (replace-item 1 pathList 1)]]
            [ask patch-at 0 0 [set pcolor black set pathList (replace-item 1 pathList 0)]]]
          [ifelse heading = 180 [ifelse [item 2 pathList] of patch-at 0 0 = 0 [rt 90 ask patch-at 0 0 [set pcolor black set pathList (replace-item 2 pathList 1)]]
            [ask patch-at 0 0 [set pcolor black set pathList (replace-item 2 pathList 0)]]]
            [if heading = 270 [ifelse [item 3 pathList] of patch-at 0 0 = 0 [rt 90 ask patch-at 0 0 [set pcolor black set pathList (replace-item 3 pathList 1)]]
              [ask patch-at 0 0 [set pcolor black set pathList (replace-item 3 pathList 0)]]]]]]]

        ;Se o movimento em diagonal não foi possível, verifica se o bloco à esquerda relativa ao ângulo está disponível,
        ;e, se sim, move-se à esquerda e volta a olhar para direção que estava antes do movimento (Mantém a mesma direção).
        [ifelse [pcolor] of patch-left-and-ahead 90 1 != blue [lt 90 fd 1 rt 90]

          ;Verifica se pode se mover uma casa à esquerda e também para trás, caso sim, realiza um passo para trás e outro para esquerda.
          [ifelse [pcolor] of patch-left-and-ahead 135 1 != blue and [pcolor] of patch-ahead -1 != blue [lt 180 fd 1 rt 90 fd 1 rt 90]
            ;Caso nenhum dos anteriores seja possível, irá mudar o ângulo da direção.
            [lt 90
            ]
          ]
        ]
      ]

  ]
end

;ENVIRONMENT
to addBox
  ;Seleciona os patches do contorno (box) do labirinto.
  ;Inicia no x limite e seleciona todos os y menores e iguais ao limite e
  ;faz o contrario em seguida.
  ask patches with [ ((abs pxcor = boxTam) and (abs pycor <= boxTam)) or
                     ((abs pycor = boxTam) and (abs pxcor <= boxTam)) ]
  ;Marca como parede (cor azul).
  [ set pcolor blue ]
  ;Adiciona um label aos blocos no exterior do labirinto, para controle da saída.
  ask patches with [ ((abs pxcor = boxTam + 1) and (abs pycor <= boxTam + 1)) or
                     ((abs pycor = boxTam + 1) and (abs pxcor <= boxTam + 1)) ]
  [set plabel-color black]
end

to addLabirinto
  let Labqt ((2 * boxTam) - 1) * ((2 * boxTam) - 1) * labirintoQt / 100
  ;LABIRINTO RANDOM
  ;Seleciona os patches dentro da box (contorno) do labirinto.
   ask patches with [ (abs pxcor < boxTam and abs pycor < boxTam)]
   ;Não 100% eficaz mas para garantir alguma consistência de que haveram saídas possíveis
   ;foram utilizadas algumas condições na hora de construir as paredes:
     [if pcolor != blue and
       ;Caso ainda não seja parede, verifica se não há duas das diagonais do patch já marcadas como parede, para não criar muitas diagonais.
       (    ([pcolor] of patch-at 1 1 != blue and [pcolor] of patch-at -1 -1 != blue) or ([pcolor] of patch-at 1 1 != blue and [pcolor] of patch-at -1 1 != blue) or ([pcolor] of patch-at 1 1 != blue and [pcolor] of patch-at 1 -1 != blue)
         or ([pcolor] of patch-at 1 -1 != blue and [pcolor] of patch-at -1 -1 != blue) or ([pcolor] of patch-at 1 -1 != blue and [pcolor] of patch-at -1 1 != blue) or ([pcolor] of patch-at 1 -1 != blue and [pcolor] of patch-at 1 1 != blue)
         or ([pcolor] of patch-at -1 1 != blue and [pcolor] of patch-at -1 -1 != blue) or ([pcolor] of patch-at -1 1 != blue and [pcolor] of patch-at 1 -1 != blue) or ([pcolor] of patch-at -1 1 != blue and [pcolor] of patch-at 1 1 != blue)
         or ([pcolor] of patch-at -1 -1 != blue and [pcolor] of patch-at -1 1 != blue) or ([pcolor] of patch-at -1 -1 != blue and [pcolor] of patch-at 1 -1 != blue) or ([pcolor] of patch-at -1 -1 != blue and [pcolor] of patch-at 1 1 != blue)
        ) and
       ;Verifica se não há 3 blocos lado a lado (no contorno) já marcados, para não criar quadrados 2x2 de parede.
       (    ([pcolor] of patch-at 0 1 != blue and [pcolor] of patch-at -1 0 != blue and [pcolor] of patch-at -1 1 != blue) or ([pcolor] of patch-at 0 1 != blue and [pcolor] of patch-at 1 0 != blue and [pcolor] of patch-at 1 1 != blue) or ([pcolor] of patch-at 0 1 != blue and [pcolor] of patch-at 0 -1 != blue and ([pcolor] of patch-at 1 0 != blue or [pcolor] of patch-at -1 0 != blue))
         or ([pcolor] of patch-at 0 -1 != blue and [pcolor] of patch-at -1 0 != blue and [pcolor] of patch-at -1 -1 != blue) or ([pcolor] of patch-at 0 -1 != blue and [pcolor] of patch-at 1 0 != blue and [pcolor] of patch-at 1 -1 != blue) or ([pcolor] of patch-at 0 -1 != blue and [pcolor] of patch-at 0 1 != blue and ([pcolor] of patch-at 1 0 != blue or [pcolor] of patch-at -1 0 != blue))
         or ([pcolor] of patch-at 1 0 != blue and [pcolor] of patch-at -1 0 != blue and ([pcolor] of patch-at 0 1 != blue or [pcolor] of patch-at 0 -1 != blue)) or ([pcolor] of patch-at 1 0 != blue and [pcolor] of patch-at 0 -1 != blue and [pcolor] of patch-at 1 -1 != blue) or ([pcolor] of patch-at 1 0 != blue and [pcolor] of patch-at 0 1 != blue and [pcolor] of patch-at 1 1 != blue)
         or ([pcolor] of patch-at -1 0 != blue and [pcolor] of patch-at 1 0 != blue and ([pcolor] of patch-at 0 1 != blue or [pcolor] of patch-at 0 -1 != blue)) or ([pcolor] of patch-at -1 0 != blue and [pcolor] of patch-at 0 1 != blue and [pcolor] of patch-at -1 1 != blue) or ([pcolor] of patch-at -1 0 != blue and [pcolor] of patch-at 0 -1 != blue and [pcolor] of patch-at -1 -1 != blue)
        )
       ;Por fim, controla a quantidade de paredes construidas.
       [set Labqt Labqt - 1 if Labqt >= 0 [set pcolor blue]]
     ]
end

to addSaidas
   ;saidas
   ;cria nova variável (qtSaidas) e atribui o valor de saidas (slider na interface) à ela.
   let qtSaidas saidas
   ;Pede, seleciona todos os patches que estejam no contorno do labirinto.
   ;A seleção (ordem) desses patches é aleatória.
   ask patches with [ ((abs pxcor = boxTam) and (abs pycor <= boxTam)) or
                     ((abs pycor = boxTam) and (abs pxcor <= boxTam)) ]
   [
    ;Verifica se o patch a direita e a esquerda do patch em execução são pretos (caminháveis)
    ;Verifica também se o patch ainda é azul (parede) para não sobrescrever uma saída.
    if [pcolor] of patch-at 1 0 = black
    and [pcolor] of patch-at -1 0 = black
    and pcolor = blue
    ;Se forem caminháveis, reduz 1 em qtSaidas (controle da quantidade de saídas existentes)
    ;e torna aquele bloco preto (caminhável).
    [if qtSaidas > 0 [set qtSaidas (qtSaidas - 1) set pcolor black ]]
    ;Repete o processo anterior, mas verificando os patches acima
    ;e abaixo do patch em questão.
    if [pcolor] of patch-at 0 1 = black
    and [pcolor] of patch-at 0 -1 = black
    and pcolor = blue
    [if qtSaidas > 0 [set qtSaidas qtSaidas - 1 set pcolor black]]
   ]
end

to mataTartarugasReseta
  ;Para cada agente, se a cor do label do patch em que ele se encontra for preta,
  ;mata o agente (morre).
  ask turtles [if [plabel-color] of patch-at 0 0 = black [die]]
  ;{ count turtles } retorna o numero de agentes e, se igual a 0, faz um setup (função de iniciação).
  if count turtles = 0 [setup]
end



;;;------------------------------------------------------------------------;;;
;;;-------------------------WillianFeldmannKumlehn-------------------------;;;
;;;------------------------------------------------------------------------;;;
@#$#@#$#@
GRAPHICS-WINDOW
210
10
666
467
-1
-1
12.11
1
10
1
1
1
0
0
0
1
-18
18
-18
18
1
1
1
ticks
30.0

BUTTON
8
416
85
449
Clear All
ca
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
140
118
205
151
+TurtlesN
createGalera
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
138
10
206
79
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
140
82
205
115
GO
mataTartarugasReseta\nmoveFD\nmoveFDL\nmoveFDR\ntick
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
5
10
134
43
BoxTam
BoxTam
0
max-pxcor - 1
17.0
1
1
NIL
HORIZONTAL

SLIDER
5
46
134
79
LabirintoQt
LabirintoQt
0
60
20.0
5
1
%
HORIZONTAL

BUTTON
141
155
206
188
Pen
ask turtles [ifelse pen-mode = \"down\" [pen-up] [pen-down]]\n;ask turtles [ifelse pen-mode = false [print 1 pen-up] [print 0 pen-down]]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
5
82
134
115
Saidas
Saidas
0
50
5.0
1
1
NIL
HORIZONTAL

SLIDER
5
119
134
152
BuscaEsquerda
BuscaEsquerda
0
10
1.0
1
1
NIL
HORIZONTAL

SLIDER
5
155
134
188
BuscaDireita
BuscaDireita
0
10
1.0
1
1
NIL
HORIZONTAL

SLIDER
5
191
134
224
BuscaAleatoria
BuscaAleatoria
0
25
0.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
