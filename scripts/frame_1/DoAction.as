var demomode;
var challengeID;
var challengeEmail;
var challReciever = new LoadVars();
var nullReciever = new LoadVars();
var challCheckup = false;
if(jid != null && jid != "")
{
   var dataSender = new LoadVars();
   dataSender.id = jid;
   dataSender.email = jemail;
   challReciever.onLoad = function()
   {
      if(challReciever.result == 0)
      {
         challengeID = jid;
         challengeEmail = jemail;
         demomode = challReciever.demomode;
      }
      challCheckup = true;
   };
   dataSender.sendAndLoad("LoadChallenge.aspx",challReciever,"POST");
}
else
{
   challCheckup = true;
}
stop();
