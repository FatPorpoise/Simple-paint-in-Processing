//Input/Output

void outputFileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    
  } else {
    println("User selected " + selection.getAbsolutePath());
    try {
      ObjectOutputStream outputStream = new ObjectOutputStream(new FileOutputStream(selection.getAbsolutePath()));
      for (Shape shape : allShapes) {
        outputStream.writeObject(shape.s);
      }
      outputStream.close();
      println("Objects serialized and saved to " + selection.getName());
    } catch (IOException e) {
      e.printStackTrace();
      println("Serialization failed.");
    }
  }
}

void inputFileSelected(File selection) {
  if (selection == null) {
    println("No file selected for deserialization.");
  } else {
    try {
      ObjectInputStream inputStream = new ObjectInputStream(new FileInputStream(selection.getAbsolutePath()));
      ArrayList<ShapeSerializable> deserializedShapes = new ArrayList<>();

      while (true) {
        try {
          ShapeSerializable deserializedShape = (ShapeSerializable) inputStream.readObject();
          deserializedShapes.add(deserializedShape);
        } catch (EOFException e) {
          break; // End of file reached
        }
      }
      inputStream.close();

      if (deserializedShapes.isEmpty()) {
        println("No objects found in the selected file.");
      } else {
        println("Objects deserialized from " + selection.getName());
        allShapes = new ArrayList<Shape>();
        for(ShapeSerializable shapeSerializable : deserializedShapes){
          allShapes.add(new Shape(shapeSerializable));
        }
        focusedShape = allShapes.get(0);
      }
    } catch (InvalidClassException e) {
      println("The selected file does not contain valid serialized objects of the expected class.");
    }
    catch (IOException e) {
      println("Deserialization failed.");
    }
    catch (ClassNotFoundException e) {
      println("Class not found.");
    }
  }
}
