class kage.classes.slider extends MovieClip
{
   var mcHandle;
   var Min;
   var txtValue;
   var Max;
   var OnChange;
   var __startx;
   var __mousedown = false;
   var __value = kage.classes.slider.prototype.Min;
   function slider()
   {
      super();
      this.mcHandle.useHandCursor = true;
      this.mcHandle.onPress = this.handlerPress;
      this.mcHandle.onMouseUp = this.handlerMouseUp;
      this.mcHandle.onMouseMove = this.handerMouseMove;
      this.__value = this.Min;
      this.txtValue._visible = false;
      if(this.Max == 1)
      {
         this.txtValue.text = "off";
      }
      else
      {
         this.txtValue.text = "" + this.Min;
      }
   }
   function get Value()
   {
      return this.__value;
   }
   function set Value(newval)
   {
      var _loc2_ = newval;
      if(_loc2_ > this.Max)
      {
         _loc2_ = this.Max;
      }
      if(_loc2_ < this.Min)
      {
         _loc2_ = this.Min;
      }
      this.__value = _loc2_;
      this.mcHandle._x = 15 + Math.round(this.__value * 100 / (this.Max - this.Min));
      if(this.OnChange != null)
      {
         this.OnChange(this.__value);
      }
   }
   function handlerPress()
   {
      this.__mousedown = true;
      this.__startx = this._xmouse;
      this._parent.txtValue._visible = true;
   }
   function handlerMouseUp()
   {
      this.__mousedown = false;
      this._parent.txtValue._visible = false;
   }
   function handerMouseMove()
   {
      if(this.__mousedown)
      {
         var _loc2_ = this._parent._xmouse - this.__startx - 15;
         if(_loc2_ > 100)
         {
            _loc2_ = 100;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         this._parent.__value = Math.round((this._parent.Max - this._parent.Min) * _loc2_ / 100);
         this._x = 15 + Math.round(this._parent.__value * 100 / (this._parent.Max - this._parent.Min));
         if(this._parent.OnChange != null)
         {
            this._parent.OnChange(this._parent.__value);
         }
         if(this._parent.Max == 1)
         {
            if(this._parent.__value == 0)
            {
               this._parent.txtValue.text = "off";
            }
            else
            {
               this._parent.txtValue.text = "on";
            }
         }
         else
         {
            this._parent.txtValue.text = this._parent.__value;
         }
         this._parent.txtValue._x = this._x - 12;
      }
   }
}
