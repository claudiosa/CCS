%
% Lewis Carrol's classical puzzle with five houses and a zebra:
% 
% Five men with different nationalities live in the first five houses
% of a street.  They practise five distinct professions, and each of
% them has a favourite animal and a favourite drink, all of them
% different.  The five houses are painted in different colours.
% 
% The Englishman lives in a red house.
% The Spaniard owns a dog.
% The Japanese is a painter.
% The Italian drinks tea.
% The Norwegian lives in the first house on the left.
% The owner of the green house drinks coffee.
% The green house is on the right of the white one.
% The sculptor breeds snails.
% The diplomat lives in the yellow house.
% Milk is drunk in the middle house.
% The Norwegian's house is next to the blue one.
% The violinist drinks fruit juice.
% The fox is in a house next to that of the doctor.
% The horse is in a house next to that of the diplomat.
% 
% Who owns a Zebra, and who drinks water?
% 

:-use_module(library(clpfd)).
:-use_module(library(lists)).

zebra :-

    % we use 5 lists of 5 variables each
	Nat = [English, Spaniard, Japanese, Italian, Norwegian],
	Color = [Red, Green, White, Yellow, Blue],
	Profession = [Painter, Sculptor, Diplomat, Violinist, Doctor],
	Pet = [Dog, Snails, Fox, Horse, Zebra],
	Drink = [Tea, Coffee, Milk, Juice, Water],

    % domains: all the variables range over house numbers 1 to 5
	domain(Nat,1,5),
	domain(Color,1,5),
	domain(Profession,1,5),
	domain(Pet,1,5),
	domain(Drink,1,5),

    % the values in each list are exclusive
	all_different(Nat),
	all_different(Color),
	all_different(Profession),
	all_different(Pet),
	all_different(Drink),

    % and here follow the actual constraints
	English #= Red,
	Spaniard #= Dog,
	Japanese #= Painter,
	Italian #= Tea,
	Norwegian #= 1,
	Green #= Coffee,
	Green #= White + 1,
	Sculptor #= Snails,
	Diplomat #= Yellow,
	Milk #= 3,
        
	%domain(Dist1 , -1, 1),
        Dist1 in -1..1,
        Dist1 #= 0,	
        Dist1 #= Norwegian - Blue, 
        
	Violinist #= Juice,
        Dist2 in -1..1,
	Dist2 #= 0,
	Dist2 #= Fox - Doctor, 
        
        Dist3 in -1..1,
	Dist3 #= 0,
	Dist3 #= Horse - Diplomat, 
        
    % put all the variables in a single list
     append([Nat, Color, Profession, Pet, Drink], List),

    % search: label all variables with values
        labeling([ff], List),
    
	% print the answers: we need to do some decoding
	NatNames = [English-english, Spaniard-spaniard, Japanese-japanese,
		    Italian-italian, Norwegian-norwegian],
	memberchk(Zebra-ZebraNat, NatNames),
	memberchk(Water-WaterNat, NatNames),
	
	format('The  owns the zebra ~w', [ZebraNat]),
	format('\nThe  drinks water ~w', [WaterNat]).
    
/**************************************************/
/*
>>> inside of SICSTUS:

| ?- % compiling /home/ccs/my_main/MODAL/github_modal/cablerouter-pl/exemplo_transliteracao/walter_carnielli/zebra.pl...
% compiled /home/ccs/my_main/MODAL/github_modal/cablerouter-pl/exemplo_transliteracao/walter_carnielli/zebra.pl in module user, 5 msec -3440 bytes
% source_info
| ?-  zebra.
The  owns the zebra japanese
The  drinks water norwegian
yes
% source_info
| ?-
*/