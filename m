From: Jeff Moyer <jmoyer@redhat.com>
Subject: RE: [patch] umount loopback filessystems on autofs stop
Date: Fri, 3 Sep 2004 10:17:07 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16696.31971.99631.303086@segfault.boston.redhat.com>
References: <482A3FA0050D21419C269D13989C61130435E749@lavender-fe.eng.netapp.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482A3FA0050D21419C269D13989C61130435E749@lavender-fe.eng.netapp.com>
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
To: "Lever, Charles" <cel@netapp.com>
Cc: autofs@linux.kernel.org, Mike Waychison <Michael.Waychison@Sun.COM>

==> Regarding RE: [autofs] [patch] umount loopback filessystems on autofs stop; "Lever, Charles" <cel@netapp.com> adds:

cel> i know that some RHEL AS 2.1 kernels truncate /proc/mounts.  they have
cel> a single page buffer for /proc/mounts and do not use seq_file.  i'm
cel> not sure if this has been addressed in recent updates; maybe jeff
cel> knows.

AS2.1 does not support autofs4, so there's really no problem there.  ;)

-Jeff

>> -----Original Message-----
From> Mike Waychison [mailto:Michael.Waychison@Sun.COM]
Sent> Thursday, September 02, 2004 10:31 PM
To> Joseph V Moss
Cc> autofs@linux.kernel.org; raven@themaw.net
Subject> Re: [autofs] [patch] umount loopback filessystems on
>> autofs stop
>> 
>> 
>> -----BEGIN PGP SIGNED MESSAGE-----
Hash> SHA1
>> Joseph V Moss wrote: > Using /proc/mounts could be an issue for anyone
>> trying to use this with a kernel > that truncates /proc/mounts.
>> >
>> 
>> Which kernel truncates /proc/mounts?
>> 
>> Any recent kernel uses the seq_file interface which guarantees that
>> nothing gets truncated.  I have a system up and running that works fine
>> with about 2500 mounts.
>> 
>> 
>> >
>> >>Hello,
>> >>
>> >>The netfs scripts for Red Hat go through and umount any loopback
>> >>devices before attempting to umount the encompassing filesystem.  This
>> >>seems a sane >>thing to do (and I have a bug on said issue), so I've
>> added similar >>functionality to the autofs init script.  Attached is a
>> patch.  >>Comments encouraged.  Testing by debian folks would be nice,
>> too.
>> >>
>> >>-Jeff
>> >>
>> >>--- autofs-4.1.3/samples/rc.autofs.in.umount-loopback 2004-09-02
15> 55:21.722705296 -0400
>> >>+++ autofs-4.1.3/samples/rc.autofs.in 2004-09-02
16> 16:09.985940440 -0400
>> >>@@ -351,6 +351,31 @@ function signal_automounts() >> return $RETVAL >>
>> }
>> >>
>> >>+function umount_loopback() >>+{ >>+ loops=`LC_ALL=C awk '!/^#/ && $1
>> ~ /^\/dev\/loop/ && $2 != "/" {print $2}' /proc/mounts` >>+
>> automounts=`LC_ALL=C awk '!/^#/ && $1 ~ /^automount/ {print $2}'
>> /proc/mounts` >>+ >>+ for l in $loops >>+ do >>+ for a in $automounts
>> >>+ do >>+ command="echo $l | grep -E '^$a'" >>+ match=`echo $command |
>> sh` >>+ if [ -n "$match" ]; then >>+ echo "" >>+ echo -n $"Unmounting
>> loopback filesystem $match: " >>+ umount -d $match >>+ if [ $? -eq 0 ];
>> then >>+ echo "done" >>+ else >>+ echo "failed ($?)"  >>+ fi >>+ fi >>+
>> done >>+ done >>+} >>+ >> # Redhat start/stop function.
>> >> #
>> >> function redhat() >>@@ -386,6 +411,7 @@ case "$1" in >> if [ -z
>> "`pidofproc $prog`" -a -z "`getmounts`" ]; then >> RETVAL=0 >> else >>+
>> umount_loopback >> signal_automounts >> RETVAL=$?  >> fi >>@@ -477,6
>> +503,7 @@ case "$1" in >> ;; >> stop) >> echo 'Stopping automounter.'
>> >>+ umount_loopback >> start-stop-daemon --stop --quiet --signal USR2
>> --exec $DAEMON >> ;; >> reload|restart)
>> >>
>> >>_______________________________________________ >>autofs mailing list
>> >>autofs@linux.kernel.org
>> >>http://linux.kernel.org/mailman/listinfo/autofs
>> >>
>> >
>> >
>> > _______________________________________________ > autofs mailing list
>> > autofs@linux.kernel.org >
>> http://linux.kernel.org/mailman/listinfo/autofs
>> 
>> 
>> - --
>> Mike Waychison Sun Microsystems, Inc.  1 (650) 352-5299 voice 1 (416)
>> 202-8336 voice
http> //www.sun.com
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE> The opinions expressed in this email are held by me,
>> and may not represent the views of Sun Microsystems,
>> Inc. ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> -----BEGIN PGP SIGNATURE-----
Version> GnuPG v1.2.4 (GNU/Linux)
>> iD8DBQFBN9d9dQs4kOxk3/MRAuv7AJ9RwuxkWHgwUkHsW/+C+Qoy/5hzhgCdFoSW
>> fM9teS9ID1cEs0ZzVJfgO+g= =qIAQ -----END PGP SIGNATURE-----
>> 
>> _______________________________________________ autofs mailing list
>> autofs@linux.kernel.org
http> //linux.kernel.org/mailman/listinfo/autof> s
>>

cel> _______________________________________________ autofs mailing list
cel> autofs@linux.kernel.org
http> //linux.kernel.org/mailman/listinfo/autofs
