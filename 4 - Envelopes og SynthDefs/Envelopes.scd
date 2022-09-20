// Husk at boote lydserveren inden du kører nedenstående eksempler
s.boot;


/* --- Udvikling over tid med envelopes ---

Et meget væsentligt aspekt af enhver form for lyddesign angår hvordan lyd udvikler sig og forandres over tid. Herunder tager vi hul på dette emne ved at introducere til såkaldte envelopes og pege på nogle forskellige anvendelser af envelopes i lyddesign.
*/


/* --- Line og XLine - enkle envelope-generatorer ---
Line og XLine er UGens, som genererer en henholdsvis lineær og eksponentiel udvikling fra ét punkt til et andet. Her er et eksempel, hvor envelopen bevæger sig fra 100 til 800 i løbet af 1 sekund: */
{Line.kr(100, 800, 1)}.plot(1);
{XLine.kr(100, 800, 1)}.plot(1);

// Denne udvikling kan vi fx bruge til at styre frekvensen for en oscillator
{SinOsc.ar(Line.kr(100, 800, 1)) * 0.1}.play;
// Eller langsommere og eksponentielt
{SinOsc.ar(XLine.kr(100, 800, 5)) * 0.1}.play;
// Eller hurtigere
{SinOsc.ar(XLine.kr(100, 800, 0.050)) * 0.1}.play;


/* --- Env og EnvGen - envelopes for enhver smag ---

Line og XLine genererer envelopes med ét segment (dvs. ét tidsinterval med ét start- og slutpunkt). Envelopes har imidlertid meget ofte mere end ét segment og kan have meget forskellige former (kurve-krumning). For at definere mere komplekse envelopes bruger vi Env-klassen. Her er fx en standard-envelope med to segmenter, Env.perc (bemærk, at første segment er meget kort - 10ms):  */
Env.perc.plot;

// De to segmenter i Env.perc hedder attack og release, og vi kan specificere deres varighed med argumenter - her en attack-tid på 1 sekund og en release-tid på 4 sekunder:
Env.perc(1, 4).plot;

// Vi kan også vælge bare at justere release-segmentet:
Env.perc(releaseTime: 10).plot;

// Eller segmenternes krumning (curve):
[Env.perc(curve: 5), Env.perc(curve: 0), Env.perc(curve: -5)].plot;


/* Når vi skal bruge en envelope som Env.perc i vores lyddesign, skal vi tage højde for, at Env blot specificerer en envelope-form - en Env er ikke en UGen!

For at bruge Env-baserede envelopes skal vi anvende EnvGen, som er en envelope-generator-UGen. Vi fortæller EnvGen, at vi ønsker en Env.perc sådan her: */
{EnvGen.kr(Env.perc)}.plot(1);

// Vi kan nu bruge envelope-generatoren til at modulere lydstyrken for en oscillator. Som nævnt i kursusgang 3 gør vi dette ved ganske enkelt at gange outputtet fra oscillatoren med outputtet fra envelope-generatoren:
{PinkNoise.ar * EnvGen.kr(Env.perc) * 0.1}.play;


// Inden vi går videre, er det vigtigt at skrive sig bag øret, at EnvGen ofte noteres implicit (skjult). Følgende to linjer har præcis samme resultat, og man kan selv vælge hvilken form man foretrækker:
{PinkNoise.ar * EnvGen.kr(Env.perc) * 0.1}.play;
{PinkNoise.ar * Env.perc.kr * 0.1}.play;


// Det er ofte nyttigt at skille disse elementer ad på forskellige linjer og bruge lokale variabler:
(
{
	var env = EnvGen.kr(Env.perc);
	var sig = PinkNoise.ar;
	sig * env * 0.1;
}.play;
)

// Når vi gemmer envelope-generatoren under en lokal variabel, kan vi efterfølgende bruge den til flere forskellige formål. Fx kan vi styre både tonehøjde og lydstyrke med den samme envelope, således at flere parametre udvikler sig over tid i takt med hinanden - dette kan give anledning til yderst interessante lyddesign, alt efter hvilke parametre man modulerer med envelopen!

// Lad os tage et eksempel: Envelopen herunder skaleres med .exprange, så den bevæger sig mellem 220 og 440 i stedet for 0 og 1.
(
{
	var env = EnvGen.kr(Env.perc(0.1, 5));
	var sig = Pulse.ar(env.exprange(440, 880));
	sig * env * 0.1;
}.play;
)



/* --- Design dine egne envelopes ---
I SuperCollider er der rig mulighed for at opfinde nye envelopes (ud over de indbyggede envelopes, som vi kigger på nedenfor). Vi kan definere vores egne envelopes med Env.new på følgende måde:
- Først angiver vi en liste med niveauer, som udgør start- og slutpunkter for de enkelte segmenter.
- Dernæst angiver vi en liste med varigheder af de enkelte segmenter. Denne liste vil altid være ét element kortere end listen med niveauer.
- Til sidst kan vi vælge at angive en eller flere såkaldte kurve-værdier, som definerer hvordan segmenterne skal være formet - lige, krum, eksponentiel etc. Læs nærmere herom i dokumentationen for Env.

Her er et par eksempler: */
Env.new([0, 1, 0], [0.2, 1]).plot;
Env.new([0, 1, 0.2, 0.5, 0], [0.1, 1, 0.3, 3], \exp).plot;
Env.new([500, 800, 400, 150], [1, 2, 3], [2, 5, -3]).plot;

