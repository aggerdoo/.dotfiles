# suckless


      1 dwm - dynamic window manager
      2 ============================
      3 dwm is an extremely fast, small, and dynamic window manager for X.
      4 
      5 
      6 Requirements
      7 ------------
      8 In order to build dwm you need the Xlib header files.
      9 
     10 
     11 Installation
     12 ------------
     13 Edit config.mk to match your local setup (dwm is installed into
     14 the /usr/local namespace by default).
     15 
     16 Afterwards enter the following command to build and install dwm (if
     17 necessary as root):
     18 
     19     make clean install
     20 
     21 
     22 Running dwm
     23 -----------
     24 Add the following line to your .xinitrc to start dwm using startx:
     25 
     26     exec dwm
     27 
     28 In order to connect dwm to a specific display, make sure that
     29 the DISPLAY environment variable is set correctly, e.g.:
     30 
     31     DISPLAY=foo.bar:1 exec dwm
     32 
     33 (This will start dwm on display :1 of the host foo.bar.)
     34 
     35 In order to display status info in the bar, you can do something
     36 like this in your .xinitrc:
     37 
     38     while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
     39     do
     40     	sleep 1
     41     done &
     42     exec dwm
     43 
     44 
     45 Configuration
     46 -------------
     47 The configuration of dwm is done by creating a custom config.h
     48 and (re)compiling the source code.

