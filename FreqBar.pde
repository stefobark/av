class FreqBar{
  FreqBar(){}
  
  void display(FFT fftLin){
    // draw linear averages
    {
      int w = int( width/fftLin.avgSize() );
      for(int i = 0; i < fftLin.avgSize(); i++)
      {
       ellipse(i*w, height/2, (fftLin.getAvg(i)*3) + w, fftLin.getAvg(i)*3);
      }
    }
  }