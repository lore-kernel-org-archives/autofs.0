From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs dump map option
Date: Sun, 07 Aug 2011 11:09:44 +0800
Message-ID: <1312686584.8240.1.camel@perseus.themaw.net>
References: <4E3BB3C8.9040305@s3group.cz>
	<1312620890.3304.1.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:from:to:cc:in-reply-to:references
	:content-type:date:message-id:mime-version
	:content-transfer-encoding; s=smtpout; bh=J0n+XfiPibIq6wUQ0YGes9
	RonSc=; b=YgwxvrNPoNEa0VYXGNGT6yNO3MpHJRK+mva8+d2tUjB2qRq6UQJTb5
	XFNNtqDePTWwN4D5vX94o6vjZCnRXR+9TXBTJD5Go/FEdMf97TEyY4RcADHf7HQo
	DxbSeFirNw7jhRepZgJ5cw+MCZxqFizLmPCGDaGh+Pac61VKpeTdU=
In-Reply-To: <1312620890.3304.1.camel@perseus.themaw.net>
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
To: Ondrej Valousek <webserv@s3group.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Sat, 2011-08-06 at 16:54 +0800, Ian Kent wrote:
> On Fri, 2011-08-05 at 11:11 +0200, Ondrej Valousek wrote:
> > Hi Ian,
> > 
> > Thanks for looking after the bugs #538408 and #704416 for me, but I
> > have one slight problem with it:
> > Automouter won't show any keys in my indirect NIS maps unless I
> > specify "BROWSE_MODE=yes".
> > Maybe it is expected behaviour so I was thinking - can we always force
> > browse_mode when dumping maps?
> > 
> > Sorry for spotting this too late.
> 
> Ha, I'll have a look and see what we need to do.
> 
> I'm on leave between the 8th and 13th and will have limited internet
> connectivity so I likely won't be able to do much until I get back.

I think this patch should help.

autofs-5.0.6 - fix dumpmaps not reading maps

From: Ian Kent <raven@themaw.net>

The lookup modules won't read any indirect map entries (other than those
in a file map) unless unless the browse option is set. In order to list
the entries when tyhe dumpmap option is given the browse option needs to
be set.
---

 CHANGELOG    |    1 +
 lib/master.c |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)


diff --git a/CHANGELOG b/CHANGELOG
index 884a9ae..946a196 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -3,6 +3,7 @@
 - fix ipv6 name for lookup fix.
 - improve mount location error reporting.
 - fix paged query more results check.
+- fix dumpmaps not reading maps.
 
 28/06/2011 autofs-5.0.6
 -----------------------
diff --git a/lib/master.c b/lib/master.c
index 153a38b..6c89e1d 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -1283,6 +1283,15 @@ int master_show_mounts(struct master *master)
 		printf("\nMount point: %s\n", ap->path);
 		printf("\nsource(s):\n");
 
+		/*
+		 * Ensure we actually read indirect map entries so we can
+		 * list them. The map reads won't read any indirect map
+		 * entries (other than those in a file map) unless the
+		 * browse option is set.
+		 */
+		if (ap->type == LKP_INDIRECT)
+			ap->flags |= MOUNT_FLAG_GHOST;
+
 		/* Read the map content into the cache */
 		if (lookup_nss_read_map(ap, NULL, now))
 			lookup_prune_cache(ap, now);
