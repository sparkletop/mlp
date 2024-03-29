// --- Øvelse 4: Grundlæggende brug af UGens --- //


/* 4.1: Blip båt

Afspil følgende lyde med peak-amplitude på 0.1:
- Sinustone med frekvens på 220Hz
- Savtakket bølgeform med frekvens på 100Hz
- En firkantet bølgeform med frekvens på 350Hz   */
{SinOsc.ar(   ) * 0.1}.play;
{     * 0.1}.play;
{     * 0.1}.play;




/* 4.2: Visualisering af bølgeformer i tidsdomænet med .plot

SuperCollider kan plotte lyd-outputtet i en graf. Nedenstående linje viser eksempelvis outputtet fra SinOsc, målt over et tidsrum på 10 millisekunder:         */
{ SinOsc.ar }.plot(0.010);
                                        /*
Brug {}.plot-teknikken til at besvare følgende spørgsmål:
- Hvad er forskellen på Pulse.ar(width: 0.5) og Pulse.ar(width: 0.1)?
- Hvad er forskellen på LFNoise0.kr(2), LFNoise1.kr(2) og LFNoise2.kr(2)? (Vi har med LFO at gøre, plot derfor over fx 3 sekunder)                               */
{}.plot;
{}.plot;
{}.plot;
{}.plot;
{}.plot;


// Har du mange ekstra vinduer åbne (fx fra ovenstående øvelse med plots), kan de lukkes på én gang:
Window.closeAll




// 4.3: Visualisering af lyd-output i frekvensdomænet med s.freqscope

// Vi kan vise SuperColliders output i frekvensdomænet sådan her:
s.freqscope;
                                        /*
Brug s.freqscope-teknikken til at besvare følgende spørgsmål:
- Hvad kendetegner overtonespektrene for de forskellige bølgeformer fra øvelse 4.1 og 4.2?
- Hvad styrer musen i nedenstående eksempel?   */
{ Blip.ar(220, MouseX.kr(1,50)) * 0.1 }.play




/* 4.4: Modulation af lydstyrke (amplitude)

Når vi arbejder med volumen, skalerer vi typisk amplituden med en faktor mellem 0 og 1. Sørg derfor altid for, en outputtet fra en LFO, der modulerer volumen, bevæger sig i intervallet 0-1. Det kan gøres let med .unipolar - sammenlign fx disse to bølger:   */
{[LFTri.ar, LFTri.ar.unipolar]}.plot;
                                         /*
Anvend følgende UGens til at modulere amplituden i intervallet 0-1 for en savtakket bølgeform. Modulatorens egen frekvens vælges frit i intervallet 0-20Hz:
- LFTri (trekantet bølgeform)
- LFPulse (firkantet bølgeform)
- LFNoise1 (tilfældig bølgeform, lineær interpolation)
- SinOsc (sinusbølge)         */
{Saw.ar * }.play;
{Saw.ar * }.play;
{Saw.ar * }.play;
{Saw.ar * }.play;




/* 4.5: Modulation af tonehøjde (frekvens)

Når vi modulerer frekvens, er det typisk nødvendigt at justere modulatorens egen frekvens og outputrækkevidde. Brug hertil .range eller .exprange som vist her: */
(
{
	var modulator = LFPulse.ar(5).exprange(500, 1000);
	Saw.ar(modulator) * 0.1;
}.play;
)
                    /*
Brug følgende UGens til at modulere frekvensen for en savtakket bølge mellem 200Hz og 1600Hz.
- LFTri (trekantet bølgeform)
- LFPulse (firkantet bølgeform)
- LFNoise0 (tilfældig bølgeform, ingen interpolation)
- SinOsc (sinusbølge)
Vælg selv en passende frekvens mellem 0Hz og 20Hz til modulatoren. Udfyld koden herunder:    */
(
{ // LFTri som modulator
	var modulator =   ;
	Saw.ar(modulator) * 0.1;
}.play;
)

(
{ // LFPulse som modulator
	var modulator =   ;
	Saw.ar(modulator) * 0.1;
}.play;
)

(
{ // LFNoise0 som modulator
	var modulator =   ;
	Saw.ar(modulator) * 0.1;
}.play;
)

(
{ // SinOsc som modulator
	var modulator =   ;
	Saw.ar(modulator) * 0.1;
}.play;
)




/*  4.6: Bonus-øvelse - modulation af pulsbredde

Modulér pulsbredden for en firkantet bølgeform ved hjælp af en savtakket bølgeform (LFSaw).
- Modulatorens frekvens skal være 0.2.
- Modulatorens output skal skaleres med .range, således at det ligger i intervallet 0.1-0.5. */
(
{
	var modulator =    ;
	Pulse.ar(440, modulator);
}.play;
)
// Hvordan ændrer modulationen på bølgens klang?
// Tjek forandringer i overtonespektret med hjælp s.freqscope

