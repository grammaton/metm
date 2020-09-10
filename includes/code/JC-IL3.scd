// Constant Frequency Record
(
SynthDef("constant-frequency", { arg out=0;
    Out.ar(out,
    SinOsc.ar(1000,0, 0.2))
}).play;
s.record(duration:900, numChannels:0);
)

// Continuously Variable Frequency Record
(
SynthDef("continuously-variable-frequency", { arg out=0;
    Out.ar(out,
    SinOsc.ar(LFNoise2.ar(0.5).range(400, 4000), 0, 0.2))
}).play;
s.record(duration:900, numChannels:0);
)

// Generator Whine Record
(
SynthDef("generator-whine", { arg out=0;
    Out.ar(out,
        LFBrownNoise2.ar(2000, 1, 0, 0.25) + SinOsc.ar(LFNoise2.ar(1234).range(9751, 10000),0, 0.012345)
    )
}).play;
s.record(duration:900);
)
