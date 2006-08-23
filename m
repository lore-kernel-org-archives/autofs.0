From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs5: unable to locate ldap master map
Date: Wed, 23 Aug 2006 15:43:21 +0200
Message-ID: <44EC5B79.4050102@inria.fr>
References: <44A25311.2040501@inria.fr>	
	<1151554184.2929.45.camel@raven.themaw.net>
	<44A3B6CD.5030403@inria.fr>
	<1151585997.3915.36.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1151585997.3915.36.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org

Ian Kent wrote:
> On Thu, 2006-06-29 at 13:17 +0200, Guillaume Rousse wrote:
>>>> 2) using nss-based master map lookup, by using "/usr/sbin/automount
>>>> name-without-path", and insert a "ldap" value in "automount" line in
>>>> "/etc/nsswitch.conf"
>>> Yep. Or just use the default name which is auto.master.
>> Right (according to include/default.h), but then man page template has
>> to be corrected: it gives "@autofsmapdir@@/auto.master" as default.
> 
> Oops. I'll fix that.
Here is the patch, quite longue because the file is renamed now that no
substitution is needed anymore.

diff -Naur autofs-5.0.1/man/automount.8
autofs-5.0.1.fix-man-page/man/automount.8
--- autofs-5.0.1/man/automount.8	1970-01-01 01:00:00.000000000 +0100
+++ autofs-5.0.1.fix-man-page/man/automount.8	2006-08-23
13:52:26.000000000 +0200
@@ -0,0 +1,107 @@
+.\" Linux man page by B. James Phillippe, 1997 <bryan@Terran.ORG>
+.\"
+.\" This page was written to contribute to the Linux kernel autofs
+.\" implementation by H. Peter Anvin (1997).  It is loosly based on
+.\" the documentation for mount(8) and amd(8) Linux manpages.
+.\"
+.\" This is free documentation.
+.\"
+.\" $Id: automount.8,v 1.8 2004/11/20 13:54:39 raven Exp $
+.\"
+.TH AUTOMOUNT 8 "12 Apr 2006"
+.SH NAME
+automount \- manage autofs mount points
+.SH SYNOPSIS
+\fBautomount\fP [\fIoptions\fP] [\fImaster_map\fP]
+.SH DESCRIPTION
+The \fBautomount\fP program is used to manage mount points for
+autofs, the inlined Linux automounter.  \fBautomount\fP works by
+reading the
+.nh
+.BR auto.master (8)
+.hy
+map and sets up mount points for each entry in the master map allowing
+them to be automatically mounted when accessed. The file systems are
+then automatically umounted after a period of inactivity.
+.SH OPTIONS
+.TP
+.I "\-h, \-\-help"
+Print brief help on program usage.
+.TP
+.I "\-p, \-\-pid-file"
+Write the pid of the daemon to the specified file.
+.TP
+.I "\-t, \-\-timeout"
+Set the global minimum timeout, in seconds, until directories
+are unmounted. The default is 10 minutes. Setting the timeout
+to zero disables umounts completely.
+.TP
+.I "\-v, \-\-verbose"
+Enables logging of general status and progress messages for all
+autofs managed mounts.
+.TP
+.I "\-d, \-\-debug"
+Enables logging of general status and progress messages as well as
+debuging messages for all autofs managed mounts.
+.TP
+.I "\-Dvariable=value"
+Define a global macro substitution variable. Global definitions
+are over-ridden macro definitions of the same name specified in
+mount entries.
+.TP
+.I "\-V, \-\-version"
+Display the version number, then exit.
+.SH ARGUMENTS
+\fBautomount\fP takes one optional argument, the name of the master map to
+use.
+.TP
+\fBmaster_map\fP
+Location for autofs master map that defines autofs managed mount points
+and the mount maps they will use. The default is
+.nh
+\fBauto.master\fP.
+.hy
+.RE
+.SH NOTES
+If the \fBautomount\fP daemon catches a USR1 signal, it will umount all
+currently unused autofs managed mounted file systems and continue running
+(forced expire).  If it catches the TERM signal it will umount
+all unused autofs managed mounted file systems and exit if there are
+no remaining busy file systems. If autofs has been compiled with the
+option to ignore busy mounts on exit it will exit leaving any busy
+mounts in place otherwise busy file systems will not be umounted
+and autofs will not exit.
+Alternatively, if autofs has been compiled with the option to enable
+forced shutdown then a USR2 signal to the daemon will cause all
+mounts to be umounted and any busy mounts to be forcibly umounted,
+including autofs mount point directories (summary execution). Note
+that the forced umount is an unlink operation and the actual umount
+will not happen in the kernel until active file handles are released.
+The daemon also responds to a HUP signal which triggers an update of
+the maps for each mount point.
+.P
+If any autofs mount point directories are busy when the daemon is sent
+an exit signal the daemon will not exit. The exception to this is
+if autofs has been built with configure options to either ignore busy
+mounts at exit or force umount at exit. If the ignore busy mounts at
+exit option is used the filesystems will be left in a catatonic
+(non-functional) state and can be manually umounted when they become
+unused. If the force umount at exit option is used the filesystems
+will be umounted but the mount will not be released by the kernel
+until they are no longer in use by the processes that held them busy.
+If automount managed filesystems are found mounted when autofs is
+started they will be recoverd unless they are no longer present in
+the map in which case they need to umounted manually.
+.SH "SEE ALSO"
+.BR autofs (5),
+.BR mount (8).
+.SH BUGS
+Don't know, I've fixed everything I know about.
+
+The documentation could be better.
+
+Please report other bugs along with a detailed description to
+<autofs@linux.kernel.org>. For instructions on how to join the list
+and for archives visit http://linux.kernel.org/mailman/listinfo/autofs
+.SH AUTHOR
+H. Peter Anvin <hpa@transmeta.com> and Ian Kent <raven@themaw.net>.
diff -Naur autofs-5.0.1/man/automount.8.in
autofs-5.0.1.fix-man-page/man/automount.8.in
--- autofs-5.0.1/man/automount.8.in	2006-07-13 10:11:39.000000000 +0200
+++ autofs-5.0.1.fix-man-page/man/automount.8.in	1970-01-01
01:00:00.000000000 +0100
@@ -1,107 +0,0 @@
-.\" Linux man page by B. James Phillippe, 1997 <bryan@Terran.ORG>
-.\"
-.\" This page was written to contribute to the Linux kernel autofs
-.\" implementation by H. Peter Anvin (1997).  It is loosly based on
-.\" the documentation for mount(8) and amd(8) Linux manpages.
-.\"
-.\" This is free documentation.
-.\"
-.\" $Id: automount.8,v 1.8 2004/11/20 13:54:39 raven Exp $
-.\"
-.TH AUTOMOUNT 8 "12 Apr 2006"
-.SH NAME
-automount \- manage autofs mount points
-.SH SYNOPSIS
-\fBautomount\fP [\fIoptions\fP] [\fImaster_map\fP]
-.SH DESCRIPTION
-The \fBautomount\fP program is used to manage mount points for
-autofs, the inlined Linux automounter.  \fBautomount\fP works by
-reading the
-.nh
-.BR auto.master (8)
-.hy
-map and sets up mount points for each entry in the master map allowing
-them to be automatically mounted when accessed. The file systems are
-then automatically umounted after a period of inactivity.
-.SH OPTIONS
-.TP
-.I "\-h, \-\-help"
-Print brief help on program usage.
-.TP
-.I "\-p, \-\-pid-file"
-Write the pid of the daemon to the specified file.
-.TP
-.I "\-t, \-\-timeout"
-Set the global minimum timeout, in seconds, until directories
-are unmounted. The default is 10 minutes. Setting the timeout
-to zero disables umounts completely.
-.TP
-.I "\-v, \-\-verbose"
-Enables logging of general status and progress messages for all
-autofs managed mounts.
-.TP
-.I "\-d, \-\-debug"
-Enables logging of general status and progress messages as well as
-debuging messages for all autofs managed mounts.
-.TP
-.I "\-Dvariable=value"
-Define a global macro substitution variable. Global definitions
-are over-ridden macro definitions of the same name specified in
-mount entries.
-.TP
-.I "\-V, \-\-version"
-Display the version number, then exit.
-.SH ARGUMENTS
-\fBautomount\fP takes one optional argument, the name of the master map to
-use.
-.TP
-\fBmaster_map\fP
-Location for autofs master map that defines autofs managed mount points
-and the mount maps they will use. The default is
-.nh
-\fB@@autofsmapdir@@/auto.master\fP.
-.hy
-.RE
-.SH NOTES
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
-.SH "SEE ALSO"
-.BR autofs (5),
-.BR mount (8).
-.SH BUGS
-Don't know, I've fixed everything I know about.
-
-The documentation could be better.
-
-Please report other bugs along with a detailed description to
-<autofs@linux.kernel.org>. For instructions on how to join the list
-and for archives visit http://linux.kernel.org/mailman/listinfo/autofs
-.SH AUTHOR
-H. Peter Anvin <hpa@transmeta.com> and Ian Kent <raven@themaw.net>.

Tested, it works.
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
