From: Michael Tosch <eedmit@eed.ericsson.se>
Subject: automount Solaris compatible
Date: Fri, 06 Feb 2004 22:43:19 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40240A77.5060603@eed.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010308080105000105080207"
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------010308080105000105080207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have an improvement proposal for /etc/rc.d/init.d/autofs (Redhat).

During our migration to Sun LDAP server, we have renamed NIS maps from
auto.map to auto_map.
This has worked well with the Solaris clients but not with the Linux clients.
The Linux clients are hardcoded to only use the "dot" maps.

So I have modified the autofs start scripts to use the same approach as Solaris
clients do, by using the ypwhich -m command (see what the server offers), and
decide for the _ map if available.
Unlike Solaris, I have implemented it only for auto.master. But this should be
enough, as other maps can be correctly named in the NIS auto.master (or auto_master).
Special to Redhat I had also to undo hardcoded renamings for auto.home and auto.mnt
(which I think has never been a good idea).

I have attached two modified autofs scripts, one from Redhat 7, one from Redhat 8.
The changes are marked with a comment: # Solaris compatibility
I hope this can be integrated in a next release.

Rgds
Michael

-- 
Michael Tosch
IT Specialist
HP Managed Services Germany
Phone +49 2407 575 313

This communication is confidential and intended solely for the addressee(s). Any unauthorized review, use, disclosure or distribution is prohibited. If you believe this message has been sent to you in error, please notify the sender by replying to this transmission and delete the message without disclosing it. Thank you.

E-mail including attachments is susceptible to data corruption, interruption, unauthorized amendment, tampering and viruses, and we only send and receive e-mails on the basis that we are not liable for any such corruption, interception, amendment, tampering or viruses or any consequences thereof.


--------------010308080105000105080207
Content-Type: text/plain;
 name="autofs.rh7.fixed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs.rh7.fixed"

#!/bin/bash
#
# $Id: rc.autofs.in,v 1.4 2000/01/22 22:17:34 hpa Exp $
#
# rc file for automount using a Sun-style "master map".
# We first look for a local /etc/auto.master, then a YP
# map with that name
#
# On most distributions, this file should be called:
# /etc/rc.d/init.d/autofs or /etc/init.d/autofs
#

# For Redhat-ish systems
#
# chkconfig: 345 28 72
# processname: /usr/sbin/automount
# config: /etc/auto.master
# description: Automounts filesystems on demand

# This is used in the Debian distribution to determine the proper
# location for the S- and K-links to this init file.
# The following value is extracted by debstd to figure out how to
# generate the postinst script. Edit the field to change the way the
# script is registered through update-rc.d (see the manpage for
# update-rc.d!)
#
FLAGS="defaults 21"

#
# Location of the automount daemon and the init directory
#
DAEMON=/usr/sbin/automount
prog=`basename $DAEMON`
initdir=/etc/init.d

#
# Determine which kind of configuration we're using
#
system=unknown
if [ -f /etc/debian_version ]; then
    system=debian
elif [ -f /etc/redhat-release ]; then
    system=redhat
else
    echo "$0: Unknown system, please port and contact autofs@linux.kernel.org" 1>&2
    exit 1
fi

if [ $system = redhat ]; then
    . $initdir/functions
fi

test -e $DAEMON || exit 0
thisscript="$0"
if [ ! -f "$thisscript" ]; then
    echo "$0: Cannot find myself" 1>&2
    exit 1
fi

PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH

#
# We can add local options here
# e.g. localoptions='rsize=8192,wsize=8192'
#
localoptions=''

# Daemon options
# e.g. --timeout 60
#
daemonoptions=''

