import("stdfaust.lib");
// all-pass filter
apf(t,g) = _ <: *(ma.neg(min(0.999,g))) + (dflc(t,g)*(1-(g*g)));
process = apf(1,0.5);
