From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 4/4] autofs: add comment about
 autofs_mountpoint_changed()
Date: Fri, 27 Mar 2020 19:33:17 +0800
Message-ID: <11a106b080f743964c86e6c0dd3ce32aa5d48b1b.camel@themaw.net>
References: <158520019862.5325.7856909810909592388.stgit@mickey.themaw.net>
         <158520021604.5325.4342529050022426912.stgit@mickey.themaw.net>
         <20200327051928.i5xtvskvktbugifa@mayhem.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        Onhi3WOhu99LoHFUFk71poWljRjNkAHvTTxbtB4I1nE=; b=ndoytVo0TrRRKDgA
        Y+Otg+vtxSv11h+SWwq0w478ve0tIPFGWJxdypZOYh9E6o+L0ct0IBxY5LXtQEwq
        YWT22NVpyJgsVDgMSdf1Haj0t8IBJZycaYTREF9suSJmWgdqcJPx1IUWNRtCtxn9
        4+uiPugRwOPqndmONwEEetjArRqBnQlwFdOqLQISlmG1e2a1511xGnnU31vu0/hI
        WwBc2+ryptxKc7hRzM4C/grbOQKtnIwk/Qx+k6j5L/r4rVuk/8q1uRiIxQ1RjFZ/
        SoN9nO+5H5S62NiA9VQ/9ZvZA2N46qddpTZXb5U4ZkVyeNaA/dhcvSV0kc39cAbZ
        QDMI1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Onhi3WOhu99LoHFUFk71poWljRjNkAHvTTxbtB4I1
        nE=; b=oZLe0eCM/BA9pkehdtqitW5v+7BL08NRu2SeTuxoEHygOlz+YWXrSXJff
        CXvbH4k5fIXJjsPkrhpgffh42w7ZSn6bXbuRN4d+kfMNlgj66p+E4VHkNq5R41rz
        8PGEfHK1t018xtSINAqoCwkCNSKQRfGiNmcRwCbTs/9Ey3bLi4C6wEBGyZt8/kA+
        Als6Gqljwu060rNK/lagpUr2TqM9xyKuicnO1FsJg4rjd/jSmGGcLpT0s+peJrLz
        cNzL1SWxenwOGDVs2ehEYRJTKA/u1bb/dIvydwSKspBknTg7qldnhTzr2v7zZ2wS
        mZPYw1j05ZEf7RS7Y0wkZHhxY4Sog==
In-Reply-To: <20200327051928.i5xtvskvktbugifa@mayhem.atnf.CSIRO.AU>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "McIntyre, Vincent (CASS, Marsfield)" <Vincent.Mcintyre@csiro.au>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 2020-03-27 at 05:19 +0000, McIntyre, Vincent (CASS, Marsfield)
wrote:
> One nit, below.

Yeah, thanks for that, you effort looking at the patches is
appreciated, I'll fix it.

> Vince
> 
> On Thu, Mar 26, 2020 at 01:23:36PM +0800, Ian Kent wrote:
> > The function autofs_mountpoint_changed() is unusual, add a comment
> > about two cases for which it is used.
> > 
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> > fs/autofs/root.c |   21 ++++++++++++++++++---
> > 1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> > index 308cc49aca1d..a972bbaecb46 100644
> > --- a/fs/autofs/root.c
> > +++ b/fs/autofs/root.c
> > @@ -280,9 +280,24 @@ static struct dentry
> > *autofs_mountpoint_changed(struct path *path)
> > 	struct dentry *dentry = path->dentry;
> > 	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
> > 
> > -	/*
> > -	 * If this is an indirect mount the dentry could have gone away
> > -	 * as a result of an expire and a new one created.
> > +	/* If this is an indirect mount the dentry could have gone away
> > +	 * and a new one created.
> > +	 *
> > +	 * This is unusual and I can't remember the case for which it
> > +	 * was originally added now. But a example of how this can
> 
> 'an' example
> 
> > +	 * happen is an autofs indirect mount that has the "browse"
> > +	 * option set and also has the "symlink" option in the autofs
> > +	 * map entry. In this case the daemon will remove the browse
> > +	 * directory and create a symlink as the mount (pointing to a
> > +	 * local path) leaving the struct path stale.
> > +	 *
> > +	 * Another not so obvious case is when a mount in an autofs
> > +	 * indirect mount that uses the "nobrowse" option is being
> > +	 * expired and the mount has been umounted but the mount point
> > +	 * directory remains when a stat family system call is made.
> > +	 * In this case the mount point is removed (by the daemon) and
> > +	 * a new mount triggered leading to a stale dentry in the
> > struct
> > +	 * path of the waiting process.
> > 	 */
> > 	if (autofs_type_indirect(sbi->type) && d_unhashed(dentry)) {
> > 		struct dentry *parent = dentry->d_parent;
> > 
> 
> -- 

