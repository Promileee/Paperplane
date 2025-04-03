class kage.classes.radiobutton extends MovieClip
{
   var onPress;
   var mcActive;
   var checked;
   var __callback;
   var __onset;
   function radiobutton()
   {
      super();
      this.cacheAsBitmap = true;
      this.useHandCursor = true;
      this.onPress = this.handlerPress;
      this.mcActive._visible = this.checked;
   }
   function set Callback(func)
   {
      this.__callback = func;
   }
   function set OnClick(func)
   {
      this.__onset = func;
   }
   function Uncheck()
   {
      this.checked = false;
      this.mcActive._visible = false;
   }
   function handlerPress()
   {
      if(this.__callback != null)
      {
         this.__callback();
      }
      if(this.__onset != null)
      {
         this.__onset();
      }
      this.checked = true;
      this.mcActive._visible = this.checked;
   }
}
