var __goingLeft = false;
var __currentPos = 0;
var _scroll = false;
onEnterFrame = function()
{
   if(_scroll)
   {
      if(txtLocal.maxhscroll > 0)
      {
         if(__goingLeft)
         {
            __currentPos -= 20;
            txtLocal.hscroll = __currentPos;
            if(__currentPos <= 0)
            {
               __goingLeft = false;
               _scroll = false;
            }
         }
         else
         {
            __currentPos += 20;
            txtLocal.hscroll = __currentPos;
            if(__currentPos >= txtLocal.maxhscroll)
            {
               __goingLeft = true;
            }
         }
      }
      else
      {
         _scroll = false;
      }
   }
};
