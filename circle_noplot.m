function [xcoord, ycoord] = circle_noplot(x,y,r)


ang=0:0.01:2*pi;

xp=r*cos(ang);

yp=r*sin(ang);
xcoord = x+xp;
ycoord = y+yp;


end