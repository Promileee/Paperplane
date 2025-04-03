_root.vol = 0;
_root.sfx_gui_click.setVolume(0);
_root.sfx_gui_slide.setVolume(0);
_root.sfx_challenge_come.setVolume(0);
_root.sfx_challenge_go_for_it.setVolume(0);
_root.sfx_challenge_i_love.setVolume(0);
_root.sfx_challenge_looser.setVolume(0);
_root.sfx_challenge_publik_sorl_loop.setVolume(0);
_root.sfx_challenge_publik_winner.setVolume(0);
_root.sfx_challenge_show_what.setVolume(0);
_root.sfx_challenge_speaker_heres_the_moment.setVolume(0);
_root.sfx_challenge_speaker_wait_and_see.setVolume(0);
_root.sfx_challenge_speaker_we_have_a_winner.setVolume(0);
_root.sfx_challenge_speaker_welcome.setVolume(0);
_root.sfx_title.setVolume(0);
onPress = function()
{
   var _loc1_ = new LoadVars();
   _loc1_.cmd = "on";
   _loc1_.sendAndLoad("Sound.aspx",_loc1_,"GET");
   gotoAndPlay(1);
};
stop();
