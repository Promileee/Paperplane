function setData(mc, bmp, fire, col, sx)
{
   timetolaunch = col;
   startx = sx;
   posx = startx;
   mcCanvas = mc;
   bmpCanvas = bmp;
   bmpFirework = flash.display.BitmapData.loadBitmap(fire);
   speedx = Math.random() * 2 - 1;
   time = 105 + Math.floor(Math.random() * 10) - 5;
}
function drawParticles()
{
   if(timetolaunch > 0)
   {
      timetolaunch--;
      return undefined;
   }
   if(pstate == 0)
   {
      bmpCanvas.copyPixels(bmpFirework,new flash.geom.Rectangle(85,16,16,16),new flash.geom.Point(posx,posy),bmpFirework,new flash.geom.Point(85,16),true);
      posx += speedx;
      posy += speedy;
      speedy += 0.15;
      time--;
      if(time == 0)
      {
         particles = new Array();
         var _loc3_ = undefined;
         var _loc4_ = undefined;
         var _loc1_ = 0;
         while(_loc1_ < 100)
         {
            _loc4_ = Math.random() * 360 * 3.141592653589793 / 360;
            _loc3_ = Math.random() * 8 - 4;
            particles.push(makeParticle(posx,posy,Math.cos(_loc4_) * _loc3_,Math.sin(_loc4_) * _loc3_,50));
            _loc1_ = _loc1_ + 1;
         }
         pstate = 1;
         time = 50;
      }
   }
   else if(pstate == 1)
   {
      var _loc5_ = 160 - Math.floor(time * 10 / 50) * 16;
      _loc1_ = 0;
      while(_loc1_ < 100)
      {
         var _loc2_ = Math.floor(Math.random() * 2) * 16;
         bmpCanvas.copyPixels(bmpFirework,new flash.geom.Rectangle(_loc5_,_loc2_,16,16),new flash.geom.Point(particles[_loc1_].x,particles[_loc1_].y),bmpFirework,new flash.geom.Point(_loc5_,_loc2_),true);
         particles[_loc1_].x += particles[_loc1_].speedx;
         particles[_loc1_].y += particles[_loc1_].speedy;
         _loc1_ = _loc1_ + 1;
      }
      time--;
      if(time == 0)
      {
         pstate = 0;
         posx = startx;
         posy = 300;
         speedy = -10;
         speedx = Math.random() * 2 - 1;
         time = 105 + Math.floor(Math.random() * 10) - 5;
      }
   }
}
function makeParticle(px, py, sx, sy, life)
{
   return {x:px,y:py,speedx:sx,speedy:sy,life:life};
}
var posx = 200;
var posy = 300;
var speedx = 2;
var speedy = -10;
var time = 105;
var pstate = 0;
var particles;
var startx = 0;
var timetolaunch;
var mcCanvas;
var bmpCanvas;
var bmpFirework;
