/* --- Methods ---

SuperColliders funktionalitet er knyttet til såkaldte "methods"

I kode kan man ofte se disse methods lige efter punktummer.
Her er et par eksempler:   */
"Hello world".postln;  // method'en .postln viser objekter i post window, i dette tilfælde et stykke tekst
69.midicps;            // method'en .midicps omregner fra MIDI-tonehøjde til Hertz
7.midiratio;           // method'en .midiratio omregner en given tonal afstand i halvtoner til skaleringsfaktor i frekvens
7.even;                // method'en .even fortæller om et givet tal er lige elller ej
[1, 2, 3].reverse;     // method'en .reverse vender en liste om
[1, 2, 3].scramble;    // method'en .reverse vender en liste om
TempoClock.tempo;      // TempoClocks method .tempo angiver tempo i BPS


// Class methods bruger vi direkte på "classes"
Pbind.new();           // genererer en ny Pbind
Array.interpolation(); // genererer et nyt array ved hjælp af interpolation
TempoClock.tempo;      // finder eller angiver tempo


// Instance methods bruger vi på "instances", dvs. konkrete forekomster af bestemte typer af objekter
Pbind().play;              // vi afspiller en ny Pbind (der er tale om en konkret forekomst på grund af implicit .new)
{PinkNoise.ar * 0.1}.play  // vi afspiller noget pink støj (boot serveren for lyd)
3.sqrt;                    // vi beder om kvadratroden af tallet 3


// En method, som vi bruger hele tiden: .new
// .new skaber et nyt objekt (en "instance" eller forekomst) af den klasse, man angiver før punktummet
Scale.new() // - en ny skala
Pseq.new()  // - opskrift på en ny sekvens
Prand.new() // - opskrift på en ny tilfældighedsgenerator


// .new er så almindeligt, at der findes en genvej - nemlig helt at udelade .new. Derfor giver disse to udtryk samme resultat:
Pwhite.new(0, 10, 5)
Pwhite(0, 10, 5)
// .new er her implicit - men angives eksplicit i SuperColliders dokumentation


/*
I SuperColliders dokumentation kan man læse nærmere om de fleste methods, som knytter sig til forskellige klasser.
- Slår man en klasse op (fx Array, Pwhite, SinOsc etc.), vil man kunne se de forskellige class methods og instance methods samt hvordan de bruges
- Slår man en method op (fx .new, .play, .reverse etc.), vil man kunne se de forskellige klasser, som har denne method tilknyttet (klik på klassen for at se hvordan fx .new anvendes inden for den specifikke klasse)    */
Array
Pwhite
SinOsc
.new
.play
.reverse
