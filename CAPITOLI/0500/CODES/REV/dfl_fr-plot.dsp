import("stdfaust.lib");

// delay feedback in loop
dfl(t,g) = (+ : de.delay(ma.SR/2,int(t)))~*(min(0.999,g));
process = os.osc(lsweep(1,1)) : dflc(12,0.708);
