From: Jochen Reinwand <Jochen.Reinwand@gmx.de>
Subject: Re: autofs v4 maintainer request
Date: Sun, 17 Aug 2003 23:26:58 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200308172317.33020.jbr.1@gmx.net>
References: <Pine.LNX.4.44.0308161741530.1538-100000@raven.themaw.net>
	<1061138039.23980.8.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iM/P/LDXdgqAn7Z"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1061138039.23980.8.camel@ixodes.goop.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>


--Boundary-00=_iM/P/LDXdgqAn7Z
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> > This is on my list. I believe that it can be addressed by bringing the
> > parsing of the master map into the daemon. This will enable a much more
> > generic init script to be written.
>
> The approach I was thinking about was to factor all the init scripts
> into two parts: one set of functions for doing autofs specific things
> (parsing maps, starting and stopping daemons, etc), and a set of
> per-distro scripts which use the autofs functions to do their work.  The
> per-distro scripts should have very little real code in them, just
> whatever the distro needs an init script to do.
>
> Why would moving the map parsing into the C code make things more
> generic?

Look at the way Solaris does it. It's somehow nice, because the command 
"automount" handles nearly _everything_.

But it's not very flexible. You can only edit auto.master, start automount and 
hope that it does exactly what you want.

Therefore I had a different idea some time ago:
Looking at the different init scripts revealed a great problem: The scripts 
for the different distros do the same things in different ways!
We have LSB, so why not use it?

So I wrote a common init script I called rc.autofs that does everything, but 
leaves out the distro specific stuff, like the output on the screen.

I took all useful things from the different init scripts and implemented a few 
new things.
What was important for me: The script uses PID files and waits a few seconds 
after "rc.autofs stop" and _very_ important during "rc.autofs restart" after 
the stop part for the PID files to disappear to be sure the automount is 
really gone. If one or more PID files remain, it prints an error message 
telling what mount point is broken or still in use. In the case of "rc.autofs 
start" or after the stop part of "rc.autofs restart" the script does _not_ 
start an already or still running automount!

I attached the rc.autofs script and an example "real" autofs script for SuSE. 
It's for an old version (something around 7.x, where init scripts used 
rc.config variables), but the basic concept should be clear.

The code is old and I haven't looked at it for a long time. While reading this 
thread I decided to share it with you, although there are some problems about 
it (see below). I have not cleaned up a lot. Only a few German comments ;-)
So if anyone wants to clean it up or use a few parts for a complete new 
version of the script, feel free to use it!

Now to the problems: I made a big mistake! I changed the syntax of auto.master 
to the following:

# mount-point   map-type   map   options   --   additional options
/mnt   file,sun   /etc/autofs_mnt   nonstrict,nosuid,nodev,sync   --   -t1

As you can see I disabled the autodetection of the map type and used the new 
second column.
In the docs there was nothing about how to specify a different timeout and 
other daemon options for a map. So I made it possible to pass daemon options 
after the "--". But as I found out later it is already possible by normal 
options...

So if someone wants to use my code, he/she has to take care about it. But it 
should be very easy to clean this up!!

regards,
Jochen

--Boundary-00=_iM/P/LDXdgqAn7Z
Content-Type: application/x-shellscript;
  name="rc.autofs"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rc.autofs"

#! /bin/bash

# TODO:
# - IMPORTANT: throw away these silly extensions to auto.master
# - IMPORTANT: implement YP/NIS features in get_mounts
# - The SysV info is taken from SuSE. Is it really SysV? ;-)
# - implement "probe" like in "reload" but without doing anything

###############################################################################
# Supported Features                                                          #
###############################################################################

#Fill me

###############################################################################
# Set needed Variables if they are not already defined                        #
###############################################################################

