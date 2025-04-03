var mcCanvas;
var bmpCanvas;
mcCanvas = this.createEmptyMovieClip("mcCanvas",this.getNextHighestDepth());
bmpCanvas = new flash.display.BitmapData(Stage.width,Stage.height,true,0);
mcCanvas.attachBitmap(bmpCanvas,this.getNextHighestDepth());
this.attachMovie("mc_firework","mcFirework1",this.getNextHighestDepth());
this.attachMovie("mc_firework","mcFirework2",this.getNextHighestDepth());
this.attachMovie("mc_firework","mcFirework3",this.getNextHighestDepth());
this.attachMovie("mc_firework","mcFirework4",this.getNextHighestDepth());
this.attachMovie("mc_firework","mcFirework5",this.getNextHighestDepth());
onEnterFrame = function()
{
   if(fireaway == true)
   {
      if(mcFirework1.timetolaunch == null)
      {
         mcFirework1.setData(mcCanvas,bmpCanvas,"gfx_firework",0,90);
      }
      if(mcFirework2.timetolaunch == null)
      {
         mcFirework2.setData(mcCanvas,bmpCanvas,"gfx_firework_blue",20,100);
      }
      if(mcFirework3.timetolaunch == null)
      {
         mcFirework3.setData(mcCanvas,bmpCanvas,"gfx_firework_green",42,105);
      }
      if(mcFirework4.timetolaunch == null)
      {
         mcFirework4.setData(mcCanvas,bmpCanvas,"gfx_firework_yellow",50,621);
      }
      if(mcFirework5.timetolaunch == null)
      {
         mcFirework5.setData(mcCanvas,bmpCanvas,"gfx_firework_purple",56,580);
      }
      bmpCanvas.fillRect(new flash.geom.Rectangle(0,0,bmpCanvas.width,bmpCanvas.height),0);
      mcFirework1.drawParticles();
      mcFirework2.drawParticles();
      mcFirework3.drawParticles();
      mcFirework4.drawParticles();
      mcFirework5.drawParticles();
   }
};
stop();
