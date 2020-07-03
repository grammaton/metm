import("stdfaust.lib");

// delay feedback in loop
dfl(t,g) = (+ : de.delay(ma.SR/2,int(t)))~*(min(0.999,g));
process = os.impulse : dfl(1,0.5);