# Name of the automount binary (also used for locking file names)
AUTOMOUNT=${AUTOMOUNT:-automount}
# The full path to the automount binary
AUTOMOUNT_PATH=${AUTOMOUNT_PATH:-/usr/sbin/$AUTOMOUNT}
# Additional Options for ALL automount daemons
# We use `echo ...` because unused whitespace will then be eliminated
# If you want to add something, put it behind the "}"
AUTOMOUNTOPTIONS=`echo ${AUTOMOUNTOPTIONS} `
# Additional Options for ALL maps
MAPOPTIONS=`echo ${MAPOPTIONS} `
# The place, where we can find the auto.master file
AUTO_MASTER="/etc/auto.master"

###############################################################################
# Now define some useful functions                                            #
###############################################################################

# pidf2mnt, mnt2pidf and get_pidfs are three very simple function, but this way
# we have all PID file stuff in only three functions. So filename and path of
# the PID files can be changed easily

# This funtion takes a list of PID filenames and turns them into the list of
# mount points they represent
function pidf2mnt() {
  local foo first=yes
  for foo in $@
  do
    foo=${foo#/var/run/${AUTOMOUNT}}
    foo=${foo%.pid}
    # Do not print a leading " " if it's the first item
    if [ "$first" != "yes" ]; then echo -n " "; fi
    first=no
    echo -n $foo | sed 's/_/\//g'
  done
  return 0
}

# This funtion takes a list of mount points and turns them into the list of
# PID filenames that are used for these mount points
function mnt2pidf() {
  local foo first=yes
  for foo in $@
  do
    # Do not print a leading " " if it's the first item
    if [ "$first" != "yes" ]; then echo -n " "; fi
    first=no
    echo -n /var/run/${AUTOMOUNT}`echo $foo | sed 's/\//_/g'`.pid
  done
  return 0
}

# Writes a list of all existing PID files on STDOUT. If no files exist it
# returns an empty string and $? will be set !=0 ($? from ls)
function get_pidfs() {
  ls /var/run/${AUTOMOUNT}*.pid 2>/dev/null
}

# The Following funtion is responsible for extracting the necessary entries
# from the auto.master file. Currently only the file is looked up. YP/NIS
# support not included!
# The function writes the extracted mounts to stdout. If an error occurs it
# prints out "ERROR" followed by a specific number and further information.
# The following errors are possible:
# ERROR 1: The auto.master file was not found. Currently this will exit the
#          function. One additional Paramter is written to stdout. It is the
#          path auto.master was searched with.
# ERROR 2: An auto.master entry could not been read. Additionally Parameters 
#          are the place where the entry came from (currently only the file
#          name of the auto.master file) and the first part (mount point) of
#          the entry.
# See the example auto.master for further details
function get_mounts() {
  local mnt maptype map options
  if [ ! -f $AUTO_MASTER ]
  then 
    echo ERROR 1 $AUTO_MASTER
    return 1
  fi
  cat $AUTO_MASTER | sed -e '/^#/d' -e '/^$/d' | (
    while read mnt maptype map options
    do
      if [ -z "$mnt" ]; then continue; fi # No data -> next entry
      if [ -z "$map" ] # Simple check: everything up to $map has to be filled
      then
        echo ERROR 2 $AUTO_MASTER $mnt
        continue
      fi
      echo $mnt $maptype $map $options
    done
  )
  return 0
}

# This function builds the automount command that finally should be executed.
function get_command() {
  local mnt=$1 maptype=$2 map=$3
  shift 3
  local foo mode="opts" aopts="" opts=""
  for foo in $*
  do
    if [ "$foo" = "--" ]
    then
      mode=aopts
      continue
    fi
    eval "$mode=\$$mode\\ $foo"
  done
  echo "$AUTOMOUNT_PATH -p" $(mnt2pidf $mnt) $aopts $AUTOMOUNTOPTIONS $mnt $maptype $map $opts $MAPOPTIONS
  return 0
}

# This function extracts the command line an automount was started with by
# using ps.
function get_ps_command() {
  local pid tt stat time command
  ps -axhwwwww | grep "$AUTOMOUNT_PATH" | (
    while read pid tt stat time command
    do
      if [ "$pid" = "$1" ]
      then
        echo $command |
   sed 's/\(file\|program\|yp\|nisplus\|hesiod\|ldap\) \(sun\|hesiod\)/\1,\2/'
        return 0
      fi
    done
  )
  return 1;
}

# This function is a small wrapper. It is started instead of executing the
# command for starting automount directly. It makes it easier to make some
# special additions to EVERY automount call that cannot be included in the
# command string (e.g. changes to $PATH).
function start_automount() {
  local ret
  export LD_PRELOAD=/usr/lib/autofs/automount_syslog.so
  $*
  ret=$?
  unset LD_PRELOAD
  return $ret
}

# This function kills all processes given by the PID files given as parameters.
# It waits 5 times 3 seconds. It prints the count and the
# still existing PID files on stdout. If it times out (5 times 3 seconds) it
# prints a count of -1 and the still existing PID files.
# If kill fails it prints only -2 and returns.
function do_umount() {
  local mounted=$@
  local pidf
  local count=1  # Variable to count how long we wait
  while true
  do
    kill -TERM `cat $mounted` 2>&1 ||
      { echo -2; return 2; }  # Error during kill
    sleep 3
    local _mounted=""
    for pidf in $mounted
    do
      if [ -f $pidf ]; then _mounted="$_mounted $pidf"; fi
    done
    mounted=$_mounted
    count=$(expr $count + 1)
    if [ $count -gt 5 ]
    then
      echo -1 $mounted  # "Giving up"
      return 1
    fi
    echo $count $mounted  # Print what is still mounted ("" if umounted)
    if [ -z "$mounted" ]; then return 0; fi  # No more open mounts
  done
}


###############################################################################

# Check if the automount binary is installed
if [ ! -x $AUTOMOUNT_PATH ]
then
  echo -e "\nCannot find automount binary ($AUTOMOUNT_PATH)"
  exit 5
fi

case "$1" in
 start)
  ret=0
  get_mounts | {
    while read mnt maptype map options
    do
      if [ "$mnt" = "ERROR" ]
      then
        if [ "$maptype" = "1" ]
        then
          echo -e "\nauto.master not found"
          exit 6
        elif [ "$maptype" = "2" ]
        then
          # We just report and set the return value to 1
          echo -e "\nError reading entry $options in $map!"
          ret=1
          continue # Process next entry
        else
          echo -e "\nUnknown Error!"
          exit 1  # We better leave
        fi
      fi
      # No errors -> check if this automount is already running
      if [ -f `mnt2pidf $mnt` ]
      then
        echo -e "\nAlready mounted: $mnt"
        continue
      fi
      # -> execute automount
      if start_automount `get_command $mnt $maptype $map $options`
      then
        echo -n " $mnt"
      else  # If an error occurs it will be printed. We should only set $ret
        ret=1
      fi
    done
    # When we leave the block, $ret will get lost! So we "return" it
    exit $ret
  }
  ret=$?
  ;;

 stop)
  pidfs=`get_pidfs`
  if [ -z "$pidfs" ]
  then
   echo -ne "\nNo running automount daemons!"
   exit 7
  fi

  echo `pidf2mnt $pidfs` # Show what we stopped
  echo "Waiting for automounts to umount..."
  ret=0
  do_umount $pidfs | {
    while read count mounted
    do
      if [ "$count" = "-2" ]; then exit 1; fi
      pidfs=$mounted  # We would loose $mounted when leaving the while loop
      if [ -n "$pidfs" -a "$count" != "-1" ]
      then
       echo "Still mounted: `pidf2mnt $pidfs` -- retrying... (attempt $count)"
      fi
    done
    if [ -n "$pidfs" ] # All mounts umounted?
    then
      echo -n "Cannot umount: `pidf2mnt $pidfs` -- giving up!"
      exit 1
    fi
    echo -n "All automounts umounted"
    exit $ret
  }
  ret=$?
  ;;

 force-reload|reload)
  echo  # We need a new line
  newpidfs=""  # PID files that are extracted from auto.master
  ret=0
  get_mounts | {
    while read mnt maptype map options
    do
      if [ "$mnt" = "ERROR" ]
      then
        if [ "$maptype" = "1" ]
        then
          echo -ne "\nauto.master not found"
          exit 6
        elif [ "$maptype" = "2" ]
        then
          # We just report and set the return value to 1
          echo "Error reading entry $options in $map!"
          ret=1
          continue # Process next entry
        else
          echo "Unknown Error!"
          exit 1  # We better leave
        fi
      fi

      # Get command, that would be executed by entry
      command=`get_command $mnt $maptype $map $options`
      # Get PID file for $mnt
      pidf=`mnt2pidf $mnt`
      newpidfs="$newpidfs $pidf"
      if [ ! -f $pidf ]
      then
        echo -n "Mounting new mount point $mnt ... "
        if start_automount $command
        then
          echo "done"
        else  # We don't need to leave, but we should set $ret
          echo "failed"
          ret=1  
        fi
        continue  # New entry processed => next entry
      fi
      # We have a running automount for $mnt
      # First get command of running automount
      pid=`cat $pidf`
      oldcommand=`get_ps_command $pid`
      if [ "$command" != "$oldcommand" ]
      then
        echo "Waiting for $mnt to umount ..."
        do_umount $pidf | {
          while read count _mounted
          do
            if [ "$count" = "-2" ]; then exit 1; fi
            mounted=$_mounted  # We would loose _mounted when leaving while loop
            if [ ! -z "$mounted" -a "$count" != "-1" ]
            then
              echo "Still mounted -- retrying... (attempt $count)"
            fi
          done
          if [ -n "$mounted" ] # All mounts umounted?
          then
            echo "Cannot umount -- giving up, $mnt will not be remounted!"
            exit 1
          fi
          echo -n "Remounting $mnt ... "
          if start_automount $command
          then
            echo "done"
          else
            echo "failed"
            ret=1
          fi
          exit $ret
        }
        ret=$?
      fi
    done

    # Now kill unused automounts
    if [ -z "$newpidfs" ]; then exit 1; fi  # Nothing read from auto.master
    for pidf in `get_pidfs`
    do
      if echo $newpidfs | grep -v $pidf >/dev/null 2>&1
      then
        echo -n "Umounting old automount `pidf2mnt $pidf` ... "
        do_umount $pidf | {
          while read count _mounted
          do
            if [ "$count" = "-2" ]; then exit 1; fi
            mounted=$_mounted  # Don't loose $_mounted after while
            if [ ! -z "$mounted" -a "$count" != "-1" ]
            then
              echo -ne "\nStill mounted -- retrying... (attempt $count)"
            fi
          done
          if [ -z "$mounted" ] # All mounts umounted?
          then
            echo "done"
          else
            echo -e "\nCannot umount -- giving up!"
            ret=1
          fi
          exit $ret
        }
        ret=$?
      fi
    done
    exit $ret
  }
  ret=$?
  ;;

 restart)
  ret=0
  echo -e "\nStopping..."
  $0 stop || ret=$?
  echo -e "\nRestarting..."
  $0 start || ret=$?
  ;;

 try-restart)
  echo -e "\nStopping..."
  $0 stop || exit $?
  ret=0
  echo -e "\nRestarting..."
  $0 start || ret=$?
  ;;

 status)
  ret=0
  echo
  echo "Configured Mount Points:"
  echo "------------------------"
  get_mounts | (
    while read mnt maptype map options
    do
      if [ "$mnt" = "ERROR" ]
      then
        if [ "$maptype" = "1" ]
        then
          # auto.master not found
          echo -e "\nCannot open $map!"
          break
        elif [ "$maptype" = "2" ]
        then
          echo -e "\nError reading entry $options in $map!"
          continue # Process next entry
        else
          echo -e "\nUnknown Error!"
          break
        fi
      fi
      echo -e "$mnt\t $maptype\t $map\t $options"
    done
  )
  echo
  echo "Active Mount Points:"
  echo "--------------------"
  pidfs=`get_pidfs`
  [ -z "$pidfs" ] && ret=3
  for pidf in $pidfs
  do
    pid=`cat $pidf`
    echo `get_ps_command $pid`
  done
  echo
  ;;

 probe)
  ret=3
  ;;

 *)
  echo "Parameters: {[re]start|stop|reload|status}"
  ret=2
  ;;