#
# Check for all maps that are to be loaded
#
function getschemes()
{
    grep ^automount: /etc/nsswitch.conf | sed -e 's/^.*://' -e 's/\[.*\]/ /g'
}
function getfilemounts()
{
    if [ -f /etc/auto.master ] ; then
        cat /etc/auto.master | sed -e '/^#/d' -e '/^$/d'
    fi
}
function getnismounts()
{
# Solaris compatibility: try to get auto_master in favour of auto.master
    mastermap=`/usr/bin/ypwhich -m | sed -n '/^auto[._]master /{s/ .*//;p;}' | sort | tail -1`
    /usr/bin/ypcat -k ${mastermap:-auto.master} 2> /dev/null | sed -e '/^#/d' -e '/^$/d'
}
function getldapmounts()
{
    /usr/lib/autofs/autofs-ldap-auto-master 2> /dev/null
}
function getrawmounts()
{
    for scheme in `getschemes` ; do
        case "$scheme" in
            files)
                getfilemounts
                ;;
            nis*)
                getnismounts
                ;;
            ldap*)
                getldapmounts
                ;;
        esac
    done
}


#
# This function will build a list of automount commands to execute in
# order to activate all the mount points. It is used to figure out
# the difference of automount points in case of a reload
#
function getmounts()
{
	knownmaps=" "
	getrawmounts | (
	while read dir map options
	do
	    # These checks screen out duplicates and skip over directories
	    # where the map is '-'.
	    if [ ! -z "$dir" -a ! -z "$map" \
			-a x`echo "$map" | cut -c1` != 'x-' \
			-a "`echo "$knownmaps" | grep $dir/`" = "" ]
	    then
		# If the options include a -t or --timeout parameter, then
		# pull those particular options out.
		# echo DAEMONOPTIONS OPTIONS $daemonoptions $options
		startupoptions=
		if echo $options | grep -q -- '-t' ; then
		    startupoptions="--timeout $(echo $daemonoptions $options | \
		      sed 's/.*--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\).*$/\2/g')"
		fi
		# Other option flags are intended for maps.
		mapoptions="$(echo "$daemonoptions $options" |\
		      sed   's/--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\)//g')"
		# Break up the maptype and map, if the map type is specified
		maptype=`echo $map | cut -f1 -d:`
		# Handle degenerate map specifiers
		if [ "$maptype" = "$map" ] ; then
		    if [ -x "$map" ]; then
			maptype=program
		    elif [ -x "/etc/$map" ]; then
			maptype=program
			map=`echo /etc/$map | sed 's^//^/^g'`
		    elif [ -f "$map" ]; then
			maptype=file
		    elif [ -f "/etc/$map" ]; then
			maptype=file
			map=`echo /etc/$map | sed 's^//^/^g'`
		    elif [ "$map" = "hesiod" -o "$map" = "userhome" ] ; then
			maptype=$map
			map=
		    elif [ "$map" = "multi" ] ; then
			maptype=$map
			map=
		    else
			maptype=yp
			# map=`basename $map | sed -e s/^auto_home/auto.home/ -e s/^auto_mnt/auto.mnt/`
# Solaris compatibility: leave the map name
			map=`basename $map`
		    fi
		fi
		map=`echo $map | cut -f2- -d:`

		# echo STARTUPOPTIONS $startupoptions
		# echo DIR $dir
		# echo MAPTYPE $maptype
		# echo MAP $map
		# echo MAPOPTIONS $mapoptions
		# echo LOCALOPTIONS $localoptions

		echo "$DAEMON $startupoptions $dir $maptype $map $mapoptions $localoptions" | sed -e 's/	/ /g' -e 's/  / /g'

		# echo ------------------------
	    fi
	    knownmaps=" $dir/ $knownmaps"
	done
    )
}

#
# Status lister.
#
function status()
{
	echo $"Configured Mount Points:"
	echo  "------------------------"
	getmounts
	echo ""
	echo $"Active Mount Points:"
	echo  "--------------------"
	ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON " | (
		while read pid tt stat time command; do echo $command; done
	)
}


