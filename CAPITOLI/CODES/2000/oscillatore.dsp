import("math.lib");

// waveform

tablesize = 65536;
samplingfreq = fconstant(int fSamplingFreq, <math.h>);
time = (+(1)~_ ) - 1;
sinwaveform = float(time)*(2.0*PI)/float(tablesize) : sin;




//­­­­­­­­­­­­­­­­­­­­ oscillator

decimal(x) = x - floor(x);
phase(freq) = freq/float(samplingfreq) : (+ : decimal) ~ _ : *(float(tablesize));
osc(freq) = rdtable(tablesize, sinwaveform, int(phase(freq)) );

//­­­­­­­­­­­­­­­­­­­­­ process

vol = hslider("volume", 0, 0, 1, 0.01);
freq = hslider("freq", 1000, 0, 24000, 0.1);
process = vgroup("Oscillator", osc(freq) * vol);
