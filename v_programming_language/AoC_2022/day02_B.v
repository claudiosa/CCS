import os

fn main() {

/* 
"Anyway, the second column says how the round needs to end:
 X means you need to lose, 
 Y means you need to end the round in a draw,
  and Z means you need to win. Good luck!"
*/

lines := os.read_lines('day02_inp.txt') !
//print(lines)

teste := ['A Y', 'B X', 'C Z']   // from code
mut a_map := map [u8] string{}
a_map[65] = 'A' //ROCK
a_map[66] = 'B' //PAPER
a_map[67] = 'C' //SCISSOR
a_map[88] = 'X' //ROCK
a_map[89] = 'Y' //PAPER
a_map[90] = 'Z' //SCISSOR

print('\n A map to deal difficulties with string: ${a_map}')
println('\n typeof ==> ${typeof(a_map).name }')
//println(' ==> ${typeof(teste).name }') // []string

mut opponent := '' //string
mut you :=  '' //string
/*
>>> mut l := 'C Y'
>>> println(' ==> ${typeof( l ).name }')
 ==> string
>>> print(l[0])
67
>>> print(l[0].ascii_str())
C
*/
mut object := 0
mut score := 0
for l in lines {
//for l in teste {	
	opponent = l[0] . str()
	you = l[2] . str()
// the opponent starts with A - ROCK   
// ['A Y', 'B X', 'C Z'] 
	if a_map[opponent.u8()] == 'A'
	{
		if  a_map[you.u8()] == 'X'
		{
		object = 1  // X == 1
		score += 0 + object // 
		continue
		}
		
		if  a_map[you.u8()] == 'Y'
		{
		object = 1  // 2 == Y 
		score += 3 + object //
		continue
		}
		
		if  a_map[you.u8()] == 'Z'
		{
		object = 1  // 3 == Z 
		score += 6 + object //
		continue
		}
	}
// the opponent starts with B - PAPER
	if a_map[opponent.u8()] == 'B'
	{
		if  a_map[you.u8()] == 'X'
		{
		object = 1  // 1 == X
		score += 0 + object // you lose
		continue
		}
		if  a_map[you.u8()] == 'Y'
		{
		object = 1  // Y
		score += 3 + object // equal
		continue
		}
		if  a_map[you.u8()] == 'Z'
		{
		object = 1 // Y
		score += 6 + object // you win
		continue
		}
	
	}
// the opponent starts with C - SCISSOR
	if a_map[opponent.u8()] == 'C'
	{
		if a_map[you.u8()] == 'X'
		{
		object = 1 // 3 == Z
		score += 0 + object //win
 		continue
		}
		
		if a_map[you.u8()] == 'Y'
		{
		object = 1 // 3 == Z
		score += 3 + object //lose
 		continue
		}

		if a_map[you.u8()] == 'Z'
		{
		object = 1 // 3 == Z
		score += 6 + object //equal
 		continue
		}
	}
    //print(a_map[opponent.u8()])	
	//println(' ${typeof( opponent ).name } :: ${opponent}  <===> ${you} ${you.len}')
	
}	
println('\n Final score: ${score} PART II of the problem' )
	//print(l)
	//println('${l[0].str()}')
	// println(l[2])
	//println('${l[0].str()} ----- ${l[2].str()}')

} // end main

