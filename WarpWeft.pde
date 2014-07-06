//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies



// I didn't discuss this example in the lecture
// It is based on AnimationBasic but adds the
// ability to scrub through the animation by
// moving the mouse. 
// I've only commented the new bits to make 
// it clearer.


int currentPosition = 0;
PImage [] images;
PImage mask1, mask2, mask3;
PImage doilie;

Maxim maxi;
AudioPlayer playerWhispers;
AudioPlayer playerKeys;
boolean playing;

void setup()
{
  size(960, 640);
  images = loadImages("vid/ww-", ".png", 352);
  mask1 = loadImage("mask/mask1.png");
  mask2 = loadImage("mask/mask2.png");
  mask3 = loadImage("mask/mask3.png");
  doilie = loadImage("mask/doilie.png");
  maxi = new Maxim(this);
  playerWhispers = maxi.loadFile("sound/whisper.wav");
  playerWhispers.setLooping(true);
  playerKeys = maxi.loadFile("sound/keyboard.wav");
  playerKeys.setLooping(true);
}

void draw()
{  
  imageMode(CORNER);
  float imageWidth = (height*images[currentPosition].width)/images[currentPosition].height;
  image(images[currentPosition], 0, 0, imageWidth, height);
  // I've removed currentPosition+=1
  // because the animation is controlled by 
  // the mouse
  imageMode(CENTER);
  if (mouseY < height/3) {
    image(mask3, mouseX, mouseY);
  } else if (mouseY < 2*height/3) {
    image(mask2, mouseX, mouseY);
  } else {
    image(mask1, mouseX, mouseY);
  }
  image(doilie, mouseX, mouseY);
  if (currentPosition >= images.length)
  {
    currentPosition = 0;
  }
  adjustSoundSpeed();
}

void mousePressed() {
  if (!playing) {
    playerWhispers.cue(0);
    playerWhispers.play();
    playerKeys.cue(0);
    playerKeys.play();
  } else {
    playerWhispers.stop();
    playerKeys.stop();
  }
  playing = !playing;
}


void mouseDragged()
{
  // map the x position of the mouse from 
  // the width of the screen to the length of
  // the animation
  // and use that as the current position
  currentPosition = (int)map(mouseX, 0, width, 0, images.length-1);
  // this makes sure that the currentPosition
  // doesn't go below 0 or above the length 
  // of the animation
  currentPosition = constrain(currentPosition, 0, images.length-1);
}

void adjustSoundSpeed() {
  float ratioX =0;
  ratioX = (float) mouseX / (float) width;
  ratioX *= 2;
  playerWhispers.speed(ratioX);
  float ratioY =0;
  ratioY = (float) mouseY / (float) height;
  ratioY *= 2;
  playerKeys.speed(ratioY);
}


