From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and path_is_mountpoint_rcu()
Date: Thu, 08 Dec 2016 10:30:24 +1300
Message-ID: <8737hzv34f.fsf@xmission.com>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
        <20161203051322.GA24765@ZenIV.linux.org.uk>
        <1481017056.4589.21.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481017056.4589.21.camel@themaw.net> (Ian Kent's message of
        "Tue, 06 Dec 2016 17:37:36 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

Ian Kent <raven@themaw.net> writes:

> On Sat, 2016-12-03 at 05:13 +0000, Al Viro wrote:
>> 	FWIW, I've folded that pile into vfs.git#work.autofs.
>> 
>> Problems:
>
> snip ...
>
>> 	* the last one (propagation-related) is too ugly to live - at the
>> very least, its pieces should live in fs/pnode.c; exposing propagate_next()
>> is simply wrong.  I hadn't picked that one at all, and I would suggest
>> coordinating anything in that area with ebiederman - he has some work
>> around fs/pnode.c and you risk stepping on his toes.
>
> The earlier patches seem to be ok now so how about we talk a little about this
> last one.
>
> Eric, Al mentioned that you are working with fs/pnode.c and recommended I co-
> ordinate with you.
>
> So is my working on this this (which is most likely going to live in pnode.c if
> I can can get something acceptable) going to cause complications for you?
> Is what your doing at a point were it would be worth doing as Al
> suggests?
>
> Anyway, the problem that this patch is supposed to solve is to check if any of
> the list of mnt_mounts or any of the mounts propagated from each are in use.
>
> One obvious problem with it is the propagation could be very large.
>
> But now I look at it again there's no reason to have to every tree because if
> one tree is busy then the the set of trees is busy. But every tree would be
> visited if the not busy so it's perhaps still a problem.
>
> The difficult thing is working out if a tree is busy, more so because there
> could be a struct path holding references within any the trees so I don't know
> of a simpler, more efficient way to check for this.

So coordination seems to be in order.  Not so much because of your
current implementation (which won't tell you what you want to know)
but because an implementation that tells you what you are looking for
has really bad > O(N^2) complexity walking the propagation tree in
the worst case.

To be correct you code would need to use next_mnt and walk the tree and
on each mount use propagate_mnt_busy to see if that entry can be
unmounted.  Possibly with small variations to match your case.  Mounts
in one part of the tree may propagate to places that mounts in other
parts of the tree will not.

I am assuming you are not worried about MNT_DETACH, as that case would
not need may_umount_tree at all.

I am researching how to make walking propagation for multiple mounts
efficient but it is a non-trivial problem.

> Anyone have any suggestions at all?

In the short term I recommend just not doing this, but if you want to
see if you can find an efficient algorithm with me, I am happy to bring
you up to speed on all of the gory details.

Eric


