class kage.classes.aerodynamics
{
   var cl;
   var cd;
   var y;
   var oldangle;
   var planeangle;
   var dy;
   var v;
   var q;
   var lift;
   var drag;
   var x;
   var difangle;
   var onLanding;
   var x2;
   var y2;
   var planeA = {cd0:0.025,ar:1,area:0.1736,clmax:0.92};
   var planeB = {cd0:0.03,ar:1.825,area:0.2028,clmax:0.55};
   var planeC = {cd0:0.03,ar:0.85,area:0.2049,clmax:0.5};
   var ar = 1.825;
   var cd0 = 0.03;
   var area = 0.208;
   var weight = 0.012;
   var dt = 0.025;
   var clmax = 0.55;
   var err = 0;
   var g = 32.2;
   var _plane = 3;
   var element = 5;
   var power = 35;
   var angle = 0;
   var winglets = 0;
   var dx = 0;
   function aerodynamics()
   {
      this.init();
   }
   function setPlane(plane)
   {
      var _loc2_ = undefined;
      if(plane == 1)
      {
         _loc2_ = this.planeA;
      }
      else if(plane == 2)
      {
         _loc2_ = this.planeB;
      }
      else
      {
         _loc2_ = this.planeC;
      }
      this._plane = plane;
      this.cd0 = _loc2_.cd0;
      this.ar = _loc2_.ar;
      this.area = _loc2_.area;
      this.clmax = _loc2_.clmax;
   }
   function init()
   {
      this.cl = this.clmax * (this.element / 1600);
      this.cd = this.cd0 + this.cl * this.cl / (2.2 * this.ar);
      this.y = 1;
      this.oldangle = this.angle;
      this.planeangle = this.angle;
      this.dy = 60;
      this.v = this.power;
   }
   function fly()
   {
      if(this.y <= -50)
      {
         return undefined;
      }
      this.q = 0.00115 * this.v * this.v;
      this.lift = this.q * (this.area - this.winglets * 0.01) * this.cl;
      this.drag = this.q * (this.area - this.winglets * 0.01) * this.cd;
      this.v -= (this.weight * Math.sin(this.angle / 57.29577951308232) + this.drag) * this.g * this.dt * 57.29577951308232;
      this.angle += (this.lift - this.weight * Math.cos(this.angle / 57.29577951308232)) * this.g * this.dt * 57.29577951308232 / (this.weight * this.v);
      if(this.v < 0)
      {
         this.v = - this.v;
         this.angle = - this.angle;
      }
      this.angle %= 360;
      this.dx += this.v * this.dt * Math.cos(this.angle / 57.29577951308232) * 10;
      this.dy += this.v * this.dt * Math.sin(this.angle / 57.29577951308232) * 10;
      this.x = Math.round(this.dx);
      this.y = Math.round(this.dy);
      if(this.angle != this.planeangle)
      {
         this.difangle = (this.angle - this.planeangle) % 360;
         if(Math.abs(this.difangle) > 180)
         {
            this.difangle = (Math.abs(this.difangle) - 360) * (this.difangle / Math.abs(this.difangle));
         }
         this.difangle %= 360;
         this.planeangle += this.difangle * this.v / 180;
      }
      if(this.y <= -50)
      {
         this.y = -50;
         if(this.onLanding != null)
         {
            this.onLanding();
         }
      }
      this.x2 = 200;
      this.y2 = 300 - this.y;
   }
}
