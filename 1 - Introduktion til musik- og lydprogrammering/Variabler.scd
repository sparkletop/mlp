/* --- Variabler ---

Vi kan opbevare forskellige former for data i computerens hukommelse ved hjælp af variabler
Variabler udgør dermed en slags opbevaringsrum, hvor vi kan gemme ting og finde dem frem igen senere
Dette er ekstremt nytt

Der er to typer variabler: Globale og lokale variabler


Globale variabler
Kan tilgås overalt i et SuperCollider-program
Noteres med "~", direkte efterfulgt af et passende navn    */
~alder;
~kaffekop;

// Alle enkeltbogstaver (a-z) udgør også globale variabler
a;
q;

/*
Lokale variabler
Lan tilgås inden for en afgrænset kodeblok (bestående af () eller {})
Defineres med nøgleordet "var"    */
(
var model = "Fabia";
model.postln; // inden for kodeblokken: viser variablens indhold
)

model.postln; // uden for kodeblokken: giver en fejlmeddelelse





// For at kunne bruge variabler skal vi kunne tilgå og ændre deres indhold

// Vi tilgår indholdet af en variabel
~alder.postln;

// Indholdet på højre side af lighedstegnet gemmes under variablen ~alder:
~alder = 23;

// Efter vi har udført en assignment-operation kan vi tilgå og bruge variablens indhold blot ved at bruge dens navn:
~alder * 100 + 787;

~alder = ~alder * 10 + 7;


// OBS: Variabelnavne SKAL have lille begyndelsesbogstav (fordi klassenavne har stort begyndelsesbogstav)


