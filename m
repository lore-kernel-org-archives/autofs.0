From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Suggestion for better manpage.
Date: Tue, 17 Jun 2008 10:44:09 -0400
Message-ID: <x497ico15qe.fsf@segfault.boston.devel.redhat.com>
References: <200806171257.45914.stef@bononline.nl>
	<1213704836.20728.10.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1213704836.20728.10.camel@raven.themaw.net> (Ian Kent's message
	of "Tue, 17 Jun 2008 20:13:56 +0800")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent <raven@themaw.net> writes:

> On Tue, 2008-06-17 at 12:57 +0200, Stef Bon wrote:
>> Hello,
>> 
>> reading the manpage of automount, I would like to change the section in the 
>> manpage about how the daemon reacts on signals.
>
> Send a patch.

Try this on for size.

Cheers,

Jeff

diff --git a/man/automount.8 b/man/automount.8
index 59ad50e..4cb7384 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -92,36 +92,51 @@ and the mount maps they will use. The default is
 \fBauto.master\fP.
 .hy
 .RE
+.SH SIGNALS
+.TP
+\fBSIGHUP\fP
+This signal triggers a re-read of the automount configuration.
+.TP
+\fBSIGTERM\fP
+This signal instructs the daemon to unmount all unused file systems
+and exit.  If any file system cannot be unmounted, then the daemon does not
+exit unless the daemon was compiled with either the ENABLE_IGNORE_BUSY_MOUNTS
+option or the ENABLE_FORCED_SHUTDOWN option set (see \fBNOTES\fP below).
+If ENABLE_IGNORE_BUSY_MOUNTS is set, the daemon will unmount unused file
+systems and exit, leaving busy file systems mounted.  If the
+ENABLE_FORCED_SHUTDOWN options is set, then the file systems will be
+unmounted and the daemon will exit, but the busy mountpoints will not be
+released by the kernel until they are no longer in use by the processes
+that held them busy.
+.TP
+\fBSIGUSR1\fP
+Sending this signal to the running automount daemon will cause a forced
+expire.  All automount-managed mount points that are not busy will be
+unmounted.
+.TP
+\fBSIGUSR2\fP
+This signal requires that the daemon is compiled with the
+ENABLE_FORCED_SHUTDOWN flag set (see \fBNOTES\fP below).  Sending this
+signal to the running automount daemon will cause a summary execution;
+all automount-managed mount points will be unmounted, whether they are busy
+or not.  Note that the forced unmount is an unlink operation (umount -l),
+and the actual umount will not happen in the kernel until active file
+handles are released.  In current incarnations of autofs (all releases of
+version 5, up to and including 5.0.3 and potentially newer releases, too),
+this can cause unwanted behaviour in applications.  Since the mount point
+is unlinked from the file system tree, and attempt to get a current working
+directory will fail.
+
 .SH NOTES
-If the \fBautomount\fP daemon catches a USR1 signal, it will umount all
-currently unused autofs managed mounted file systems and continue running
-(forced expire).  If it catches the TERM signal it will umount
-all unused autofs managed mounted file systems and exit if there are
-no remaining busy file systems. If autofs has been compiled with the
-option to ignore busy mounts on exit it will exit leaving any busy
-mounts in place otherwise busy file systems will not be umounted
-and autofs will not exit.
-Alternatively, if autofs has been compiled with the option to enable
-forced shutdown then a USR2 signal to the daemon will cause all
-mounts to be umounted and any busy mounts to be forcibly umounted,
-including autofs mount point directories (summary execution). Note
-that the forced umount is an unlink operation and the actual umount
-will not happen in the kernel until active file handles are released.
-The daemon also responds to a HUP signal which triggers an update of
-the maps for each mount point.
-.P
-If any autofs mount point directories are busy when the daemon is sent
-an exit signal the daemon will not exit. The exception to this is
-if autofs has been built with configure options to either ignore busy
-mounts at exit or force umount at exit. If the ignore busy mounts at
-exit option is used the filesystems will be left in a catatonic
-(non-functional) state and can be manually umounted when they become
-unused. If the force umount at exit option is used the filesystems
-will be umounted but the mount will not be released by the kernel
-until they are no longer in use by the processes that held them busy.
-If automount managed filesystems are found mounted when autofs is
-started they will be recoverd unless they are no longer present in
-the map in which case they need to umounted manually.
+To see which compile-time options were selected, run '/usr/sbin/automount -V'.
+The names of the selected options will be present in the "Compile options:"
+section.
+
+If automount-managed file systems are found already mounted when the automount
+daemon starts, those file systems will be recovered unless they are no longer
+present in the automounter configuration.  In that case, the file systems will
+need to be manually unmounted.
+
 .SH "SEE ALSO"
 .BR autofs (5),
 .BR autofs (8),
