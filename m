From: Hans Deragon <hans@deragon.biz>
Subject: Re: backfstype patch.
Date: Wed, 30 Jun 2004 11:01:42 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E2D5D6.6010604@deragon.biz>
References: <40E1CCC3.1010809@deragon.biz>
 <16610.49006.880121.543138@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <16610.49006.880121.543138@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Greetings Jeff.

Jeff Moyer wrote:
> ==> Regarding [autofs] backfstype patch.; Hans Deragon <hans@deragon.biz> adds:
> 
> hans> Greetings.  Attached, my patch for supporting backfstype.  If the OS
> hans> is Linux and cachefs is detected, this fs is ignored and no attempt
> hans> is made to mount a cachefs kernel module (none exist).  This way we
> hans> avoid useless error messages in syslog.
> 
> First off, thanks for taking the initiative!
> 
> Now, to business.  Ian meant to say that you _don't_ need to do #ifdef
> __linux__, as this is the Linux automounter.  It won't work on any other
> OS.
> 
> I'm not sure I like the special casing for cachefs, but that's ultimately
> Ian's call.  I just attempted a mount -t cachefs on my machine, and got no
> messages in the logs.  I wonder what's trying the modprobe.

I got messages in my logs.

> I've taken a cursory look at your patch, and inlined some initial
> comments.  I'll try to take a closer look at it some time this week.
> 
> Thanks!
> 
> Jeff
> 
> 
> 
> 
>>diff -Nur autofs-4.1.3.org/modules/parse_sun.c autofs-4.1.3/modules/parse_sun.c
>>--- autofs-4.1.3.org/modules/parse_sun.c	2004-05-18 08:22:40.000000000 -0400
>>+++ autofs-4.1.3/modules/parse_sun.c	2004-06-29 14:54:49.000000000 -0400
>>@@ -22,7 +22,6 @@
>>#include <fcntl.h>
>>#include <unistd.h>
>>#include <stdlib.h>
>>-#include <syslog.h>
>>#include <string.h>
>>#include <syslog.h>
>>#include <ctype.h>
>>@@ -516,17 +515,20 @@
>>static int sun_mount(const char *root, const char *name, int namelen,
>>		     const char *loc, int loclen, const char *options)
>>{
>>-	char *fstype = "nfs";	/* Default filesystem type */
>>+	char *fstype     = "nfs"; /* Default filesystem type */
> 
> 
> Bad form to change spacing.

Better alignment with new variable backfstype.  Looks cleaner.

> [snip]
> 
> 
>>@@ -551,6 +553,15 @@
>>				fstype = alloca(typelen + 1);
>>				memcpy(fstype, cp + 7, typelen);
>>				fstype[typelen] = '\0';
>>+			} else if (strncmp("backfstype=", cp, 11) == 0) {
>>+				int typelen = comma - (cp + 11);
>>+				backfstype = alloca(typelen + 1);
>>+				memcpy(backfstype, cp + 11, typelen);
>>+				backfstype[typelen] = '\0';
>>+#if 0
>>+			} else if (strncmp("cachedir=", cp, 9) == 0) {
>>+        /* Ignoring cachedir, since cachefs is not supported. */
>>+#endif
> 
> 
> Ick.

Ick what?

> [snip]
> 
> 
>>+#ifdef __linux__
>>+		if (!strcmp(curfstype, "cachefs")) {
>>+			/* cachefs not supported for Linux.  We do not even try because when
>>+			   we try, mount will complain about the module being absent.  This is
>>+			   not desired because if backfstype parameter is provided and works,
>>+			   we sure do not want any error messages reported to syslog. */
>>+			debug("cachefs not implemented under Linux and thus ignored.");
>>+			continue;
>>+		}
>>+#endif
> 
> 
> Don't need the ifdef.  Also, try to keep w/in 80 columns, please.

#ifdef could be removed.  And it is 80 columns!  Set your tabstops at 2. :) 
Granted, I have to figure out what your tab settings are, and my I suggest that 
you ban tabs all together?  I never found any value to use tabs, but always 
grief with alignements.

>>+
>>+		if (!strcmp(curfstype, "nfs")) {
>>+			/* Removing cachedir parameter which is not understood by nfs. */
>>+			start=strstr(noptions, ",cachedir=");
> 
> 
> You don't really need to do this.  We use the sloppy (-s) option to mount,
> which just ignore unrecognized options.

When I tested, nfs mount would fail when cachedir was present.  Are you sure 
that -s is sent to the mount command and it works?
> 
> [snip]
> 
> 
>>+		if(!rv)
>>+		{
>>+			break;
>>+		}
> 
> 
> Keep to coding style:  { on same line as if.

Agree.


Thanks for the comments.
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.     Open source:
http://www.deragon.biz        http://facil.qc.ca (Promotion du libre)
mailto://hans@deragon.biz     http://autopoweroff.sourceforge.net (Logiciel)
