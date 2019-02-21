#################################################################################
#
#                       Sunplus CAD Environment - 2005.06 (2005-06-02)
#
#  The following commands will setup a basic CAD environment.
#  Please DO NOT MODIFY
#
#################################################################################

setenv OSNAME `uname -s`
setenv OSVERSION `uname -r`
tty >& /dev/null
if ( $status ) set NOTTY

# man csh to learn more details
set nonomatch
unset autologout

setenv LOCAL_HOME /usr/local

setenv X11HOME $LOCAL_HOME/X11R6

if ( $OSNAME == HP-UX ) then
	setenv OPENWINHOME /usr/local/xview		
else if ( $OSNAME == Linux ) then
  setenv OPENWINHOME /usr/X11R6
else
	setenv OPENWINHOME /usr/openwin		 
endif
setenv XKEYSYMDB $X11HOME/lib/X11/XKeysymDB
setenv XAPPLRESDIR /usr/lib/X11/app-defaults:${X11HOME}/lib/X11/app-defaults:$LOCAL_HOME/lib/X11/app-defaults
setenv MANPATH /usr/man:/usr/local/share/man:${OPENWINHOME}/man:${X11HOME}/man:$LOCAL_HOME/teTeX/man:$LOCAL_HOME/man:/usr/dt/man
setenv XNLSPATH $LOCAL_HOME/lib/nls
setenv LANG C

# /usr/lib MUST preceed /lib in LD_LIBRARY_PATH, otherwise, can not use openwin on console running SunOs 4.1.X
setenv LD_LIBRARY_PATH ${X11HOME}/lib:${OPENWINHOME}/lib:/usr/lib:/lib:${LOCAL_HOME}/lib:/usr/dt/lib:/opt/SUNWspro/lib
 
####  CXTERM and ChinesePower Editor  -------------------------------------------
setenv CXTERM_FONTPATH $LOCAL_HOME/lib/cxterm_fonts
setenv FONTPATH "$OPENWINHOME/lib/X11/fonts:$CXTERM_FONTPATH"
setenv HZINPUTDIR $LOCAL_HOME/lib/cxterm_dict
setenv HZASSOCIATION 	$HZINPUTDIR/simple.lx
setenv HBFPATH $LOCAL_HOME/lib/cnprint_fonts
setenv TTFPATH $LOCAL_HOME/lib/Chinese_TTF
setenv CHPOWERPATH $LOCAL_HOME/lib/chpower-3.0
setenv CHPPICPATH $CHPOWERPATH/pic

####  For TGIF  -----------------------------------------------------------------
setenv TGIFPATH /usr/local/X11R5/lib/X11/tgif

####  For Tool Evaluation, need to set the 'EVALUATION' environment variable  ---
#setenv EVALUATION

####  Set default path  ---------------------------------------------------------
#--------------------------------------------------------------------------------
set path = ( /bin /usr/ucb /eda/sunplus/bin $OPENWINHOME/bin $X11HOME/bin \
             $LOCAL_HOME/bin /usr/bin /usr/sbin . ~/bin \
             /eda/sunplus/scripts /etc )

if ( $OSNAME == SunOS && $OSVERSION =~ 5* ) then # Solaris
	set path = ( $path /usr/xpg4/bin /opt/SUNWspro/bin /usr/ccs/bin )
else if ( $OSNAME == HP-UX && $OSVERSION =~ *10.* ) then
	set path = ( $path /opt/ansic/bin /usr/bin/X11 )
endif

####  For DQS related setting  --------------------------------------------------
##setenv DQS_VERSION 19990701
##
##switch (`uname -r`)
##   case 4.*: # SunOS
##     set path=($path /eda/DQS/DQS.sun4)
##   breaksw
##   case 5.*: # Solaris
##     set path=($path /eda/DQS/DQS.solaris)
##   breaksw
##   case A.*: # HP-UX09
##      set path=($path /eda/DQS/DQS.hpux9 )
##   breaksw
##   case B.*: # HP-UX10
##     set path=($path /eda/DQS/DQS.hpux10)
##   breaksw
##   case 2.2*: # Linux 2.2
##     set path=($path /eda/DQS/DQS.linux)
##   breaksw
##   case 2.4*: # Linux 2.4 (pingux)
##     set path=($path /eda/DQS/DQS.linux)
##   breaksw
##endsw
##
##setenv MANPATH ${MANPATH}:/eda/DQS/man
##alias q 'qstat -f'
##alias qu 'qstat -ext -u'

