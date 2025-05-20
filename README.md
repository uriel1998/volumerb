volumerb | volumesh
========

# What it is

This is designed to set your pulseaudio volume settings, muting, and such from the command line. 

Usage will be largely for folks who are using keybinds for volume, etc.

The ruby version -- which I am not maintaining -- is for pulseaudio. The shell 
version is for pipewire, and uses `wpctl`.

# Installation

## Ruby version (PULSEAUDIO)

If you don't already have ruby installed, you might need to run:

    
    `sudo apt-get install ruby`
   

then download the script:

    ```
    
    wget https://github.com/uriel1998/volumerb/raw/master/volume.rb -O ~/volume.rb
    sudo mv ~/volume.rb /usr/local/bin/volume
    sudo chmod +x /usr/local/bin/volume
    
    ````
    
## Shell version (PIPEWIRE) 
    
    ```
    sudo apt install wireplumber

    wget https://github.com/uriel1998/volumerb/raw/master/volume.sh -O ~/volume.sh
    sudo mv ~/volume.sh /usr/local/bin/volume
    sudo chmod +x /usr/local/bin/volume
    ````

# Usage

Bind a key to `volume up`, `volume down`, `volume toggle`, `volume mute`, and `volume unmute`. 

You can also pass a number between 0-100 to set the percentage of the volume, e.g. 

`volume 35` for 35%, and so on.

Then, presuming you're using Openbox, open up your rc.xml  (probably ~/.config/openbox/rc.xml ) and add this code in the keybinds: 

    ```
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
    ```        

Then reconfigure openbox (or relog) and you should get some results!


# License

This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.

# Attribution

Ruby version forked/derived from original by Jasper Van der Jeugt (jaspervdj)


