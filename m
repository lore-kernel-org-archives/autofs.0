From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] umount loopback filessystems on autofs stop
Date: Thu, 02 Sep 2004 22:31:26 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4137D77E.9080703@sun.com>
References: <11395.1094160050@ichips.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <11395.1094160050@ichips.intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Joseph V Moss <jmoss@ichips.intel.com>
Cc: autofs@linux.kernel.org, raven@themaw.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joseph V Moss wrote:
> Using /proc/mounts could be an issue for anyone trying to use this
with a kernel
> that truncates /proc/mounts.
>

Which kernel truncates /proc/mounts?

Any recent kernel uses the seq_file interface which guarantees that
nothing gets truncated.  I have a system up and running that works fine
with about 2500 mounts.


>
>>Hello,
>>
>>The netfs scripts for Red Hat go through and umount any loopback devices
>>before attempting to umount the encompassing filesystem.  This seems a
sane
>>thing to do (and I have a bug on said issue), so I've added similar
>>functionality to the autofs init script.  Attached is a patch.  Comments
>>encouraged.  Testing by debian folks would be nice, too.
>>
>>-Jeff
>>
>>--- autofs-4.1.3/samples/rc.autofs.in.umount-loopback	2004-09-02
15:55:21.722705296 -0400
>>+++ autofs-4.1.3/samples/rc.autofs.in	2004-09-02 16:16:09.985940440 -0400
>>@@ -351,6 +351,31 @@ function signal_automounts()
>> 	return $RETVAL
>> }
>>
>>+function umount_loopback()
>>+{
>>+    loops=`LC_ALL=C awk '!/^#/ && $1 ~ /^\/dev\/loop/ && $2 != "/"
{print $2}' /proc/mounts`
>>+    automounts=`LC_ALL=C awk '!/^#/ && $1 ~ /^automount/ {print $2}'
/proc/mounts`
>>+
>>+    for l in $loops
>>+    do
>>+	for a in $automounts
>>+	do
>>+	    command="echo $l | grep -E '^$a'"
>>+	    match=`echo $command | sh`
>>+	    if [ -n "$match" ]; then
>>+		echo ""
>>+		echo -n $"Unmounting loopback filesystem $match:  "
>>+		umount -d $match
>>+		if [ $? -eq 0 ]; then
>>+		    echo "done"
>>+		else
>>+		    echo "failed ($?)"
>>+		fi
>>+	    fi
>>+	done
>>+    done
>>+}
>>+
>> # Redhat start/stop function.
>> #
>> function redhat()
>>@@ -386,6 +411,7 @@ case "$1" in
>> 	if [ -z "`pidofproc $prog`" -a -z "`getmounts`" ]; then
>> 		RETVAL=0
>> 	else
>>+		umount_loopback
>> 		signal_automounts
>> 		RETVAL=$?
>> 	fi
>>@@ -477,6 +503,7 @@ case "$1" in
>> 	;;
>>     stop)
>> 	echo 'Stopping automounter.'
>>+	umount_loopback
>> 	start-stop-daemon --stop --quiet --signal USR2 --exec $DAEMON
>> 	;;
>>     reload|restart)
>>
>>_______________________________________________
>>autofs mailing list
>>autofs@linux.kernel.org
>>http://linux.kernel.org/mailman/listinfo/autofs
>>
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBN9d9dQs4kOxk3/MRAuv7AJ9RwuxkWHgwUkHsW/+C+Qoy/5hzhgCdFoSW
fM9teS9ID1cEs0ZzVJfgO+g=
=qIAQ
-----END PGP SIGNATURE-----