#
# Redhat start/stop function.
#
function redhat()
{

#
# See how we were called.
#
case "$1" in
  start)
        # Make sure the autofs filesystem type is available.
        (grep -q autofs /proc/filesystems || /sbin/modprobe -k autofs || /sbin/modprobe -k autofs4) 2> /dev/null
	# Check if the automounter is already running?
	if [ ! -f /var/lock/subsys/autofs ]; then
            echo -n $"Starting $prog:"
            getmounts | sh && success "autofs startup" || failure "autofs startup"
            RETVAL=$?
            echo
            [ $RETVAL = 0 ] && touch /var/lock/subsys/autofs
	fi
	;;
  stop)
        echo -n $"Stopping $prog:"
        killproc $DAEMON -USR2
        RETVAL=$?
        count=0
        sleep 1
        while [ -n "`/sbin/pidof $DAEMON`" -a $count -lt 5 ] ; do
	    killproc $DAEMON -TERM
            RETVAL=$?
            umount -a -f -t autofs
	    [ $RETVAL = 0 ] || sleep 5
            count=`expr $count + 1`
        done
        umount -a -f -t autofs
	[ $RETVAL = 0 ] && rm -f /var/lock/subsys/autofs
        echo
	;;
  restart)
        redhat stop
        redhat start
	;;
  reload)
	if [ ! -f /var/lock/subsys/autofs ]; then
		echo $"$prog not running"
		RETVAL=1
		return
	fi
	echo $"Checking for changes to /etc/auto.master ...."
        TMP1=`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp file" >& 2; exit 1; }
        TMP2=`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp file" >& 2; exit 1; }
	getmounts > $TMP1
	ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON" | (
	    while read pid tt stat time command; do
		echo "$command" >>$TMP2
		if ! grep -q "^$command" $TMP1; then
		    if ! echo "$command" | grep -q -e --submount; then
			kill -USR2 $pid
			echo $"Stop $command"
		    fi
		fi
	    done
	)
	cat $TMP1 | ( while read x; do
		if ! grep -q "^$x" $TMP2; then
			$x
			echo $"Start $x"
		fi
        done )
	rm -f $TMP1 $TMP2
	;;
  status)
	status
	;;
  condrestart)
	[ -f /var/lock/subsys/autofs ] && redhat restart
        RETVAL=0
	;;
  *)
	echo $"Usage: $0 {start|stop|restart|reload|condrestart|status}"
	RETVAL=0
esac
}

#
# Debian start/stop functions.
#
function debian()
{
#
# See how we were called.
#
case "$1" in
    start)
	echo -n 'Starting automounter:'
	getmounts | while read cmd mnt rest
	do
		echo -n " $mnt"
		pidfile=/var/run/autofs`echo $mnt | sed 's/\//./'`.pid
		start-stop-daemon --start --pidfile $pidfile --quiet \
			--exec $DAEMON -- $mnt $rest
		#
		#	Automount needs a '--pidfile' or '-p' option.
		#	For now we look for the pid ourself.
		#
		ps ax | grep "[0-9]:[0-9][0-9] $DAEMON $mnt" | (
			read pid rest
			echo $pid > $pidfile
			echo "$mnt $rest" >> $pidfile
		)
	done
	echo "."
	;;
    stop)
	echo 'Stopping automounter.'
	start-stop-daemon --stop --quiet --signal USR2 --exec $DAEMON
	;;
    reload|restart)
	echo "Reloading automounter: checking for changes ... "
	TMP=/var/run/autofs.tmp
	getmounts >$TMP
	for i in /var/run/autofs.*.pid
	do
		pid=`head -n 1 $i 2>/dev/null`
		[ "$pid" = "" ] && continue
		command=`tail +2 $i`
		if ! grep -q "^$command" $TMP
		then
			echo "Stopping automounter: $command"
			kill -USR2 $pid
		fi
	done
	rm -f $TMP
	$thisscript start
	;;
    status)
	status
	;;
    *)
	echo "Usage: $initdir/autofs {start|stop|restart|reload|status}" >&2
	exit 1
	;;
