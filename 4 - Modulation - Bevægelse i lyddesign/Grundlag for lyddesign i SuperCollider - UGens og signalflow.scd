// Husk at boote lydserveren inden du kører nedenstående eksempler
s.boot;

// Inden du prøver eksemplerne herunder, er det en god idé at køre disse to linjer, så du kan se SuperColliders lydlige output. Flyt evt. vinduerne, så du kan se både bølgeform og frekvensspektrum.
s.scope;
s.freqscope;


/* --- Grundlag for lyddesign i SuperCollider: UGens ---

Dannelse og transformation af lyd er en central del af musik- og lydprogrammering. Redskaber som SuperCollider tillader os at arbejde meget fleksibelt med lyd på et meget detaljeret niveau. Dette kan give os interessante lyddesign til brug i musikalsk komposition, interaktive systemer, musikinstrumenter, lydkunst mm. Samtidig giver arbejdet med lyddesign på dette niveau en glimrende forståelse af principperne bag digital musik- og lydteknologi.

Det grundlæggende redskab for musikalsk lyddesign i SuperCollider og lignende platforme er såkaldte UGens (Unit Generators). At arbejde med musikalsk lyddesign i SuperCollider forudsætter en god forståelse af hvordan UGens fungerer. */


// --- Første trin med SinOsc og venner ---

// UGens bruges inde i såkaldte funktioner, som noteres med {}. Den mest enkle UGen er SinOsc - en ydmyg sinustone-oscillator. Vi afspiller den her ved audio rate (.ar):
{SinOsc.ar}.play;
// Vi kan angive oscillatorens frekvens med et argument lige efter .ar
{SinOsc.ar(220)}.play;
// Vi kan skrue ned for lydstyrken ved at gange med 0.1
{SinOsc.ar(220) * 0.1}.play;

// Vi kan plotte outputtet med .plot i stedet for .play
{SinOsc.ar}.plot;
// Sammenligning af sinusbølger med forskellige parametre
{SinOsc.ar([220, 440, 2000])}.plot;  // frekvenser på 220Hz, 440Hz og 2000Hz
{[SinOsc.ar, SinOsc.ar * 0.1]}.plot; // peak-amplitude på 1 og 0.1
{[SinOsc.ar(440), SinOsc.ar(440, pi/2)]}.plot; // sinusbølge og faseforskudt sinusbølge (cosinus)



// Dette bliver hurtigt lidt monotont, så lad os skabe lidt udvikling ved at modulere sinustonen. Der findes grundlæggende to parametre, man kan manipulere: Tonehøjde (frekvens) og lydstyrke (amplitude).

// Lad os først modulere sinustonens lydstyrke. Det gør vi ganske enkelt ved *at gange med en anden UGen*. I dette eksempel bruger vi LFPulse, som blot bevæger sig mellem 0 og 1 og dermed regelmæssigt tænder og slukker for lyden.
{SinOsc.ar(440) * LFPulse.kr(2) * 0.1}.play;
// Dette ligger til grund for den klangdannelsesteknik som kaldes amplitude modulation (AM) eller ring modulation (RM).

// Vi kan også modulere frekvensen. Her erstatter vi den fast angivne frekvens på 440hz med en anden SinOsc. Det er her nødvendigt at skalere outputtet fra den anden SinOsc, så vi får hørbare frekvenser (over 20hz) - det gør vi med .range, her fra 200hz til 400hz.
{SinOsc.ar(SinOsc.kr(5).range(200, 400)) * 0.1}.play;
// Dette ligger til grund for den klangdannelsesteknik som kaldes frequency modulation (FM).


// Koden begynder nu at blive for kompliceret til at stå på én linje. For at gøre signalflowet mellem de forskellige UGens mere overskueligt og fleksibelt, kan vi derfor dele koden op, så den står på flere forskellige linjer. Dette indebærer, at vi indfører lokale variabler, så vi kan henvise til de forskellige signaler i vores UGen-funktion.
(
{ // Samme lyd som ovenfor, men kildekoden er lettere at læse og justere
	var modulator = SinOsc.kr(5).range(200, 400);
	var sig = SinOsc.ar(modulator);
	sig * 0.1;
}.play;
)


// --- Andre standard bølgeformer ---
// SuperCollider har en række andre standardbølgeformer, som vælges med andre UGens.

// Savtakket bølge
{Saw.ar(440)}.plot;
{Saw.ar(440) * 0.1}.play;

// Kvadratisk bølge
{Pulse.ar(440)}.plot;
{Pulse.ar(440) * 0.1}.play;

// Firkantet bølge, 20% pulsbredde
{Pulse.ar(440, 0.2)}.plot;
{Pulse.ar(440, 0.2) * 0.1}.play;

// "Trekantet" bølge
{VarSaw.ar(440, width: 0.5)}.plot;
{VarSaw.ar(440, width: 0.5) * 0.1}.play;

// Savtakket bølge med top ved 80% af bølgelængden
{VarSaw.ar(440, width: 0.8)}.plot;
{VarSaw.ar(440, width: 0.8) * 0.1}.play;

// Det er muligt at arbejde med mange andre bølgeformer vha. såkaldt wavetables - men det er et lidt mere avanceret emne. Se evt. dokumentationen for UGen'en Osc.
// Vi lærer flere UGens at kende senere i kurset, så vi kan arbejde med lydkilder som støj, samples, live-signaler (mikrofoner eller line-input) osv.
