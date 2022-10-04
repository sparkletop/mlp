// --- Øvelse 8A: Additiv syntese og multikanalslyd --- //

// Først: Indlæs et sample i en buffer gemt under variablen ~buffer. Hvis du ikke har en lydfil klar selv, kan du bruge den nederste linje herunder i stedet med et indbygget sample fra SuperCollider.
~buffer = Buffer.read(s,      );  // <-- udfyld her med dit eget sample
~buffer = Buffer.readChannel(s, channels: [0], path:   );  // <-- brug denne, hvis dit sample er i stereo

~buffer = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav"); // <-- alternativ


/* 8A.1: Afspilning med PlayBuf

- Afspil dit sample ved dobbelt hastighed
- Afspil dit sample ved halv hastighed
- Afspil den sidste halvdel af dit sample
- Afspil dit sample baglæns (bemærk, kræver justering af enten startPos eller loop og doneAction)   */
(
{
	PlayBuf.ar(
		numChannels: 1,
		bufnum: ~buffer,
		rate: BufRateScale.kr(~buffer) * 1,
		trigger: 1,
		startPos: BufFrames.kr(~buffer) * 0,
		loop: 0,
		doneAction: Done.freeSelf
	)
}.play;
)



/* 8A.2: Afspilningshastighed

- Modulér afspilningshastigheden ved at fjerne //'erne for en række forskellige LFO'er herunder.
- Notér i kommentarer, hvilken effekt de forskellige modulatorer har på den æstetiske oplevelse.
*/
(
{
	var rate = 1; // afkommentér linjerne herunder for eksempler
	// rate = LFPulse.kr(1).range(0.5, 2);
	// rate = SinOsc.kr(1).range(-1, 1);
	// rate = SinOsc.kr(1).range(0.5, 2);
	rate = SinOsc.kr([1, 1.02]).range(1, 1.5);
	// rate = LFNoise1.kr(2.dup).exprange(0.5, 4);
	// rate = Line.kr(-5, 5, 10, doneAction: 2);

	PlayBuf.ar(
		1,
		~buffer,
		BufRateScale.kr(~buffer) * rate,
		loop: 1,
		doneAction: Done.none
	);
}.play;
)



/* 8A.3: Lydcollage-komposition

Fremstil en komposition, som udgør en abstrakt lydcollage med minimalistiske træk.
Kompositionen skal baseres på ét sample og realiseres ved hjælp af nedenstående SynthDef og Pbind.  */

(
SynthDef(\sample, {
	arg amp = 0.1, out = 0, pan = 0,
	rate = 1, startPosition = 0,
	buffer, loop = 0, t_reset = 1,
	drive = 0, cutoff = 20000,
	atk = 0.005, sus = 1, rel = 0.2, gate = 1;

	var sig, env;
	env = EnvGen.kr(Env.asr(atk, sus, rel), gate, doneAction: Done.freeSelf);

	sig = PlayBuf.ar(
		numChannels: 1,
		bufnum: buffer,
		rate: rate * BufRateScale.kr(buffer),
		trigger: t_reset,
		startPos: startPosition.linlin(0, 1, 0, BufFrames.kr(buffer) - 2),
		loop: loop
	);

	sig = (sig * drive.linexp(0, 1, 1, 100)).tanh; // drive/distortion

	sig = LPF.ar(sig, cutoff.clip(20, 20000));

	sig = sig * env;

	sig = Pan2.ar(sig, pan, amp);

	Out.ar(out, sig);
}).add;
)


(
Pbind(
	\instrument, \sample,   // justér koden herunder ⬇

	\buffer, ~buffer,
	\startPos, 1,
	\rate, 1,
	\loop, 1,

	\dur, 1,
	\legato, 1,

	\pan, 0,
	\db, -20,
).play;
)