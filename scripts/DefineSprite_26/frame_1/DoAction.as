var fadecounter = 0;
var fadedirection = false;
var onLoaded;
onEnterFrame = function()
{
   txtLoading._alpha = fadecounter;
   if(fadedirection)
   {
      fadecounter -= 10;
      if(fadecounter == 0)
      {
         fadedirection = false;
      }
   }
   else
   {
      fadecounter += 10;
      if(fadecounter == 100)
      {
         fadedirection = true;
      }
   }
   var _loc2_ = _root.getBytesTotal();
   var _loc3_ = _root.getBytesLoaded();
   if(_loc3_ == _loc2_)
   {
      txtPercent.text = "100%";
      mcLoadBar._width = 100;
      onLoaded();
   }
   else
   {
      txtPercent.text = int(_loc3_ / _loc2_ * 100) + "%";
      mcLoadBar._width = int(_loc3_ / _loc2_ * 100);
   }
};
stop();
