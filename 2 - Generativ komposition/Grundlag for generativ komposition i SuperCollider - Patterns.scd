// Husk at boote lydserveren inden du kører nedenstående eksempler
s.boot;



/* --- Grundlag for generativ komposition i SuperCollider: Patterns ---

Generativ komposition kan være kernen i den kreative proces, hvilket ofte er tilfældet inden for computermusikken. Men i bredere forstand er generativ komposition også en tilgang hvormed vi kan generere samples, sekvenser, variationer mm. til brug i mere traditionel komposition.

I SuperCollider udgør de såkaldte patterns et centralt redskab til generativ komposition, og som udgangspunkt er det derfor vigtigt at lære, hvordan man arbejder med patterns. Alle navne på SuperColliders patterns starter belejligt nok med stort P - fx Pbind, Pseq, Pwhite og Prand.


Som udgangspunkt for generativ komposition bruger vi noget, der hedder Pbind:  */
~eksempel = Pbind().play; // kør denne linje for at starte kompositionen
~eksempel.stop;           // og denne linje for at stoppe igen

// Pbind knytter ("binder") musikalske parametre sammen til konkrete begivenhder. I Pbind bruger vi "nøgler", angivet med \degree, \dur, \scale og andre betegnelser til at angive kompositionsmæssige parametre, og vi bruger patterns eller faste værdier til at styre disse parametre.

// Her er et enkelt eksempel, hvor vi med nøglen \degree vælger at knytte den musikalske parameter skalatrin sammen med en fast værdi, nemlig værdien 0 (grundtonen).
(
~eksempel = Pbind(
	\degree, 0,
).play;
)
~eksempel.stop;

// Men ovenstående bliver hurtigt lidt ensformigt at lytte til. I stedet for faste værdier kan vi bruge et pattern til at generere forskellige værdier. Vi starter med Pseq, som vi kan bruge til at generere en sekvens af værdier - stadig skalatrin, fordi vi bruger \degree-nøglen.
(
Pbind(
	\degree, Pseq([0, 1, 3, 4, 7]),
).play;
)

// Alternativt kan vi lade computeren vælge skalatrin for os. Vi kan fx bruge Pwhite til at generere 5 tilfældige skalatrin inden for en oktav (trin 0-7).
(
Pbind(
	\degree, Pwhite(0, 7, 5),
).play;
)

// Vi kan også kombinere Pseq og Pwhite, så vi får en komposition med en blanding af faste og tilfældige parametre.
(
Pbind(
	\degree, Pwhite(0, 7),
	\dur, Pseq([0.25, 0.5, 0.25], 4),
).play;
)

// Herunder får du først en introduktion til Pseq og Pwhite, og til sidst et par vigtige teknikker til komposition med Pbind og patterns




// --- Introduktion til Pseq, en meget fleksibel sequencer ---
( // I Pseq noterer vi først en liste med de elementer, som skal indgå i vores sekvens
// Det gør vi med kantede parenteser, adskilt af kommaer, fx sådan her: [a, b, c]
Pbind(
	\degree, Pseq([0, 1, 2, 7]),
).play;
)

( // Vi kan som det næste argument (det, som står inde i Pbind-parenteserne) angive hvor mange gange sekvensen skal afspilles
Pbind(
	\degree, Pseq([0, 1, 2, 7], 2),
).play;
)

( // I stedet for et bestemt antal gentagelser kan vi gentage uendeligt med nøgleordet inf
~eksempel = Pbind(
	\degree, Pseq([0, 1, 2, 7], inf),
).play;
)
~eksempel.stop;

( // Vi kan vælge at bruge Pseq til at styre mange forskellige parametre
// Her slutter vores komposition, så snart en af vores sekvenser afsluttes
Pbind(
	\degree, Pseq([0, 1, 2, 7, 4, 3, 1, 2]),
	\dur, Pseq([0.25, 0.5, 0.25, 1], inf),
).play;
)

( // Det kan nogle gange være en god idé at bruge variabler til at fordele vores kode over flere linjer
// Eksemplet herunder giver samme resultat som ovenfor
~skalatrin = [0, 1, 2, 7, 4, 3, 1, 2];
~varigheder = [0.25, 0.5, 0.25, 1];
Pbind(
	\degree, Pseq(~skalatrin),
	\dur, Pseq(~varigheder, inf),
).play;
)

