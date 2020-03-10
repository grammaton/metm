import("stdfaust.lib");
sweep = +(0.125)~_;
process = sin(sweep*ma.PI);
