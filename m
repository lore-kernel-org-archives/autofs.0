From: Joseph V Moss <jmoss@ichips.intel.com>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Fri, 21 Oct 2005 10:41:24 -0700
Message-ID: <29797.1129916484@plxw9904.pdx.intel.com>
References: <17241.6728.530111.716756@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Fri, 21 Oct 2005 12:41:44 EDT."
	<17241.6728.530111.716756@segfault.boston.redhat.com> 
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jmoyer@redhat.com
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

> ==> Regarding Re: [autofs] Unable to mount with autofs-4.1.4: aquire_lock: can't lock lock file timed out: /var/lock/autofs; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Fri, 21 Oct 2005, Rainer Krienke wrote:
> >> On Mittwoch 19 Oktober 2005 17:55, Ian Kent wrote: > As Jeff has said
> >> this sort of nesting of mounts is, in general, not > supported by autofs
> >> and it worked previously because the locking was less > broken in 4.1.3
> >> than in 4.1.4 (yes its still broken in 4.1.4).
> >> >
> >> > Can this case be done safely?
> >> >
> >> > I'm not entirely sure of the answer to this but I've never liked using
> >> > locking in autofs. I introduced it only to prevent mtab corruption
> >> during > mount (correct me if you have a different recollection
> >> Jeff). It happens > during rapid mount activity such as when there as a
> >> largish number of > entries in the master map (of the order of 50 or
> >> more).
> >> >
> >> > The mtab locking should be done in mount which narrows the scope of
> >> the > lock enough to allow this case to function as requested.
> >> >
> >> 
> >> For me it would be important to learn if this feature will be possible
> >> in the future or if it is decided that for whatever reason it will not
> >> be. The former case would be the best thing for me because I would not
> >> have to find a new solution for mounting home directories and I guess
> >> other people with a large user base would also welcome it. In the latter
> >> case I have to think about a alternative way to go for the future. At
> >> the moment my solution is to use an older version of autofs for suse10.0
> >> installations since this older autofs version simply works for me but
> >> this is of course not an ideal solution.
> >> 
> >> Any comments?
> 
> raven> Yes.
> 
> raven> I was wondering what can be done about this also.
> 
> raven> All that I can offer is to make a patch to remove the locking from
> raven> autofs and another for mount (util-linux) to hopefully fix the mtab
> raven> locking. If you are prepared to carry these non-standard patches we
> raven> can see how it goes. Somewhat more testing would be required before
> raven> removing the locking from the distribution.
> 
> What, exactly, do you think is broken about the mtab locking?  I remember
> spending a few hours with that code, and it looked sane to me.

We used to see the problem of the mtab getting corrupted due to too
many filesystems getting mounted within a short time frame.  We started
using this patch a while ago and have continued to do so, even though
autofs now has locking.  The mtab problems stopped after making this
change.

===============================================================================
If there are lots of mounts happening simultaneously (usually due to autofs),
the locking of /etc/mtab could fail, in which case, the mount succeeds, but
doesn't get properly recorded in the mount table.  This patch greatly
increases the number of tries to lock the mtab, before giving up.  The chance
that the lock will fail due to contention from lots of other mount processes
should be very close to nil.

 -- Joseph Moss <jmoss@ichips.intel.com> 13-Nov-2002

--- util-linux-2.11g/mount/fstab.c.waitlock	Wed Nov 13 11:45:40 2002
+++ util-linux-2.11g/mount/fstab.c	Wed Nov 13 12:04:55 2002
@@ -441,8 +441,12 @@
 			alarm(0);
 			/* Limit the number of iterations - maybe there
 			   still is some old /etc/mtab~ */
-			if (tries++ > 3) {
-				if (tries > 5)
+			if (tries++ > 2) {
+				if ((tries % 20) == 0)
+				    printf(_("Warning: Unable to create link %s"
+						" after %d tries\n"),
+					   MOUNTED_LOCK, tries);
+				if (tries > 115)
 					die (EX_FILEIO, _("Cannot create link %s\n"
 					    "Perhaps there is a stale lock file?\n"),
 					     MOUNTED_LOCK);
