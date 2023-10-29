//Main

ArrayList<Shape> allShapes = new ArrayList<Shape>();
Shape currentShape, focusedShape;
String shapeType = "line", mode = "draw";

void setup() {
  surface.setTitle("Paint");
  surface.setResizable(true);
  surface.setLocation(200, 200);
  size(640, 360);
  background(0);
  noStroke();
  fill(256);
  
  String[] args = {"Menu"};
  MenuWindow mw = new MenuWindow();
  PApplet.runSketch(args, mw);
}

void draw() {
  frameRate(60);
  stroke(255);
  background(0);
  
  if(currentShape!=null){
    currentShape.Draw();
  }
  if(allShapes!=null){
    fill(255);
    text(Integer.toString(allShapes.size()),40,40);
    for (Shape shape : allShapes){
      if(shape!=null)
      shape.Draw();
    }
  }
}

void windowResized(){
  loop();
}

void mainNoLoop(){noLoop();}
void mainLoop(){loop();}