esac
}

RETVAL=0
if [ $system = debian ]; then
	debian "$@"
elif [ $system = redhat ]; then
	redhat "$@"
fi

exit $RETVAL

--------------010308080105000105080207
Content-Type: text/plain;
 name="autofs.rh8.fixed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs.rh8.fixed"

#!/bin/bash
#
# $Id: rc.autofs.in,v 1.4 2000/01/22 22:17:34 hpa Exp $
#
# rc file for automount using a Sun-style "master map".
# We first look for a local /etc/auto.master, then a YP
# map with that name
#
# On most distributions, this file should be called:
# /etc/rc.d/init.d/autofs or /etc/init.d/autofs
#

# For Redhat-ish systems
#
# chkconfig: 345 28 72
# processname: /usr/sbin/automount
# config: /etc/auto.master
# description: Automounts filesystems on demand

# This is used in the Debian distribution to determine the proper
# location for the S- and K-links to this init file.
# The following value is extracted by debstd to figure out how to
# generate the postinst script. Edit the field to change the way the
# script is registered through update-rc.d (see the manpage for
# update-rc.d!)
#
FLAGS="defaults 21"

#
# Location of the automount daemon and the init directory
#
DAEMON=/usr/sbin/automount
prog=`basename $DAEMON`
initdir=/etc/init.d

#
# Determine which kind of configuration we're using
#
system=unknown
if [ -f /etc/debian_version ]; then
    system=debian
elif [ -f /etc/redhat-release ]; then
    system=redhat
else
    echo "$0: Unknown system, please port and contact autofs@linux.kernel.org" 1>&2
    exit 1
fi

if [ $system = redhat ]; then
    . $initdir/functions
fi

test -e $DAEMON || exit 0

if [ $system = debian ]; then
    thisscript="$0"
    if [ ! -f "$thisscript" ]; then
        echo "$0: Cannot find myself" 1>&2
        exit 1
    fi
fi

PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH

#
# We can add local options here
# e.g. localoptions='rsize=8192,wsize=8192'
#
localoptions=''

# Daemon options
# e.g. --timeout 60
#
daemonoptions=''

#
# Check for all maps that are to be loaded
#
function getschemes()
{
    grep ^automount: /etc/nsswitch.conf | sed -e 's/^.*://' -e 's/\[.*\]/ /g'
}
function catnismap()
{
    if [ -z "$1" ] ; then
        map="auto_master"
    else
        map="$1"
    fi
    /usr/bin/ypcat -k "$map" 2> /dev/null | sed -e '/^#/d' -e '/^$/d'
}
function getfilemounts()
{
    if [ -f /etc/auto.master ] ; then
        cat /etc/auto.master | grep -v '^\+' | sed -e '/^#/d' -e '/^$/d'
        for nismap in `cat /etc/auto.master | grep '^\+' | sed -e '/^#/d' -e '/^$/d'`; do
            catnismap `echo "$nismap" | sed -e 's/^\+//'`
        done
    fi
}
function getnismounts()
{
# Solaris compatibility: try to get auto_master in favour of auto.master
    mastermap=`/usr/bin/ypwhich -m | sed -n '/^auto[._]master /{s/ .*//;p;}' | sort | tail -1`
    catnismap ${mastermap:-auto.master}
}
function getldapmounts()
{
    /usr/lib/autofs/autofs-ldap-auto-master 2> /dev/null
}
function getrawmounts()
{
    for scheme in `getschemes` ; do
        case "$scheme" in
            files)
                if [ -z "$filescheme" ] ; then
                    getfilemounts
                    filescheme=1
                    export filescheme
                fi
                ;;
            nis)
                if [ -z "$nisscheme" ] ; then
                    getnismounts
                    nisscheme=1
                    export nisscheme
                fi
                ;;
            ldap*)
                if [ -z "$ldapscheme" ] ; then
                    getldapmounts
                    ldapscheme=1
                    export ldapscheme
                fi
                ;;
        esac
    done
}


