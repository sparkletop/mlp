// Nedenstående eksempler er inspireret af Andrea Pejrolo og Scott B. Metcalfes "opskrifter" på subtraktiv syntese. Læs nærmere om bogen her:
"https://global.oup.com/academic/product/creating-sounds-from-scratch-9780199921898".openOS



(
// En simpel "klarinet"-lyd, jf. Pejrolo & Metcalfe s. 119
SynthDef(\clarinet, {
	arg freq = 440, gate = 1;

	// lydkilde: firkantet bølgeform med mulighed for glissando via .lag (sliding)
	var oscillator = Pulse.ar(freq.lag(0.025));
	// resonant low pass-filter anvendes til klanglig justering
	var sig = RLPF.ar(oscillator, 1200, 0.5);

	// lydstyrke styres med en envelope
	sig = sig * EnvGen.kr(Env.asr, gate, doneAction: Done.freeSelf) * 0.1;
	Out.ar(0, sig.dup);
}).add;
)

(
Pmono(\clarinet,
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 2),
	\octave, Pseq([4, 5], inf).stutter(2),
	\dur, 0.15,
).play;
)



(
// Simpel 80'er-strings, jf. Pejrolo & Metcalfe s. 120
SynthDef(\stringz, {
	arg freq = 440, gate = 1;

	// lydkilde: to savtakkede bølgeformer, den ene med en smule detuning
	var oscillator = Saw.ar(freq) + Saw.ar(freq * 0.9971);

	// cutoff styres af oscillatorens frekvens samt af en envelope
	var cutoff = freq * EnvGen.kr(
		Env.adsr(0.2, 0.7),
		gate,
		levelBias: 1
	);
	var sig = RLPF.ar(oscillator, cutoff, 0.4);

	// lydstyrke styres med en separat envelope
	sig = sig * EnvGen.kr(Env.adsr(0.2, 0.4), gate, doneAction: Done.freeSelf) * 0.1;
	Out.ar(0, sig.dup);
}).add;
)

( // en akkordrække
Pbind(
	\instrument, \stringz,
	\degree, [-7, 0, 2, 4, 6, 8],
	\mtranspose, Pseq([3, 1, 0]),
	\dur, 2,
).play;
)



(
// Syntetisk lilletromme, jf. Pejrolo & Metcalfe s. 121-122
{
	// trommens krop (vi kan "stemme" trommen ved at justere start- og slutværdier for XLine)
	var resonance = VarSaw.ar(XLine.kr(220, 110, 0.275));

	// trommens seiding (metaltråde monteret på undersiden) simuleres med hvid støj
	var snares = WhiteNoise.ar;

	var sig = resonance + snares;

	// Et dynamisk low pass filter simulerer trommens klanglige forandring over tid
	sig = LPF.ar(sig, XLine.ar(8000, 2500, 0.010));

	// sidst men ikke mindst en envelope til at styre volumen
	sig = sig * EnvGen.ar(Env.perc(0.0005, 0.150), doneAction: 2);
	Out.ar(0, sig);
}.play;
)
