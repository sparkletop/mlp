/* --- Øvelse 2B: Forståelse og brug af Pattern-eksempler ---

- Gennemlæs og afspil nedenstående eksempler på algoritmisk komposition.
- Beskriv i kommentarer hvad hver kodelinje gør. Du kan tjekke hvilke værdier de enkelte patterns genererer ved hjælp af .trace-metoden.
- Kopiér nogle af idéerne og skriv din egen komposition, hvor du varierer teknikkerne.  */


(
// Eksempel 2B.0: Demonstration af nøgler
// Bemærk brugen af nøgler - hvad gør de enkelte nøgler?
// Bemærk også den effekt man opnår med kombination af Pwhite og .stutter
TempoClock.tempo = 120/60;

~trin = [0, 4, 3, 1, 2];
~nodevaerdier = [1/8, 1/8, 1/8, 1/16, 1/16];
Pbind(
	\octave, 5,
	\root, 2,
	\scale, Scale.lydian,
	\degree, Pseq(~trin, inf),
	\mtranspose, Pwhite(-3, 3).stutter(10),

	\dur, Pseq(~nodevaerdier, inf) * 4,
	\legato, 1.2,
	\lag, Pgauss(0, 0.005),

	\db, Pseq([-10, Pgauss(-15, 2, 4)], inf),
).play;
)



(
// Eksempel 2B.1: Skala-udforskning med Pbrown
// Bemærk hvordan Pbrown begrænser størrelsen af tilfældige spring
TempoClock.tempo = 80 / 60;

Pbind(
	\degree, Pbrown(0, 21, 2),
	\octave, 4,
	\ctranspose, Pbrown(-5, 4, 1).stutter(32),
	\dur, 0.2
).play;
)




(
// Eksempel 2B.2: Pentatone mønstre
// Bemærk hvordan tilfældigheden (Pwhite, Pshuf, Pxrand, Pbrown) filtreres og sekvenseres ved hjælp af .stutter og .repeat
TempoClock.tempo = 140 / 60;
Pbind(
	\scale, Scale.minorPentatonic,
	\octave, Pwhite(4, 5).stutter(4),
	\degree, Pshuf([0, 1, 2, 3, 4, 5], 4).repeat,
	\ctranspose, Pxrand([0, 1, 2]).repeat.stutter(32),

	\dur, 0.3,
	\legato, Pseq(Array.interpolation(160, 0.1, 3.5)),

	\db, Pbrown(-20, -17, 0.6)
).play;
)




(
// Eksempel 2B.3: Korte, rytmiske sekvenser
// Bemærk hvordan Pshuf of Pwrand kombineres til at skabe en kombination af tilfældighed og genkendelighed
TempoClock.tempo = 85 / 60;

~melodi = Pbind(
	\scale, Scale.dorian,
	\degree, Pshuf((0..7), 4).repeat,

	\legato, 1.3,
	\dur, Pwrand([
		Pseq( [1/4, 1/4] ),
		Pseq( [1/16, 1/16, 1/8] ),
		Pseq( [1/16, 1/8, 1/16] ),
		Pseq( [Pn(1/24, 6), 1/4] ), // 16.-dels-trioler
		Pseq( [1/2, Rest(1/2)] ),   // Rest angiver pause
	], [40, 40, 30, 5, 5].normalizeSum
	).repeat * 4,
);
~komp = ~melodi.play;
)
~komp.stop;

// Flerstemmig version med Ppar (parallelle Pbinds):
~komp = Ppar(~melodi ! 2).play;
~komp.stop;





(
// Eksempel 2B.4: Rytmiserede og dynamiserede akkorder
// Bemærk hvordan Pwrand og Pxrand anvendes sammen med .stutter og .repeat
TempoClock.tempo = 120 / 60;

Pbind(
	\degree, Pwrand([
		[-14, 0, 2, 4, 6],
		[-12, -1, 1, 4, 5]
	], [0.9, 0.1]).stutter(16).repeat,

	\mtranspose, Pxrand((-5..5)).repeat.stutter(16),

	\dur, 1/16 * 4,
	\legato, 0.7,

	\db, Pseq(Array.interpolation(16, -20, -10), inf),
).play;
)






