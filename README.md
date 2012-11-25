volumerb
========
 This work is licensed under the Creative Commons Attribution-ShareAlike 3.0
 Unported License. To view a copy of this license, visit
 http://creativecommons.org/licenses/by-sa/3.0/.

 Forked/derived from original by Jasper Van der Jeugt (jaspervdj);
 large chunks rewritten by Steven Saus (uriel1998)
 This is designed to set your pulseaudio volume settings, muting, and
 default sink from the command line. It will even switch currently
 running streams to the new sink when you switch it!
 Usage will be largely for folks who are using keybinds for volume, etc.
 Originally wrote this to work with ALSA cards - that's what I have.
 (see line 46) but the code at line 45 *should* work for anything
 that's set up as a device in PulseAudio. This is written to work
 with the version of PulseAudio I have on my system - 0.9.22.
 By perusing the online PulseAudio documentation, it looks like this
 *should* still work just fine for later versions. Please ping me one
 way or another so I can properly document/fix it...

Originally stored at https://gist.github.com/1791270 ; I'm not updating that
version any longer.
