butStart.onRelease = function()
{
   if(_parent.onStart != null)
   {
      _parent.onStart();
   }
   _parent._parent.mcMinilogo.gotoAndPlay(2);
   onEnterFrame = function()
   {
      var _loc2_ = _root.sfx_title.getVolume();
      if(_loc2_ > 0)
      {
         _root.sfx_title.setVolume(_loc2_ - 10);
      }
   };
};
