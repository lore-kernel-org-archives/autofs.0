From: ace <acelists@atlas.sk>
Subject: autofs & slackware
Date: Mon, 14 Feb 2005 20:44:23 +0100
Message-ID: <4210FF97.4010703@atlas.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_tac-56482-1108410226-0001-2"
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org, support@slackware.com

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_tac-56482-1108410226-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I ported the rc.autofs script (from the autofs userspace tools package) 
to Slackware 9.1. Is it of any use to you?


--=_tac-56482-1108410226-0001-2
Content-Type: text/plain; name="rc.autofs"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rc.autofs"

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
# chkconfig: 345 15 85
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
initdir=/etc/rc.d

#
# Determine which kind of configuration we're using
#
system=unknown
if [ -f /etc/debian_version ]; then
    system=debian
elif [ -f /etc/redhat-release ]; then
    system=redhat
elif [ -f /etc/slackware-version ]; then
    system=slackware
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

#
# This function will build a list of automount commands to execute in
# order to activate all the mount points. It is used to figure out
# the difference of automount points in case of a reload
#
function getmounts()
{
#
# Check for local maps to be loaded
#
if [ -f /etc/auto.master ]
then
    cat /etc/auto.master | sed -e '/^#/d' -e '/^$/d'| (
	while read dir map options
	do
	    if [ ! -z "$dir" -a ! -z "$map" \
			-a x`echo "$map" | cut -c1` != 'x-' ]
	    then
		map=`echo "/etc/$map" | sed -e 's:^/etc//:/:'`
		options=`echo "$options" | sed -e 's/\(^\|[ \t]\)-/\1/g'`
		if [ -x $map ]; then
		    echo "$DAEMON $dir program $map $options $localoptions"
		elif [ -f $map ]; then
		    echo "$DAEMON $dir file $map $options $localoptions"
		else
		    echo "$DAEMON $dir `basename $map` $options $localoptions"
		fi
	    fi
	done
    )
fi

#
# Check for YellowPage maps to be loaded
#
if [ -e /usr/bin/ypcat ] && [ `ypcat -k auto.master 2>/dev/null | wc -l` -gt 0 ]
then
    ypcat -k auto.master | (
	while read dir map options
	do
	    if [ ! -z "$dir" -a ! -z "$map" \
			-a x`echo "$map" | cut -c1` != 'x-' ]
	    then
		map=`echo "$map" | sed -e 's/^auto_/auto./'`
		if echo $options | grep -- '-t' >/dev/null 2>&1 ; then
		    mountoptions="--timeout $(echo $options | \
		      sed 's/^.*-t\(imeout\)*[ \t]*\([0-9][0-9]*\).*$/\2/g')"
		fi
                options=`echo "$options" | sed -e '
                  s/--*t\(imeout\)*[ \t]*[0-9][0-9]*//g
                  s/\(^\|[ \t]\)-/\1/g'`
		echo "$DAEMON $dir yp $map $options $localoptions"
	    fi
	done
    )
fi
}

#
# Status lister.
#
function status()
{
	echo "Configured Mount Points:"
	echo "------------------------"
	getmounts
	echo ""
	echo "Active Mount Points:"
	echo "--------------------"
	ps ax|grep "[0-9]:[0-9][0-9] automount " | (
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
	# Check if the automounter is already running?
	if [ ! -f /var/lock/subsys/autofs ]; then
	    echo 'Starting automounter: '
	    getmounts | sh
	    touch /var/lock/subsys/autofs
	fi
	;;
  stop)
	kill -TERM $(/sbin/pidof /usr/sbin/automount)
	rm -f /var/lock/subsys/autofs
	;;
  reload|restart)
	if [ ! -f /var/lock/subsys/autofs ]; then
		echo "Automounter not running"
		exit 1
	fi
	echo "Checking for changes to /etc/auto.master ...."
        TMP1=`mktemp /tmp/autofs.XXXXXX` || { echo "could not make temp file" >& 2; exit 1; }
        TMP2=`mktemp /tmp/autofs.XXXXXX` || { echo "could not make temp file" >& 2; exit 1; }
	getmounts >$TMP1
	ps ax|grep "[0-9]:[0-9][0-9] automount " | (
	    while read pid tt stat time command; do
		echo "$command" >>$TMP2
		if ! grep -q "^$command" $TMP2; then
			kill -USR2 $pid
			echo "Stop $command"
		fi
	    done
	)
	cat $TMP1 | ( while read x; do
		if ! grep -q "^$x" $TMP2; then
			$x
			echo "Start $x"
		fi
        done )
	rm -f $TMP1 $TMP2
	;;
  status)
	status
	;;
  *)
	echo "Usage: $initdir/autofs {start|stop|restart|reload|status}"
	exit 1
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


#
# Slackware start/stop functions.
#
function slackware()
{
#
# See how we were called.
#
case "$1" in
    start)
	echo -n 'Starting automounter:'
	getmounts | while read cmd mnt maptype map rest
	do
		echo -n " $mnt"
		# The pid currently isn't used anywhere...
		pidfile=/var/run/autofs`echo $mnt | sed 's/\//./'`.pid
		$DAEMON -p $pidfile $rest $mnt $maptype $map
	done
	echo "."
	;;
    stop)
	echo 'Stopping automounter.'
	killall -USR2 $DAEMON
#	rm -f /var/run/autofs.*.pid
	;;
    reload|restart)
	echo "Reloading automounter..."
	# The method used by debian and redhat didn't work to kill the current
	# processes, because getmounts returned new command lines (with changes)
	# and those didn't match the old running processes.
	# This should be cleaner.
	$thisscript stop
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

if [ $system = debian ]; then
	debian "$@"
elif [ $system = redhat ]; then
	redhat "$@"
elif [ $system = slackware ]; then
	slackware "$@"
fi

exit 0

--=_tac-56482-1108410226-0001-2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=_tac-56482-1108410226-0001-2--

