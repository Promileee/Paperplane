function onInitObject()
{
   pointsArray = [make3DPoint(4,0,-79),make3DPoint(4,0,0.5),make3DPoint(4,0,80),make3DPoint(0,-36.5,-73.5),make3DPoint(0,-23.5,0.5),make3DPoint(0,-12,81.5),make3DPoint(2,-10.41667,-46.83334),make3DPoint(2,-6.833334,51.5),make3DPoint(-4,0,-79),make3DPoint(-4,0,0.5),make3DPoint(-4,0,80),make3DPoint(-2,-10.41667,-46.83334),make3DPoint(-2,-6.833334,51.5),make3DPoint(4,0,-79),make3DPoint(4,0,0.5),make3DPoint(4,0,80),make3DPoint(18.83333,0,80.16667),make3DPoint(65,0,-20),make3DPoint(65,0,-79),make3DPoint(75.5,0,-79),make3DPoint(79.5,0,-51),make3DPoint(20.5,0,-79),make3DPoint(49,0,-79),make3DPoint(49,0,-69),make3DPoint(20.5,0,-69),make3DPoint(22.05556,0,-10.63889),make3DPoint(-4,0,-79),make3DPoint(-65,0,-20),make3DPoint(-65,0,-79),make3DPoint(-75.5,0,-79),make3DPoint(-79.5,0,-51),make3DPoint(-20.5,0,-79),make3DPoint(-49,0,-79),make3DPoint(-49,0,-69),make3DPoint(-20.5,0,-69),make3DPoint(-21.5,0,79.66667)];
   faceArray = [{points:[6,3,4],color:0},{points:[6,4,1],color:0},{points:[7,5,2],color:0},{points:[7,2,1],color:0},{points:[0,3,6],color:0},{points:[0,6,1],color:0},{points:[4,7,1],color:0},{points:[4,5,7],color:0},{points:[4,3,11],color:0},{points:[9,4,11],color:0},{points:[10,5,12],color:0},{points:[9,10,12],color:0},{points:[11,3,8],color:0},{points:[9,11,8],color:0},{points:[9,12,4],color:0},{points:[12,5,4],color:0},{points:[17,20,19],color:1},{points:[19,18,17],color:1},{points:[17,18,23],color:1},{points:[18,22,23],color:1},{points:[23,22,21],color:1},{points:[21,24,23],color:1},{points:[24,17,23],color:1},{points:[24,21,13],color:1},{points:[15,25,14],color:1},{points:[15,16,25],color:1},{points:[14,25,13],color:1},{points:[25,24,13],color:1},{points:[29,30,27],color:1},{points:[27,28,29],color:1},{points:[33,28,27],color:1},{points:[33,32,28],color:1},{points:[31,32,33],color:1},{points:[33,34,31],color:1},{points:[33,27,34],color:1},{points:[26,31,34],color:1},{points:[16,17,25],color:1},{points:[25,17,24],color:1},{points:[34,9,8],color:1},{points:[9,34,27],color:1},{points:[10,9,27],color:1},{points:[35,10,27],color:1}];
}
function modifyModel(elevator, winglets)
{
   pointsArray[21].y = elevator / 10;
   pointsArray[22].y = elevator / 10;
   pointsArray[31].y = elevator / 10;
   pointsArray[32].y = elevator / 10;
   if(winglets == 1)
   {
      pointsArray[19].x = 65;
      pointsArray[19].y = 10;
      pointsArray[20].x = 65;
      pointsArray[20].y = 10;
      pointsArray[29].x = -65;
      pointsArray[29].y = 10;
      pointsArray[30].x = -65;
      pointsArray[30].y = 10;
   }
   else
   {
      pointsArray[19].x = 75.5;
      pointsArray[19].y = 0;
      pointsArray[20].x = 79.5;
      pointsArray[20].y = 0;
      pointsArray[29].x = -75.5;
      pointsArray[29].y = 0;
      pointsArray[30].x = -79.5;
      pointsArray[30].y = 0;
   }
}
onInitObject();
colorArray = [{back:4155525,front:14674411},{back:5208213,front:15727099}];
onInitObject();
rx = -0.24;
ry = -0.48;
rz = -3.1;
stop();
