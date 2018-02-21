##swipl --goal=main --stand_alone=true -t main -o saida.exe -c fatorial.pl
#!/bin/sh
swipl --goal=main --stand_alone=true -t halt -o saida.exe -c fatorial.pl
swipl -stand_alone=true  -g main -t halt -o saida.exe -c fatorial.pl 
