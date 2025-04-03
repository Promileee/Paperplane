_root.vol = 100;
_root.sfx_gui_click.setVolume(100);
_root.sfx_gui_slide.setVolume(100);
_root.sfx_challenge_come.setVolume(100);
_root.sfx_challenge_go_for_it.setVolume(100);
_root.sfx_challenge_i_love.setVolume(100);
_root.sfx_challenge_looser.setVolume(100);
_root.sfx_challenge_publik_sorl_loop.setVolume(100);
_root.sfx_challenge_publik_winner.setVolume(100);
_root.sfx_challenge_show_what.setVolume(100);
_root.sfx_challenge_speaker_heres_the_moment.setVolume(100);
_root.sfx_challenge_speaker_wait_and_see.setVolume(100);
_root.sfx_challenge_speaker_we_have_a_winner.setVolume(100);
_root.sfx_challenge_speaker_welcome.setVolume(100);
_root.sfx_title.setVolume(100);
onPress = function()
{
   var _loc1_ = new LoadVars();
   _loc1_.cmd = "off";
   _loc1_.sendAndLoad("Sound.aspx",_loc1_,"GET");
   gotoAndPlay(2);
};
stop();
