// Basic structure of the display and rectangles
size(800,800);
rectMode(CENTER);

/*
BASKETBALL HOOP MODELING
*/

//Basketball stand
noStroke();
fill(#A52A2A);
rect(150,400,30,500);

// Basketball backboard larger rect
fill(#FFFFFF);
stroke(#FFA500);
strokeWeight(4);
rect(150,150,150,100);

// Basketball backboard smaller rect
stroke(#FFA500);
strokeWeight(4);
rect(150,175,75,50);

// Basketball Net
stroke(#FFFFFF);
noFill();
strokeWeight(2);
//triangle(10, 0, 30, 0, 20, 20);
//triangle(30, 0, 50, 0, 40, 20);
//triangle(50, 0, 70, 0, 60, 20);
triangle(105, 210, 125, 210, 115, 230);
triangle(125, 210, 145, 210, 135, 230);
triangle(145, 210, 165, 210, 155, 230);
triangle(165, 210, 185, 210, 175, 230);

// Basketball Hoop
stroke(#FFA500);
strokeWeight(4);
noFill();
ellipse(150,210,75,20);

/*
ME MODELING
*/
fill(#C0C0C0);
stroke(#A9A9A9);
triangle(400,550,475,350,325,350);
//Legs
rect(375,550,50,150);
rect(425,550,50,150);
//Arms
rect(335,400,20,100);
rect(465,400,20,100);
//head
ellipse(400,320,70,70);
//eyes
strokeWeight(2);
ellipse(385,305,15,15);
ellipse(415,305,15,15);
//hair
fill(#000000);
stroke(#000000);
triangle(385,285,405,285,395,265);
triangle(400,285,420,285,410,265);
triangle(375,290,395,290,385,270);
triangle(410,290,430,290,420,270);
triangle(395,290,410,290,403,270);

/*
BASKETBALL MODELING
*/
fill(#FFA500);
ellipse(300,200,60,60);