#
# This function will build a list of automount commands to execute in
# order to activate all the mount points. It is used to figure out
# the difference of automount points in case of a reload
#
function getmounts()
{
	knownmaps=" "
	getrawmounts | (
	while read dir map options
	do
	    # These checks screen out duplicates and skip over directories
	    # where the map is '-'.
	    # We can't do empty or direct host maps, so don't bother trying.
	    if [ ! -z "$map" -a "$map" = "-hosts" ] ; then
		continue
	    fi
	    if [ ! -z "$dir" -a ! -z "$map" \
			-a x`echo "$map" | cut -c1` != 'x-' \
			-a "`echo "$knownmaps" | grep $dir/`" = "" ]
	    then
		# If the options include a -t or --timeout parameter, then
		# pull those particular options out.
		: echo DAEMONOPTIONS OPTIONS $daemonoptions $options
		startupoptions=
		if echo $options | grep -q -- '-t' ; then
		    startupoptions="--timeout $(echo $daemonoptions $options | \
		      sed 's/.*--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\).*$/\2/g')"
		fi
		# Other option flags are intended for maps.
		mapoptions="$(echo "$daemonoptions $options" |\
		      sed   's/--*t\(imeout\)*[ \t=]*\([0-9][0-9]*\)//g')"
		# Break up the maptype and map, if the map type is specified
		maptype=`echo $map | cut -f1 -d:`
		# Handle degenerate map specifiers
		if [ "$maptype" = "$map" ] ; then
		    if [ -x "$map" ]; then
			maptype=program
		    elif [ -x "/etc/$map" ]; then
			maptype=program
			map=`echo /etc/$map | sed 's^//^/^g'`
		    elif [ -f "$map" ]; then
			maptype=file
		    elif [ -f "/etc/$map" ]; then
			maptype=file
			map=`echo /etc/$map | sed 's^//^/^g'`
		    elif [ "$map" = "hesiod" -o "$map" = "userhome" ] ; then
			maptype=$map
			map=
		    elif [ "$map" = "multi" ] ; then
			maptype=$map
			map=
		    else
			maptype=yp
			#map=`basename $map | sed -e s/^auto_home/auto.home/ -e s/^auto_mnt/auto.mnt/`
# Solaris compatibility: leave the map name
			map=`basename $map`
		fi
		fi
		map=`echo $map | cut -f2- -d:`

		: echo STARTUPOPTIONS $startupoptions
		: echo DIR $dir
		: echo MAPTYPE $maptype
		: echo MAP $map
		: echo MAPOPTIONS $mapoptions
		: echo LOCALOPTIONS $localoptions

		echo "$DAEMON $startupoptions $dir $maptype $map $mapoptions $localoptions" | sed -e 's/	/ /g' -e 's/  / /g'

		: echo ------------------------
	    fi
	    knownmaps=" $dir/ $knownmaps"
	done
    )
}

#
# Status lister.
#
function status()
{
	echo $"Configured Mount Points:"
	echo  "------------------------"
	getmounts
	echo ""
	echo $"Active Mount Points:"
	echo  "--------------------"
	ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON " | (
		while read pid tt stat time command; do echo $command; done
	)
}


