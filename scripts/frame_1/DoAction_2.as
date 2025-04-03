var preloadDone = false;
mcLoader.onLoaded = function()
{
   preloadDone = true;
};
this.onEnterFrame = function()
{
   if(challCheckup && preloadDone)
   {
      gotoAndPlay(3);
   }
};
