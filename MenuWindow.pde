class MenuWindow extends PApplet {
  Button lineButton, rectangleButton, ellipseButton, drawButton, selectButton, newButton;
  TextBox p1x, p1y, p2x, p2y;
  
  void settings() {
    size(280, 280);
  }
  
  void setup() {
    this.surface.setLocation(840, 200);
    background(255);
    
    lineButton = new Button("Line", 40, 30, 60, 30);
    rectangleButton = new Button("Rectangle", 110, 30, 60, 30);
    ellipseButton = new Button("Ellipse", 180, 30, 60, 30);
    drawButton = new Button("Draw", 40, 85, 60, 30);
    selectButton = new Button("Select", 110, 85, 60, 30);
    newButton = new Button("New", 180, 85, 60, 30);
    
    p1x = new TextBox(30,160,100,30);
    p1y = new TextBox(30,200,100,30);
    p2x = new TextBox(155,160,100,30);
    p2y = new TextBox(155,200,100,30);
  }
  
  void draw() {
    frameRate(30);
    background(255);
    text("Shapes",120,25);
    text("Mode",125,80);
    text("Point 1",60,140);
    text("Point 2",185,140);
    
    lineButton.display();
    rectangleButton.display();
    ellipseButton.display();
    drawButton.display();
    selectButton.display();
    newButton.display();
    
    if(focusedShape!=null){
      //println(abs(round(focusedShape.s.p1.x)));
      p1x.Text = Integer.toString(abs(round(focusedShape.s.p1.x)));
      p1y.Text = Integer.toString(abs(round(focusedShape.s.p1.y)));
      p2x.Text = Integer.toString(abs(round(focusedShape.s.p2.x)));
      p2y.Text = Integer.toString(abs(round(focusedShape.s.p2.y)));
    }
    
    p1x.display();
    p1y.display();
    p2x.display();
    p2y.display();
  }
  
  void mousePressed() {
    mainNoLoop();
    delay(100);
    if (lineButton.isClicked()) {
      shapeType = "line";
    } else if (rectangleButton.isClicked()) {
      shapeType = "rectangle";
    } else if (ellipseButton.isClicked()) {
      shapeType = "ellipse";
    } else if (drawButton.isClicked()) {
      mode = "draw";
    } else if (selectButton.isClicked()) {
      mode = "select";
    } else if (newButton.isClicked()) {
      focusedShape = new Shape(shapeType,new PVector(10,10),new PVector(40,40),color(256));
      allShapes.add(focusedShape);
    }
    p1x.pressed(mouseX, mouseY);
    p1y.pressed(mouseX, mouseY);
    p2x.pressed(mouseX, mouseY);
    p2y.pressed(mouseX, mouseY);
    mainLoop();
  }
  
  void keyPressed(){
    mainNoLoop();
    delay(100);
    if(p1x.KeyPressed(key, keyCode)){
      focusedShape.s.p1.x = p1x.toFloat();
      focusedShape.calcPoints();
    }
    else if(p1y.KeyPressed(key, keyCode)){
      focusedShape.s.p1.y = p1y.toFloat();
      focusedShape.calcPoints();
    }
    else if(p2x.KeyPressed(key, keyCode)){
      focusedShape.s.p2.x = p2x.toFloat();
      focusedShape.calcPoints();
    }
    else if(p2y.KeyPressed(key, keyCode)){
      focusedShape.s.p2.y = p2y.toFloat();
      focusedShape.calcPoints();
    }
    mainLoop();
  }




  class Button {
    String label;
    float x, y, w, h;
    int background;
    
    Button(String label, float x, float y, float w, float h) {
      this.label = label;
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      background = 200;
    }
    
    void display() {
      fill(background);
      if(background!=200)
        background = 200;
      rect(x, y, w, h);
      fill(0);
      text(label, x + 5, y + 20);
    }
    
    boolean isClicked() {
      if(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
        background = 150;
        return true;
      }
      return false;
    }
  }






  class TextBox {
     int X = 0, Y = 0, H = 35, W = 200;
     color Background = color(140, 140, 140);
     color Foreground = color(0, 0, 0);
     color BackgroundSelected = color(160, 160, 160);
     color Border = color(30, 30, 30);
     boolean BorderEnable = true;
     int BorderWeight = 1;
     String Text = "0", sign = "";
     private boolean selected = false;
     
     
     TextBox(int x, int y, int w, int h) {
        X = x; Y = y; W = w; H = h;
     }
     
     float toFloat(){
       return Float.parseFloat(sign+Text);
     }
     
     void display() {
        if (selected) {
           fill(BackgroundSelected);
        } else {
           fill(Background);
        }
        
        if (BorderEnable) {
           strokeWeight(BorderWeight);
           stroke(Border);
        } else {
           noStroke();
        }
        
        rect(X, Y, W, H);
        
        fill(Foreground);
        text(sign+Text, X + 2, Y+H/2+3);
     }
     
     boolean KeyPressed(char KEY, int KEYCODE) {
        if (selected) {
           if (KEY == BACKSPACE) {
              backspace();
              return true;
           } else if (KEY == '-') {
              sign = "-";
              return true;
           } else if (KEY == '+') {
              sign = "";
              return true;
           }else { 
              if (KEY >= '0' && KEY <= '9') {
                if(Text.equals("0"))
                  Text = ""+KEY;
                else
                 addText(KEY);
                 
              return true;
              }
           }
        }
        return false;
     }
     
     private void addText(char text) {
        if (textWidth(Text + text) < W) {
           Text += text;
        }
     }
     
     private void backspace() {
        if (Text.length() - 1 > 0) {
           Text = Text.substring(0, Text.length() - 1);
        }else if(Text.length() - 1 == 0){
          Text = "0";
        }
     }
     private boolean overBox(int x, int y) {
        if (x >= X && x <= X + W) {
           if (y >= Y && y <= Y + H) {
              return true;
           }
        }
        
        return false;
     }
     
     void pressed(int x, int y) {
        if (overBox(x, y)) {
           selected = true;
        } else {
           selected = false;
        }
     }
  }


}
