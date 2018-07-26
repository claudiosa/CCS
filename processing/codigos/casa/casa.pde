//Jane Hamel - Draw a House
size(800,800);
rect(50,200,500,350);   // outside border of house
triangle(50,200,300,50,550,200);   // roof
rect(85,250,100,225);   // outside of left window
rect(415,250,100,225);  // outside of right window
line(85,363,185,363);   // horizontal line in left window
line(135,250,135,475);  // vertical line in left window
line(415,363,515,363);  // horizontal line in right window
line(465,250,465,475);  // vertical line of right window
rect(250,250,100,300);  // border of door
ellipse(270,393,15,15); // door knob
