// Additiv syntese

// Herunder demonstreres formler til dannelse af tre standardbølgeformer (og en enkelt ikke-standard-bølgeform)

// Kilde til formler og udgangspunkt for nedenstående eksempler
"https://thormagnusson.gitbooks.io/scoring/content/PartII/chapter_5.html".openOS

// Vis frekvensspektrum og bølgeform
s.freqscope; s.scope;


(
// Savtakket bølgeform
// Alle overtoner (her blot de første 30)
{
	var sig = Mix.fill(25, {
		arg num;
		var overtone = num + 1;
		SinOsc.ar(220 * overtone) * 0.5 / overtone;
	});
	sig * 0.05;
}.play;
)


(
// Firkantet bølgeform
// "Ulige" overtoner (her blot de første 30)
{
	var sig = Mix.fill(30, {
		arg num;
		var overtone = num * 2 + 1;
		SinOsc.ar(220 * overtone) * 0.5 / overtone;
	});
	sig * 0.05;
}.play;
)


(
// Trekantet bølgeform
// Ulige overtoner (her blot de første 30)
{
	var sig = Mix.fill(30, {
		arg num;
		var overtone = num * 2 + 1;
		SinOsc.ar(440 * overtone, pi/2) * 0.7 / overtone.pow(2);
	});
	sig * 0.1;
}.play;
)


(
// Ikke-standard bølgeform
// Hver tredje overtone (her de første 15)
{
	var sig = Mix.fill(15, {
		arg num;
		var overtone = num * 3 + 1;
		SinOsc.ar(220 * overtone) * 0.5 / overtone
	});
	sig * 0.1;
}.play;
)