/* Lad os definere en ny envelope med tre segmenter, som vi vil bruge til at styre frekvensen for en oscillator:
- Først går vi fra 200 til 400, derefter til 100, og til sidst til 50.
- Første segment varer 10 milisekunder, de sidste to segmenter varer 250 milisekunder hver.
*/
( // Definér og plot envelopen
~frekvensEnvelope = Env.new(
	[200, 800, 100, 50], // niveauer
	[0.01, 0.25, 0.25]   // segment-varigheder
);
~frekvensEnvelope.plot;
)

( // Brug envelopen til at styre frekvens for en oscillator
{
	var env = EnvGen.kr(~frekvensEnvelope);
	SinOsc.ar(env) * 0.1;
}.play;
)

// Envelopes kan ligesom LFO'er bruges til at modulere mange forskellige parametre - fx cutoff-frekvenser, detuning, LFO-frekvenser/-amplituder osv. Her er et særligt redskab Env.circle, som giver os mulighed for at loope envelopes, så de fungerer som en slags oscillator!

// Env.circle har næsten præcis samme syntaks som Env.new, vi skal blot tilføje en enkelt varighed til listen med segmentvarigheder - nemlig den tid det tager at vende tilbage til begyndelsen af envelopen, når vi looper.
(
{ // Samme eksempel som ovenfor, dog tilpasset Env.circle med et ekstra tidsinterval (0.24)
	var env = EnvGen.kr(
		Env.circle(
			[200, 800, 100, 50],
			[0.01, 0.25, 0.25, 0.24]
		)
	);
	SinOsc.ar(env) * 0.1;
}.play;
)

// Vi kan endda modulere segment-varighederne med en LFO eller en anden envelope. Dertil bruger vi timeScale-argumentet i EnvGen - her blot en simpel Line, hvor varighederne bliver skaleret med først en faktor 6 og til sidst en faktor 0.2:
(
{
	var env = EnvGen.kr(
		Env.circle(
			[200, 800, 100, 50],
			[0.01, 0.25, 0.25, 0.24]
		),
		timeScale: Line.kr(6, 0.2, 10));
	SinOsc.ar(env) * 0.1;
}.play;
)




/* --- Standard-envelopes - med og uden gate ---
Ud over Env.perc og Env.new/Env.circle har vi adgang til en række standard-envelopes. Her kan vi skelne mellem to slags envelopes:

- Den ene type er selv-afsluttende envelopes (fx Env.perc). Disse envelopes varer præcis så lang tid som det tager at gennemløbe de segmenter, de består af. */
[Env.perc, Env.triangle, Env.linen, Env.sine].plot;  /*

- Den anden type envelope er vedvarende (sustaining) envelopes, som bliver hængende mellem to segmenter, indtil de bliver bedt om at gå videre. Det er fx ofte tilfældet med et keyboard, hvor tonen begynder at klinge, når vi trykker tangenten ned, og fortsætter indtil vi slipper tangenten igen. Her er nogle af de almindelige vedvarende envelopes: */
[Env.asr, Env.adsr, Env.cutoff, Env.dadsr].plot;

/* Vi vender tilbage til implementering af vedvarende envelopes, når vi gennemgår Synth og SynthDef. */




/* --- En vigtig pointe: Hvad er doneAction? ---
Når vi afspiller en tone, oprettes der en såkaldt Synth-node på lydserveren. Vi kan få vist de aktive Synths på denne måde (nedenstående åbner et nyt vindue): */
s.plotTree;

// Hvis du kan se, at du har en række gamle Synths liggende, kan du fjerne dem med Ctrl-Punktum/Cmd-Punktum.

// Vi beder typisk SuperCollider om at fjerne Synths fra lydserveren automatisk, når den lyd de producerer har klinget ud. Det kan vi bl.a. gøre ved hjælp af envelope-generatorens såkaldte doneAction. Sammenlign disse to eksempler (hold øje med Node Tree-vinduet og bemærk hvilken forskel vores doneAction: Done.freeSelf gør):
{PinkNoise.ar * EnvGen.kr(Env.perc) * 0.1}.play;
{PinkNoise.ar * EnvGen.kr(Env.perc, doneAction: Done.freeSelf) * 0.1}.play;

// doneAction: Done.freeSelf betyder altså, at vores Synth-node fjernes automatisk, når envelopen er afsluttet.

// Som tommelfingerregel er det en god idé at bruge doneAction: Done.freeSelf til den envelope, som styrer tonens lydstyrke over tid. Dette betyder nemlig, at vi ikke får ophobet gamle Synths på lydserveren.


// Bemærk også, at "doneAction: 2" og "doneAction: Done.freeSelf" betyder det samme - at Synth'en skal fjernes fra lydserveren, når envelopen er slut:
{PinkNoise.ar * EnvGen.kr(Env.perc, doneAction: Done.freeSelf) * 0.1}.play;
{PinkNoise.ar * EnvGen.kr(Env.perc, doneAction: 2) * 0.1}.play;

// Om man bruger "doneAction: 2" eller "doneAction: Done.freeSelf" er således helt valgfrit. Førstnævnte er kortest at skrive, men sidstnævnte er umiddelbart lettest at forstå, når man man læser koden.




