From: "Fabricio Lima" <listas@fabriciolima.com.br>
Subject: autofs dont keep running in slackware
Date: Wed, 30 Jun 2004 10:05:42 -0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040629204829.M71473@fabriciolima.com.br>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

My post will be too much hardcore, I presume (I hope not:)

I developeted a embeded linux distro based in slackware 9 (and another on=
e=20
based in redhat 8) (it runs using a compact flash 128mb in a IDE Drive)

Now I'm trying to mount a USB Pendrive (modules usb-storage and vfat load=
ed!)

autofs in redhat8 is working pretty good, but the automount using the=20
same /etc/auto.master and /etc/auto.misc at the slackware do not keep run=
ning=20
when I type 'ps ax'.

The libs were copied correctly to /usr/lib/autofs/*,  and the autofs.o mo=
dule=20
is loaded at the startup.

I had made a modified version of rc.autofs (see below) to make it work wi=
th=20
slackware, but even if I type 'automount /mnt file /etc/auto.misc' it sto=
ps=20
running and when I type '/etc/rc.d/rc.autofs status' it shows:
Mount points configured:
------------------------
/usr/sbin/automount /mnt file /etc/auto.misc

Active mount points:
--------------------
#

Some interesting observations about my enviroment:
-The root filesystem is readonly (cramfs!) I boot the system from /boot=20
(ext2) and /var and /tmp is mounted using /dev/ram0. (/mnt resides at my =
read-
only root file system)

/etc/fstab:
/dev/hda1        /boot            ext2        ro               1   0
/dev/hda2        /                cramfs      ro               1   0
/dev/hda3        /Data/Files   ext3    sync,data=3Djournal       1   0
devpts           /dev/pts         devpts      gid=3D5,mode=3D620   0   0
proc             /proc            proc        defaults         0   0

As the /etc/mtab is never updated (readonly filesystem) that=B4s what is=20
mounted at run-time:
#cat /proc/mounts:
rootfs / rootfs ro 0 0
/dev/root / cramfs ro 0 0
/dev/hda1 /boot ext2 ro 0 0
/dev/hda3 /root/2m2b/Data/Files ext3 rw,sync 0 0
devpts /dev/pts devpts rw 0 0
proc /proc proc rw 0 0
/dev/ram2 /var ext2 rw 0 0
/dev/ram2 /var/tmp/autofs-bind-40e28eec-5c/dir2\040(deleted) ext2 rw 0 0
automount(pid92) /mnt autofs rw 0 0

main part of rc.sysinit:
dd if=3D/var.fs of=3D/dev/ram2
mount -n /dev/ram2 /var
(tmp is linked to /var/tmp)
/etc/rc.d/rc.autofs start

/etc/auto.master:
/mnt    /etc/auto.misc

/etc/auto.misc:
usb   -fstype=3Dvfat,sync,nodev,nosuid   :/dev/sda1

/etc/rc.d/rc.autofs:
#!/bin/bash
#
# $Id: rc.autofs.in,v 1.11 2004/04/03 07:14:33 raven Exp $
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
FLAGS=3D"defaults 21"

#
# Location of the automount daemon and the init directory
#
DAEMON=3D/usr/sbin/automount
prog=3D`basename $DAEMON`
initdir=3D/etc/init.d

#
# Determine which kind of configuration we're using
#
system=3Dunknown
if [ -f /etc/slackware-version ]; then
    system=3Dslackware
elif [ -f /etc/redhat-release ]; then
    system=3Dredhat
else
    echo "$0: Unknown system, please port and contact=20
autofs@linux.kernel.org" 1>&2
    exit 1
fi

if [ $system =3D redhat ]; then
    . $initdir/functions
fi

test -e $DAEMON || exit 0

if [ $system =3D slackware ]; then
    thisscript=3D"$0"
    if [ ! -f "$thisscript" ]; then
        echo "$0: Cannot find myself" 1>&2
        exit 1
    fi
fi

PATH=3D/sbin:/usr/sbin:/bin:/usr/bin
export PATH

#
# We can add local options here
# e.g. localoptions=3D'rsize=3D8192,wsize=3D8192'
#
localoptions=3D''

#
# Daemon options
# e.g. --timeout=3D60
#
daemonoptions=3D''

#
# Check for all maps that are to be loaded
#
function getschemes()
{
    grep ^automount: /etc/nsswitch.conf | sed -e 's/^.*://' -e 's/\[.*\]/=
 /g'
}
function catnismap()
{
    if [ -z "$1" ] ; then
        map=3D"auto_master"
    else
        map=3D"$1"
    fi
    /usr/bin/ypcat -k "$map" 2> /dev/null | sed -e '/^#/d' -e '/^$/d'
}
function getfilemounts()
{
    if [ -f /etc/auto.master ] ; then
        cat /etc/auto.master | grep -v '^\+' | sed -e '/^#/d' -e '/^$/d'
        for nismap in `cat /etc/auto.master | grep '^\+' | sed -e '/^#/d'=
 -
e '/^$/d'`; do
            catnismap `echo "$nismap" | sed -e 's/^\+//'`
        done
    fi
}
function getnismounts()
{
    YPMAP=3D`catnismap auto.master`
    if [ -z "$YPMAP" ]; then
       catnismap
    else
       catnismap auto.master
    fi
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
                    filescheme=3D1
                    export filescheme
                fi
                ;;
            nis)
                if [ -z "$nisscheme" ] ; then
                    getnismounts
                    nisscheme=3D1
                    export nisscheme
                fi
                ;;
            ldap*)
                if [ -z "$ldapscheme" ] ; then
                    getldapmounts
                    ldapscheme=3D1
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
        knownmaps=3D" "
        getrawmounts | (
        while read dir map options
        do
            # These checks screen out duplicates and skip over directorie=
s
            # where the map is '-'.
            # We can't do empty or direct host maps, so don't bother tryi=
ng.
            if [ ! -z "$map" -a "$map" =3D "-hosts" ] ; then
                continue
            fi
            if [ ! -z "$dir" -a ! -z "$map" \
                        -a x`echo "$map" | cut -c1` !=3D 'x-' \
                        -a "`echo "$knownmaps" | grep '\<'$dir/`" =3D "" =
]
            then
                # If the options include a -t or --timeout or a -g or --g=
host
                # parameter, then pull those particular options out.
                : echo DAEMONOPTIONS OPTIONS $daemonoptions $options
                startupoptions=3D
                if echo "$daemonoptions" | grep -q -- '-t' ; then
                    startupoptions=3D"--timeout=3D$(echo $daemonoptions $=
options=20
| \
                      sed 's/.*--*t\(imeout\)*[ \t=3D]*\([0-9][0-9]*\).*$=
/
\2/g')"
                fi
                # Override timeout in $daemonoptions with map $options
                if echo "$options" | grep -q -- '-t' ; then
                    startupoptions=3D"--timeout=3D$(echo $daemonoptions $=
options=20
| \
                      sed 's/.*--*t\(imeout\)*[ \t=3D]*\([0-9][0-9]*\).*$=
/
\2/g')"
                fi
                if echo "$daemonoptions $options" | grep -q -- '-g' ; the=
n
                    startupoptions=3D"$startupoptions --ghost"
                fi
                if echo "$daemonoptions $options" | grep -q -- '-v' ; the=
n
                    startupoptions=3D"$startupoptions --verbose"
                fi
                if echo "$daemonoptions $options" | grep -q -- '-d' ; the=
n
                    startupoptions=3D"$startupoptions --debug"
                fi
                # Other option flags are intended for maps.
                mapoptions=3D"$(echo "$daemonoptions $options" |\
                      sed   's/--*t\(imeout\)*[ \t=3D]*\([0-9][0-9]*\)//g=
' |
                      sed   's/--*g\(host\)*//g' |
                      sed   's/--*v\(verbose\)*//g' |
                      sed   's/--*d\(ebug\)*//g')"
                # Break up the maptype and map, if the map type is specif=
