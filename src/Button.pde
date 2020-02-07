public class Button {
  int x;
  int y;
  int w;
  int h;
  int textSize;
  String message;
  color col;
  boolean enabled;
  
  public Button() {
    x = width / 2;
    y = height / 2;
    w = 50;
    h = 50;
    textSize = w / 3;
    enabled = true;
    message = "";
    col = color(255, 255, 255);
  }
  
  public Button(int _x, int _y, int _w, int _h, String msg) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    textSize = w / 3;
    message = msg;
    col = color(255, 255, 255);
    enabled = true;
  }
  
  public Button(int _x, int _y, int _w, int _h, String msg, color _col, int _textSize) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    textSize = _textSize;
    message = msg;
    col = _col;
    enabled = true;
  }
  
  void make() {
    if(enabled) {
      fill(col);
      rectMode(CENTER);
      rect(x, y, w, h, 10);
      textSize(textSize);
      textAlign(CENTER, CENTER);
      fill(255);
      text(message, x, y - (h / 10));
    }
  }
  
  boolean clicked() {
    if(mousePressed) {
      if(mouseX >= x - w / 2 && mouseX <= x + w / 2 && mouseY >= y - h / 2 && mouseY <= y + h / 2) {
        return true;
      }
    }
    return false;
  }
}
