/**
  * An FFT object is used to convert an audio signal into its frequency domain representation. This representation
  * lets you see how much of each frequency is contained in an audio signal. Sometimes you might not want to 
  * work with the entire spectrum, so it's possible to have the FFT object calculate average frequency bands by 
  * simply averaging the values of adjacent frequency bands in the full spectrum. There are two different ways 
  * these can be calculated: <b>Linearly</b>, by grouping equal numbers of adjacent frequency bands, or 
  * <b>Logarithmically</b>, by grouping frequency bands by <i>octave</i>, which is more akin to how humans hear sound.
  * <br/>
  * This sketch illustrates the difference between viewing the full spectrum, 
  * linearly spaced averaged bands, and logarithmically spaced averaged bands.
  * <p>
  * From top to bottom:
  * <ul>
  *  <li>The full spectrum.</li>
  *  <li>The spectrum grouped into 30 linearly spaced averages.</li>
  *  <li>The spectrum grouped logarithmically into 10 octaves, each split into 3 bands.</li>
  * </ul>
  *
  * Moving the mouse across the sketch will highlight a band in each spectrum and display what the center 
  * frequency of that band is. The averaged bands are drawn so that they line up with full spectrum bands they 
  * are averages of. In this way, you can clearly see how logarithmic averages differ from linear averages.
  * <p>
  * For more information about Minim and additional features, visit http://code.compartmental.net/minim/
  */

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;  
AudioPlayer comp;
FFT fftLin;
float spectrumScale = 4;
FreqBar freqBar = new FreqBar();

void setup()
{
  size(1000, 1000);

  minim = new Minim(this);
  comp = minim.loadFile("beato.wav", 1024);
  
  // loop the file
  comp.loop();
  
  // create an FFT object that has a time-domain buffer the same size as jingle's sample buffer
  // note that this need s to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  fftLin = new FFT( comp.bufferSize(), comp.sampleRate() );
  
  // calculate the averages by grouping frequency bands linearly. use 30 averages.
  fftLin.linAverages( 30 );
  fill(255,255,255,20);
  stroke(0,0,0,40);
}

void draw()
{
    fftLin.forward( comp.mix );
    freqBar.display(fftLin);
}