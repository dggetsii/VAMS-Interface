import 'dart:html' as html;
import 'package:stagexl/stagexl.dart' as sxl;

//Pointx Format
const RADIO_POINT = 5;
const COLOR_POINT = sxl.Color.Black;

//Alux Format
const BORDER_COLOR_ALU = sxl.Color.Blue;
const BORDER_WIDTH_ALU = 2;
const FILL_COLOR_ALU = sxl.Color.White;

//Cellx Format
const FONT_CELL = "Arial";
const FONT_SIZE_CELL = 30;
const FONT_COLOR_CELL= sxl.Color.Black;
const HEIGHT_CELL = 40;
const WIDTH_CELL = 250;

//Information board Format
const FILL_COLOR_BOARD= sxl.Color.White;
const BORDER_COLOR_BOARD = sxl.Color.Blue;
const BORDER_WIDTH_BOARD = 2;
const HEIGHT_BOARD = 300;
const WIDTH_BOARD = 200;

const BORDER_COLOR_WIRE = sxl.Color.Gray;
const BORDER_WIDTH_WIRE = 2;

class point extends sxl.Sprite{
     
     informationBoard info;
     
     point(num x_, num y_){
          x=x_;
          y=y_;
          paint();
          onMouseRollOver.listen(_onPass);
          onMouseRollOut.listen(_onPassOut);
          onMouseClick.listen(_onClick);
          info = new informationBoard(x,y);
          this.addChild(info);
     }
     
     _onPass(sxl.MouseEvent e) =>  info.visible=true;
     
     _onPassOut(sxl.MouseEvent e) => info.visible=false;
          
     _onClick(sxl.MouseEvent e) => print("$x $y");
     
    paint(){
        graphics.circle(x, y, RADIO_POINT);
        graphics.fillColor(COLOR_POINT);
     }
    
}


class informationBoard extends sxl.Sprite {
    
     informationBoard(num x_, num y_){
          
          x=x_;
          y=y_;
          paint();
          onMouseRollOver.listen(_onPass);
          onMouseRollOut.listen(_onPassOut);
     }
     
     paint(){
          graphics.rect(x, y, WIDTH_BOARD, HEIGHT_BOARD);
          graphics.fillColor(FILL_COLOR_BOARD);
          graphics.strokeColor(BORDER_COLOR_BOARD,BORDER_WIDTH_BOARD);
          visible=false;
     }

     _onPassOut(sxl.MouseEvent e) => visible=false;

     _onPass(sxl.MouseEvent e) => visible=true;    
}


class ALUx extends sxl.Sprite {
   
     point op1, op2, res;
   
     ALUx(num x_,num y_){
          x=x_;
          y=y_;
          pintar();
          onMouseClick.listen(_onMouseClick);
          onMouseRollOver.listen(_onPass);
          op1 = new point (x, y+15);
          op2 = new point (x, y+55);
          res = new point (x+40, y+35);
          this.addChildAt(op1, 0);
          this.addChildAt(op2, 0);
          this.addChildAt(res, 0);
     }
     
     _onMouseClick(sxl.MouseEvent e) => print("hola soy alu");
     
     _onPass(sxl.MouseEvent e) => print("ey hola");
     
     pintar (){
            
            graphics.beginPath();
            graphics.moveTo(x, y);
            graphics.lineTo(x, y+60);
            graphics.lineTo(x+30, y+70);
            graphics.lineTo(x, y+80);
            graphics.lineTo(x, y+140);
            graphics.lineTo(x+80, y+105);//esquina 1 
            graphics.lineTo(x+80, y+30);//esquina 2
            graphics.closePath();
            graphics.fillColor(FILL_COLOR_ALU);
            graphics.strokeColor(BORDER_COLOR_ALU, BORDER_WIDTH_ALU);            
     }    
}

class cell extends sxl.TextField {
     
     point pointer;
     
     cell(var s,num x_, num y_){
          x=x_;
          y=y_;
          pointer = new point(x,y);
          text=s.toString();
          defaultTextFormat = new sxl.TextFormat(FONT_CELL, FONT_SIZE_CELL,FONT_COLOR_CELL);
          height=HEIGHT_CELL;
          width=WIDTH_CELL;
          border=true;
          onMouseClick.listen(_onClick);
          
          
     }
     
     _onClick(sxl.MouseEvent e) => print(this.text);
}

class MEMORYx extends sxl.Sprite {
     
     List<cell> table;
     
     MEMORYx (num x_,num y_){
          x=x_;
          y=y_;
          table = new List<cell>();
          for (int i=0; i<10; i++){
               cell xcell = new cell(i,x,y+(HEIGHT_CELL*i));
               table.insert(i,xcell);
               this.addChildAt(table[i],0);
               this.addChildAt(table[i].pointer,1);
          }   
          this.onMouseClick.listen(_eventClick);
     }
     
     _eventClick(sxl.MouseEvent e) => _move();
     
     _move(){
          print("memory");
          print("$x $y");
     }
}

class wire extends sxl.Sprite {
     
     point init, end;
     
     wire(this.init, this.end){  
          graphics.beginPath();
          graphics.moveTo(init.x, init.y);
          graphics.lineTo(end.x, end.y);
          graphics.closePath();
          graphics.strokeColor(BORDER_COLOR_WIRE, BORDER_WIDTH_WIRE);
     }
     
}




void main() {
     var canvas = html.querySelector('#stage');
     var stage = new sxl.Stage(canvas, width: 960, height: 570);
     stage.scaleMode = sxl.StageScaleMode.SHOW_ALL;
     stage.align = sxl.StageAlign.NONE;

     var renderLoop = new sxl.RenderLoop();
     renderLoop.addStage(stage);

     ALUx al = new ALUx(0,0);
     MEMORYx t = new MEMORYx(200,0);
     //var w = new wire (al.res,t.table.last.pointer);
     
     //stage.addChild(w);
     stage.addChild(al);
     stage.addChild(t);
     
     
     var pto = new point(200,0);
     stage.addChild(pto);
     
     
     var pr = new sxl.Sprite();
     pr.graphics.circle(200, 0, 5);
     pr.graphics.fillColor(COLOR_POINT);
     stage.addChild(pr);     
}



