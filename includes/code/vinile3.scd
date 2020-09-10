// Generator Whine Record
(
SynthDef("generator-whine", { arg out=0;
    Out.ar(out,
        LFBrownNoise2.ar(2000, 1, 0, 0.25) + SinOsc.ar(LFNoise2.ar(1234).range(9751, 10000),0, 0.012345)
    )
}).play;
s.record(duration:900);
)