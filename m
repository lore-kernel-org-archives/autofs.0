From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Tue, 06 Dec 2016 17:37:36 +0800
Message-ID: <1481017056.4589.21.camel@themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
         <20161203051322.GA24765@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=v89PjHg9HvPgSnR
        rmJFBzP2MhoY=; b=qWsLfAScEzwYUnTDpVP8+GjK54inlxz+qSg+zoO7nshafgv
        d3r7Qpmts8wgfdyeO/FUyZpZKmbn+afqwMeI8ERZ84CS3tH4WeTQhajPr8f1NKRj
        0dc4bcmqO/YVTjXI9cRfpls89Rf16rfig5XUUnDd/vAL7KoAHgMWzp/IrfqY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=v89PjHg9HvPgSnRrmJFBzP2MhoY=; b=WRKvJ3kCcSGUyK+PxbF7
        aFDB+nxAF2W7BQYSUxsIcFX9kXhsHbm/c484OsOmeAbqaKB69pzgvVpbQn+Clhns
        T36Hw/hTMwS0X7QlIwLpCnVUKucAkn826nYVD6SLL3TU365FCQASFMMOqlHhjS19
        SltO51R4qlWZuthPlPIoCto=
In-Reply-To: <20161203051322.GA24765@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Al Viro <viro@ZenIV.linux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Sat, 2016-12-03 at 05:13 +0000, Al Viro wrote:
> 	FWIW, I've folded that pile into vfs.git#work.autofs.
> 
> Problems:

snip ...

> 	* the last one (propagation-related) is too ugly to live - at the
> very least, its pieces should live in fs/pnode.c; exposing propagate_next()
> is simply wrong.  I hadn't picked that one at all, and I would suggest
> coordinating anything in that area with ebiederman - he has some work
> around fs/pnode.c and you risk stepping on his toes.

The earlier patches seem to be ok now so how about we talk a little about this
last one.

Eric, Al mentioned that you are working with fs/pnode.c and recommended I co-
ordinate with you.

So is my working on this this (which is most likely going to live in pnode.c if
I can can get something acceptable) going to cause complications for you?
Is what your doing at a point were it would be worth doing as Al suggests?

Anyway, the problem that this patch is supposed to solve is to check if any of
the list of mnt_mounts or any of the mounts propagated from each are in use.

One obvious problem with it is the propagation could be very large.

But now I look at it again there's no reason to have to every tree because if
one tree is busy then the the set of trees is busy. But every tree would be
visited if the not busy so it's perhaps still a problem.

The difficult thing is working out if a tree is busy, more so because there
could be a struct path holding references within any the trees so I don't know
of a simpler, more efficient way to check for this.

Anyone have any suggestions at all?
Ian
