function initPlane(plane, target, xpos, ypos)
{
   if(target.planeD != null)
   {
      target.planeD.removeMovieClip();
   }
   target.attachMovie(plane,"planeD",target.getNextHighestDepth());
   target.planeD._x = xpos;
   target.planeD._y = ypos;
}
function setPlaneA()
{
   if(SelectedPlane != 1)
   {
      _root.sfx_gui_click.start();
      initPlane("mc3DEagle",_parent.mcConfig,30,-45);
      SelectedPlane = 1;
      copyConfig();
      _root.InitPlane(1);
   }
}
function setPlaneB()
{
   if(SelectedPlane != 2)
   {
      _root.sfx_gui_click.start();
      initPlane("mc3D_square",_parent.mcConfig,25,-30);
      SelectedPlane = 2;
      copyConfig();
      _root.InitPlane(2);
   }
}
function setPlaneC()
{
   if(SelectedPlane != 3)
   {
      _root.sfx_gui_click.start();
      initPlane("mc3D_dart",_parent.mcConfig,50,-40);
      SelectedPlane = 3;
      copyConfig();
      _root.InitPlane(3);
   }
}
function copyConfig()
{
   mcSliderElevators.Value = configs[SelectedPlane - 1].elev;
   mcSliderWinglets.Value = configs[SelectedPlane - 1].wing;
   mcSliderWeight.Value = configs[SelectedPlane - 1].weight;
   updatePlane = true;
}
function clearRadioButtons()
{
   radioPlaneA.Uncheck();
   radioPlaneB.Uncheck();
   radioPlaneC.Uncheck();
}
var configs = [{elev:0,weight:0,wing:0},{elev:0,weight:0,wing:0},{elev:0,weight:0,wing:0}];
var SelectedPlane = 3;
var updatePlane = false;
initPlane("mc3D_dart",this,50,-40);
butBlocker.useHandCursor = false;
radioPlaneA.Callback = clearRadioButtons;
radioPlaneB.Callback = clearRadioButtons;
radioPlaneC.Callback = clearRadioButtons;
radioPlaneA.OnClick = setPlaneA;
radioPlaneB.OnClick = setPlaneB;
radioPlaneC.OnClick = setPlaneC;
butPlaneA.onPress = function()
{
   radioPlaneA.handlerPress();
};
butPlaneB.onPress = function()
{
   radioPlaneB.handlerPress();
};
butPlaneC.onPress = function()
{
   radioPlaneC.handlerPress();
};
if(varChallengeEmail == "<p align=\"left\"><font face=\"Eurostile_9pt_st\" size=\"9\" color=\"#ffffff\" letterSpacing=\"1.000000\" kerning=\"0\">email@</font></p>")
{
   txtChallengedBy._visible = false;
   txtChallengeEmail._visible = false;
}
onEnterFrame = function()
{
   if(updatePlane)
   {
      planeD.modifyModel(mcSliderElevators.Value,mcSliderWinglets.Value);
      updatePlane = false;
   }
};
var mrot = false;
var xpos = 0;
var ypos = 0;
planeD.onPress = function()
{
   mrot = true;
   xpos = _xmouse;
   ypos = _ymouse;
};
planeD.onMouseUp = function()
{
   mrot = false;
};
planeD.onMouseMove = function()
{
   if(mrot)
   {
      planeD.ry += (_xmouse - xpos) / 20 * 3.141592653589793 / 180;
      planeD.rz += (_ymouse - ypos) / 20 * 3.141592653589793 / 180;
   }
};
mcSliderElevators.OnChange = function(newval)
{
   if(configs[SelectedPlane - 1].elev == newval)
   {
      return undefined;
   }
   _root.sfx_gui_click.start();
   planeD.modifyModel(newval,mcSliderWinglets.Value);
   configs[SelectedPlane - 1].elev = newval;
};
mcSliderWinglets.OnChange = function(newval)
{
   if(configs[SelectedPlane - 1].wing == newval)
   {
      return undefined;
   }
   _root.sfx_gui_click.start();
   planeD.modifyModel(mcSliderElevators.Value,newval);
   configs[SelectedPlane - 1].wing = newval;
   if(newval == 0)
   {
      mc_on._x = -323;
      mc_off._x = -158;
   }
   else
   {
      mc_on._x = -158;
      mc_off._x = -323;
   }
};
mcSliderWeight.OnChange = function(newval)
{
   if(configs[SelectedPlane - 1].weight == newval)
   {
      return undefined;
   }
   _root.sfx_gui_click.start();
   configs[SelectedPlane - 1].weight = newval;
};
stop();