ied
                maptype=3D`echo $map | cut -f1 -d:`
                # Handle degenerate map specifiers
                if [ "$maptype" =3D "$map" ] ; then
                    if [ -x "$map" ]; then
                        maptype=3Dprogram
                    elif [ -x "/etc/$map" ]; then
                        maptype=3Dprogram
                        map=3D`echo /etc/$map | sed 's^//^/^g'`
                    elif [ -f "$map" ]; then
                        maptype=3Dfile
                    elif [ "$map" =3D "hesiod" -o "$map" =3D "userhome" ]=
 ; then
                        maptype=3D$map
                        map=3D
                    elif [ "$map" =3D "multi" ] ; then
                        maptype=3D$map
                        map=3D
                    else
                        maptype=3Dyp
                        # If the master map says the maps have '_' why ch=
ange=20
it?
                        # map=3D`basename $map | sed -e=20
s/^auto_home/auto.home/ -e s/^auto_mnt/auto.mnt/`
                        map=3D`basename $map | sed 's^//^/^g'`
                fi
                fi
                map=3D`echo $map | cut -f2- -d:`

                : echo STARTUPOPTIONS $startupoptions
                : echo DIR $dir
                : echo MAPTYPE $maptype
                : echo MAP $map
                : echo MAPOPTIONS $mapoptions
                : echo LOCALOPTIONS $localoptions

                echo "$DAEMON $startupoptions $dir $maptype $map $mapopti=
ons=20
$localoptions" | sed -e 's/        / /g' -e 's/  / /g'

                : echo ------------------------
            fi
            knownmaps=3D" $dir/ $knownmaps"
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
                while read pid tt stat time command; do echo $command; do=
ne
        )
}

# return true if at least one pid is alive
function alive()
{
    if [ -z "$*" ]; then
        return 1
    fi
    for i in $*; do
        if kill -0 $i 2> /dev/null; then
            return 0
        fi
    done

    return 1
}

#
# Find pid of deepest nested submount
#
function get_deepest_submount()
{
        ps axw|grep $DAEMON|\
           grep submount|\
           sed -e 's/--timeout[ =3D][0-9]*//g'|\
           awk '{print $7,$1}'|\
           sort -r|\
           awk 'BEGIN {ORS=3D" "} {print $2}'|\
           awk '{print $1}'
}

#
# Signal each nested submount
#
function signal_submounts()
{
        tries=3D0
        pid=3D`get_deepest_submount`
        while [ -n "$pid" -a $tries -lt 8 ]; do
                oldpid=3D$pid
                kill -USR2 $pid 2 > /dev/null
                usleep 300000
                pid=3D`get_deepest_submount`
                if [ "$oldpid" =3D "$pid" ]; then
                        tries=3D`expr $tries + 1`
                else
                        tries=3D0
                fi
        done
        echo $pid
}

#
# Signal each automount
#
function signal_automounts()
{
        RETVAL=3D0
        if [ -z "`signal_submounts`" ]; then
                pids=3D"`/sbin/pidof $DAEMON`"
                for one_pid in $pids ; do
                        kill -USR2 $one_pid 2 > /dev/null
                        count=3D0
                        while ps ax|grep -v grep|grep $one_pid >/dev/null=
; do
                                usleep 200000
                                count=3D$(expr $count + 1)
                                if [ $count -gt 20 ]; then
                                        break;
                                fi
                        done
                done
        fi
        if [ -n "`/sbin/pidof $DAEMON`" ] ; then
                RETVAL=3D1
        fi
        return $RETVAL
}

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
        (grep -q autofs /proc/filesystems || /sbin/modprobe -k autofs4=20
|| /sbin/modprobe -k autofs) 2> /dev/null
        echo -n $"Starting $prog:"
        TMP=3D`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp=
 file"=20
