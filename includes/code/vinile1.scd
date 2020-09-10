// Constant Frequency Record
(
SynthDef("constant-frequency", { arg out=0;
    Out.ar(out,
    SinOsc.ar(1000,0, 0.2))
}).play;
s.record(duration:900, numChannels:0);
)