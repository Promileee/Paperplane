function startScroll()
{
   if(!mcVS1._scroll && !mcVS2._scroll && !mcVS3._scroll && !mcVS4._scroll && !mcVS5._scroll)
   {
      mcVS1._scroll = true;
      mcVS2._scroll = true;
      mcVS3._scroll = true;
      mcVS4._scroll = true;
      mcVS5._scroll = true;
   }
}
txtChallenger.text = Name0.toUpperCase();
mcVS1.txtLocal.text = Name1.toUpperCase();
mcVS2.txtLocal.text = Name2.toUpperCase();
mcVS3.txtLocal.text = Name3.toUpperCase();
mcVS4.txtLocal.text = Name4.toUpperCase();
mcVS5.txtLocal.text = Name5.toUpperCase();
setInterval(this,"startScroll",2000);
stop();
