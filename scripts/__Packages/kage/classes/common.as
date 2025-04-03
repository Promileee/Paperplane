class kage.classes.common
{
   function common()
   {
   }
   static function drawRect(mcTarget, x1, y1, x2, y2, color, alpha)
   {
      mcTarget.beginFill(color,alpha);
      mcTarget.moveTo(x1,y1);
      mcTarget.lineTo(x2,y1);
      mcTarget.lineTo(x2,y2);
      mcTarget.lineTo(x1,y2);
      mcTarget.lineTo(x1,y1);
      mcTarget.endFill();
   }
}
