0..24: HoraX = 17;
0..24: HoraY = 18;
0..24: maxTempoEstudo = 4;

var HoraX..HoraY: hora;
var 0..maxTempoEstudo: tempoEstudo;
var bool: lavouLouca;
var bool: secouLouca;

constraint HoraX < HoraY;
constraint hora >= 15;
constraint hora <= 21;
constraint tempoEstudo >= 2;
constraint (lavouLouca \/ secouLouca) = true;

solve satisfy;

output [ "hora: ", show(hora),
         "\ntempo de estudo: ", show(tempoEstudo),
         "\nlavou a louca: ", show(lavouLouca),
         "\nsecou a louca: ", show(secouLouca)];
