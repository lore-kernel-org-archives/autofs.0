From: "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
Subject: Re: [PATCH 3/4] vfs: check for autofs expiring dentry in
 follow_automount()
Date: Mon, 30 Mar 2020 23:20:33 +0000
Message-ID: <20200330232032.vmlt3glzqdkgijhy@mayhem.atnf.CSIRO.AU>
References: <158560961146.14841.14430383874338917674.stgit@mickey.themaw.net>
 <158560962258.14841.1166162348928695084.stgit@mickey.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1585610871; x=1617146871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HjQeJM3In1u/kI3GKZJDhbcAwcHi1MytLhtx6vlSoDI=;
  b=M/s/ZonZnroaqKCoWvzoh9RYRGbUUAzz0nm3+JbZC8HEYNtqL9MqDuoe
   xDi104xHT5CULBEd3lknK0hmOAxO8PSsBVWTKEm9KZHP9ksV3XMNcwGQv
   XCal3ujMHAc1M4P3mevbHzPABxZRogTaDu7lJEJVAUY2nzC+Ihujr0wzX
   U=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qih3NYdOuzsvqCc0txHTaehRyRn3UfrJH7hj7a4Sniw=;
 b=IMETsLvnW+Z2J6h6eS5G/VohFdPZGGJQQod9hnlW91AG3bLa6ub0xloNdaqu3xDP8KFNM6fclAkl6r3OpRjXMqDSme8KBXf5hMjvC59cw67avx87QdJwy1aaXgCFNRkNzJkZ0NaPKXrg0oYKefrITBIF3b4txsptA+hgqaI0TOo=
In-Reply-To: <158560962258.14841.1166162348928695084.stgit@mickey.themaw.net>
Content-Language: en-US
Content-ID: <CDC3BA921DD37444B97C17F4AC9B2590@ausprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Mar 31, 2020 at 07:07:02AM +0800, Ian Kent wrote:
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
>index a1c9c32e104f..b3f748e4df08 100644
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
>+		 * can wait on the expire outcome and possibly
>+		 * attempt a re-mount.
>+		 */
>+		return 1;
> 	}
>
> 	/*
>diff --git a/fs/namei.c b/fs/namei.c
>index db6565c99825..869e0d4bb4d9 100644
>--- a/fs/namei.c
>+++ b/fs/namei.c
>@@ -1227,11 +1227,20 @@ static int follow_automount(struct path *path, str=
uct nameidata *nd,
> 	 * mounted directory.  Also, autofs may mark negative dentries
> 	 * as being automount points.  These will need the attentions
> 	 * of the daemon to instantiate them before they can be used.
>+	 *
>+	 * Also if ->d_manage() returns 1 the dentry transit needs
>+	 * to be managing. For autofs, a return of 1 it tells us the

Unclear. Do you mean "to be managed." ? Or "managing." ?

Cheers
Vince

>+	 * dentry might be expired, so proceed to ->d_automount().
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
