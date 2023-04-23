function circle(x,y,r, color)


ang=0:0.01:2*pi;

xp=r*cos(ang);

yp=r*sin(ang);
xcoord = x+xp;
ycoord = y+yp;
plot(x+xp,y+yp, color);




hold on

axis equal 

end