esac

exit $ret


--Boundary-00=_iM/P/LDXdgqAn7Z
Content-Type: application/x-shellscript;
  name="autofs.SuSE"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="autofs.SuSE"

#! /bin/bash

# TODO
# - INIT INFO

# This script wraps SuSE typical features around rc.autofs. As many features as
# possible are included. Since SuSE has already included the normal autofs
# system we even have a Variable set in rc.config!
#
### BEGIN INIT INFO
# Provides: FOO
# Required-Start: $remote_fs $syslog
# Required-Stop:  $remote_fs $syslog
# Default-Start:  3 5
# Default-Stop:   0 1 2 6
# Description:    Start FOO to allow XY and provide YZ.
### END INIT INFO

# Source SuSE config
. /etc/rc.config

# Determine the base and follow a runlevel link name.
base=${0##*/}
link=${base#*[SK][0-9][0-9]}

# Force execution if not called by a runlevel directory.
test $link = $base && START_AUTOFS=yes
test "$START_AUTOFS" = yes || exit 0

# Now set the variables used by rc.aufofs
#
# Name of the automount binary (also used for locking file names)
export AUTOMOUNT=automount
# The full path to the automount binary
export AUTOMOUNT_PATH="/usr/sbin/${AUTOMOUNT}"
# Additional Options for ALL automount daemons
export AUTOMOUNTOPTIONS=""
# Additional Options for ALL maps
export MAPOPTIONS=""
# The place, where we can find the auto.master file
export AUTO_MASTER="/etc/auto.master"


# Where is the "real" INIT-Script?
rc_autofs="/usr/sbin/rc.autofs"

. /etc/rc.status

# First reset status of this service
rc_reset

# Return values acc. to LSB for all commands but status:
# 0 - success
# 1 - misc error
# 2 - invalid or excess args
# 3 - unimplemented feature (e.g. reload)
# 4 - insufficient privilege
# 5 - program not installed
# 6 - program not configured
# 7 - program is not running
# 
# Note that starting an already running service, stopping
# or restarting a not-running service as well as the restart
# with force-reload (in case signalling is not supported) are
# considered a success.

case "$1" in
    start)
	echo -n "Starting autofs: "
	# startproc should return 0, even if service is 
	# already running to match LSB spec.
        $rc_autofs start
	rc_status -v
	;;
    stop)
	echo -n "Shutting down autofs: "
        $rc_autofs stop
	rc_status -v
	;;
    try-restart)
        echo -n "Trying to restart autofs: "
        $rc_autofs try-restart
	rc_status -v
	;;
    restart)
	echo -n "Reload service autofs: "
	$rc_autofs restart
	rc_status -v
	;;
    force-reload)
	echo -n "Reload service autofs: "
	$rc_autofs force-reload
	#touch /var/run/FOO.pid
	rc_status -v
	;;
    reload)
	echo -n "Reload service autofs: "
	$rc_autofs reload
	#touch /var/run/FOO.pid
	rc_status -v
	;;
    status)
	echo -n "Checking for autofs: "
	# Status has a slightly different for the status command:
	# 0 - service running
	# 1 - service dead, but /var/run/  pid  file exists
	# 2 - service dead, but /var/lock/ lock file exists
	# 3 - service not running

        $rc_autofs status
	rc_status
	;;
    probe)
	$rc_autofs probe
	rc_status
        ;;
    *)
	echo "Usage: $0 {start|stop|status|try-restart|restart|force-reload|reload|probe}"
	exit 2
	;;
esac
rc_exit

--Boundary-00=_iM/P/LDXdgqAn7Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_iM/P/LDXdgqAn7Z--

