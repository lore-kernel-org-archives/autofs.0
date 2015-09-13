From: Ian Kent <raven@themaw.net>
Subject: Re: automount subprocesses accumulate
Date: Sun, 13 Sep 2015 19:52:13 +0800
Message-ID: <1442145133.2902.26.camel@themaw.net>
References: <55F1971B.1050301@excellency.fr>
	  <1441949699.5198.6.camel@themaw.net> <55F2EFBD.2020104@excellency.fr>
	 <1442142599.2902.13.camel@themaw.net> <55F55C0E.3010806@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=7x8cSMt+zGRb8opHcRnN/xvqoa4=; b=r5XjrV
	vZtmjX4ABmgTllZKXtq8HKy2dCm39hYiWppooLZbopv7hEyUS0up8yCQxPSt41+d
	XQvoWmsIhb5K+MVIkKgWlf+1XD4a0ymzOtEi8UgxrAmYZIJgeGPCx+R7EIEagLKl
	+5OJ5ej1O0oHE/mJx9TUWeCGTB1DsFGWdRmcA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=7x8cSMt+zGRb8op
	HcRnN/xvqoa4=; b=kORhURRD0Mj2+focC7CcVMFNfC3HAwOgV+PCXMZJ9gFN/NA
	h/ABMcDEYmIPTSJzgC8ipYaIgv6eicu2qakQW+Lc/3JcTU9g5EAPvQOjRfqoiz4T
	OwjOvZj9R8MNJAGNCADczL7vruZGtHdWGfACvl8U+6KeyDrYu5ujIJgyrXfg=
In-Reply-To: <55F55C0E.3010806@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: cbay@excellency.fr
Cc: autofs@vger.kernel.org

On Sun, 2015-09-13 at 13:20 +0200, Cyril B. wrote:
> Ian Kent wrote:
> > On Fri, 2015-09-11 at 17:14 +0200, Cyril B. wrote:
> >> >  Hello Ian,
> >> >
> >> >  Thanks for the quick response. I was able to reliably reproduce the
> >> >  deadlock on a test server with a test script that triggers many
> >> >  simultaneous mounts. On this setup /home is replaced with /mnt.
> >
> > Yes, it's a puzzle.
> >
> > The default.c module looks like there's no possibility of a deadlock.
> > It's fairly simple and there is no place where the mutex isn't released
> > before return and there are no other calls are made that could take
> > other locks that could introduce a deadlock.
> >
> > It occurred to me that the call to force_standard_program_map_env() is
> > out probably out of order.
> >
> > It's made after the fork() that's used to exec the program map code.
> >
> > I think the child is seeing the state of the mutex at the time of the
> > fork and if the mutex was locked at that time the child process will
> > never see it unlocked since the forked process copy will not see that
> > change.
> >
> > That's just a guess, so let me put together a patch for you to try.
> > Are you in a position to be able to apply and build autofs to test?
> 
> Sure, I can test as much as I want. I guess I could probably even setup 
> a test VM that reproduces the issue and give you root credentials if it 
> helps.
> 

OK, see if you can apply this patch.
The CHANGELOG hunk won't apply, of course, so just ignore the reject or
delete the hunk from the patch before applying it.

Umm ... now I see I need to fix a couple of spelling mistakes as
well, ;)

autofs-5.1.1 - fix out of order call in program map lookup

From: Ian Kent <raven@themaw.net>

Commit 91e42e58b4 fixed a problem with program map environment variable
nameing and commit 743deb0e4e added a configuration option to force use
of the old environment names for those who need it and are sure it is
safe to continue to use them.

But the call to get the configuration entry was placed after a fork()
so the state of the mutex used when querying the configuration is
undefined and can lead to a dedlock.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                |    1 +
 modules/lookup_program.c |   20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 4430c39..357d201 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,6 +1,7 @@
 ??/??/2015 autofs-5.1.2
 =======================
 - fix left mount count return from umount_multi_triggers().
+- fix out of order call in program map lookup.
 
 21/04/2015 autofs-5.1.1
 =======================
diff --git a/modules/lookup_program.c b/modules/lookup_program.c
index a3a7e98..67d4c47 100644
--- a/modules/lookup_program.c
+++ b/modules/lookup_program.c
@@ -139,6 +139,16 @@ static char *lookup_one(struct autofs_point *ap,
 	}
 
 	/*
+	 * By default use a prefix with standard environment
+	 * variables to prevent system subversion by interpreted
+	 * languages.
+	 */
+	if (defaults_force_std_prog_map_env())
+		prefix = NULL;
+	else
+		prefix = "AUTOFS_";
+
+	/*
 	 * We don't use popen because we don't want to run /bin/sh plus we
 	 * want to send stderr to the syslog, and we don't use spawnl()
 	 * because we need the pipe hooks
@@ -177,16 +187,6 @@ static char *lookup_one(struct autofs_point *ap,
 			     ap->path, ctxt->mapname);
 
 		/*
-		 * By default use a prefix with standard environment
-		 * variables to prevent system subversion by interpreted
-		 * languages.
-		 */
-		if (defaults_force_std_prog_map_env())
-			prefix = NULL;
-		else
-			prefix = "AUTOFS_";
-
-		/*
 		 * MAPFMT_DEFAULT must be "sun" for ->parse_init() to have setup
 		 * the macro table.
 		 */


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
