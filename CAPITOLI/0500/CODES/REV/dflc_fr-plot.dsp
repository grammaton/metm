import("stdfaust.lib");
// corrected delay feedback in loop
dflc(t,g) = (+:de.delay(ma.SR/2,int(t-1)))~*(min(0.999,g)):mem;
lsweep(sec,t) = (ma.SR/2) : %(int(*(t):max(1)))~+((1/sec)');
process = os.osc(lsweep(1,1)) : dflc(12,0.708);