>& 2; exit 1; }
        getmounts | tee $TMP | sh
        RETVAL=3D$?
        if [ -s $TMP ] ; then
            if [ $RETVAL -eq 0 ] ; then
                success "$prog startup"
            else
                failure "$prog startup"
            fi
            [ $RETVAL =3D 0 ] && touch /var/lock/subsys/autofs
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
                RETVAL=3D0
        else
                signal_automounts
                RETVAL=3D$?
        fi
        count=3D0
        while [ -n "`/sbin/pidof $DAEMON`" -a $count -lt 10 ] ; do
           killproc $DAEMON -USR2 >& /dev/null
           RETVAL=3D$?
           [ $RETVAL =3D 0 -a -z "`/sbin/pidof $DAEMON`" ] || sleep 3
           count=3D`expr $count + 1`
        done
        umount -a -f -t autofs
        rm -f /var/lock/subsys/autofs
        if [ -n "`/sbin/pidof $DAEMON`" ] ; then
            failure "$prog shutdown"
        else
            success "$prog shutdown"
        fi
        echo
        ;;
  restart)
        redhat stop
        redhat start
        ;;
  reload)
        if [ ! -f /var/lock/subsys/autofs ]; then
                echo $"$prog not running"
                RETVAL=3D1
                return
        fi
        echo "Checking for changes to /etc/auto.master ...."
        TMP1=3D`mktemp /tmp/autofs.XXXXXX` || { echo "could not make temp=
 file"=20
>& 2; exit 1; }
        TMP2=3D`mktemp /tmp/autofs.XXXXXX` || { echo "could not make temp=
 file"=20
>& 2; exit 1; }
        getmounts >$TMP1
        ps axwww|grep "[0-9]:[0-9][0-9] $DAEMON " | (
            while read pid tt stat time command; do
                echo "$command" >>$TMP2
                if ! grep -q "^$command" $TMP1; then
                    if ! echo "$command" | grep -q -e --submount; then
                        kill -USR2 $pid 2> /dev/null
                        echo $"Stop $command"
                    fi
                else
                        kill -HUP $pid 2> /dev/null
                        echo $"Reload map $command"
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
        RETVAL=3D0
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|reload|condrestart|status}"
        RETVAL=3D0
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
        getmounts | while read cmd mnt rest
        do
                echo -n " $mnt"
                pidfile=3D/var/run/autofs`echo $mnt | sed 's/\//./'`.pid
                $DAEMON $daemonoptions -- $mnt $rest
        done
        echo "."
        ;;
    stop)
        echo 'Stopping automounter.'
        kill -TERM $(/sbin/pidof $DAEMON)
        rm -f /var/lock/subsys/autofs
        ;;
    reload|restart)
        echo "Reloading automounter: checking for changes ... "
        TMP=3D/var/run/autofs.tmp
        getmounts >$TMP
        for i in /var/run/autofs.*.pid
        do
                pid=3D`head -n 1 $i 2>/dev/null`
                [ "$pid" =3D "" ] && continue
                command=3D`tail +2 $i`
                if ! grep -q "^$command" $TMP
                then
                        echo "Stopping automounter: $command"
                        kill -USR2 $pid 2> /dev/null
                else
                        echo "Reloading automounter map: $command"
                        kill -HUP $pid 2> /dev/null
                fi
        done
        rm -f $TMP
        $thisscript start
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $initdir/autofs {start|stop|restart|reload|status}" =
>&2
        exit 1
        ;;
esac
}

RETVAL=3D0
if [ $system =3D slackware ]; then
        slackware "$@"
elif [ $system =3D redhat ]; then
        redhat "$@"
fi
