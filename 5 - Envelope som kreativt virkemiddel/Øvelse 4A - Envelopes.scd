// --- Øvelse 4A: Envelopes --- //


/* 4A.1: Brug af envelopes til modulation af amplitude

Brug følgende envelopes til at modulere amplituden for en firkantet bølgeform:
- Env.perc, Env.linen, Env.sine og Env.triangle
- Env.perc med attack-tid på 200 milisekunder og release-tid på 3 sekunder
- Env.linen med sustain-tid på 2 sekunder
- Env.sine med varighed på 0.1 sekund
- Env.linen med attack-tid på 1 sekunder og sinusbølge-baserede kurver (brug curve: \sine)

Modificér dernæst koden, således at vi også modulerer Pulse-oscillatorens frekvens med envelopen - lad intervallet være 55-440 (dvs. slet 440 og erstat med env.range(...)).
*/
(
{
	var env = EnvGen.kr(    , doneAction: 2); // <-- udfyld her
	Pulse.ar(440) * env * 0.1;
}.play;
)

Env.perc(1, 3).plot; // .plot kan være en nyttig hjælp



/* 4A.2: Hjemmelavede envelopes

Definér din egen envelope med mindst tre segmenter. Envelopen skal anvendes til at modulere frekvens. Trin og tidsintervaller vælges frit.
*/
(
~frekvensEnvelope = Env(
	// ⬇ udfyld her
	[   ], // trin/værdier
	[   ], // varigheder af tidsintervaller
	\exp
);
{
	var freq = EnvGen.kr(~frekvensEnvelope);
	var env = EnvGen.kr(
		Env.perc(releaseTime: ~frekvensEnvelope.duration),
		doneAction: Done.freeSelf
	);
	SinOsc.ar(freq) * env * 0.1;
}.play;
)



/* 4A.3: Vedvarende envelopes

Modificér nedenstående kode, så følgende overholdes:
- Der går et halvt sekund, før vi rammer maksimal lydstyrke.
- Når vi lukker gaten, går der 3 sekunder før tonen er fadet ud.  */
(
~tone = {
	arg gate = 1;
	var env = EnvGen.kr(
		Env.asr(  ), // <-- udfyld her
		gate: gate,
		doneAction: Done.freeSelf
	);
	Pulse.ar(440) * env * 0.1;
}.play;
)
// Her lukker vi gaten (dvs. fortæller, at envelope-generatoren skal gå videre til release-segmentet):
~tone.set(\gate, 0);



/* BONUS: 4A.4: Hjemmelavede LFO'er med Env.circle

Design din egen LFO ved hjælp af Env.circle. Se et eksempel i SuperColliders dokumentation eller i dokumentet vedr. envelopes.
*/
(
{
	var freq = EnvGen.kr(
		Env.circle(
			[   ],  // trin/værdier
			[   ],  // varigheder af tidsintervaller
			\exp
		)
	);
	Pulse.ar(freq) * 0.1;
}.play;
)


