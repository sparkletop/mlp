// --- Øvelse 9A: Granular syntese --- //

// Først: Indlæs et sample i en buffer gemt under variablen ~buffer. Hvis du ikke har en lydfil klar selv, kan du bruge den nederste linje herunder i stedet med et indbygget sample fra SuperCollider.

// OBS: Til øvelserne skal der anvendes et MONO-sample!
~buffer = Buffer.read(s,      );  // <-- udfyld her med dit eget sample i MONO
~buffer = Buffer.readChannel(s, channels: [0], path:   );  // <-- brug denne, hvis dit sample er i stereo, så indlæser vi blot den første kanal

// Hvis du ikke har et sample klar til brug:
~buffer = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav"); // <-- alternativ



/* 9A.1: Grain-produktion med GrainBuf
Justér nedenstående kodeblok, således at:

- Der kommer overlap mellem de enkelte grains

- Følgende parametre moduleres af LFO'er, fx SinOsc, XLine, EnvGen, LFNoise, LFTri etc.:
  - dur
  - rate
  - pos
  - pan

- Dust anvendes som trigger i stedet for Impulse

Hvordan påvirker disse parametre og modulationer lyden? Hvilke æstetiske muligheder kan du se i denne form for sample-manipulation?    */
(
{
	GrainBuf.ar(
		numChannels: 2,
		trigger: Impulse.ar(200),
		dur: 0.025,
		sndbuf: ~buffer,
		rate: BufRateScale.kr(~buffer) * 1,
		pos: MouseX.kr(0, 1),
		pan: 0
	)
}.play;
)



/* 9A.2: Granular komposition

Anvend den udleverede \cloud-SynthDef til at fremstille følgende lyde:
- En alternativ fortolkning af et sample (tempo, tonehøjde)
- En minimalistisk lydtekstur (små udviklingstrin over tid)
- En kaotisk lydtekstur

For at komme i gang med opgaven kan du eventuelt tage afsæt i de eksempler, som findes nederst i \cloud-SynthDef-dokumentet.
*/
