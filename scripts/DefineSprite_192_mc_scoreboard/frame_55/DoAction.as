function startScroll()
{
   mcWinner._scroll = true;
   mcLooser._scroll = true;
}
mcWinner.txtLocal.text = Name1.toUpperCase();
mcLooser.txtLocal.text = Name2.toUpperCase();
txtLengthWinner.text = Len1;
txtLengthLooser.text = Len2;
setInterval(this,"startScroll",4000);
stop();
stop();
