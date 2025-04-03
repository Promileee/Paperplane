var acc = 0;
var speedx = 0;
var speedy = 0;
var inair = false;
var myzoom = 100;
onEnterFrame = function()
{
   mcArena._xscale = myzoom;
   mcArena._yscale = myzoom;
   mcTrees._xscale = myzoom;
   mcTrees._yscale = myzoom;
   mcHouses._xscale = myzoom;
   mcHouses._yscale = myzoom;
   mcHouseAway._xscale = myzoom;
   mcHouseAway._yscale = myzoom;
   mcSun._xscale = myzoom;
   mcSun._yscale = myzoom;
   if(xpos > 1285 * myzoom / 100 - 360)
   {
      xpos = 1285 * myzoom / 100 - 360;
   }
   if(xpos < - (1285 * myzoom / 100 - 360))
   {
      xpos = - (1285 * myzoom / 100 - 360);
   }
   if(ypos > 713.5 * myzoom / 100 - 200)
   {
      ypos = 713.5 * myzoom / 100 - 200;
   }
   if(ypos < - (713.5 * myzoom / 100 - 200))
   {
      ypos = - (713.5 * myzoom / 100 - 200);
   }
   mcSun._x = xpos * 0.04 + 360;
   mcSun._y = ypos * 0.04 + 200;
   mcHouseAway._x = xpos * 0.7 + 360;
   mcHouseAway._y = ypos * 0.7 + 200;
   mcHouses._x = xpos * 0.8 + 360;
   mcHouses._y = ypos * 0.8 + 200;
   mcTrees._x = xpos * 0.9 + 360;
   mcTrees._y = ypos * 0.9 + 200;
   mcArena._x = xpos + 360;
   mcArena._y = ypos + 200;
};
Stage.showMenu = false;
stop();
