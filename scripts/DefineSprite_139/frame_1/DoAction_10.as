function clearErrors()
{
   mcerrorn._visible = false;
   mcerror0._visible = false;
   mcerror1._visible = false;
   mcerror2._visible = false;
   mcerror3._visible = false;
   mcerror4._visible = false;
   mcerror5._visible = false;
}
function initForm()
{
   if(_parent.myName != "" && _parent.myName != null)
   {
      txtYourName.text = _parent.myName;
   }
   if(_parent.myMail != "" && _parent.myMail != null)
   {
      txtYourEmail.text = _parent.myMail;
   }
   if(_parent.Challenger1 != "" && _parent.Challenger1 != null)
   {
      txtChallanger1.text = _parent.Challenger1;
   }
   if(_parent.Challenger2 != "" && _parent.Challenger2 != null)
   {
      txtChallanger2.text = _parent.Challenger2;
   }
   if(_parent.Challenger3 != "" && _parent.Challenger3 != null)
   {
      txtChallanger3.text = _parent.Challenger3;
   }
   if(_parent.Challenger4 != "" && _parent.Challenger4 != null)
   {
      txtChallanger4.text = _parent.Challenger4;
   }
   if(_parent.Challenger5 != "" && _parent.Challenger5 != null)
   {
      txtChallanger5.text = _parent.Challenger5;
   }
}
function OnEnterChallenger(oldFocus)
{
   if(this.text == "CHALLENGER\'S EMAIL")
   {
      this.text = "";
   }
}
function OnExitChallenger(newFocus)
{
   if(this.text == "")
   {
      this.text = "CHALLENGER\'S EMAIL";
   }
}
function handleFormValidation()
{
   if(dataReceiver.result == 0)
   {
      if(_parent.OnSubmit != null)
      {
         _parent.OnSubmit();
      }
      _root.sfx_gui_slide.play();
      _parent.play();
   }
   else
   {
      txtError.text = dataReceiver.errorCode;
      if(dataReceiver.errorn == 1)
      {
         mcerrorn._visible = true;
      }
      if(dataReceiver.error0 == 1)
      {
         mcerror0._visible = true;
      }
      if(dataReceiver.error1 == 1)
      {
         mcerror1._visible = true;
      }
      if(dataReceiver.error2 == 1)
      {
         mcerror2._visible = true;
      }
      if(dataReceiver.error3 == 1)
      {
         mcerror3._visible = true;
      }
      if(dataReceiver.error4 == 1)
      {
         mcerror4._visible = true;
      }
      if(dataReceiver.error5 == 1)
      {
         mcerror5._visible = true;
      }
      butBlocker._visible = false;
   }
}
var dataSender;
var dataReceiver;
butBlocker._visible = false;
initForm();
clearErrors();
butCancel.onRelease = function()
{
   if(_parent.OnCancel != null)
   {
      _parent.OnCancel();
   }
};
mcButGo.butGo.onRelease = function()
{
   mcerrorn._visible = false;
   mcerror0._visible = false;
   mcerror1._visible = false;
   mcerror2._visible = false;
   mcerror3._visible = false;
   mcerror4._visible = false;
   mcerror5._visible = false;
   butBlocker._visible = true;
   dataSender = new LoadVars();
   dataReceiver = new LoadVars();
   dataSender.myName = nameown;
   dataSender.myEmail = emailown;
   dataSender.challenged1 = email1;
   dataSender.challenged2 = email2;
   dataSender.challenged3 = email3;
   dataSender.challenged4 = email4;
   dataSender.challenged5 = email5;
   dataReceiver.onLoad = handleFormValidation;
   dataSender.sendAndLoad("ValidateForm.aspx",dataReceiver,"POST");
};
txtYourName.onSetFocus = function(oldFocus)
{
   if(txtYourName.text == "YOUR NAME")
   {
      txtYourName.text = "";
   }
};
txtYourName.onKillFocus = function(newFocus)
{
   if(txtYourName.text == "")
   {
      txtYourName.text = "YOUR NAME";
   }
};
txtYourEmail.onSetFocus = function(oldFocus)
{
   if(txtYourEmail.text == "YOUR EMAIL ADDRESS")
   {
      txtYourEmail.text = "";
   }
};
txtYourEmail.onKillFocus = function(newFocus)
{
   if(txtYourEmail.text == "")
   {
      txtYourEmail.text = "YOUR EMAIL ADDRESS";
   }
};
txtChallanger1.onSetFocus = OnEnterChallenger;
txtChallanger2.onSetFocus = OnEnterChallenger;
txtChallanger3.onSetFocus = OnEnterChallenger;
txtChallanger4.onSetFocus = OnEnterChallenger;
txtChallanger5.onSetFocus = OnEnterChallenger;
txtChallanger1.onKillFocus = OnExitChallenger;
txtChallanger2.onKillFocus = OnExitChallenger;
txtChallanger3.onKillFocus = OnExitChallenger;
txtChallanger4.onKillFocus = OnExitChallenger;
txtChallanger5.onKillFocus = OnExitChallenger;
stop();
