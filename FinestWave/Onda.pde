import ddf.minim.*;
import ddf.minim.effects.*;



Minim minim;
AudioPlayer groove;
LowPassSP lpf;


void setup()
{
  
  size(displayWidth, displayHeight, P3D);
  
  minim = new Minim(this);
  groove = minim.loadFile("Detroit Swindle - Brotherman.mp3");
  groove.loop();
  // make a low pass filter with a cutoff frequency of 100 Hz
  // the second argument is the sample rate of the audio that will be filtered
  // it is required to correctly compute values used by the filter
  lpf = new LowPassSP(100, groove.sampleRate());
  groove.addEffect(lpf);
}

void draw()
{
  background(224,114,208);
  stroke(0,171,169);
  strokeWeight(60);  // Thicker
  //line(20, 40, 80, 40);
  // we multiply the values returned by get by 50 so we can see the waveform
  for ( int i = 0; i < groove.bufferSize() - 1; i++ )
  {
    float x1 = map(i, 0, groove.bufferSize(), 0, width);
    float x2 = map(i+1, 0, groove.bufferSize(), 0, width);
    line(x1, height/4 - groove.left.get(i)*120, x2, height/4 - groove.left.get(i+1)*50);
    line(x1, 3*height/4 - groove.right.get(i)*120, x2, 3*height/4 - groove.right.get(i+1)*50);
  }
}

void mouseMoved()
{
  // map the mouse position to the range [20, 1000], an arbitrary range of cutoff frequencies
  float cutoff = map(mouseX, 0, width, 700, 50);
  lpf.setFreq(cutoff);
}



