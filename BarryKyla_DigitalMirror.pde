import processing.video.*;      
PImage img, output;
int spacing = 300;   
Capture camera;   

void setup() {
  size(1280, 720);
  //background(255);
  //frameRate= 100;
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    //println("Couldn't detect any cameras!");
    exit();
  } else {
    //println("Available cameras:");
    //printArray(cameras);
  }
  camera = new Capture(this, cameras[0]);
  camera.start();
}



void drawShape() { 
  pushMatrix();
  beginShape();
  float angle = 100;
  float angleAmt = TWO_PI / 5;
  for (int i=0; i<5; i++) {
    pushMatrix();
    rotate(angle);
    float dist = random(10, 50);
    float x2 = cos(angle) * dist;
    float y2 = sin(angle) * dist;
    float x3 = random(angle) * dist;
    float y3 = random(angle) * dist;
    vertex(x3, y3);
    vertex(x2, y2);
    popMatrix();
    angle += angleAmt;
  }
  endShape(CLOSE);
  popMatrix();
}

void draw() {
  if (camera.available()) {
    //background (0);
    //get a frame
    camera.read();
    camera.loadPixels();    
    for (int y=0; y<height; y+=spacing) {
      for (int x=0; x<width; x+=spacing) {
        int index = (width-x-1) + y*width;
        fill(camera.pixels[index]);
        drawShape();
      }

      //for (int i=0; i<width; i++) {
      //  // if a > 10000
      //  drawShape();
      //  translate(width/10, height/10);
      //}
    }
  }
}