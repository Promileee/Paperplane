class kage.classes.viewport extends MovieClip
{
   var __height;
   var __mc;
   var __mask;
   var __cameraTarget;
   var __layers = Array();
   var __width = 0;
   var __cameraX = 0;
   var __cameraY = 0;
   var __cameraZoom = 100;
   var __cameraBoundX = 0;
   var __cameraBoundY = 0;
   var __cameraMode = 0;
   var __cameraZoomTarget = 100;
   var __cameraVar2 = 0;
   function viewport(vp_Width, vp_Height, vp_Xpos, vp_Ypos)
   {
      super();
      this.__width = vp_Width;
      this.__height = vp_Height;
      this.__mc = _root.createEmptyMovieClip("__mc",_root.getNextHighestDepth());
      this.__mask = _root.createEmptyMovieClip("__mask",_root.getNextHighestDepth());
      kage.classes.common.drawRect(this.__mask,0,0,this.__width,this.__height,16711680,0);
      this.__mask._x = vp_Xpos;
      this.__mask._y = vp_Ypos;
      this.__mc.setMask(this.__mask);
      this.__mc._x = vp_Xpos;
      this.__mc._y = vp_Ypos;
   }
   function get offsetX()
   {
      return this.__width / 2;
   }
   function get offsetY()
   {
      return this.__height / 2;
   }
   function get movieClip()
   {
      return this.__mc;
   }
   function setCameraBounds(maxwidth, maxheight)
   {
      this.__cameraBoundX = maxwidth;
      this.__cameraBoundY = maxheight;
   }
   function setCamera(xpos, ypos)
   {
      this.__cameraX = xpos;
      this.__cameraY = ypos;
      this.renderView();
   }
   function setCameraZoom(zoom)
   {
      this.__cameraZoom = zoom;
      for(var _loc3_ in this.__layers)
      {
         if(this.__layers[_loc3_].depth > 0)
         {
            this.__layers[_loc3_]._xscale = zoom;
            this.__layers[_loc3_]._yscale = zoom;
         }
      }
   }
   function setCameraZoomTarget(zoom)
   {
      this.__cameraZoomTarget = zoom;
   }
   function setCameraModeFollow(target)
   {
      this.__cameraTarget = target;
      this.__cameraMode = 1;
      this.renderView();
   }
   function renderView()
   {
      if(this.__cameraZoom < this.__cameraZoomTarget)
      {
         var _loc5_ = this.__cameraZoom + 4;
         if(_loc5_ > this.__cameraZoomTarget)
         {
            _loc5_ = this.__cameraZoomTarget;
         }
         this.setCameraZoom(_loc5_);
      }
      else if(this.__cameraZoom > this.__cameraZoomTarget)
      {
         _loc5_ = this.__cameraZoom - 4;
         if(_loc5_ < this.__cameraZoomTarget)
         {
            _loc5_ = this.__cameraZoomTarget;
         }
         this.setCameraZoom(_loc5_);
      }
      if(this.__cameraMode == 1)
      {
         var _loc3_ = this.__cameraTarget._x - this.__cameraX;
         var _loc2_ = Math.abs(_loc3_);
         var _loc6_ = _loc3_ / _loc2_;
         if(_loc2_ > 16)
         {
            this.__cameraX += _loc6_ * (_loc2_ - 16) / 8;
         }
         _loc3_ = this.__cameraTarget._y - this.__cameraY;
         _loc2_ = Math.abs(_loc3_);
         _loc6_ = _loc3_ / _loc2_;
         if(_loc2_ > 10)
         {
            this.__cameraY += _loc6_ * (_loc2_ - 10) / 8;
         }
      }
      if(this.__cameraX > this.__cameraBoundX - 100 / this.__cameraZoom * this.__width / 2)
      {
         this.__cameraX = this.__cameraBoundX - 100 / this.__cameraZoom * this.__width / 2;
      }
      if(this.__cameraX < - (this.__cameraBoundX - 100 / this.__cameraZoom * this.__width / 2))
      {
         this.__cameraX = - (this.__cameraBoundX - 100 / this.__cameraZoom * this.__width / 2);
      }
      if(this.__cameraY > this.__cameraBoundY - 100 / this.__cameraZoom * this.__height / 2)
      {
         this.__cameraY = this.__cameraBoundY - 100 / this.__cameraZoom * this.__height / 2;
      }
      if(this.__cameraY < - (this.__cameraBoundY - 100 / this.__cameraZoom * this.__height / 2))
      {
         this.__cameraY = - (this.__cameraBoundY - 100 / this.__cameraZoom * this.__height / 2);
      }
      for(var _loc4_ in this.__layers)
      {
         this.__layers[_loc4_].setZoomedPos(- this.__cameraX,- this.__cameraY,this.__cameraZoom,this.__width,this.__height);
      }
   }
   function addLayer(idName, newName, depth)
   {
      var tmpLayer;
      if(eval("__mc." + newName) != null)
      {
         eval("__mc." + newName).removeMovieClip();
      }
      tmpLayer = this.__mc.attachMovie(idName,newName,this.__mc.getNextHighestDepth());
      tmpLayer._x = this.__width / 2;
      tmpLayer._y = this.__height / 2;
      tmpLayer.depth = depth;
      tmpLayer.offsetX = this.__width / 2;
      tmpLayer.offsetY = this.__height / 2;
      tmpLayer.cacheAsBitmap = true;
      this.__layers.push(tmpLayer);
   }
   function clearLayers()
   {
      for(var _loc2_ in this.__layers)
      {
         this.__layers[_loc2_].removeMovieClip();
      }
      this.__layers = new Array();
   }
}
