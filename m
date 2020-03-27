From: "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
Subject: Re: [PATCH 3/4] vfs: check for autofs expiring dentry in
 follow_automount()
Date: Fri, 27 Mar 2020 05:18:56 +0000
Message-ID: <20200327051855.6o6y6l6b3gamlkji@mayhem.atnf.CSIRO.AU>
References: <158520019862.5325.7856909810909592388.stgit@mickey.themaw.net>
 <158520020932.5325.1998880625163566595.stgit@mickey.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1585286770; x=1616822770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZgOQdAkbe0m/WHfybthXX1IPiYH6HzKG/kfRxIv0uUI=;
  b=fECoa30iatJA6z/jXdUvm9u0YwSeQWqVYdCw0V770r5mwRZM4/hPQ1pO
   +pHdbi7zUTwrev5qRSfff23wmujgLP+oZd03I9KLU/EbMlXpztqyqt6Nd
   2ZKFf4m5pzFU81X364Oxf57nU4JJ72EPo/fT3CoOSr919fkU9gV4NqRz4
   g=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR+j0oF6vyw3qdvsX+NhgsRv+2EgpHqVBWj+hHAiy2A=;
 b=AwhpBn53rEzuzXifiKo03wBheI5ppXiRpEDacWXlos9+KThF0E98mbgO5paqZ0GqPmjfN4VDjkfKl4L8kHIYQsToFPtHS/xNDRBNRM5WgEN0SnHROniveYilqeAkEMpdyZJ++nxGOH69EHNS3M8sld21ORfNzVGbRwNtyL93yLo=
In-Reply-To: <158520020932.5325.1998880625163566595.stgit@mickey.themaw.net>
Content-Language: en-US
Content-ID: <747723B718D0C04086926CFC1F0509FF@ausprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Mar 26, 2020 at 01:23:29PM +0800, Ian Kent wrote:
>follow_automount() checks if a stat family system call path walk is
>being done on a positive dentry and and returns -EISDIR to indicate
>the dentry should be used as is without attempting an automount.
>
>But if autofs is expiring the dentry at the time it should be
>remounted following the expire.
>
>There are two cases, in the case of a "nobrowse" indirect autofs
>mount it would have been mounted on lookup anyway. In the case of
>a "browse" indirect or direct autofs mount re-mounting it will
>maintain the mount which is what user space would be expected.
>
>This will defer expiration of the mount which might lead to mounts
>unexpectedly remaining mounted under heavy stat activity but there's
>no other choice in order to maintain consistency for user space.
>
>Signed-off-by: Ian Kent <raven@themaw.net>
>---
> fs/autofs/root.c |   10 +++++++++-
> fs/namei.c       |   13 +++++++++++--
> 2 files changed, 20 insertions(+), 3 deletions(-)
>
>diff --git a/fs/autofs/root.c b/fs/autofs/root.c
>index a1c9c32e104f..308cc49aca1d 100644
>--- a/fs/autofs/root.c
>+++ b/fs/autofs/root.c
>@@ -406,9 +406,17 @@ static int autofs_d_manage(const struct path *path, b=
ool rcu_walk)
>
> 	/* Check for (possible) pending expire */
> 	if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
>+		/* dentry possibly going to be picked for expire,
>+		 * proceed to ref-walk mode.
>+		 */
> 		if (rcu_walk)
> 			return -ECHILD;
>-		return 0;
>+
>+		/* ref-walk mode, return 1 so follow_automount()
>+		 * can to wait on the expire outcome and possibly

'can to wait' ?
Do you mean: "can wait", "will wait", "knows to wait",
or something else?

>+		 * attempt a re-mount.
>+		 */
>+		return 1;
> 	}
>
> 	/*
>diff --git a/fs/namei.c b/fs/namei.c
>index db6565c99825..34a03928d32d 100644
>--- a/fs/namei.c
>+++ b/fs/namei.c
>@@ -1227,11 +1227,20 @@ static int follow_automount(struct path *path, str=
uct nameidata *nd,
> 	 * mounted directory.  Also, autofs may mark negative dentries
> 	 * as being automount points.  These will need the attentions
> 	 * of the daemon to instantiate them before they can be used.
>+	 *
>+	 * Also if ->d_manage() returns 1 the dentry transit needs
>+	 * managing, for autofs it tells us the dentry might be expired,
>+	 * so proceed to ->d_automount().

I'm wondering if this should be two sentences.
Does this version reflect reality?

+	 * Also if ->d_manage() returns 1 the dentry transit needs
+	 * to be managed. For autofs, a return of 1 tells us the
+	 * dentry might be expired, so proceed to ->d_automount().

Kind regards
Vince
> 	 */
> 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
> 			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
>-	    path->dentry->d_inode)
>-		return -EISDIR;
>+	    path->dentry->d_inode) {
>+		if (path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) {
>+			if (!path->dentry->d_op->d_manage(path, false))
>+				return -EISDIR;
>+		} else
>+			return -EISDIR;
>+	}
>
> 	nd->total_link_count++;
> 	if (nd->total_link_count >=3D 40)
>

-- =
