volumerb
========

# What it is

This is designed to set your pulseaudio volume settings, muting, and default sink from the command line. It will even switch currently running streams to the new sink when you switch it!

Usage will be largely for folks who are using keybinds for volume, etc.

# Installation

If you don't already have ruby installed, you might need to run:

	sudo apt-get install ruby

then download the script:

	wget https://github.com/uriel1998/volumerb/raw/master/volume.rb -O ~/volume.rb
	sudo mv ~/volume.rb /usr/local/bin/volume
	sudo chmod +x /usr/local/bin/volume

Then, presuming you're using Openbox, open up your rc.xml  (probably ~/.config/openbox/rc.xml ) and add this code in the keybinds: 


	   <keybind key="XF86AudioRaiseVolume">
		  <action name="execute">
			<execute>/usr/local/bin/volume up</execute>
		  </action>
		</keybind>
		<keybind key="XF86AudioLowerVolume">
		  <action name="execute">
			<execute>/usr/local/bin/volume down</execute>
		  </action>
		</keybind>
		<keybind key="XF86AudioMute">
		  <action name="execute">
			<execute>/usr/local/bin/volume toggle</execute>
		  </action>
		</keybind>

Then reconfigure openbox (or relog) and you should get some results!


# License

This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.

# Attribution

 Forked/derived from original by Jasper Van der Jeugt (jaspervdj)


# Notes

Originally wrote this to work with ALSA cards - that's what I have. (see line 46) but the code at line 45 *should* work for anything  that's set up as a device in PulseAudio. This is written to work with the version of PulseAudio I have on my system - 0.9.22.  By perusing the online PulseAudio documentation, it looks like this *should* still work just fine for later versions. Please ping me one way or another so I can properly document/fix it... 

Originally stored at https://gist.github.com/1791270 ; I'm not updating that version any longer.