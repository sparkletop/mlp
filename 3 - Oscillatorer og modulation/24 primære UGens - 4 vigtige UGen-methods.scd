/* --- 24 primære UGens - 4 UGen-methods --- */


// Inden du prøver eksemplerne herunder, er det en god idé at køre disse to linjer, så du kan se SuperColliders lydlige output. Flyt evt. vinduerne, så du kan se både bølgeform og frekvensspektrum.
s.scope;
s.freqscope;



// --- 24 primære UGens ---
// Start med at lære disse UGens at kende!


// - Oscillatorer - Band limited
// SinOsc, Saw og Pulse - basale bølgeformer
{SinOsc.ar(440) * 0.1}.play;
{Saw.ar(440) * 0.1}.play;
{Pulse.ar(440) * 0.1}.play;


// - Oscillatorer - Ikke-band limited
// VarSaw - en trekantet bølge, som kan varieres i form
{VarSaw.ar(440) * 0.1}.play;

// LFSaw, LFTri, LFPulse - velegnede som LFO'er
{LFSaw.kr(10)}.plot(0.2);
{LFTri.kr(10)}.plot(0.2);
{LFPulse.kr(10)}.plot(0.2);


// - Støjkilder -
// WhiteNoise og PinkNoise - hvid og pink støj
{WhiteNoise.ar * 0.01}.play;
{PinkNoise.ar * 0.1}.play;

// LFNoise0, LFNoise1 og LFNoise2 - lavfrekvent støj, velegnede som tilfældighedsgeneratorer
{LFNoise1.kr(10)}.plot(1);

// - Envelopes -
// Line og XLine - envelopes med ét segment, lige eller eksponentiel linje
{Line.kr(0, 1, 4, doneAction: 2) * PinkNoise.ar * 0.1}.play;
{XLine.kr(0.01, 1, 4, doneAction: 2) * PinkNoise.ar * 0.1}.play;

// EnvGen - Envelope-generator, bruges sammen med forskellige Envelopes
{EnvGen.kr(Env.perc, doneAction: 2) * PinkNoise.ar * 0.1}.play;


// - Filtre -
// LPF, HPF, BPF - low/high/band pass-filtre
{LPF.ar(PinkNoise.ar, 440) * 0.1}.play;
{HPF.ar(PinkNoise.ar, 440) * 0.1}.play;
{BPF.ar(PinkNoise.ar, 440) * 0.1}.play;

// RLPF, RHPF - low/high pass-filtre med resonans
{RLPF.ar(PinkNoise.ar, 440, 0.01) * 0.1}.play;
{RHPF.ar(PinkNoise.ar, 440, 0.01) * 0.1}.play;

// BLowShelf og BHiShelf - shelf-filtre
{BLowShelf.ar(PinkNoise.ar, 440, db: 20) * 0.05}.play;
{BHiShelf.ar(PinkNoise.ar, 440, db: 20) * 0.05}.play;

// MoogFF - low pass-filter inspireret af filtrene i de klassiske Moog-synthesizere
{MoogFF.ar(PinkNoise.ar, 440) * 0.1}.play;


// - Triggere -
// Impulse og Dust - genererer impulser, regelmæssigt eller tilfældigt fordelt i tid (bruges ofte som et signal, der udløser begivenheder, fx igangsætning af envelopes)
{Impulse.ar(10) * 0.1}.play;
{Dust.ar(10) * 0.1}.play;


// - Delays -
// DelayN, DelayL, DelayC - delays uden feedback
{DelayL.ar(Impulse.ar(0), 1, 1) * 0.1}.play;

// CombN, CombL, CombC - såkaldt "comb filter", fungerer som delay med feedback
{CombL.ar(Impulse.ar(0), decaytime: 10) * 0.1}.play;


// - Buffer/Samples -
// Kør først denne linje for at indlæse et sample i en buffer:
~sample = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

// PlayBuf og BufRd - afspiller indholdet af en buffer
{PlayBuf.ar(1, ~sample, doneAction: 2)}.play;
{BufRd.ar(1, ~sample, SinOsc.ar(0.1).range(0, BufFrames.kr(~sample)))}.play;


// - Stereo-lyd -
// Pan2 - placerer et signal i et stereofelt
{Pan2.ar(SinOsc.ar, 0.5) * 0.1}.play;

// Balance2 - justerer forholdet mellem to kanaler (venstre og højre)
{Balance2.ar(SinOsc.ar(440), SinOsc.ar(443)) * 0.1}.play;


// - Routing -
// Out - sender signal ud af en Synth
{Out.ar(0, SinOsc.ar * 0.1)}.play;



// --- 4 vigtige UGen-methods ---
// Tillader os at justere output fra UGens på forskellige måder

// .ar - generer lydsignal (audio rate), anvendes typisk til lydkilder og filtre
{SinOsc.ar * 0.1}.play;

// .kr - generer kontrolsignal (control rate), anvendes typisk til LFO'er og envelopes
{SinOsc.kr(1)}.plot;

// .range og .exprange - justerer outputtet fra en UGen, så det ligger mellem et nyt min og max
{SinOsc.ar.range(50, 1000)}.plot;     // bemærk Y-aksen
{SinOsc.ar.exprange(50, 1000)}.plot;  // bemærk Y-aksen og bølgeform

// .unipolar og .bipolar - genveje til at skrive .range(0, x) og .range(-x, x)
{SinOsc.ar.unipolar(100)}.plot;  // bemærk Y-aksen, signalet går fra 0 til 100
{SinOsc.ar.bipolar(100)}.plot;   // bemærk Y-aksen, signalet går fra -100 til 100

// .dup - kopierer et signal, så det bliver til et multikanals-signal
{SinOsc.ar(440).dup * 0.1}.play;



// Udvalget af UGens i dette dokument er kraftigt inspireret af Eli Fieldsteels liste over "essential UGens"
"https://uofi.app.box.com/s/1bfva2kan3ntmgey2345goc73snjzpwt".openOS