class kage.classes.kage3d extends MovieClip
{
   var onEnterFrame;
   var __targetmc;
   var pointsArray;
   var sortArray;
   var faceArray;
   var colorArray;
   var focalLength = 300;
   var __scale = 1;
   var rx = 0;
   var ry = 0;
   var rz = 0;
   var anglez = 0;
   var gz = 0;
   function kage3d()
   {
      super();
      this.onEnterFrame = function()
      {
         this.drawObject(this,Math.sin(this.anglez * 3.141592653589793 / 180) * 0.1);
         this.anglez += 3;
      };
   }
   function initMe()
   {
   }
   function make3DPointX(sz, sx, sy)
   {
      return {x:sx,y:sy,z:sz};
   }
   function SetScale(scale)
   {
      this.__scale = scale;
   }
   function make3DPoint(sx, sy, sz)
   {
      return {x:sx * this.__scale,y:sy * this.__scale,z:sz * this.__scale};
   }
   function drawObject(tc, rotz)
   {
      this.__targetmc = tc;
      var _loc4_ = this.Transform3DPointsTo2DPoints(this.pointsArray,{x:this.rx,y:this.ry + rotz,z:this.rz + rotz * 0.5});
      this.__targetmc.clear();
      this.__targetmc.lineStyle(0,0,0);
      this.sortArray = new Array(0);
      var _loc3_ = 0;
      while(_loc3_ < this.faceArray.length)
      {
         this.sortArray.push({pos:_loc3_,z:(_loc4_[this.faceArray[_loc3_].points[0]].z + _loc4_[this.faceArray[_loc3_].points[1]].z + _loc4_[this.faceArray[_loc3_].points[2]].z) / 3});
         _loc3_ = _loc3_ + 1;
      }
      this.sortArray.sortOn("z",Array.NUMERIC);
      var _loc5_ = 0;
      while(_loc5_ < this.faceArray.length)
      {
         _loc3_ = this.sortArray[_loc5_].pos;
         var _loc2_ = new Array();
         _loc2_.push(_loc4_[this.faceArray[_loc3_].points[0]]);
         _loc2_.push(_loc4_[this.faceArray[_loc3_].points[1]]);
         _loc2_.push(_loc4_[this.faceArray[_loc3_].points[2]]);
         _loc2_.sortOn("z",Array.NUMERIC);
         this.drawGradientTriangle(new kage.classes.GradientPoint(_loc2_[0].x,_loc2_[0].y,0,this.createColor(this.colorArray[this.faceArray[_loc3_].color].back,this.colorArray[this.faceArray[_loc3_].color].front,_loc2_[0].z / 3 + 50)),new kage.classes.GradientPoint(_loc2_[1].x,_loc2_[1].y,100 * (_loc2_[1].z - _loc2_[0].z) / (_loc2_[2].z - _loc2_[0].z),0),new kage.classes.GradientPoint(_loc2_[2].x,_loc2_[2].y,100,this.createColor(this.colorArray[this.faceArray[_loc3_].color].back,this.colorArray[this.faceArray[_loc3_].color].front,_loc2_[2].z / 3 + 50)));
         _loc5_ = _loc5_ + 1;
      }
   }
   function createColor(rgbDark, rgbLight, scale)
   {
      if(scale > 100)
      {
         scale = 100;
      }
      if(scale < 0)
      {
         scale = 0;
      }
      var _loc3_ = rgbDark >> 16;
      var _loc4_ = rgbDark >> 8 & 0xFF;
      var _loc2_ = rgbDark & 0xFF;
      var _loc8_ = rgbLight >> 16;
      var _loc10_ = rgbLight >> 8 & 0xFF;
      var _loc9_ = rgbLight & 0xFF;
      _loc3_ += Math.round((_loc8_ - _loc3_) * scale / 100);
      _loc4_ += Math.round((_loc10_ - _loc4_) * scale / 100);
      _loc2_ += Math.round((_loc9_ - _loc2_) * scale / 100);
      var _loc5_ = (_loc3_ << 16) + (_loc4_ << 8) + _loc2_;
      return _loc5_;
   }
   function Transform3DPointsTo2DPoints(points, axisRotations)
   {
      var _loc20_ = [];
      var _loc15_ = Math.sin(axisRotations.x);
      var _loc17_ = Math.cos(axisRotations.x);
      var _loc13_ = Math.sin(axisRotations.y);
      var _loc16_ = Math.cos(axisRotations.y);
      var _loc12_ = Math.sin(axisRotations.z);
      var _loc14_ = Math.cos(axisRotations.z);
      var _loc5_ = undefined;
      var _loc4_ = undefined;
      var _loc3_ = undefined;
      var _loc10_ = undefined;
      var _loc9_ = undefined;
      var _loc11_ = undefined;
      var _loc8_ = undefined;
      var _loc19_ = undefined;
      var _loc18_ = undefined;
      var _loc6_ = undefined;
      var _loc2_ = points.length;
      while(_loc2_--)
      {
         _loc5_ = points[_loc2_].x;
         _loc4_ = points[_loc2_].y;
         _loc3_ = points[_loc2_].z;
         _loc10_ = _loc17_ * _loc4_ - _loc15_ * _loc3_;
         _loc9_ = _loc15_ * _loc4_ + _loc17_ * _loc3_;
         _loc8_ = _loc16_ * _loc9_ - _loc13_ * _loc5_;
         _loc11_ = _loc13_ * _loc9_ + _loc16_ * _loc5_;
         _loc19_ = _loc14_ * _loc11_ - _loc12_ * _loc10_;
         _loc18_ = _loc12_ * _loc11_ + _loc14_ * _loc10_;
         _loc6_ = this.focalLength / (this.focalLength + _loc8_) + 0.6;
         _loc5_ = _loc19_ * _loc6_;
         _loc4_ = _loc18_ * _loc6_;
         _loc3_ = - _loc8_;
         _loc20_[_loc2_] = this.make3DPoint(_loc5_,_loc4_,_loc3_);
      }
      return _loc20_;
   }
   function getHeight(x1, y1, x2, y2, x3, y3)
   {
      var _loc3_ = Math.sqrt(Math.pow(Math.abs(x2 - x1),2) + Math.pow(Math.abs(y2 - y1),2));
      var _loc2_ = Math.sqrt(Math.pow(Math.abs(x3 - x2),2) + Math.pow(Math.abs(y3 - y2),2));
      var _loc1_ = Math.sqrt(Math.pow(Math.abs(x1 - x3),2) + Math.pow(Math.abs(y1 - y3),2));
      var _loc4_ = 2 * Math.sqrt((_loc3_ + _loc2_ + _loc1_) / 2 * ((_loc3_ + _loc2_ + _loc1_) / 2 - _loc3_) * ((_loc3_ + _loc2_ + _loc1_) / 2 - _loc2_) * ((_loc3_ + _loc2_ + _loc1_) / 2 - _loc1_)) / _loc1_;
      if(isNaN(_loc4_))
      {
         _loc4_ = 0;
      }
      return _loc4_;
   }
   function drawGradientTriangle(gp0, gp1, gp2)
   {
      var _loc2_ = [gp0,gp1,gp2];
      _loc2_.sortOn("ratio",Array.NUMERIC);
      var _loc6_ = flash.geom.Point.interpolate(_loc2_[2],_loc2_[0],(_loc2_[1].ratio - _loc2_[0].ratio) / (_loc2_[2].ratio - _loc2_[0].ratio));
      var _loc4_ = _loc2_[2].subtract(_loc2_[0]);
      var _loc5_ = Math.atan2(_loc6_.x - _loc2_[1].x,_loc2_[1].y - _loc6_.y);
      var _loc3_ = new flash.geom.Matrix();
      _loc3_.a = Math.cos(Math.atan2(_loc4_.y,_loc4_.x) - _loc5_) * _loc4_.length / 1638.4;
      _loc3_.rotate(_loc5_);
      _loc3_.translate((_loc2_[2].x + _loc2_[0].x) / 2,(_loc2_[2].y + _loc2_[0].y) / 2);
      this.beginGradientFill("linear",[_loc2_[0].color,_loc2_[2].color],[100,100],[0,255],_loc3_);
      this.moveTo(_loc2_[2].x,_loc2_[2].y);
      this.lineTo(_loc2_[0].x,_loc2_[0].y);
      this.lineTo(_loc2_[1].x,_loc2_[1].y);
      this.lineTo(_loc2_[2].x,_loc2_[2].y);
      this.endFill();
   }
   function createGradientFill(x1, y1, x2, y2, x3, y3)
   {
      var _loc6_ = Math.sqrt(Math.pow(Math.abs(x2 - x1),2) + Math.pow(Math.abs(y2 - y1),2));
      if(Key.isDown(33))
      {
         this.gz = this.gz + 1;
      }
      var _loc7_ = this.getHeight(x2,y2,x3,y3,x1,y1);
      var _loc11_ = Math.atan(_loc6_ / _loc7_) + this.rz;
      this.__targetmc.lineStyle(0,16711680,0);
      var _loc2_ = x1;
      if(x2 < _loc2_)
      {
         _loc2_ = x2;
      }
      if(x3 < _loc2_)
      {
         _loc2_ = x3;
      }
      var _loc3_ = y1;
      if(y2 < _loc3_)
      {
         _loc3_ = y2;
      }
      if(y3 < _loc3_)
      {
         _loc3_ = y3;
      }
      this.__targetmc.lineStyle(10,15727099,100);
      this.__targetmc.beginGradientFill("linear",[5208213,15727099],[100,100],[0,255],{matrixType:"box",x:_loc2_,y:_loc3_,w:_loc6_,h:_loc7_,r:_loc11_});
   }
}
