//Shape class code outside of pApplet, for serialization purpose

import java.io.Serializable;
import processing.core.PVector;
class ShapeSerializable implements Serializable {
  String type;
  PVector p1, p2;
  int c;
  ShapeSerializable(String _type, PVector _p1, PVector _p2, int _c){
    type = _type;
    p1 = _p1;
    p2 = _p2;
    c = _c;
  }
}
