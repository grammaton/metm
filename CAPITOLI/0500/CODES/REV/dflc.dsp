import("stdfaust.lib");
// corrected delay feedback in loop
dflc(t,g) = (+:de.delay(ma.SR/2,int(t-1)))~*(min(0.999,g)):mem;
process = dflc(1,0.5);
