class kage.classes.layer extends MovieClip
{
   var __xpos = 0;
   var __ypos = 0;
   var __depth = 1;
   var __offsetX = 0;
   var __offsetY = 0;
   function layer()
   {
      super();
      this.cacheAsBitmap = true;
   }
   function get xpos()
   {
      return this.__xpos;
   }
   function get ypos()
   {
      return this.__ypos;
   }
   function get depth()
   {
      return this.__depth;
   }
   function set depth(newdepth)
   {
      this.__depth = newdepth;
   }
   function set offsetX(ofx)
   {
      this.__offsetX = ofx;
   }
   function set offsetY(ofy)
   {
      this.__offsetY = ofy;
   }
   function setPos(xpos, ypos)
   {
      this.__xpos = xpos;
      this.__ypos = ypos;
      this._x = this.__xpos * this.__depth + this.__offsetX;
      this._y = this.__ypos * this.__depth + this.__offsetY;
   }
   function setZoomedPos(xpos, ypos, zoom, scrw, scrh)
   {
      this.__xpos = xpos;
      this.__ypos = ypos;
      var _loc2_ = 0;
      var _loc3_ = 0;
      if(this.__depth > 0)
      {
      }
      this._x = this.__xpos * this.__depth * zoom / 100 - _loc2_ + this.__offsetX;
      this._y = this.__ypos * this.__depth * zoom / 100 + _loc3_ + this.__offsetY;
   }
   function addMovie(movieName, instanceName)
   {
      this.attachMovie(movieName,instanceName,this.getNextHighestDepth());
   }
}
