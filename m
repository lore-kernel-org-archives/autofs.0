From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Re[4]: autofs reload
Date: Fri, 26 Mar 2004 12:38:37 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16484.27293.279258.40887@segfault.boston.redhat.com>
References: <16484.25454.659035.551208@segfault.boston.redhat.com>
	<E1B6v3m-0000cJ-00.ia6432-inbox-ru@f25.mail.ru>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1B6v3m-0000cJ-00.ia6432-inbox-ru@f25.mail.ru>
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
To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Cc: autofs@linux.kernel.org

==> Regarding Re[4]: [autofs] autofs reload; "Peter Lojkin" <ia6432@inbox.ru> adds:

ia6432> On Fri, 26 Mar 2004 at 12:07:58 -0500, Jeff Moyer wrote: yes this
ia6432> share was umounted a couple of days prior to auto.home nis map
ia6432> update.
>> What I meant was, at the time you did an ls, were you sure that there
>> were no applications accessing the directory.
ia6432> yes there're no applications accessing the directory...

>> If nothing was accessing the directory (even if it is mounted), then
>> autofs should be able reload just fine.  If that's not the case, then I
>> am certainly perplexed.
ia6432> looks like it now needs HUP signal to update cache as mentioned in
ia6432> other rely...

Duh.  Reload only checks for changes in the auto.master file.  Sorry for
the noise.

>> >> controlled by autofs.  Attached is a patch which addresses this.  >>
>> Comments welcome.
ia6432> this should fix autofs reload or stop/start? i'll try...
>> No, this will prevent the automount daemon from starting more than once
>> for a given mount point.  Sorry if that was confusing.
ia6432> well it works i.e. no more duplicate automount and it's good.  but
ia6432> now we need to fix "stop" because when i did autofs stop, then
ia6432> installed new version and did autofs start i got unusable /auto and
ia6432> /home.  with autofs stop all automount processes stoped but autofs
ia6432> on /auto and /home was not umounted (there're directories in use),
ia6432> so when i started new version no daemon came up for this points.
ia6432> then i did umount /auto /home and got several "Busy inodes after
ia6432> unmount".  after next autofs restart everything worked...

Did the script return success when you issued the stop?   My guess is it
just didn't wait long enough for the umount?  Just a guess.

Anyway, I've got some changes to the redhat side of the autofs script to
change the status it prints out (to reflect reality).  Perhaps the attached
patch is worth including?

It may even be beneficial to change autofs reload to send a HUP to all
automount daemons.  Ian, what do you think?

Cheers,

Jeff


--- autofs-4.1.1/samples/rc.autofs.in.init-redhat-only	2004-01-29 11:01:22.000000000 -0500
+++ autofs-4.1.1/samples/rc.autofs.in	2004-03-19 17:41:35.000000000 -0500
@@ -344,7 +336,11 @@
         getmounts | tee $TMP | sh
         RETVAL=$?
 	if [ -s $TMP ] ; then
-	    success "$prog startup" || failure "$prog startup"
+	    if [ $RETVAL -eq 0 ] ; then
+		success "$prog startup"
+	    else
+		failure "$prog startup"
+	    fi
 	    [ $RETVAL = 0 ] && touch /var/lock/subsys/autofs
 	else
 	    echo -n "" $"No Mountpoints Defined"
@@ -356,22 +352,25 @@
   stop)
 	echo -n $"Stopping $prog:"
 	if [ -z "`pidofproc $prog`" -a -z "`getmounts`" ]; then
-		success $"$prog shutdown"
 		RETVAL=0
 	else
 		signal_automounts
 		RETVAL=$?
-		success "$prog shutdown" || failure "$prog shutdown"
 	fi
 	count=0
 	while [ -n "`/sbin/pidof $DAEMON`" -a $count -lt 10 ] ; do
-	   killproc $DAEMON -USR2 2> /dev/null
+	   killproc $DAEMON -USR2 >& /dev/null
 	   RETVAL=$?
 	   [ $RETVAL = 0 -a -z "`/sbin/pidof $DAEMON`" ] || sleep 3
 	   count=`expr $count + 1`
 	done
 	umount -a -f -t autofs
 	rm -f /var/lock/subsys/autofs
+	if [ -n "`/sbin/pidof $DAEMON`" ] ; then
+	    failure "$prog shutdown"
+	else
+	    success "$prog shutdown"
+	fi
 	echo
 	;;
   restart)
