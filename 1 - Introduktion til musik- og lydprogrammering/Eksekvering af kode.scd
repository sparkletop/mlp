/* --- Eksekvering af kode ---

Brugerfladen i SuperCollider er primært kildekode, som noteres og eksekveres ved hjælp af tastaturet.

Man eksekverer kode ved at taste Ctrl+Enter på Windows eller Cmd+Enter på Mac.

Sæt cursoren på en af linjerne herunder og tast Ctrl+Enter (se outputtet i SuperCollider's "Post window"):     */
5 + 10
Scale.major
rrand(0, 100)
"Vekseldominant".postln


// Hvis vi gerne vil gøre mere end én ting ad gangen, kan vi adskille vores instrukser (statements) til SuperCollider ved hjælp af ; (semikolon)
"Et fantastisk tal:".postln; rrand(0, 100).postln


// Ofte er det en god idé at fordele instrukserne over flere linjer
// Hvis vi vil have SuperCollider til at udføre instrukserne umiddelbart efter hinanden, kan vi gøre dette ved hjælp parenteser og ; (semikolon). Læg mærke til hvordan begge linjer herunder bliver udført på én gang:
(
"Endnu et fantastisk tal:".postln;
rrand(50, 100).postln;
)




// Vi eksekverer ofte kode, som genererer lyd. I de tilfælde skal vi først boote SuperColliders lydserver. Dette kan gøres på flere måder, men det mest enkle er at køre denne linje:
s.boot;
// Bemærk, at tallene nederst i højre hjørne bliver grønne, når lydserveren er bootet.


// Derefter kan vi afspille lyde:
{ SinOsc.ar(440) * 0.1}.play
Pbind(\degree, [0, 2, 4]).play

// For at slukke lyden: Tast Ctrl+Punktum på Windows eller Cmd+Punktum på Mac



// Herunder fremgår to kodeblokke. Leg med blokkene på følgende måde:
// 1. Eksekvér kodeblokken for at høre resultatet.
// 2. Prøv løbende at ændre på tallene og eksekvér kodeblokken igen.
// 3. Hvad mon de enkelte linjer i kodeblokkene gør?
(
Pdef(\eksempel1,
	Pbind(
		\degree, Pseq([0, 1, 2, 4], inf),
		\scale, Scale.minor,
		\root, 1,
		\octave, 5,
		\dur, Prand([0.2, 0.3], inf),
		\legato, 1.2,
	)
).play;
)
Pdef(\eksempel1).stop;

(
Ndef(\eksempel2, {
	var freq = 330;
	var lfoFreq = LFTri.kr(0.2).range(1, 16);
	var lfo = LFNoise0.kr(lfoFreq).bipolar(24).round(4).midiratio;
	var sig = Pulse.ar(freq * lfo);
	sig.dup * 0.1;
}).play;
)
Ndef(\eksempel2).stop;

