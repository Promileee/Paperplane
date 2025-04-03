function onInitObject()
{
   pointsArray = [make3DPoint(3,-0.45,-141.4),make3DPoint(3,-0.45,142.1),make3DPoint(-3,-0.45,-141.4),make3DPoint(-3,-0.45,142.1),make3DPoint(89,0,-80.33334),make3DPoint(89,0,-141.5),make3DPoint(102.1667,0,-113.1667),make3DPoint(102.1667,0,-141.5),make3DPoint(-89,0,-80.33334),make3DPoint(-89,0,-141.5),make3DPoint(-102.1667,0,-113.1667),make3DPoint(-102.1667,0,-141.5),make3DPoint(-3,-0.45,142.1),make3DPoint(-78,0,-141.45),make3DPoint(-70,0,-130.7833),make3DPoint(-18.33333,0,-130.1167),make3DPoint(-13,0,-141.1167),make3DPoint(13,0,-141.1167),make3DPoint(19.66667,0,-130.45),make3DPoint(78,0,-141.1167),make3DPoint(71,0,-129.7833),make3DPoint(3,-0.45,-141.4),make3DPoint(3,-0.45,-141.4),make3DPoint(3,-0.45,142.1),make3DPoint(0,-13.45,-141.4),make3DPoint(0,-13.45,-141.4),make3DPoint(0,-13.45,142.1),make3DPoint(0,-13.45,178.1),make3DPoint(-3,-0.45,-141.4),make3DPoint(-3,-0.45,-141.4),make3DPoint(-3,-0.45,142.1)];
   faceArray = [{points:[4,6,5],color:1},{points:[6,7,5],color:1},{points:[9,10,8],color:1},{points:[9,11,10],color:1},{points:[8,12,9],color:1},{points:[1,4,5],color:1},{points:[18,20,19],color:1},{points:[19,17,18],color:1},{points:[20,5,19],color:1},{points:[18,17,0],color:1},{points:[15,2,16],color:1},{points:[14,15,16],color:1},{points:[16,13,14],color:1},{points:[13,9,14],color:1},{points:[15,3,2],color:1},{points:[14,3,15],color:1},{points:[3,14,9],color:1},{points:[1,5,20],color:1},{points:[20,18,1],color:1},{points:[1,18,0],color:1},{points:[24,25,22],color:2},{points:[24,22,21],color:2},{points:[22,25,26],color:2},{points:[22,26,23],color:2},{points:[26,27,23],color:2},{points:[29,25,24],color:2},{points:[28,29,24],color:2},{points:[26,25,29],color:2},{points:[30,26,29],color:2},{points:[30,27,26],color:2}];
}
function modifyModel(elevator, winglets)
{
   pointsArray[13].y = elevator / 10 * __scale;
   pointsArray[16].y = elevator / 10 * __scale;
   pointsArray[17].y = elevator / 10 * __scale;
   pointsArray[19].y = elevator / 10 * __scale;
   if(winglets == 1)
   {
      pointsArray[6].x = 89 * __scale;
      pointsArray[6].y = 13 * __scale;
      pointsArray[7].x = 89 * __scale;
      pointsArray[7].y = 13 * __scale;
      pointsArray[10].x = -89 * __scale;
      pointsArray[10].y = 13 * __scale;
      pointsArray[11].x = -89 * __scale;
      pointsArray[11].y = 13 * __scale;
   }
   else
   {
      pointsArray[6].x = 102.1667 * __scale;
      pointsArray[6].y = 0;
      pointsArray[7].x = 102.1667 * __scale;
      pointsArray[7].y = 0;
      pointsArray[10].x = -102.1667 * __scale;
      pointsArray[10].y = 0;
      pointsArray[11].x = -102.1667 * __scale;
      pointsArray[11].y = 0;
   }
}
onInitObject();
colorArray = [{back:4155525,front:14674411},{back:4155525,front:14674411},{back:5208213,front:15727099}];
SetScale(0.8);
onInitObject();
rx = -0.24;
ry = -0.48;
rz = -3.1;
stop();
