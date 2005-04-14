From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release
Date: Wed, 13 Apr 2005 21:59:13 -0400
Message-ID: <16989.52849.68024.30163@segfault.boston.redhat.com>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
	<Pine.LNX.4.62.0504112324510.6384@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504112324510.6384@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

==> Regarding [autofs] Re: [ANNOUNCE] Important update - autofs 4.1.4 release; raven@themaw.net adds:

raven> On Sun, 10 Apr 2005 raven@themaw.net wrote:
>> Hi all,
>> 
>> Here is autofs 4.1.4.

raven> There were a couple of mistakes in the release.

raven> The kernel patches have been updated as there were some obvious
raven> errors in them.  An error in patching of the Debian portion of the
raven> init script was corrected.

raven> I've uploaded corrected versions along with a MD5SUMS file of
raven> checksums for people to verify against.

raven> The new upload has a timestamp of 11-Apr-2005 06:21-59. If you
raven> downloaded anything before this, sorry, you'll need to get the
raven> updated files.

This new version has regressed since beta2 for /net mounts in my
environment.  A simple ls of /net/<filer> will now show the contents of
/net/<filer>/exporteddir.  So, for example, we have devfiler which exports
/vol/vol1.  When I do an ls of /net/devfiler, I get the contents of
devfiler:/vol/vol1.

Okay, after further debugging, it seems we're not identifying this as a
multimount entry.  It's getting late, so I'm going to turn this over to
you.  I think that the checking of first_chunk is bogus.  For instance,
with the below change, everything works as expected for me.

-Jeff

--- autofs-4.1.4/modules/parse_sun.c.orig	2005-04-13 21:52:21.663629568 -0400
+++ autofs-4.1.4/modules/parse_sun.c	2005-04-13 21:52:31.687105768 -0400
@@ -766,7 +766,7 @@ static int check_is_multi(const char *ma
 {
 	const char *p = (char *) mapent;
 	int multi = 0;
-	int first_chunk = 0;
+	int first_chunk = 1;
 
 	while (*p) {
 		p = skipspace(p);
