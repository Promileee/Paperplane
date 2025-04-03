function onInitObject()
{
   pointsArray = [make3DPoint(2.932581,0.111765,-68.79139),make3DPoint(2.932581,0.111765,69.04139),make3DPoint(-0.046501,-12.36373,-68.29139),make3DPoint(-0.046501,-12.36373,69.54139),make3DPoint(-2.932581,0.111765,-68.79139),make3DPoint(-2.932581,0.111765,69.04139),make3DPoint(0.046501,-12.36373,-68.29139),make3DPoint(0.046501,-12.36373,69.54139),make3DPoint(-2.932581,0.111765,69.04139),make3DPoint(65.04956,0.111765,69.04139),make3DPoint(65.04956,0.111765,-68.79139),make3DPoint(2.932581,0.111765,-68.79139),make3DPoint(2.932581,0.111765,69.04139),make3DPoint(88.28683,0.083334,-68.875),make3DPoint(88.28683,0.083334,69.125),make3DPoint(53.2535,0,-68.60833),make3DPoint(12.12017,0,-68.74167),make3DPoint(17.12017,0,-58.875),make3DPoint(47.78684,0,-58.54167),make3DPoint(-65.04956,0.111765,69.04139),make3DPoint(-65.04956,0.111765,-68.79139),make3DPoint(-2.932581,0.111765,-68.79139),make3DPoint(-88.28683,0.083334,-68.875),make3DPoint(-88.28683,0.083334,69.125),make3DPoint(-53.2535,0,-68.60833),make3DPoint(-12.12017
   ,0,-68.74167),make3DPoint(-17.12017,0,-58.875),make3DPoint(-47.78684,0,-58.54167),make3DPoint(-2.932581,0.111765,69.04139),make3DPoint(-49.58966,0.07451,10.5137)];
   faceArray = [{points:[0,2,3],color:1},{points:[0,3,1],color:1},{points:[7,6,4],color:1},{points:[5,7,4],color:1},{points:[5,1,5],color:1},{points:[9,11,12],color:2},{points:[10,9,13],color:2},{points:[9,14,13],color:2},{points:[18,10,15],color:2},{points:[9,10,18],color:2},{points:[18,17,9],color:2},{points:[9,17,11],color:2},{points:[17,16,11],color:2},{points:[17,15,16],color:2},{points:[17,18,15],color:2},{points:[22,19,20],color:2},{points:[22,23,19],color:2},{points:[24,20,27],color:2},{points:[27,20,19],color:2},{points:[21,25,26],color:2},{points:[25,24,26],color:2},{points:[24,27,26],color:2},{points:[28,21,26],color:2},{points:[8,26,27],color:2},{points:[29,19,8],color:2},{points:[27,29,8],color:2},{points:[27,19,29],color:2}];
}
function modifyModel(elevator, winglets)
{
   pointsArray[15].y = elevator / 10 * __scale;
   pointsArray[16].y = elevator / 10 * __scale;
   pointsArray[24].y = elevator / 10 * __scale;
   pointsArray[25].y = elevator / 10 * __scale;
   if(winglets == 1)
   {
      pointsArray[13].x = 65 * __scale;
      pointsArray[13].y = 23 * __scale;
      pointsArray[14].x = 65 * __scale;
      pointsArray[14].y = 23 * __scale;
      pointsArray[22].x = -65 * __scale;
      pointsArray[22].y = 23 * __scale;
      pointsArray[23].x = -65 * __scale;
      pointsArray[23].y = 23 * __scale;
   }
   else
   {
      pointsArray[13].x = 88 * __scale;
      pointsArray[13].y = 0;
      pointsArray[14].x = 88 * __scale;
      pointsArray[14].y = 0;
      pointsArray[22].x = -88 * __scale;
      pointsArray[22].y = 0;
      pointsArray[23].x = -88 * __scale;
      pointsArray[23].y = 0;
   }
}
onInitObject();
colorArray = [{back:4155525,front:14674411},{back:4155525,front:14674411},{back:5208213,front:15727099}];
SetScale(0.95);
onInitObject();
rx = -0.24;
ry = -0.28;
rz = -3.1;
stop();
