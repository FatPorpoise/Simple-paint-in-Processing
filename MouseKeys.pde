 //Mouse events
PVector clickPosition = new PVector(0,0), previousP1 = new PVector(0,0), previousP2 = new PVector(0,0);

void mousePressed()
{
  if(mouseButton == LEFT){
    if(mode == "draw"){
      currentShape = new Shape(shapeType,new PVector(mouseX, mouseY),new PVector(mouseX, mouseY),color(256));
      focusedShape = currentShape;
    }else if(mode == "select"){
      for (Shape shape : allShapes){
        if(shape!=null && shape.mouseOver()){
          focusedShape = shape;
          clickPosition.x = mouseX;
          clickPosition.y = mouseY;
          previousP1 = focusedShape.s.p1.copy();
          previousP2 = focusedShape.s.p2.copy();
          break;
        }
      }
    }
  }
}

void mouseDragged() 
{
  if(mode == "draw"){
    if(currentShape!=null){
      currentShape.s.p2 = new PVector(mouseX, mouseY);
      currentShape.calcPoints();
    }
  }else if(mode == "select"){
    if(mousePressed && focusedShape.mouseOver()){
      PVector mouseD = new PVector(clickPosition.x - mouseX, clickPosition.y - mouseY);
      focusedShape.s.p1 = previousP1.copy().sub(mouseD);
      focusedShape.s.p2 = previousP2.copy().sub(mouseD);
      focusedShape.calcPoints();
    }
  }
}

void mouseReleased()
{
  if(mode == "draw"){
    if(mouseButton == LEFT){
      allShapes.add(currentShape);
      currentShape = null;
    }
  }
}

void keyPressed() {
  noLoop();
  if (keyCode == 112) {
    selectOutput("Select a file to write to:", "outputFileSelected");
  }else  if (keyCode == 113) {
    selectInput("Select a file to read from:", "inputFileSelected");
  }
  loop();
}
