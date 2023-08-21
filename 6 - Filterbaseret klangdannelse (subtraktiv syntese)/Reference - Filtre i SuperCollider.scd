// Reference: Filtre i SuperCollider

/* OBS: Pas på din hørelse.
- Undgå cutoff-frekvenser tæt på 0 - brug værdier mellem 20Hz og 20kHz.
- Sæt ikke rq til 0.   */

// Visualiser frekvensspektret for at se hvordan filteret påvirker lyden
FreqScope(server: s).window.alwaysOnTop_(true);


// Lydkilden i næsten alle eksempler er hvid støj
{WhiteNoise.ar * 0.1}.play
// Cutoff-frekvensen er næsten i alle eksempler 440hz

// Low/high pass filter, 2. orden
{LPF.ar(WhiteNoise.ar * 0.5, 440)}.play
{HPF.ar(WhiteNoise.ar * 0.5, 440)}.play

// Low/high pass filter med resonans, 2. orden, 1/Q = 0.1
{RLPF.ar(WhiteNoise.ar * 0.5, 440, 0.1)}.play
{RHPF.ar(WhiteNoise.ar * 0.5, 440, 0.1)}.play

// Low/high pass filter med resonans, 4. orden, 1/Q = 0.1
{BLowPass4.ar(WhiteNoise.ar * 0.5, 440, 0.1)}.play
{BHiPass4.ar(WhiteNoise.ar * 0.5, 440, 0.1)}.play

// Moog low pass VCF filter, "resonans" = 3
{MoogFF.ar(WhiteNoise.ar * 0.5, 440, 3)}.play


// Low/high shelf filter, gain -20dB
{BLowShelf.ar(WhiteNoise.ar * 0.5, 440, 1, -20)}.play
{BHiShelf.ar(WhiteNoise.ar * 0.5, 440, 1, -20)}.play


// Peak EQ filter, 1/Q = 0.8, gain = +30dB
{BPeakEQ.ar(WhiteNoise.ar(0.05), 440, 0.8, 30)}.play

// Band pass filter, 1/Q = 0.5
{BPF.ar(WhiteNoise.ar * 0.5, 440, 0.5)}.play
{Resonz.ar(WhiteNoise.ar * 0.5, 440, 0.5)}.play


// Band reject (notch) filter, 1/Q = 0.9 - bred profil
{BRF.ar(WhiteNoise.ar * 0.5, 440, 0.9)}.play

// Band reject (notch) filter, båndbredde 4 oktaver
{BBandStop.ar(WhiteNoise.ar * 0.5, 440, 4)}.play


// Band pass filter med feedback-resonans, decaytid på 1 sekund
{Ringz.ar(WhiteNoise.ar(0.005), 440, 1)}.play

// Bank af band pass filtre med feedback-resonans og decaytid på 1 sekund
{ Klank.ar(`[[440, 923, 1153, 1723], nil, [1, 1, 1, 1]], Dust.ar(5, 0.5)) }.play;


// Der findes mange andre filtre, fx Comb og Allpass, men de anvendes typisk til andre formål end klangforandring

