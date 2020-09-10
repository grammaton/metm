/* ------------------------------------------------------------------------------------------

SYNTHDEFS FOR KARLHEINZ STOCKHAUSEN: MANTRA (1970)

� For detailed instructions and suggestions, please refer to: http://staff.city.ac.uk/newton.armstrong.1/mantra/.


AUDIO INPUT ROUTINGS

��The microphone signals for the 'ringmod' synthdef should be mixed to two channels, with Piano 1 on channel 1, and Piano 2 on channel 2. The signals appear at software input busses 8 and 9.


AUDIO OUTPUT ROUTINGS

� Ring-modulated signal: software output busses 0 and 1 (Pianos 1 and 2 respectively).
��Dry (microphone) signal: software output busses 2 and 3 (Pianos 1 and 2 respectively).
��Shortwave signal: software outbut bus 4.


CONTROLLER MAPPINGS

� Piano 1 ring modulation frequency control: control bus 0, range: 0..255
� Piano 1 shortwave level control: control bus 2, range: 0..1
� Piano 2 ring modulation frequency control: control bus 1, range: 0..255

� The two arguments to the 'ringmod' synthdef (\pno1Mode, \pno2Mode) should be used to switch mappings between 'normal' and 'extended' modes: \pno1Mode, \pno2Mode: 0 = normal (default), 1 = extended.

------------------------------------------------------------------------------------------ */


SynthDef('ringmod', { |pno1Mode=0, pno2Mode=0|
	var in, src, pno1Mod, pno1Norm, pno1Ext, pno2Mod, pno2Norm, pno2Ext;

	pno1Norm	= [ // pno1 normal mode mapping table (256 slots)
		54!5,
		Array.interpolation(44, 54, 57)[1..42],
		57!5,
		Array.interpolation(16, 57, 58)[1..14],
		58!5,
		Array.interpolation(16, 58, 59)[1..14],
		59!5,
		Array.interpolation(16, 59, 60)[1..14],
		60!5,
		Array.interpolation(16, 60, 61)[1..14],
		61!5,
		Array.interpolation(16, 61, 62)[1..14],
		62!5,
		Array.interpolation(16, 62, 63)[1..14],
		63!5,
		Array.interpolation(16, 63, 64)[1..14],
		64!5,
		Array.interpolation(16, 64, 65)[1..14],
		65!5,
		Array.interpolation(30, 65, 67)[1..28],
		67!5,
		Array.interpolation(16, 67, 68)[1..14],
		68!5,
	].flat;

	pno2Norm = [ // pno2 normal mode mapping table (256 slots)
		46!5,
		Array.interpolation(16, 46, 47)[1..14],
		47!5,
		Array.interpolation(30, 47, 49)[1..28],
		49!5,
		Array.interpolation(16, 49, 50)[1..14],
		50!5,
		Array.interpolation(16, 50, 51)[1..14],
		51!5,
		Array.interpolation(16, 51, 52)[1..14],
		52!5,
		Array.interpolation(16, 52, 53)[1..14],
		53!5,
		Array.interpolation(16, 53, 54)[1..14],
		54!5,
		Array.interpolation(16, 54, 55)[1..14],
		55!5,
		Array.interpolation(16, 55, 56)[1..14],
		56!5,
		Array.interpolation(16, 56, 57)[1..14],
		57!5,
		Array.interpolation(44, 57, 60)[1..42],
		60!5
	].flat;

	pno1Ext = Array.interpolation(256, 2.5.cpsmidi, 6000.cpsmidi); // pno1 extended mode (256 slots)
	pno2Ext = pno1Ext.copy; // pno2 extended mode (256 slots)

	pno1Norm = LocalBuf.newFrom(pno1Norm);
	pno2Norm = LocalBuf.newFrom(pno2Norm);

	pno1Ext = LocalBuf.newFrom(pno1Ext);
	pno2Ext = LocalBuf.newFrom(pno2Ext);

	pno1Mod = Lag3.kr(Index.kr(Select.kr([pno1Norm, pno1Ext], pno1Mode), In.kr(0)), 0.1);
	pno2Mod = Lag3.kr(Index.kr(Select.kr([pno2Norm, pno2Ext], pno2Mode), In.kr(1)), 0.1);

	in = In.ar(8, 2); // audio in
	src = in * SinOsc.ar([pno2Mod, pno1Mod].midicps);
	src = CompanderD.ar(src, -9.dbamp, 1, 0.25, 0.01, 0.66, 6.dbamp);
	src = LPF.ar(src, 6000);
	Out.ar(0, src);	// ring mod
	Out.ar(2, in);	// dry
}).add;


SynthDef('shortwave', {
	var level, sw1, sw1_d, sw1_f, sw1_t, sw2, sw2_d, sw2_t;

	level = Lag3.kr(In.kr(2).linlin(0, 1, -30, 0), 0.1).dbamp;

	sw1_d = Drand(({ rrand(0.02, 0.04) } ! 23), inf);
	sw1_t = Duty.kr(sw1_d, 0, Dseq([1, 0], inf));
	sw1_f = TChoose.kr(sw1_t, [1240, 2400, 2450]) + ({ LFDNoise3.kr(0.3, 40) } ! 3);
	sw1 = SinOsc.ar(Lag3.kr(sw1_f, 0.01), 0, LFDNoise3.kr(0.3).range(-36, -24).dbamp);
	sw1 = sw1 * Lag3.kr(Trig.kr(sw1_t, sw1_d), 0.01);
	sw1 = PitchShift.ar(sw1, 0.1, 1, 0.005, 0.005);

	sw2_d = Dxrand([0.6] ++ ({ rrand(0.02, 0.09) } ! 15), inf);
	sw2_t = Duty.kr(sw2_d, 0, Dseq([1, 0], inf));
	sw2 = SinOsc.ar(960 + LFDNoise3.kr(0.2, 25), 0, -21.dbamp);
	sw2 = sw2 * Lag3.kr(Trig.kr(sw2_t, TWChoose.kr(sw2_t, [0.04, 0.09], [0.7, 0.3])), 0.005);

	Out.ar(4, Mix([sw1, sw2]) * level);
}).add;

a = Synth(\shortwave);
b = Synth(\ringmod);

a.run;
b.run;