####  For Ghostscript  ----------------------------------------------------------
if ( $OSNAME == SunOS && $OSVERSION =~ 4.1.* ) then
  setenv GS_VERSION 6.0.1
else
  setenv GS_VERSION `gs -v | head -1 | cut -f3 -d' ' `
endif
if ( $GS_VERSION != '2.6.2' )  then
  setenv GS_FONTPATH ${LOCAL_HOME}/lib/ghostscript/${GS_VERSION}:${LOCAL_HOME}/lib/ghostscript/fonts:${LOCAL_HOME}/lib/Chinese_GS_FONTS:${LOCAL_HOME}/teTeX/texmf/fonts/type1/ntuttf/kai
  setenv GS_LIB $GS_FONTPATH
  setenv GS_LIB_DEFAULT $GS_FONTPATH
endif

if ( $OSNAME == HP-UX ) then # USE gs262 ONLY for BLACK bug
  setenv GSVERSION 2.62
  unsetenv GS_FONTPATH
  setenv GS_LIB ${LOCAL_HOME}/lib/ghostscript262/2.62:${LOCAL_HOME}/lib/ghostscript262/fonts
  setenv GS_LIB_DEFAULT $GS_LIB
else
    setenv GS_DEVICE x11alpha
endif

####  Last check for HP-UX and SunOS machine-dependent settings  ----------------
if ( $?TERM ) then
  if ($TERM == "xterm") setenv TERM xterm
else
  setenv TERM vt100
endif
if ( $TERM == hp ) set HPCONSOLE

if ( $OSNAME == SunOS && $OSVERSION =~ 5.* ) then
  set console_user = `ls -la /devices/pseudo/cn@0:console  | tr -s ' ' ' ' | cut -f3 -d' '`
else
  set console_user = `ls -la /dev/console | tr -s ' ' ' ' | cut -f3 -d' '`
endif

if ($OSNAME == "HP-UX") then
#	if ( $console_user == $LOGNAME && $?WINODWID ) \
#		set noglob;eval `/usr/bin/X11/resize`;unset noglob
  if ( ! $?DT && ! $?NOTTY) then # CDE can not accept tset or stty or tty
    stty intr ^C
    stty erase ^H
    stty susp ^Z/^Y
    stty kill ^U
    stty stop ^S/^Q
    stty eof ^D
    stty cs8
    stty -parity -istrip
    stty -ixany
    stty -parenb cs8
    setenv LC_CTYPE english.iso88591
    # setenv LC_MESSAGES english.iso88591
  endif

  alias df 'bdf'
  alias psf 'ps -ef'
  alias psl 'ps -el'
  alias rsh remsh
  alias pstat  swapinfo -m
  alias op startx
  alias openwin startx

  if ( $OSVERSION =~ *10.* ) then
    limit coredumpsize 0
    limit descriptors 250
  endif
else if ($OSNAME == Linux) then
  setenv LC_ALL C
  setenv C_COLLATE C
  setenv LC_CTYPE C
  setenv LC_COLLATE C
  setenv PGLIB /usr/lib/pgsql
  setenv PGDATA /var/lib/pgsql
else # uname == SunOS
  stty erase ^H
  limit coredumpsize 0
  limit descriptors 250
  alias ping 'ping -s'
  if ( ! $?DT && ! $?NOTTY) then
    stty -parenb -istrip cs8  # same as stty pass8, see : man stty
    stty erase ^H
    # stty pass8
  endif
  setenv LC_CTYPE iso_8859_1
endif

####  Force Alias  --------------------------------------------------------------
alias rm 'rm -i'
alias mv 'mv -i'
alias cp 'cp -i'

#################################################################################
#
#  Please put your personal setting after this segment
#
#################################################################################

if ( -e ~/.cshrc2 ) then  # Setting up Personal environment
	source ~/.cshrc2 
endif
