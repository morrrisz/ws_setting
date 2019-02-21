xmodmap -e 'keysym F1 = Help'

eval `svenv -env`			# SunView binary compatibility
#
# To run the Motif Window Manager, uncomment the line with "mwm" and
# place a comment character in front of "olwm -3 &".
#
#mwm 2> /dev/null&
# xset bc
xhost +
xset +fp tcp/plus15:7001
xset fp+ /usr/local/cfonts
xset fp+ /eda/RealPC/fonts/SPARC
xset fp rehash
xset s off
#/usr/bin/X11/mwm & > /dev/null &	# Motif Window Manager
#olwm -3 &				# OpenLook Window Manager
#
# Execute the .openwin-init file for more customizations
#
if [ -x $HOME/.openwin-init ]; then
    $HOME/.openwin-init			# Custom OpenWindows tools
else
    $OPENWINHOME/lib/openwin-init   	# Default OpenWindows tools
fi
mwm & 					# Motif Window Manager
#xv -root -quit $HOME/.bg.xpm
wait

#
##[[ if ~/.Xreousrces ]] && xrdb -merge -I$HOME ~/.Xresources
