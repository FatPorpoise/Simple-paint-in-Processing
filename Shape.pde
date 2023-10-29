//Shape class

class Shape{
  ShapeSerializable s;
  ArrayList<PVector> points;

  Shape(String type, PVector p1, PVector p2, int c){
    s = new ShapeSerializable(type, p1, p2, c);
    calcPoints();
  }
  
  Shape(ShapeSerializable _s){
    s = _s;
    calcPoints();
  }

  void calcPoints(){
    if(s.type.equals("line"))
      points = Line(s.p1,s.p2);
    else if(s.type.equals("rectangle"))
      points = Rectangle(s.p1,s.p2);
    else if(s.type.equals("ellipse"))
    points = Ellipse(s.p1,s.p2);
    else
    println("Bad shape type");
  }
  
  void Draw(){
    fill(s.c);
    if(points!=null)
    for (PVector p : points){
      point(p.x, p.y);
    }
  }
  boolean mouseOver(){
    if(s.p1.x<=s.p2.x){
      if(s.p1.y<=s.p2.y){
        return mouseX>=s.p1.x && mouseX<=s.p2.x && mouseY>=s.p1.y && mouseY<=s.p2.y;
      }else{
        return mouseX>=s.p1.x && mouseX<=s.p2.x && mouseY<=s.p1.y && mouseY>=s.p2.y;
      }
    }else{
      if(s.p1.y<=s.p2.y){
        return mouseX<=s.p1.x && mouseX>=s.p2.x && mouseY>=s.p1.y && mouseY<=s.p2.y;
      }else{
        return mouseX<=s.p1.x && mouseX>=s.p2.x && mouseY<=s.p1.y && mouseY>=s.p2.y;
      }
    }
  //return false;
  }
}
