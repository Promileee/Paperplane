class kage.classes.GradientPoint extends flash.geom.Point
{
   var ratio = 0;
   var color = 0;
   function GradientPoint(px, py, pratio, pcolor)
   {
      super();
      this.color = pcolor;
      this.ratio = pratio;
      this.x = px;
      this.y = py;
   }
}
