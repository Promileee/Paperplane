function goVisit(target_mc, obj)
{
   _root.getURL("careofhaus.asp","_blank");
}
function goVisit2(target_mc, obj)
{
   _root.getURL("solidworks.asp","_blank");
}
function setupConfig()
{
   if(challengeID != null)
   {
      vp.movieClip.mcConfig.mcConfig.txtInstructions.text = "Welcome to the Battle of the Air! Your friend seems to think he\'s an ace at flying. Now you have the chance to crash her confidence.\nDesign your plane at the left. Then practice (below) flying it. When you feel confident, accept the challenge and kick some ass. Just remember, you only get one shot in the competition. (You will see your buddy’s attempt as a paper plane shadow.)\n\nKick some ass!\nFlight Commander";
      vp.movieClip.mcConfig.mcConfig.varChallengeEmail = challReciever.dejaEmail.toLowerCase();
   }
   else
   {
      vp.movieClip.mcConfig.mcConfig.txtInstructions.text = "Design your plane, practice flying it and then when you feel confident challenge your buddies and kick some ass. Just remember, you only get one shot in the competition.\n\nBon Voyage.\nFlight Commander.";
      vp.movieClip.mcConfig.mcConfig.txtChallengedBy._visible = false;
      vp.movieClip.mcConfig.mcConfig.txtChallengeEmail._visible = false;
   }
}
function clearIntroScreen()
{
   vp.movieClip.mcConfig.gotoAndPlay(42);
   mcLogo.gotoAndPlay(2);
   ival = setInterval(_root,"removeIntroScreen",1000);
}
function removeIntroScreen()
{
   clearInterval(ival);
   vp.movieClip.mcStart.removeMovieClip();
   stopAllSounds();
   _root.sfx_title.setVolume(_root.vol);
}
function resetThrow()
{
   if(vp.movieClip.mcTryAgain != null)
   {
      vp.movieClip.mcTryAgain.removeMovieClip();
   }
   vp.movieClip.LayerDef_Arena.mcTooHard._visible = false;
   dragX = 0;
   dragY = 50;
   aero1.planeangle = 0;
   fly = false;
   if(inchallenge)
   {
      vp.movieClip.LayerDef_Arena.obj_player_white.Aim(0,0);
   }
   vp.movieClip.LayerDef_Arena.obj_player.Aim(0,0);
   vp.movieClip.LayerDef_Arena.obj_player_hand.Aim(0,0);
   vp.movieClip.mcScore.txtLen.text = "0.0m";
   vp.movieClip.mcScore.mcBar._y = 27;
   vp.setCameraZoomTarget(100);
}
function grabPlane()
{
   if(demomode == 1)
   {
      return undefined;
   }
   if(!fly && !drag)
   {
      drag = true;
      startdragX = _root._xmouse;
      startdragY = _root._ymouse;
      dragX = 0;
      dragY = 50;
   }
}
function movePlane()
{
   if(drag)
   {
      var _loc2_ = undefined;
      dragX = startdragX - _root._xmouse;
      dragY = startdragY - _root._ymouse;
      if(dragX < 0)
      {
         dragX = 0;
      }
      radians = Math.atan(dragY / dragX);
      if(isNaN(radians))
      {
         radians = 0;
      }
      degrees = (- radians * 180) / 3.141592653589793;
      if(degrees < -60)
      {
         degrees = -60;
         radians = (- degrees) / 180 * 3.141592653589793;
      }
      if(degrees > 60)
      {
         degrees = 60;
         radians = (- degrees) / 180 * 3.141592653589793;
      }
      aero1.planeangle = degrees;
      aero1.angle = degrees;
      _loc2_ = Math.sqrt(dragX * dragX + dragY * dragY);
      if(_loc2_ > 80)
      {
         _loc2_ = 80;
      }
      dragX = Math.cos(radians) * _loc2_ - Math.sin(radians) * 50;
      dragY = Math.sin(radians) * _loc2_ + Math.cos(- radians) * 50;
      if(inchallenge)
      {
         vp.movieClip.LayerDef_Arena.obj_player_white.Aim(_loc2_ * 89 / 80,- degrees);
      }
      vp.movieClip.LayerDef_Arena.obj_player.Aim(_loc2_ * 89 / 80,- degrees);
      vp.movieClip.LayerDef_Arena.obj_player_hand.Aim(_loc2_ * 89 / 80,- degrees);
      aero1.power = _loc2_ * 3.4;
   }
}
function releasePlane()
{
   if(!fly && drag)
   {
      if(vp.movieClip.LayerDef_Arena.mcInfo)
      {
         vp.movieClip.LayerDef_Arena.mcInfo.removeMovieClip();
      }
      lastspeed = aero1.power;
      lastangle = aero1.angle;
      drag = false;
      vp.movieClip.mcConfig.mcConfig.SelectedPlane;
      aero1.setPlane(vp.movieClip.mcConfig.mcConfig.SelectedPlane);
      aero1.element = vp.movieClip.mcConfig.mcConfig.mcSliderElevators.Value;
      aero1.weight = 0.012 + vp.movieClip.mcConfig.mcConfig.mcSliderWeight.Value / 5000;
      aero1.winglets = vp.movieClip.mcConfig.mcConfig.mcSliderWinglets.Value;
      var _loc1_ = aero1.power - (200 + aero1.winglets * 10 + (aero1.weight - 0.012) * 1000);
      mcBorder.txtDanger = "";
      aero1.err = _loc1_;
      if(_loc1_ > 0)
      {
         vp.movieClip.LayerDef_Arena.mcTooHard.gotoAndPlay(1);
         vp.movieClip.LayerDef_Arena.mcTooHard._visible = true;
         if(aero1.element > 5)
         {
            aero1.element = 100;
         }
         else
         {
            aero1.element = -200;
         }
         aero1.weight = 0.012;
      }
      aero1.init();
      aero1.dx = - dragX;
      aero1.dy = dragY;
      if(inchallenge)
      {
         vp.movieClip.LayerDef_Arena.obj_player_white.Throw();
      }
      vp.movieClip.LayerDef_Arena.obj_player.Throw();
      vp.movieClip.LayerDef_Arena.obj_player_hand.Throw();
      inAir1 = true;
      fly = true;
      if(inchallenge)
      {
         clearInterval(ivalchallenge);
         vp.movieClip.mcCancel.removeMovieClip();
      }
      if(challengeID != null && inchallenge)
      {
         aero2.angle = Number(challReciever.dejaAngle);
         aero2.power = Number(challReciever.dejaPower);
         aero2.element = Number(challReciever.dejaElevators);
         aero2.weight = Number(challReciever.dejaWeight);
         aero2.winglets = Number(challReciever.dejaWinglets);
         aero2.setPlane(Number(challReciever.dejaPlane));
         aero2.init();
         aero2.dx = Number(challReciever.dejaOutX);
         aero2.dy = Number(challReciever.dejaOutY);
         vp.movieClip.LayerDef_Arena.ghostplane._visible = true;
         inAir2 = true;
         vp.movieClip.LayerDef_Arena.obj_cap._visible = true;
      }
      vp.setCameraZoomTarget(100);
   }
}
function ShowForm()
{
   stopAllSounds();
   Key.removeListener(keyListener);
   vp.movieClip.mcChallengeIntro.stop();
   vp.movieClip.attachMovie("mc_formchallenge","mcFormChallenge",vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcFormChallenge._x = 360;
   vp.movieClip.mcFormChallenge._y = 200;
   vp.movieClip.mcFormChallenge.myName = _root.challYourName.toUpperCase();
   vp.movieClip.mcFormChallenge.myMail = _root.challYourEmail.toUpperCase();
   vp.movieClip.mcFormChallenge.Challenger1 = _root.challChallenger1.toUpperCase();
   vp.movieClip.mcFormChallenge.Challenger2 = _root.challChallenger2.toUpperCase();
   vp.movieClip.mcFormChallenge.Challenger3 = _root.challChallenger3.toUpperCase();
   vp.movieClip.mcFormChallenge.Challenger4 = _root.challChallenger4.toUpperCase();
   vp.movieClip.mcFormChallenge.Challenger5 = _root.challChallenger5.toUpperCase();
   vp.movieClip.mcConfig.swapDepths(vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcFormChallenge.OnCancel = CancelChallenge;
   vp.movieClip.mcFormChallenge.OnSubmit = SubmitChallenge;
}
function GoChallenge()
{
   initArenaNighttime();
   resetThrow();
   if(vp.movieClip.mcCancel != null)
   {
      vp.movieClip.mcCancel.removeMovieClip();
   }
   vp.movieClip.attachMovie("mc_cancel","mcCancel",vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcCancel._x = 120;
   vp.movieClip.mcCancel._y = 400;
   vp.movieClip.mcCancel.OnCancel = function()
   {
      myInterval = setInterval(_root,"continueToPractise",1500);
      vp.movieClip.mcConfig.gotoAndPlay(31);
   };
   vp.movieClip.mcScore.swapDepths(vp.movieClip.getNextHighestDepth());
   if(vp.movieClip.mcChallengeIntro != null)
   {
      vp.movieClip.mcChallengeIntro.removeMovieClip();
   }
   vp.movieClip.attachMovie("mc_challenge_intro","mcChallengeIntro",vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcConfig.swapDepths(vp.movieClip.getNextHighestDepth());
   if(challengeID == null)
   {
      vp.movieClip.mcChallengeIntro.onEnterForm = ShowForm;
   }
   if(challengeID == null)
   {
      vp.movieClip.mcChallengeIntro.onLaunchSample = _root.SpeakerWelcome;
   }
   else
   {
      vp.movieClip.mcChallengeIntro.onLaunchSample = function()
      {
         _root.sfx_challenge_speaker_heres_the_moment.start();
      };
   }
   vp.movieClip.mcChallengeIntro.onStartZoom = StartChallenge;
   vp.movieClip.mcChallengeIntro.onMovieEnd = RemoveIntro;
   _root.sfx_challenge_intro.start();
}
function SpeakerWelcome()
{
   _root.sfx_challenge_speaker_welcome.start();
}
function ThrowPlanes()
{
   fly = true;
   clearInterval(ivalthrow);
   clearInterval(ivalchallenge);
   aero1.angle = Number(challReciever.deja2Angle);
   aero1.power = Number(challReciever.deja2Power);
   aero1.element = Number(challReciever.deja2Elevators);
   aero1.weight = Number(challReciever.deja2Weight);
   aero1.winglets = Number(challReciever.deja2Winglets);
   aero1.setPlane(Number(challReciever.deja2Plane));
   aero1.init();
   aero1.dx = Number(challReciever.deja2OutX);
   aero1.dy = Number(challReciever.deja2OutY);
   inAir1 = true;
   aero2.angle = Number(challReciever.dejaAngle);
   aero2.power = Number(challReciever.dejaPower);
   aero2.element = Number(challReciever.dejaElevators);
   aero2.weight = Number(challReciever.dejaWeight);
   aero2.winglets = Number(challReciever.dejaWinglets);
   aero2.setPlane(Number(challReciever.dejaPlane));
   aero2.init();
   aero2.dx = Number(challReciever.dejaOutX);
   aero2.dy = Number(challReciever.dejaOutY);
   inAir2 = true;
   vp.movieClip.LayerDef_Arena.obj_cap._visible = true;
   vp.movieClip.LayerDef_Arena.ghostplane._visible = true;
   if(inchallenge)
   {
      vp.movieClip.LayerDef_Arena.obj_player_white.Throw();
   }
   vp.movieClip.LayerDef_Arena.obj_player.Throw();
   vp.movieClip.LayerDef_Arena.obj_player_hand.Throw();
   vp.setCameraZoomTarget(100);
}
function RemoveIntro()
{
   _root.sfx_challenge_publik_sorl_loop.start(0,999);
   tauntcount = 0;
   oneshot = false;
   if(challengeID != null)
   {
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name0 = challengeEmail;
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name1 = initEmail;
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name2 = "";
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name3 = "";
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name4 = "";
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name5 = "";
      vp.movieClip.LayerDef_Arena.mcScoreBoard.play();
   }
   ivalchallenge = setInterval(_root,"TauntPlayer",10000);
   vp.movieClip.mcChallengeIntro.removeMovieClip();
   if(demomode == 1)
   {
      PrepareThrowPlanes();
   }
}
function PrepareThrowPlanes()
{
   ivalthrow = setInterval(_root,"ThrowPlanes",2000);
}
function StartChallenge()
{
   vp.setCameraZoom(80);
   vp.setCameraZoomTarget(100);
}
function CancelChallenge()
{
   _root.sfx_challenge_publik_sorl_loop.stop();
   vp.movieClip.mcConfig.swapDepths(vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcConfig.gotoAndPlay(31);
   ival = setInterval(_root,"RemoveForm",1200);
   clearInterval(ivalchallenge);
}
function SubmitChallenge()
{
   _root.challYourName = vp.movieClip.mcFormChallenge.popup.txtYourName.text;
   _root.challYourEmail = vp.movieClip.mcFormChallenge.popup.txtYourEmail.text;
   _root.challChallenger1 = vp.movieClip.mcFormChallenge.popup.txtChallanger1.text;
   _root.challChallenger2 = vp.movieClip.mcFormChallenge.popup.txtChallanger2.text;
   _root.challChallenger3 = vp.movieClip.mcFormChallenge.popup.txtChallanger3.text;
   _root.challChallenger4 = vp.movieClip.mcFormChallenge.popup.txtChallanger4.text;
   _root.challChallenger5 = vp.movieClip.mcFormChallenge.popup.txtChallanger5.text;
   vp.movieClip.LayerDef_Arena.mcScoreBoard.Name0 = _root.challYourEmail;
   vp.movieClip.LayerDef_Arena.mcScoreBoard.Name1 = _root.challChallenger1 != "CHALLENGER\'S EMAIL" ? _root.challChallenger1 : "";
   vp.movieClip.LayerDef_Arena.mcScoreBoard.Name2 = _root.challChallenger2 != "CHALLENGER\'S EMAIL" ? _root.challChallenger2 : "";
   vp.movieClip.LayerDef_Arena.mcScoreBoard.Name3 = _root.challChallenger3 != "CHALLENGER\'S EMAIL" ? _root.challChallenger3 : "";
   vp.movieClip.LayerDef_Arena.mcScoreBoard.Name4 = _root.challChallenger4 != "CHALLENGER\'S EMAIL" ? _root.challChallenger4 : "";
   vp.movieClip.LayerDef_Arena.mcScoreBoard.Name5 = _root.challChallenger5 != "CHALLENGER\'S EMAIL" ? _root.challChallenger5 : "";
   vp.movieClip.LayerDef_Arena.mcScoreBoard.play();
   vp.movieClip.mcFormChallenge.swapDepths(vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcScore.swapDepths(vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcConfig.swapDepths(vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcChallengeIntro.play();
   ival = setInterval(this,RemoveForm,1000);
}
function RemoveForm()
{
   clearInterval(ival);
   vp.movieClip.mcFormChallenge.removeMovieClip();
   initArenaDaytime();
   resetThrow();
   vp.movieClip.mcScore.swapDepths(vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcConfig.swapDepths(vp.movieClip.getNextHighestDepth());
}
function practiseLanding()
{
   vp.movieClip.attachMovie("mc_try_again","mcTryAgain",vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcTryAgain.onClick = function()
   {
      vp.movieClip.mcTryAgain.removeMovieClip();
      resetThrow();
   };
}
function challengeLanding()
{
   if(challengeID == null)
   {
      var _loc2_ = new LoadVars();
      _loc2_.myName = challYourName;
      _loc2_.myEmail = challYourEmail;
      _loc2_.challenged1 = challChallenger1;
      _loc2_.challenged2 = challChallenger2;
      _loc2_.challenged3 = challChallenger3;
      _loc2_.challenged4 = challChallenger4;
      _loc2_.challenged5 = challChallenger5;
      _loc2_.abc = lastspeed;
      _loc2_.def = lastangle;
      _loc2_.ghi = vp.movieClip.mcConfig.mcConfig.SelectedPlane;
      _loc2_.jkl = aero1.element;
      _loc2_.mno = aero1.weight;
      _loc2_.pqr = aero1.winglets;
      _loc2_.stu = aero1.x;
      _loc2_.vwx = - dragX;
      _loc2_.yz = dragY;
      _loc2_.sendAndLoad("Challenge.aspx",_loc2_,"POST");
      inAir1 = false;
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Len = CalcLength(aero1.x);
      vp.movieClip.LayerDef_Arena.mcScoreBoard.gotoAndPlay(46);
      myInterval = setInterval(_root,"zoomBoard",2000);
   }
   else
   {
      inAir1 = false;
      if(!inAir2)
      {
         CompleteChallenge();
      }
      else
      {
         vp.setCameraModeFollow(vp.movieClip.LayerDef_Arena.ghostplane);
      }
   }
   if(CalcLength(aero1.x) < 5)
   {
      _root.sfx_challenge_looser.start();
   }
}
function GhostLanding()
{
   inAir2 = false;
   if(!inAir1)
   {
      CompleteChallenge();
   }
}
function CompleteChallenge()
{
   if(demomode != 1)
   {
      var _loc2_ = new LoadVars();
      _loc2_.myID = challengeID;
      _loc2_.myEmail = challengeEmail;
      _loc2_.abc = lastspeed;
      _loc2_.def = lastangle;
      _loc2_.ghi = vp.movieClip.mcConfig.mcConfig.SelectedPlane;
      _loc2_.jkl = aero1.element;
      _loc2_.mno = aero1.weight;
      _loc2_.pqr = aero1.winglets;
      _loc2_.stu = aero1.x;
      _loc2_.vwx = - dragX;
      _loc2_.yz = dragY;
      _loc2_.sendAndLoad("CompleteChallenge.aspx",_loc2_,"POST");
      _root.challYourEmail = challengeEmail;
      _root.challChallenger1 = initEmail;
   }
   if(aero1.x > aero2.x)
   {
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Len1 = CalcLength(aero1.x);
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Len2 = CalcLength(aero2.x);
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name1 = challengeEmail;
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name2 = initEmail;
   }
   else
   {
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Len1 = CalcLength(aero2.x);
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Len2 = CalcLength(aero1.x);
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name1 = initEmail;
      vp.movieClip.LayerDef_Arena.mcScoreBoard.Name2 = challengeEmail;
   }
   vp.movieClip.LayerDef_Arena.mcScoreBoard.gotoAndPlay(55);
   myInterval = setInterval(_root,"zoomBoard",2000);
}
function zoomBoard()
{
   clearInterval(myInterval);
   vp.setCameraModeFollow(vp.movieClip.LayerDef_Arena.mcScoreBoard);
   vp.setCameraZoomTarget(180);
   if(challengeID == null)
   {
      _root.sfx_challenge_speaker_wait_and_see.start();
   }
   else
   {
      vp.movieClip.mcBigBang.fireaway = true;
      _root.sfx_challenge_speaker_we_have_a_winner.start();
      _root.sfx_challenge_publik_winner.start();
   }
   vp.movieClip.LayerDef_Arena.mcScoreBoard.butContinue.onPress = function()
   {
      myInterval = setInterval(_root,"continueToPractise",1500);
      vp.movieClip.mcConfig.gotoAndPlay(31);
   };
   challengeID = null;
   demomode = null;
   _root.setupConfig();
}
function continueToPractise()
{
   clearInterval(myInterval);
   _root.sfx_challenge_publik_sorl_loop.stop();
   initArenaDaytime();
   resetThrow();
   vp.setCameraZoom(100);
   vp.movieClip.mcScore.swapDepths(vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcConfig.swapDepths(vp.movieClip.getNextHighestDepth());
}
function initArenaDaytime()
{
   inchallenge = false;
   vp.clearLayers();
   vp.addLayer("LayerDef_Sky","LayerDef_Sky",0);
   vp.addLayer("LayerDef_Sun","LayerDef_Sun",0.04);
   vp.addLayer("LayerDef_HousesFarAway","LayerDef_HousesFarAway",0.7);
   vp.addLayer("LayerDef_Houses","LayerDef_Houses",0.8);
   vp.addLayer("LayerDef_Trees","LayerDef_Trees",0.9);
   vp.addLayer("LayerDef_Arena","LayerDef_Arena",1);
   aero1.onLanding = practiseLanding;
   initArenaStandard();
   vp.renderView();
}
function initArenaNighttime()
{
   inchallenge = true;
   vp.clearLayers();
   vp.addLayer("LayerDef_SkyNight","LayerDef_Sky",0);
   vp.addLayer("LayerDef_SunNight","LayerDef_Sun",0.04);
   vp.addLayer("LayerDef_HousesFarAwayNight","LayerDef_HousesFarAway",0.7);
   vp.movieClip.attachMovie("mc_bigbang","mcBigBang",vp.movieClip.getNextHighestDepth());
   vp.addLayer("LayerDef_HousesNight","LayerDef_Houses",0.8);
   vp.addLayer("LayerDef_TreesNight","LayerDef_Trees",0.9);
   vp.addLayer("LayerDef_ArenaNight","LayerDef_Arena",1);
   if(challengeID != null)
   {
      vp.movieClip.LayerDef_Arena.addMovie(GetRightPlane(3),"ghostplane");
      vp.movieClip.LayerDef_Arena.ghostplane._x = -1100;
      vp.movieClip.LayerDef_Arena.ghostplane._y = 580;
      vp.movieClip.LayerDef_Arena.ghostplane._visible = false;
      vp.movieClip.LayerDef_Arena.ghostplane._alpha = 30;
      vp.movieClip.LayerDef_Arena.addMovie("mc_smallcap","obj_cap");
      vp.movieClip.LayerDef_Arena.obj_cap._x = -1100;
      vp.movieClip.LayerDef_Arena.obj_cap._y = 600;
      vp.movieClip.LayerDef_Arena.obj_cap._visible = false;
      vp.movieClip.LayerDef_Arena.obj_cap.txtEmail.text = initEmail.toLowerCase();
      vp.movieClip.LayerDef_Arena.obj_cap.txtEmail2.text = initEmail.toLowerCase();
      aero2.onLanding = GhostLanding;
   }
   vp.movieClip.LayerDef_Arena.addMovie("mc_player","obj_player_white");
   vp.movieClip.LayerDef_Arena.obj_player_white._x = -1099;
   vp.movieClip.LayerDef_Arena.obj_player_white._y = 629;
   Dmctransform = new flash.geom.Transform(vp.movieClip.LayerDef_Arena.obj_player_white);
   cColorTransform = new flash.geom.ColorTransform(1,1,1,1,180,180,180,0);
   Dmctransform.colorTransform = cColorTransform;
   aero1.onLanding = challengeLanding;
   initArenaStandard();
}
function InitPlane(planeType)
{
   if(vp.movieClip.LayerDef_Arena.obj_plane != null)
   {
      var _loc1_ = undefined;
      _loc1_ = vp.movieClip.LayerDef_Arena.obj_plane.getDepth();
      vp.movieClip.LayerDef_Arena.obj_plane.removeMovieClip();
      vp.movieClip.LayerDef_Arena.attachMovie(GetRightPlane(planeType),"obj_plane",_loc1_);
   }
   else
   {
      vp.movieClip.LayerDef_Arena.addMovie(GetRightPlane(planeType),"obj_plane");
   }
   vp.movieClip.LayerDef_Arena.obj_plane._x = -1100;
   vp.movieClip.LayerDef_Arena.obj_plane._y = 580;
   vp.movieClip.LayerDef_Arena.obj_plane.onPress = grabPlane;
   vp.movieClip.LayerDef_Arena.obj_plane.onMouseMove = movePlane;
   vp.movieClip.LayerDef_Arena.obj_plane.onMouseUp = releasePlane;
   vp.setCameraModeFollow(vp.movieClip.LayerDef_Arena.obj_plane);
}
function initArenaStandard()
{
   vp.setCameraBounds(1285,743.5);
   vp.movieClip.LayerDef_Arena.addMovie("mcPlaneShadow","obj_shadow");
   vp.movieClip.LayerDef_Arena.addMovie("mc_player","obj_player");
   vp.movieClip.LayerDef_Arena.obj_player._x = -1100;
   vp.movieClip.LayerDef_Arena.obj_player._y = 630;
   InitPlane(aero1._plane);
   vp.movieClip.LayerDef_Arena.addMovie("mc_player_hand","obj_player_hand");
   vp.movieClip.LayerDef_Arena.obj_player_hand._x = -1100;
   vp.movieClip.LayerDef_Arena.obj_player_hand._y = 630;
   vp.movieClip.LayerDef_Arena.addMovie("mc_too_hard","mcTooHard");
   vp.movieClip.LayerDef_Arena.mcTooHard._visible = false;
   vp.movieClip.LayerDef_Arena.mcTooHard._x = -1085;
   vp.movieClip.LayerDef_Arena.mcTooHard._y = 500;
   vp.movieClip.LayerDef_Arena.obj_shadow._x = -1100;
   vp.movieClip.LayerDef_Arena.obj_shadow._y = 570;
}
function TauntPlayer()
{
   tauntcount++;
   if(tauntcount == 1)
   {
      _root.sfx_challenge_go_for_it.start();
   }
   if(tauntcount == 2)
   {
      _root.sfx_challenge_show_what.start();
   }
   if(tauntcount == 3)
   {
      _root.sfx_challenge_i_love.start();
   }
}
function CalcLength(xpos)
{
   var _loc1_ = (xpos - 40) / 44.5;
   if(_loc1_ < 0)
   {
      _loc1_ = 0;
   }
   _loc1_ = int(_loc1_) + "." + int(_loc1_ * 10 % 10);
   return !isNaN(_loc1_) ? _loc1_ : "0.0";
}
function GetRightPlane(PlaneNr)
{
   if(PlaneNr == 1)
   {
      return "mc_plane_eagle";
   }
   if(PlaneNr == 2)
   {
      return "mc_plane_square";
   }
   if(PlaneNr == 3)
   {
      return "mc_plane_dart";
   }
   return "mc_plane_dart";
}
var menu_cm = new ContextMenu();
menu_cm.customItems.push(new ContextMenuItem("Copyright 2007 SolidWorks Corp.  All rights reserved.",goVisit2));
menu_cm.customItems.push(new ContextMenuItem("Developed by Care of Haus, Sweden",goVisit,true));
menu_cm.hideBuiltInItems();
_root.menu = menu_cm;
var myzoom = 100;
var inchallenge = false;
var tauntcount = 0;
var oneshot = false;
var Dmctransform;
var cColorTransform;
var inAir1 = false;
var inAir2 = false;
var initEmail = challReciever.dejaEmail;
var ivalchallenge;
var ival;
var aero1 = new kage.classes.aerodynamics();
var aero2 = new kage.classes.aerodynamics();
var fly = false;
var dragX = 0;
var dragY = 50;
var startdragX = 0;
var startdragY = 0;
var drag = false;
var degrees = 0;
var radians = degrees / 180 * 3.141592653589793;
var lastspeed = 0;
var lastangle = 0;
var challYourName;
var challYourEmail;
var challChallenger1;
var challChallenger2;
var challChallenger3;
var challChallenger4;
var challChallenger5;
var sfx_gui_click = new Sound();
var sfx_gui_slide = new Sound();
var sfx_challenge_come = new Sound();
var sfx_challenge_go_for_it = new Sound();
var sfx_challenge_i_love = new Sound();
var sfx_challenge_intro = new Sound();
var sfx_challenge_looser = new Sound();
var sfx_challenge_publik_sorl_loop = new Sound();
var sfx_challenge_publik_winner = new Sound();
var sfx_challenge_show_what = new Sound();
var sfx_challenge_speaker_heres_the_moment = new Sound();
var sfx_challenge_speaker_wait_and_see = new Sound();
var sfx_challenge_speaker_we_have_a_winner = new Sound();
var sfx_challenge_speaker_welcome = new Sound();
var sfx_title = new Sound();
sfx_gui_click.attachSound("gui_click.wav");
sfx_gui_slide.attachSound("gui_slide.wav");
sfx_challenge_come.attachSound("challenge_come.wav");
sfx_challenge_go_for_it.attachSound("challenge_go_for_it.wav");
sfx_challenge_i_love.attachSound("challenge_i_love.wav");
sfx_challenge_intro.attachSound("challenge_intro.wav");
sfx_challenge_looser.attachSound("challenge_looser.wav");
sfx_challenge_publik_sorl_loop.attachSound("challenge_publik_sorl_loop.wav");
sfx_challenge_publik_winner.attachSound("challenge_publik_winner.wav");
sfx_challenge_show_what.attachSound("challenge_show_what.wav");
sfx_challenge_speaker_heres_the_moment.attachSound("challenge_speaker_heres_the_moment.wav");
sfx_challenge_speaker_wait_and_see.attachSound("challenge_speaker_wait_and_see.wav");
sfx_challenge_speaker_we_have_a_winner.attachSound("challenge_speaker_we_have_a_winner.wav");
sfx_challenge_speaker_welcome.attachSound("challenge_speaker_welcome.wav");
sfx_title.attachSound("sfx_prelude");
if(SoundCmd == "off")
{
   mcBorder.mcSound.gotoAndPlay(2);
}
var vp = new kage.classes.viewport(700,410,10,22);
mcBorder.swapDepths(1000);
mcLogo.swapDepths(1001);
initArenaDaytime();
vp.movieClip.LayerDef_Arena.addMovie("mov_info","mcInfo");
vp.movieClip.LayerDef_Arena.mcInfo._x = -1200;
vp.movieClip.LayerDef_Arena.mcInfo._y = 450;
aero1.dx = 0;
aero1.dy = 60;
aero1.init();
vp.movieClip.attachMovie("mc_score","mcScore",vp.movieClip.getNextHighestDepth());
vp.movieClip.mcScore._x = 590;
vp.movieClip.mcScore._y = 345;
if(challengeID != null && demomode == 1)
{
   GoChallenge();
}
else
{
   vp.movieClip.attachMovie("mc_start","mcStart",vp.movieClip.getNextHighestDepth());
   vp.movieClip.mcStart.onStart = clearIntroScreen;
   if(challengeID != null)
   {
      vp.movieClip.mcStart.mcStart.varStartText = "YOU HAVE BEEN CHALLENGED BY " + challReciever.dejaName.toUpperCase() + ". DESIGN A PLANE, PRACTICE YOUR SKILLS, AND TAKE OFF TO THE BATTLE OF THE AIR!";
   }
}
vp.movieClip.attachMovie("mc_configurator","mcConfig",vp.movieClip.getNextHighestDepth());
vp.movieClip.mcConfig._x = 700;
vp.movieClip.mcConfig._y = 391;
vp.movieClip.mcConfig.OnChallenge = GoChallenge;
vp.movieClip.mcConfig.OnPractice = resetThrow;
vp.movieClip.mcConfig.gotoAndStop(30);
setupConfig();
onEnterFrame = function()
{
   if(fly)
   {
      aero1.fly();
      vp.movieClip.LayerDef_Arena.obj_plane._x = -1100 + aero1.x;
      vp.movieClip.LayerDef_Arena.obj_plane._y = 630 - aero1.y;
      vp.movieClip.mcScore.txtLen.text = CalcLength(aero1.x) + "M";
      vp.movieClip.mcScore.mcBar._y = 27 - aero1.y / 20;
      if(inchallenge)
      {
         if(CalcLength(aero1.x) > 20 && !oneshot)
         {
            oneshot = true;
            _root.sfx_challenge_come.start();
         }
      }
      if(challengeID != null && inchallenge)
      {
         aero2.fly();
         vp.movieClip.LayerDef_Arena.ghostplane._x = -1100 + aero2.x;
         vp.movieClip.LayerDef_Arena.ghostplane._y = 630 - aero2.y;
         degrees = - aero2.planeangle;
         vp.movieClip.LayerDef_Arena.ghostplane._rotation = degrees;
         vp.movieClip.LayerDef_Arena.obj_cap._x = -1100 + aero2.x;
         vp.movieClip.LayerDef_Arena.obj_cap._y = 600 - aero2.y;
      }
   }
   else
   {
      vp.movieClip.LayerDef_Arena.obj_plane._x = -1100 - dragX;
      vp.movieClip.LayerDef_Arena.obj_plane._y = 630 - dragY;
   }
   degrees = - aero1.planeangle;
   vp.movieClip.LayerDef_Arena.obj_plane._rotation = degrees;
   var _loc2_ = (- (- vp.movieClip.LayerDef_Arena.obj_plane._y + 570) + 120) / 2;
   if(_loc2_ < 0)
   {
      _loc2_ = 0;
   }
   vp.movieClip.LayerDef_Arena.obj_shadow._alpha = _loc2_;
   vp.movieClip.LayerDef_Arena.obj_shadow._x = vp.movieClip.LayerDef_Arena.obj_plane._x;
   vp.movieClip.LayerDef_Arena.obj_shadow._y = 690;
   vp.renderView();
};
var ivalthrow;
var myInterval;
var easter = " ";
keyListener = new Object();
keyListener.onKeyDown = function()
{
   easter += String.fromCharCode(Key.getAscii());
   if(easter.length > 20)
   {
      easter = easter.substr(easter.length - 20,20);
   }
   if(easter.length > 6 && easter.substr(easter.length - 7,7) == "fredrik")
   {
      mcBorder.mcEaster.gotoAndPlay(2);
   }
   if(easter.length > 5 && easter.substr(easter.length - 6,6) == "daniel")
   {
      mcBorder.mcEaster.gotoAndPlay(2);
   }
   if(easter.length > 6 && easter.substr(easter.length - 7,7) == "andreas")
   {
      mcBorder.mcEaster.gotoAndPlay(2);
   }
   if(easter.length > 5 && easter.substr(easter.length - 6,6) == "tobias")
   {
      mcBorder.mcEaster.gotoAndPlay(2);
   }
};
Key.addListener(keyListener);
stop();
