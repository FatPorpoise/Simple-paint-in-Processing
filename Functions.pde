//Functions for calculating points of a shape

ArrayList<PVector> Line(PVector p1, PVector p2){
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  int pointNum;
  PVector dist = p1.copy().sub(p2), d, currentP = p1.copy();
  pointNum = Math.round(p1.dist(p2))*2;
  d = dist.div(pointNum);
  
  for(int i = 0;i<pointNum;i++){
    points.add(currentP.copy());
    currentP.sub(d);
  }
  
  return points;
}

ArrayList<PVector> Rectangle(PVector A, PVector D){
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  PVector B = new PVector(A.x, D.y), C = new PVector(D.x, A.y);
  points.addAll(Line(A,B));
  points.addAll(Line(A,C));
  points.addAll(Line(B,D));
  points.addAll(Line(C,D));
  
  return points;
}

ArrayList<PVector> Ellipse(PVector A, PVector D) {
  ArrayList<PVector> points = new ArrayList<PVector>();

  float semiMajorAxis = dist(A.x, A.y, D.x, A.y) / 2;
  float semiMinorAxis = dist(A.x, A.y, A.x, D.y) / 2;
  PVector center = A.copy().add(D).div(2);
  float perimeter = (2 * PI * sqrt(2 * (semiMajorAxis * semiMajorAxis + semiMinorAxis * semiMinorAxis) / 2));
  int numPoints = round(2 * perimeter);

  for (int i = 0; i < numPoints; i++) {
      float angle = map(i, 0, numPoints, 0, TWO_PI);
      float x = center.x + semiMajorAxis * cos(angle);
      float y = center.y + semiMinorAxis * sin(angle);
      points.add(new PVector(x, y));
  }

  return points;
}
