// --- Øvelse 1A: Grundlæggende programmering --- //


// Nedenstående øvelser omhandler brug af variabler og eksekvering af kildekode.


// 1A.0: Eksekvér nedenstående kodeblok på én gang. Forklar i kommentarer hvad hver enkelt kodelinje gør.
(
"Else Marie Pade".postln;

TempoClock.tempo.postln;

~akkord = [0, 3, 4];
~akkord.postln;

(3+4).postln;
)


// 1A.1: Post dit yndlingstal i SuperColliders post window


// 1A.2: Gem dit yndlingstal under en global variabel, fx ~mitYndlingstal


// 1A.3: Post indholdet af din variabel fra øvelse 1A.2


// 1A.4: Post indholdet af din variabel fra øvelse 1A.3 ganget med 200


/* 1A.5: Find syv fejl
- Find og ret fejlene i de syv eksempler herunder
- Vigtigt: Læs altid fejlmeddelelsen, før du retter fejlen!
- Forklar i en kommentar for hvert eksempel hvad du har rettet og hvad problemet bestod i
- Ryd SuperColliders post window (Ctrl+Shift+p) inden du starter med et nyt eksempel           */

~alder = 32,5;

~skala = Scale.locrian; \\ her gemmer jeg min yndlingsskala

(
10.postln
20.postln
)

(
~resultat = 4 * 10;
~Resultat.postln;
)

(
var Rytme = [1/4, 1/8, 1/8];
Rytme.postln;
)

"57".midicps;

(
~svar = 10 * (4 + (2);
~svar.postln;
)

