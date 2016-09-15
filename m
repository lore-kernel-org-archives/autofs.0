From: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Wed, 14 Sep 2016 17:32:43 -0700
Message-ID: <20160915003243.GA16372@vader>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
 <20160914061445.24714.68331.stgit@pluto.themaw.net>
 <87zina9ys3.fsf@x220.int.ebiederm.org>
 <1473898163.3205.32.camel@themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8tgNKf0JXDZWYCkfLPB/8E1Wr89PzV7j4vtYBSD+h7I=;
        b=oM9JHLl8hfMiet1fNNPWCki6T6ujOeA1nYVC0N6+ZuT0ILpMImQyijRCTBhwDP9Vf/
         bRGSFT9H5UviOYUKjhtYA4TkwwN02qFUeTH1FHXg86kaeYqYWdsSUY2Gpr6aWPe9oD62
         crwhpVzwFD4Q9WU3GFg3ExiyDUciP6e9I2RFRtBhNxRknWXzFN0cxZHpip/xWuaoINwd
         +lDvWR+p7VT4GXyRB6SAk7EVUDeWEbpyYYQVS3WbTLVGXlS/dy3ZkRX9gqTxzTls9P86
         dJYCeZYANR3A2iKSQU3fDKW7xLOnQdx1Qk5ff/k+B6aovao4D5dQC9M9/Q2FEuhB2bBB
         kBug==
Content-Disposition: inline
In-Reply-To: <1473898163.3205.32.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@fb.com

On Thu, Sep 15, 2016 at 08:09:23AM +0800, Ian Kent wrote:
> On Wed, 2016-09-14 at 12:28 -0500, Eric W. Biederman wrote:
> > Ian Kent <raven@themaw.net> writes:
> > 
> > > If an automount mount is clone(2)ed into a file system that is
> > > propagation private, when it later expires in the originating
> > > namespace subsequent calls to autofs ->d_automount() for that
> > > dentry in the original namespace will return ELOOP until the
> > > mount is manually umounted in the cloned namespace.
> > > 
> > > In the same way, if an autofs mount is triggered by automount(8)
> > > running within a container the dentry will be seen as mounted in
> > > the root init namespace and calls to ->d_automount() in that namespace
> > > will return ELOOP until the mount is umounted within the container.
> > > 
> > > Also, have_submounts() can return an incorect result when a mount
> > > exists in a namespace other than the one being checked.
> > 
> > Overall this appears to be a fairly reasonable set of changes.  It does
> > increase the expense when an actual mount point is encountered, but if
> > these are the desired some increase in cost when a dentry is a
> > mountpoint is unavoidable.
> > 
> > May I ask the motiviation for this set of changes?  Reading through the
> > changes I don't grasp why we want to change the behavior of autofs.
> > What problem is being solved?  What are the benefits?
> 
> LOL, it's all too easy for me to give a patch description that I think explains
> a problem I need to solve without realizing it isn't clear to others what the
> problem is, sorry about that.
> 
> For quite a while now, and not that frequently but consistently, I've been
> getting reports of people using autofs getting ELOOP errors and not being able
> to mount automounts.
> 
> This has been due to the cloning of autofs file systems (that have active
> automounts at the time of the clone) by other systems.
> 
> An unshare, as one example, can easily result in the cloning of an autofs file
> system that has active mounts which shows this problem.
> 
> Once an active mount that has been cloned is expired in the namespace that
> performed the unshare it can't be (auto)mounted again in the the originating
> namespace because the mounted check in the autofs module will think it is
> already mounted.
> 
> I'm not sure this is a clear description either, hopefully it is enough to
> demonstrate the type of problem I'm typing to solve.

Yup, at Facebook we've been hitting this issue for years. Our container
setup doesn't clean up the base system's mounts after the
unshare(CLONE_NEWNS) and before the chroot(), so we very frequently see
the base system's autofs mounts get broken with ELOOP. The solution
there might be to fix our container setup, but I think it's still a
kernel bug, as it breaks the isolation between namespaces.

Ian, I'm going to test these patches, thanks for sending them out.

-- 
Omar