#
# Redhat start/stop function.
#
function redhat()
{

#
# See how we were called.
#
case "$1" in
  start)
        # Make sure the autofs filesystem type is available.
        (grep -q autofs /proc/filesystems || /sbin/modprobe -k autofs || /sbin/modprobe -k autofs4) 2> /dev/null
        echo -n $"Starting $prog:"
        TMP=`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp file" >& 2; exit 1; }
        getmounts | tee $TMP | sh
        RETVAL=$?
	if [ -s $TMP ] ; then
	    success "$prog startup" || failure "$prog startup"
            [ $RETVAL = 0 ] && touch /var/lock/subsys/autofs
	else
	    echo -n "" $"No Mountpoints Defined"
	    success "$prog startup"
	fi
	rm -f $TMP
        echo
	;;
  stop)
        echo -n $"Stopping $prog:"
	if [ -z "`pidofproc $prog`" -a -z "`getmounts`" ]; then
		success $"$prog shutdown"
		RETVAL=0
	else
        	killproc $DAEMON -USR2
        	RETVAL=$?
	fi
        count=0
        while [ -n "`/sbin/pidof $DAEMON`" -a $count -lt 8 ] ; do
	    killproc $DAEMON -USR2
            RETVAL=$?
	    [ $RETVAL = 0 -a -z "`/sbin/pidof $DAEMON`" ] || sleep ${count+1}
            count=`expr $count + 1`
        done
        umount -a -f -t autofs
        rm -f /var/lock/subsys/autofs
        echo
        ;;
  restart)
        redhat stop
        redhat start
	;;
  reload)
	if [ ! -f /var/lock/subsys/autofs ]; then
		echo $"$prog not running"
		RETVAL=1
		return
	fi
	echo $"Checking for changes to /etc/auto.master ...."
        TMP1=`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp file" >& 2; exit 1; }
        TMP2=`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp file" >& 2; exit 1; }
	getmounts > $TMP1
	ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON" | (
	    while read pid tt stat time command; do
		echo "$command" >>$TMP2
		if ! grep -q "^$command" $TMP1; then
		    if ! echo "$command" | grep -q -e --submount; then
			kill -USR2 $pid
			echo $"Stop $command"
		    fi
		fi
	    done
	)
	cat $TMP1 | ( while read x; do
		if ! grep -q "^$x" $TMP2; then
			$x
			echo $"Start $x"
		fi
        done )
	rm -f $TMP1 $TMP2
	;;
  status)
	status
	;;
  condrestart)
	[ -f /var/lock/subsys/autofs ] && redhat restart
        RETVAL=0
	;;
  *)
	echo $"Usage: $0 {start|stop|restart|reload|condrestart|status}"
	RETVAL=0
esac
}

#
# Debian start/stop functions.
#
function debian()
{
#
# See how we were called.
#
case "$1" in
    start)
	echo -n 'Starting automounter:'
	getmounts | while read cmd mnt rest
	do
		echo -n " $mnt"
		pidfile=/var/run/autofs`echo $mnt | sed 's/\//./'`.pid
		start-stop-daemon --start --pidfile $pidfile --quiet \
			--exec $DAEMON -- $mnt $rest
		#
		#	Automount needs a '--pidfile' or '-p' option.
		#	For now we look for the pid ourself.
		#
		ps ax | grep "[0-9]:[0-9][0-9] $DAEMON $mnt" | (
			read pid rest
			echo $pid > $pidfile
			echo "$mnt $rest" >> $pidfile
		)
	done
	echo "."
	;;
    stop)
	echo 'Stopping automounter.'
	start-stop-daemon --stop --quiet --signal USR2 --exec $DAEMON
	;;
    reload|restart)
	echo "Reloading automounter: checking for changes ... "
	TMP=/var/run/autofs.tmp
	getmounts >$TMP
	for i in /var/run/autofs.*.pid
	do
		pid=`head -n 1 $i 2>/dev/null`
		[ "$pid" = "" ] && continue
		command=`tail +2 $i`
		if ! grep -q "^$command" $TMP
		then
			echo "Stopping automounter: $command"
			kill -USR2 $pid
		fi
	done
	rm -f $TMP
	$thisscript start
	;;
    status)
	status
	;;
    *)
	echo "Usage: $initdir/autofs {start|stop|restart|reload|status}" >&2
	exit 1
	;;
esac
}

RETVAL=0
if [ $system = debian ]; then
	debian "$@"
elif [ $system = redhat ]; then
	redhat "$@"
fi

exit $RETVAL

--------------010308080105000105080207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------010308080105000105080207--

