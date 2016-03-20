From: Ian Kent <raven@themaw.net>
Subject: Re: [BUG] contained_in_local_fs will *always* return true
Date: Sun, 20 Mar 2016 21:05:00 +0800
Message-ID: <1458479100.12385.20.camel@themaw.net>
References: <56EC6897.7040409@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=66EAHxbrxlfubENduVMH9DsbONg=; b=E5swrn
	bc70A+cVl9AH/z02SsA8Y95BcqudX9jw9wtN1XIYx90uqgDG6csA4Ku46peKh22X
	XLkOQE/j4x9HNJEw5UK7PsI7uHGDhnqrhPfaTElx2uUX5ZbMCdM7XkQ9Fvd0mL+R
	cu13PbA1tb/EnH4su7omaP8pTr2OvgKq1zyAc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=66EAHxbrxlfubEN
	duVMH9DsbONg=; b=o5ISne4HGy1hNlmcndmqG2neFQc6cmDQBuFq3p1DrrMPjIe
	thqe2IqZ/g0+1lsKtuh1fO+tDElfD1+jUOi88ImNLkFTlfzHHUCHP+9vWF3CMKoP
	eJRO12FHhhulQZZbT/7RIqdUDSlSGiQIrlL/ZRMqaVdAtAxpaqXghr+WCc24=
In-Reply-To: <56EC6897.7040409@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>, autofs@vger.kernel.org

On Fri, 2016-03-18 at 16:44 -0400, Jeff Mahoney wrote:
> Hi autofs maintainers -
> 
> I'm investigating a bug in which the user has > 8k direct mounts set
> up.
>  As documented in the README, this performs very, very badly and I'm
> looking at ways to improve that situation.
> 
> In my research, I discovered commit d3ce65e05d1 (autofs-5.0.3 - allow
> directory create on NFS root), which was intended to return true for
> rootfs.  It would pass that test.  It also returns true for every
> other
> case as long as there is *any* root file system in the mount table. 
>  So,
> ultimately, we read the mount table for every path component of every
> direct mount for no benefit whatsoever.
> 
> ====8<====
> for (this = mnts; this != NULL; this = this->next) {
>         size_t len = strlen(this->path);
> 
>         if (!strncmp(path, this->path, len)) {
>                 if (len > 1 && pathlen > len && path[len] != '/')
>                         continue;
>                 else if (len == 1 && this->path[0] == '/') {
> 
> 			/*
> 			 * jeffm -> This will cause the entire
> 			 * function to always return true.  It
> 			 * turns the loop into a test to see if
> 			 * anything is mounted on /.
> 			 */

Yes, that's not what we want.


>                         /*
>                          * always return true on rootfs, we don't
>                          * want to break diskless clients.
>                          */
>                         ret = 1;
>                 } else if (this->fs_name[0] == '/') {
>                         if (strlen(this->fs_name) > 1) {
>                                 if (this->fs_name[1] != '/')
>                                         ret = 1;
>                         } else
>                                 ret = 1;
>                 } else if (!strncmp("LABEL=", this->fs_name, 6) ||
>                            !strncmp("UUID=", this->fs_name, 5))
>                         ret = 1;
>                 break;
>         }
> }
> ====>8====
> 
> This commit landed in 2008 and, since it hasn't changed since then, I
> assume there haven't been any bugs reported.  I had trouble trying to
> locate a mailing list archive for the autofs list, so I can't confirm
> that.  Googling for contained_in_local_fs really only showed the
> thread
> that proposed the patch initially.
> 
> So, I suppose my question is this:  Since this bug has existed for
> nearly 8 years already, would fixing it at this point be considered a
> regression?

I'd prefer to fix it to do what it's supposed to do.

> 
> If so, we can skip all the checking in do_mkdir entirely, which also
> removes the performance impact of large numbers of direct mounts while
> using /proc/self/mounts.

As you can see scanning the mount table is something that must be
avoided wherever possible so I would like to find another way to perform
that check.

I don't really care about keeping the (modified, fixed) scan for those
using the ioctl interface rather than the miscellaneous device. But for
those using the miscellaneous device interface the scan of the mount
table really needs to go.

I'll need a bit of time to even remember what the intent of the change
was.

> 
> If not, how do we move forward ensuring minimal breakage?  I have a
> patch worked up that skips the mount table parsing entirely and just
> tests to see if the parent is either on the root file system,
> regardless
> of file system type, or contained in a file system mounted on a block
> device (grab st_dev and see if it exists in /sys/dev/block).  Is that
> enough or is there a corner case I'm missing?

As I say, I'll need some time to reacquaint myself with what is being
done with contained_in_local_fs() so I'm just guessing below.

IIRC the whole point of this (from a bigger picture POV) was due to
complains about autofs even trying to create directories within an NFS
file system being bad form (and autofs can potentially do so quite a
bit) so it was necessary to require the mount point directory already
exist when mounting into an NFS file system.

But that should be possible without scanning the mount table so I'm not
sure what I was thinking, again I'll need to have a look around to see
if I can recall the reason behind contained_in_local_fs() as well as the
bad change that occurred later.

Send over the patch and I'll have a look at that too.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
