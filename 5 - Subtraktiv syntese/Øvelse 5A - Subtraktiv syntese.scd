// --- Øvelse 5A: SUbtraktivs --- //



/* 4A.1: Vælg og indstilling af filtre

Brug følgende filtre til at modificere klangen af hvid støj
- Et low pass-filter med cutoff-frekvens på 1000hz
- Et high pass-filter med cutoff-frekvens på 800hz
- Et band pass-filter med centerfrekvens på 500hz
- Et resonerende low pass-filter med cutoff-frekvens på 800hz og rq-værdi på 0.1
*/
(
{
	var source = WhiteNoise.ar;
	var sig =   ; // <-- udfyld her
	sig * 0.1;
}.play;
)



/* 4A.2: Modulation af filtre

Brug følgende kilder til at modulere cutoff-frekvensen for et low pass-filter, så cutoff-frekvensen bevæger sig mellem 500hz og 1000hz (brug .range eller .exprange):
- En LFO (vælg selv bølgeform og passende frekvens)
- En XLine-envelope, vælg selv tidsinterval
- Den allerede noterede envelope
*/
(
{
	var source = WhiteNoise.ar;
	var env = EnvGen.ar(Env.linen(0.5, 0.5, 2), doneAction: Done.freeSelf);
	var cutoff =     ; // <-- udfyld her
	var sig = LPF.ar(source, cutoff);
	sig * env * 0.1;
}.play;
)



/* 4A.3: Fleksibel, subtraktiv SynthDef

Skriv en SynthDef, som gør brug af subtraktiv syntese. SynthDef'en skal overholde følgende krav:

- Lydkilden er en oscillator med en periodisk bølgeform og et righoldigt spektrum (fx en savtakket eller firkantet bølge)

- Oscillatorens frekvens styres af et argument (freq) med default-værdi 440hz

- Lydkildens lydstyrke styres af en envelope-generator - vælg selv en passende envelope med doneAction: Done.freeSelf

- Lydkildens klang modificeres af et resonant low pass filter (RLPF)

- Filterets cutoff-frekvens er automatisk 2 oktaver højere end oscillatorfrekvensen

- Filterets rq-værdi er 0.5

- Skriv en Pbind-komposition, hvor

Bonus:
- Justér koden, således at filterets cutoff-frekvens bevæger sig i takt med envelope-generatoren, fra 2 til 3 oktaver over oscillatorfrekvensen (og tilbage igen)

- Justér koden, så du kan styre envelopens parametre (segment-tider) vha. SynthDef-argumenter

- Justér koden, således at filterets rq-værdi gøres fleksibel vha. et SynthDef-argument


- Skriv en Pbind-komposition, hvor ovenstående variationsmuligheder demonstreres
*/
(
SynthDef(\subtraktor, { // udfyld herunder ⬇



	Out.ar(0, sig);
}).add;
)

