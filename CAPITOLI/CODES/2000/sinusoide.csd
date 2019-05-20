<CsoundSynthesizer>
<CsOptions>
  csound -3 -A -o sinusoide.aif
</CsOptions>
<CsInstruments>
sr    = 48000
0dbfs = 1
	instr	sine
out	poscil(1, 440)
 	endin
</CsInstruments>
<CsScore>
i "sine" 0 5
</CsScore>
</CsoundSynthesizer>
