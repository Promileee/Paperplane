butBox.onRelease = function()
{
   if(onClick != null)
   {
      onClick();
   }
   this.removeMovieClip();
};
