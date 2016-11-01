From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/8] vfs - change d_manage() to take a struct path
Date: Tue, 01 Nov 2016 10:02:03 +0800
Message-ID: <1477965723.2798.13.camel@themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
         <20161019124031.94a44fbdd0970989f05d1893@linux-foundation.org>
         <1477006776.3207.14.camel@themaw.net>
         <20161027021111.GI19539@ZenIV.linux.org.uk>
         <1477536470.2898.12.camel@themaw.net> <1477551028.2898.25.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-me-sender:x-sasl-enc:message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=mesmtp; bh=lxJFGuF/dM15kUZyNuFCvoG
        +L4U=; b=rzXw44XSFCLpj9/mjhEpVVuJxWVfhP9xMG+AI9mM9+RT6ErL8k+3hI1
        9C6yXDL+BtZHM053o8WB3l0HeF5wPtTRpVbP4hRps7OxarOzH5rc6QpKXHYk6i/H
        HJuuDA/jBzo0y7rH8Hfl8piGECrB5P8Q7LxH9ACyrVj5MBrZKW+I=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-me-sender:x-sasl-enc:message-id:subject
        :from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=smtpout; bh=lxJFGuF/d
        M15kUZyNuFCvoG+L4U=; b=SAhcrLasm9g8qFo//KKzvq8BO3+47bxQpAUke8bnW
        ytI/C1TwE+KTIdHuK6m/zDjWZOhf081M052DccINbJ1Rlp73S5fs5N8ejqXL8Ai3
        Ugdmsr7sEJBv1BXgD2dKX9Q4EbAhYnNqPM7pssCjpAU7ZSe8faq6ZbVMHmIrbT7Q
        VE=
In-Reply-To: <1477551028.2898.25.camel@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Thu, 2016-10-27 at 14:50 +0800, Ian Kent wrote:
> On Thu, 2016-10-27 at 10:47 +0800, Ian Kent wrote:
> > 
> > On Thu, 2016-10-27 at 03:11 +0100, Al Viro wrote:
> > > 
> > >  
> > > 
> > > How much testing did it get?  I've several test setups involving
> > > autofs, but they are nowhere near exhaustive and I don't have good
> > > enough feel of the codebase to slap together something with decent
> > > coverage...
> > It got my standard testing.
> > 
> > For that I use a modified version of the autofs Connectathon system.
> > 
> > It's more about testing a wide variety of syntax and map setups and so
> > exercises
> > a large number of different types of autofs mounts.
> > 
> > It's meant to check normal operation but not so much stress testing even
> > though
> > it does perform quite a few mounts (around 250-300, not to mention the
> > autofs
> > mounts themselves).
> > 
> > I have another standard test I call the submount-test and it was originally
> > done
> > to stress test the most common problem I see, concurrent expire to mount.
> > 
> > I didn't see any problems I couldn't explain in these but I might need to
> > re-
> > visit the submount-test to see if it is still doing what I want.
> > 
> > OTOH, the pattern of mount and umount I see when the submount-test is run
> > does
> > look like it is doing what I want but it might not be getting all the way to
> > the
> > top of the tree of mounts enough times over the course of the test.
> > 
> > So I'm happy with my testing, just not as happy as I could be.
> Well, almost happy with my testing.
> 
> Naturally I also tested the specific case this series is meant to fix.
> 
> Basically:
> ls /mnt/foo            # do the initial automount
> unshare -m sleep 10 &  # hold the automount in a new namespace
> umount /mnt/foo        # pretend the mount timed out
> ls /mnt/foo            # try to access it again
> ls: cannot open directory '/mnt/foo': Too many levels of symbolic links
> 
> as seen on the autofs mailing list. My specific test was a little different
> but
> verified this was resolved.
> 
> Now that Al seems reasonably OK with the series, with some changes, I'll test
> some other use cases, mainly to verify the expire still functions as required.
> That might need more work.

I have done some further tests, specifically for (what I believe are) the two
most common use cases.

First, using automount(8) entirely within a container, as expected works fine.

But the second case, one where automount(8) is run in the root namespace and has
automount directories bound into a container does have a problem.

The problem is due to may_umount_tree() only considering mounts in the root
namespace and leads to expire attempts on mounts even if they are in use in
another namespace.

It's not a serious problem as the umount attempt fails because the mount is busy
but it would be good to avoid the call back overhead.

Unfortunately it looks like transforming may_umount_tree() to use a similar
check to may_umount() introduces a race (picked up by my submount-test) which
I'm struggling to understand, I'll continue to work on it.

Ian