( // Elementerne i vores sekvens kan være andre patterns, fx Pwhite, som vi så ovenfor - på den måde kan man blande variation og dynamik ind i sin komposition
Pbind(
	\degree, Pseq([
		-7, 7,             // først et par faste toner
		Pwhite(-3, -1, 3), // derefter tre tilfældige, lidt dybe toner
		Pwhite(2, 4, 3),   // derefter tre tilfældige, lidt højere toner
	], 2).trace,         // afspil hele sekvensen to gange (og vis outputtet med .trace)
	\dur, 0.5,
).play;
)

// Pseq er beslægtet med en række andre listebaserede patterns, fx Pshuf, som sætter elementerne i tilfældig rækkefølge, eller Prand, som vælger tilfældige elementer fra listen.
Pbind(\degree, Pshuf([0, 2, 4, 7], 2)).play; // samme tilfældige sekvens to gange
Pbind(\degree, Prand([0, 2, 4, 7], 8)).play; // tilfældige elementer for hver tone




// --- Introduktion til Pwhite, en tilfældighedsgenerator ---
( // Pwhite genererer tilfældige tal inden for et minimum og et maksimum
~eksempel = Pbind(
	\degree, Pwhite(0, 4),
).play;
)
~eksempel.stop;

( // Pwhite kører som udgangspunkt uendeligt, men vi kan begrænse antallet af tilfældige tal med et yderligere argument
Pbind(
	\degree, Pwhite(0, 4, 3),
).play;
)

// Angiver vi decimaltal i stedet for heltal, får vi også decimaltal som resultat
Pbind(\degree, Pwhite(0, 7, 4).trace).play;
Pbind(\degree, Pwhite(0.0, 7.0, 4).trace).play;

// Ligesom med Pseq kan vi bruge Pwhite til at styre en række forskellige andre parametre
(
~eksempel = Pbind(
	\degree, Pseq([0, 2, 4, 5], inf),
	\db, Pwhite(-30, -20),
	\dur, Pwhite(0.1, 0.2),
	\pan, Pwhite(-1.0, 1.0),
).play;
)
~eksempel.stop;

// Med Pwhite er alle tal mellem minimum og maksimum lige sandsynlige. Dette er ikke altid ønskeligt, fx kan det være mere oplagt, at værdierne tættere på en bestemt grænse er mest sandsynlige - det kan vi gøre med Pexprand og Pgauss
Pbind(\legato, Pexprand(0.01, 1, 8).trace).play; // værdier tættere på minimum (0.01) er mest hyppige
Pbind(\legato, Pgauss(1, 0.1, 8).trace).play; // værdier tættest på middelværdi (1) er mest hyppige
// Det kan også være relevant at bevæge sig gradvist op eller ned med tilfældige spring
Pbind(\degree, Pbrown(-7, 7, 1, 8).trace).play; // små spring
Pbind(\degree, Pbrown(-7, 7, 5, 8).trace).play; // større spring



// --- Vigtige teknikker og methods ifm. patterns ---
// Når vi arbejder med patterns som kompositionsredskaber, er det typisk relevante at justere eller transformere output fra patterns. Det kan fx gøres med almindelige matematiske operationer:
Pbind(\degree, Pseq([0, 1, 2])).play;
Pbind(\degree, Pseq([0, 1, 2]) + 1).play;
Pbind(\degree, Pseq([0, 1, 2]) * 2).play;
Pbind(\degree, Pseq([0, 1, 2]) * Pwhite(1, 3)).play; // Vi kan også lave matematiske operationer med patterns!

// Afrunding er også muligt, fx kan vi fx justere output fra Pwhite til en underdelign i 16.-dele (jf. "quantize" i MIDI-sequencere)
Pbind(\dur, Pwhite(0.25, 1, 10).round(0.25).trace).play;

// Vi kan også bruge nogle specifikke pattern-methods til at gentage outputtet fra patterns på forskellig vis - gæt selv hvad .repeat, .stutter og .clump gør:
Pbind(\degree, Pseq([0, 1, 2]).repeat(3)).play;
Pbind(\degree, Pseq([0, 1, 2]).stutter(3)).play;
Pbind(\degree, Pseq([0, 1, 2]).clump(3)).play;




