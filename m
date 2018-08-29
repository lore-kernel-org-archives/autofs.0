From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs - fix autofs_sbi() does not check super block
 type
Date: Wed, 29 Aug 2018 14:35:14 +0800
Message-ID: <1535524514.2679.12.camel@themaw.net>
References: <153475422934.17131.7563724552005298277.stgit@pluto.themaw.net>
         <20180827010358.GZ6515@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=PbPhtZCVZN49VTIZF36yZA7CnNqtk
        /5IjWzEC+dSqUc=; b=EhZXKPr4ZVY7aEyjvCG3bzpxQSQoYUWgOtiN/ylbknFKW
        vE2nF1HzdwcQ1h0j1/kbRHrYlZLrbYB3X4KcmZ4OIEWWgKMaMLlI8cdIotonCWcE
        nEbqyfIPOBV3MBHDPCTISrL9M3Uodnq5sJ1S90jIpti4ybe7rH1B0IZVfFJKcKaI
        xmjbvoOAmuNzmyTWgtJ0CZXRfscC1jJUK8zEd7n47lYSt8VuBE/ZiIi9dMbKBBWe
        m6V7Ip3jecxdeg8gpU3tWqc1YAjgDJGmwKaSxuOBSqPXTUQOXRhk6mkrhiOQF3Pi
        ydzzJq5PYO5l6mvuNirVJzQdETeD2mWdeO1O32Rlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PbPhtZ
        CVZN49VTIZF36yZA7CnNqtk/5IjWzEC+dSqUc=; b=uyIZWAjN+FRG1OKgG6qHyO
        RX6WVRZrVrfzta5hQmzcJz9Cjbs90h7xBYyzCUqkBXFSQqeUh1exQHh/1oguVyqe
        b+CYwYvRZKHBo5lExQTi+eUl/gWeLUgYlWcaDNjRfy5AWGFeJPPlKVkAhTrwjA0C
        N94RVUTDNRGGyIJw2zXxlGbbnE+N1IrYa4leb4cEquf3W+sPPOseD9pJF32CLFpz
        ASNSa+p7P8tUUc/+UHuVHHvjhBGfkY8z+i5lrhbwkIRAFsBfwdAKucxh/PsF7+Is
        2psDO9ev/6KrzOdvFMlfTZw5w8xzDlkvi5G0J42sKP/ZqyLMrV+R0EtH/6m3eEqA
        ==
In-Reply-To: <20180827010358.GZ6515@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2018-08-27 at 02:03 +0100, Al Viro wrote:
> On Mon, Aug 20, 2018 at 04:37:09PM +0800, Ian Kent wrote:
> > The autofs_sbi() inline function does not check the super block
> > magic number to verify it has been given an autofs super block.
> 
> IMO it's the wrong way to fix it.  The one and only caller where that
> check might trigger is
> 
>                 if (!fp) {
>                         if (cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
>                                 goto cont;
>                         err = -EBADF;
>                         goto out;
>                 }
> 
>                 sbi = autofs_dev_ioctl_sbi(fp);
>                 if (!sbi || sbi->magic != AUTOFS_SBI_MAGIC) {
>                         err = -EINVAL;
>                         fput(fp);
>                         goto out;
>                 }
> with
> static struct autofs_sb_info *autofs_dev_ioctl_sbi(struct file *f)
> {
>         struct autofs_sb_info *sbi = NULL;
>         struct inode *inode;
> 
>         if (f) { 
>                 inode = file_inode(f);
>                 sbi = autofs_sbi(inode->i_sb);
>         }
>         return sbi;
> }
> 
> First of all, what is that `if (f)' doing in there?  We have just checked
> that in the only caller.
> 
> Next, dereferencing the result of autofs_sbi() does need to be preceded
> by making sure that superblock is autofs one, all right... and what are
> we doing in that first dereferencing, again?
> 
> IOW, turn that into
> 
> 	if (!fp) {
> 		....
> 		goto out;
> 	}
> 	sb = file_inode(fp)->i_sb;
> 	if (sb->s_type != &autofs_fs_type)
> 		bugger off
> 	sbi = autofs_sbi(sb);
> 	....
> 
> and be done with that.  Other callers of autofs_sbi() really shouldn't
> happen to other filesystem's superblocks...

Yes, adding it to the inline does add a little extra for other
callers that won't get a non-autofs super block.

I was tempted to just change autofs_dev_ioctl_sbi() in case other
callers were added but your suggestion is somewhat simpler and
really only requires due attention if changes are made.

I'll send a patch to Andrew based on what you recommend.

Thanks
Ian
