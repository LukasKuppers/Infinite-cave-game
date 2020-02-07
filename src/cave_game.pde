//written by:Lukas Kuppers
//mar 20 2019
//project lead: Lukas Kuppers
//highscore: 6758 //legacy version tho

PFont extended;
int highScore = 0;
int prevScore = 0;

BinaryFormatter bf = new BinaryFormatter();

void setup() {
 //fullScreen();
 size(720, 1440);
 background(0);
 stroke(255);
 strokeWeight(4);
 
 File f = new File(sketchPath("PlayerData.dat"));
 if(!f.isFile()) { //if player data doesnt exist create it and give it a default value
   createWriter("PlayerData.dat");
   bf.saveNum(0, "PlayerData.dat");
 }
 highScore = bf.loadNum("PlayerData.dat");
 println(highScore);
 
 extended = createFont("AGENCYB.TTF", 32);
}

 int score;
 float inc;
 float seed = 1;
 float verticalMult;
 float diff;
 float C;
 
 float velocity;
 float grav;
 float acc;
 float ypos;
 float playerRad;
 
 boolean playing;
 
 Button play_button;
 Button exit_button;

void reset() {
 score = 0;
 inc = (float)width / 100000;
 seed = 1;
 verticalMult = 500;
 diff = 200;
 C = ((float)(height / 2) - (verticalMult / 2));
 
 velocity = 0;
 grav = 0.2;
 acc = -0.4;
 ypos = height / 2;
 playerRad = (float)(width * height) / 300000;
 
 playing = false;
 
 play_button = new Button(width / 2, (height / 2) + (height / 8), 350, 150, "START", color(0), 100);
 exit_button = new Button(width / 2, (height / 2) + (height / 4), 300, 100, "EXIT", color(0), 80);
}

void controlPlayer() {
  if(mousePressed) {
    velocity += acc;
  }
  velocity += grav;
  ypos += velocity;
}

void playerCollision(float bound1, float bound2) {
  if(ypos <= bound1 || ypos >= bound2) {
    prevScore = score;
    if(score > highScore) { 
      highScore = score; 
      bf.saveNum(highScore, "PlayerData.dat");
    }
    playing = false;
  }
}

//alternate rendering method to drawCaveLines; should be more efficient
float drawCave(float size, float seed) {
  float noiseX = seed;
  float noiseY = 0;
  float output = 0;
  
  for(int i = 0; i < width / 4; i++) {
    noiseY = (noise(noiseX) * verticalMult) + C;
    float upperBound = noiseY - size;
    float lowerBound = noiseY + size;
    
    float temp = sin(((float)i * 4) / ((float)width / PI));
    float col = 100.0 * temp * temp;
    
    stroke(col);
    strokeWeight(4);
    line(i * 4, upperBound, i * 4, lowerBound);
    
    if(i == width / 8) { output = noiseY; }
    noiseX += inc;
  }
  return output;
}

void drawTitleScreen() {
  drawCave(height / 3, 0);
  
  stroke(255);
  play_button.make();
  exit_button.make();
  if(play_button.clicked()) { playing = true; }
  if(exit_button.clicked()) { exit(); }
  
  textSize(width / 7);
  textAlign(CENTER, CENTER);
  text("CAVERN DASH", width / 2, height / 2 - height/ 5);
  textSize(width / 20);
  text("High Score: " + highScore, width / 2, height / 2);
  text("Score: " + prevScore, width / 2, height / 2 + height / 30);
}

///////////////////////////////////////////////////////////////////
void draw() {
  if(playing == false) { reset(); }
  
  background(0);
  textFont(extended);
  
  if(!playing) {
    drawTitleScreen();
  } else {    
    float mid = 0;
    controlPlayer();
    mid = drawCave(diff, seed);
    playerCollision(mid - diff, mid + diff);
    
    stroke(255);
    ellipse(width / 2, ypos, playerRad, playerRad);
    diff = 1000 / seed + 5;
    seed += inc;
    score++;
    
    textSize(width / 10);
    textAlign(CENTER);
    fill(255);
    text(score, width / 2, height / 8);
    
    if(seed < 2) { 
      textSize(width / 15);
      text("Tap the screen to fly up", width / 2, height - height / 3);
      text("Don't hit the floor or ceiling...", width / 2, height - height / 3.5);
    }
  }
}
