From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Sun, 04 Dec 2016 10:18:35 +0800
Message-ID: <1480817915.3157.14.camel@themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
         <20161203051322.GA24765@ZenIV.linux.org.uk>
         <20161203232912.GE1555@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=PhasUMaXJppLp1p
        HsaJLWyf9Vhs=; b=RaiekF/sdonH9ASKiuGWlZMNFOQKi6q1YXg05LVxiGWomeF
        PF6OfeD+kXzra84br/3OdW3+Ixnymb2XLo1Tg60zAjKraDp2kH138TGZr4vSBkcY
        RlJ9OSOFKdqnpMLhfnk8pjMXiMO7bGMVxJrmFWfp8lj7cpePf5xKFFrmqXDE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=PhasUMaXJppLp1pHsaJLWyf9Vhs=; b=NyTYyIitxhIpbvMZL300
        eY4tbIf3YJciL2AL2dQo+o5lVwyuB11p/3jjO76XKdL7s/gLreRJV+NO4T7okSwy
        1WIL4qb7/3IsbnL9iR3aMyOyKgk5pCgkxfaHi1nsYRClWnpI/saKAoDn3zjWl1yg
        Ns4OoVg8NjkzTRaQXThAnBw=
In-Reply-To: <20161203232912.GE1555@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Sat, 2016-12-03 at 23:29 +0000, Al Viro wrote:
> On Sat, Dec 03, 2016 at 05:13:22AM +0000, Al Viro wrote:
> > 
> > 	* path_has_submounts() is broken.  At the very least, it's
> > AB-BA between mount_lock and rename_lock.  I would suggest trying to
> > put read_seqlock_excl(&mount_lock) around the call of d_walk() in there,
> > and using __lookup_mnt() in the callback (without retries on the mount_lock,
> > of course - read_seqlock_excl done on the outside is enough).  I'm not sure
> > if it won't cause trouble with contention, though; that needs testing.  As
> > it is, that function is broken in #work.autofs, same as it is in -mm and
> > -next.
> 	Fix for path_has_submounts() (as above) force-pushed.  It does
> need testing and profiling, obviously.

I'll run my tests against it and re-run with oprofile if all goes well.

The submount-test I use should show contention if it's a problem but I'm not
sure the number of mounts used will be sufficient to show up scale problems.

Basically each case of the test (there are two) runs for 100 iterations using 10
processes with timing set to promote expire to mount contention, mainly to test
for expire to mount races.

If I don't see contention I might need to analyse further whether the test has
adequate coverage.

Ian
