From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
Date: Wed, 30 Jan 2019 10:07:15 +0800
Message-ID: <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
         <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
         <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        yfTW4eZb1oyF14NllSamtvS5448NNG6QM44agwdZzeY=; b=VuabjD6CEoSb1KEO
        D8FsGMkxJp1rgGD7N3Yeosgr0LGU+xm8fI4IjMLYZJwsoDSA04yz40Wdnx4W4Jzo
        7RNI4ZnJcy1Z+4lsQlK3evjMWN8dS5k7QySW7NHXWDomXmklZSkC9Xd7DBRaX4Ui
        zkoErvR+s0WYH85+iC6P1rjpFvLgwFAKykpXpCcQEcvgvP3wHqmP+cuOYf62piDM
        9KXrVE6vrDYjpKFqttZDB3VI6lt9GPn18g8fTx7K5s3/BUr41ksIHdac+htX9Gzy
        UXnQQgcJ/NYUP4V2WGc7eXuAkWb6fy8WR0LoYWRobOibW7wdhJaoKGqiDcfSqP7l
        TswHWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=yfTW4eZb1oyF14NllSamtvS5448NNG6QM44agwdZz
        eY=; b=TKQiwjOfO+oH1JLB+95lsBxc6ZZ3xX7qi3Da1OvDkgaVyaNvwOkYuhbqT
        +LNcXbKB66wwoSo4iGuCwGakSWLVUBXZ6yM9jNIkkv8pi7q2EFPVxXJd3u0mHbnA
        B2y//AkIjlcrge+FguTIbDVfmkG0kcSaOJscB3hmdsgoBAz1K/iDx+usifyU2f7j
        UX6197vmPaezENf3sanvssugIdz4tJRJfZF1UnuKl1/c8yDBejVaOcxI6ErtYNcl
        XrgaYSXAs+ANpJTfwp+1Wuzt2/ysW5MQJEnOiC23iM8t1e7nu7/WR4/WckD3qu7j
        gHS/5DjJWlLGx6+8f5HFlV9Wx034Q==
In-Reply-To: <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Bian <bianpan2016@163.com>

On Tue, 2019-01-29 at 17:16 -0800, Andrew Morton wrote:
> On Sat, 12 Jan 2019 08:00:40 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > Add an autofs file system mount option that can be used to provide
> > a generic indicator to applications that the mount entry should be
> > ignored when displaying mount information.
> 
> What is the reason for adding this feature?

In other OSes that provide autofs and that provide a mount list
to user space based on the kernel mount list a no-op mount option
("ignore" is the one use on the most common OS) is allowed so that
autofs file system users can optionally use it.

The idea is that it be used by user space programs to exclude
autofs mounts from consideration when reading the mounts list.

Prior to the change to link /etc/mtab to /proc/self/mounts all
I needed to do to achieve this was to use mount(2) and not update
the mtab but now that no longer works.

I know the symlinking happened a long time ago and I considered
doing this then but, at the time I couldn't remember the commonly
used option name and thought persuading the various utility
maintainers would be too hard.

But now I have a RHEL request to do this for compatibility for a
widely used product so I want to go ahead with it and try and
enlist the help of some utility package maintainers.

Clearly, without the option nothing can be done so it's at least
a start.

Ian

