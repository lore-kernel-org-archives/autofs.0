From: "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
Subject: Re: [PATCH 4/4] autofs: add comment about autofs_mountpoint_changed()
Date: Fri, 27 Mar 2020 05:19:29 +0000
Message-ID: <20200327051928.i5xtvskvktbugifa@mayhem.atnf.CSIRO.AU>
References: <158520019862.5325.7856909810909592388.stgit@mickey.themaw.net>
 <158520021604.5325.4342529050022426912.stgit@mickey.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1585286802; x=1616822802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5d0dJ8lX1ad1+Up0aN0MABU6OV+EtqHost7YjWaZLms=;
  b=Y2WPycZ7EGll6sRmc27q+vRbPRz7sb/LLjfjW69Ts2/Vd0yZVn/c3eka
   YKvSXQH0Q/8j3blcPSqSS4ne+gI0Bf18h9xGp9oHGW+rwm56eouXMkc+k
   kK/x1GnNBhv+4J27ODa4qfTc5AmHF52eDBJt/NSEHQYoJMXnTt9J88p8k
   U=;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6UV0GnIfqpdyF7zX2wNlixfb5YVqA2sYgZR8riKpgQ=;
 b=Hft0EdPfMfPD6utQzj+KSsUgYareDIt5PY74sYzci/w/hyG0aSxVfjxHbnBrq/THDKXiHK2a2mZ8xrI9HC8aR469+96n3/gyp85xaRWRlxvjY4J7lZOqV5FbYMv1eDNnt4RH9zp06WqDvcM/Qly6OwTVS9VKCVEcGl4EVdE6QVg=
In-Reply-To: <158520021604.5325.4342529050022426912.stgit@mickey.themaw.net>
Content-Language: en-US
Content-ID: <3AB93E4465266A459CD3E8CE3385BC2B@ausprd01.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

One nit, below.
Vince

On Thu, Mar 26, 2020 at 01:23:36PM +0800, Ian Kent wrote:
>The function autofs_mountpoint_changed() is unusual, add a comment
>about two cases for which it is used.
>
>Signed-off-by: Ian Kent <raven@themaw.net>
>---
> fs/autofs/root.c |   21 ++++++++++++++++++---
> 1 file changed, 18 insertions(+), 3 deletions(-)
>
>diff --git a/fs/autofs/root.c b/fs/autofs/root.c
>index 308cc49aca1d..a972bbaecb46 100644
>--- a/fs/autofs/root.c
>+++ b/fs/autofs/root.c
>@@ -280,9 +280,24 @@ static struct dentry *autofs_mountpoint_changed(struc=
t path *path)
> 	struct dentry *dentry =3D path->dentry;
> 	struct autofs_sb_info *sbi =3D autofs_sbi(dentry->d_sb);
>
>-	/*
>-	 * If this is an indirect mount the dentry could have gone away
>-	 * as a result of an expire and a new one created.
>+	/* If this is an indirect mount the dentry could have gone away
>+	 * and a new one created.
>+	 *
>+	 * This is unusual and I can't remember the case for which it
>+	 * was originally added now. But a example of how this can

'an' example

>+	 * happen is an autofs indirect mount that has the "browse"
>+	 * option set and also has the "symlink" option in the autofs
>+	 * map entry. In this case the daemon will remove the browse
>+	 * directory and create a symlink as the mount (pointing to a
>+	 * local path) leaving the struct path stale.
>+	 *
>+	 * Another not so obvious case is when a mount in an autofs
>+	 * indirect mount that uses the "nobrowse" option is being
>+	 * expired and the mount has been umounted but the mount point
>+	 * directory remains when a stat family system call is made.
>+	 * In this case the mount point is removed (by the daemon) and
>+	 * a new mount triggered leading to a stale dentry in the struct
>+	 * path of the waiting process.
> 	 */
> 	if (autofs_type_indirect(sbi->type) && d_unhashed(dentry)) {
> 		struct dentry *parent =3D dentry->d_parent;
>

-- =
