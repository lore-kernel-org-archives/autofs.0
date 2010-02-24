From: x@muc.ccc.de
Subject: Re: automounting smb share with options,
 and suggestion to use fstab entry for direct mounts without options
 and target
Date: Wed, 24 Feb 2010 16:22:50 +0100
Message-ID: <4B85444A.5010605@muc.ccc.de>
References: <4B8416AB.4090207@muc.ccc.de> <4B84916E.7060208@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070900040308010200020700"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B84916E.7060208@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------070900040308010200020700
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

hi!

Ian Kent wrote:
> You can't start a mount location with "/" because it will be interpreted
> as a path instead of a mount location. The sun ":" escape has always
> been used to cover this case.

ahok, sorry, i saw this construct but failed to find good documentation and just forgot about it...
what i also found out in the process: for a literal \ or $, they must be escaped (makes me curious about what can be done with $ - environment variables, i guess :). trailing / don't seem to make any troubles.

ok and to compensate for my bad conscience, attached a diff for the auto.master manpage, adding a paragraph describing the map format.

>> possibility to just add the mountpoint to the direct mounts, so that
>> automount will just mount the fs according to fstab (like when
[...]
> I'd need to think about it for a while.

great to hear, thanks for considering the idea! :)

btw another point i stumbled over is that the (imho quite nice) /etc/init.d/autofs status feature seems to have been removed in rev. 5 - if it's not meant to come back eventually, i guess it were a good idea to remove it from autofs.8, too.

regards,

	Chris

--------------070900040308010200020700
Content-Type: text/x-patch;
 name="auto.master.5.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="auto.master.5.in.patch"

--- auto.master.5.in.orig	2010-02-24 15:17:54.000000000 +0100
+++ auto.master.5.in	2010-02-24 16:00:52.000000000 +0100
@@ -157,6 +157,38 @@ command line.
 Set the timeout for caching failed key lookups. This option can be
 used to override the global default given either on the command line
 or in the configuration.
+.SH MAP FORMAT
+.P
+The format of a map is as follows:
+.TP
+.IR key	mount-options	target
+.TP
+.B key
+defines the key (which is the name of the directory inside the indirect map's mountpoint) in case of an indirect map, or the full mountpoint (probably always absolute, as there's no special context for a relative path) in case of a direct map.
+.TP
+.B mount-options
+defines the mount options used when the respective filesystem is mounted. The options here are the same as the options given after the -o switch of mount, but with a leading \fB-\fP (e.g. for \fBmount <mountpoint> -o fstype=smbfs,user=foo <target>\fP, the equivalent \fBmount-options\fP would be \fB-fstype=smbfs,user=foo\fP).
+.TP
+.B target
+defines the target which is to be mounted. Targets beginning with \fB/\fP are interpreted as files. To specify a path, a leading \fB:\fP must be added. \fB\[rs]\fP is the escape character. A literal \fB\[rs]\fP can be used but then must be escaped (e.g. \fB\[rs]\[rs]\fP). A literal \fB$\fP can be used but must be escaped (\fB\[rs]$\fP).
+.TP
+As an example, a line in a direct map might look like this:
+.sp
+.RS +.2i
+.ta 1.0i
+.nf
+/srv/smb-e     -fstype=smbfs,ip=192.168.1.2,user=administrator,password=secret,uid=root,gid=root       ://192.168.1.2/E\[rs]$/
+.fi
+.RE
+.sp
+And a line in an indirect map might look like this:
+.sp
+.RS +.2i
+.ta 1.0i
+.nf
+floppy         -fstype=auto            :/dev/fd0
+.fi
+.RE
 .SH GENERAL SYSTEM DEFAULTS CONFIGURATION
 .P
 The default value of several general settings may be changed in the

--------------070900040308010200020700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------070900040308010200020700--

