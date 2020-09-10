// Continuously Variable Frequency Record
(
SynthDef("continuously-variable-frequency", { arg out=0;
    Out.ar(out,
    SinOsc.ar(LFNoise2.ar(0.5).range(400, 4000), 0, 0.2))
}).play;
s.record(duration:900, numChannels:0);
)