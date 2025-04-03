class ArenaDay extends MovieClip
{
   var xpos = 1000;
   var ypos = -827;
   var myzoom = 100;
   function ArenaDay()
   {
      super();
   }
   function SetPos(newx, newy)
   {
      if(newx > 1285 * this.myzoom / 100 - 360)
      {
         newx = 1285 * this.myzoom / 100 - 360;
      }
      if(newx < - (1285 * this.myzoom / 100 - 360))
      {
         newx = - (1285 * this.myzoom / 100 - 360);
      }
      if(newy > 713.5 * this.myzoom / 100 - 200)
      {
         newy = 713.5 * this.myzoom / 100 - 200;
      }
      if(newy < - (713.5 * this.myzoom / 100 - 200))
      {
         newy = - (713.5 * this.myzoom / 100 - 200);
      }
      this.xpos = newx;
      this.ypos = newy;
   }
}
