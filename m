From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and path_is_mountpoint_rcu()
Date: Thu, 08 Dec 2016 17:28:10 +1300
Message-ID: <87d1h32gf9.fsf@xmission.com>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
        <20161203051322.GA24765@ZenIV.linux.org.uk>
        <1481017056.4589.21.camel@themaw.net> <8737hzv34f.fsf@xmission.com>
        <1481167790.3924.3.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1481167790.3924.3.camel@themaw.net> (Ian Kent's message of "Thu,
        08 Dec 2016 11:29:50 +0800")
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

Ian Kent <raven@themaw.net> writes:

> On Thu, 2016-12-08 at 10:30 +1300, Eric W. Biederman wrote:
>> Ian Kent <raven@themaw.net> writes:
>> 
>> > On Sat, 2016-12-03 at 05:13 +0000, Al Viro wrote:
>> > > 	FWIW, I've folded that pile into vfs.git#work.autofs.
>> > > 
>> > > Problems:
>> > 
>> > snip ...
>> > 
>> > > 	* the last one (propagation-related) is too ugly to live - at the
>> > > very least, its pieces should live in fs/pnode.c; exposing
>> > > propagate_next()
>> > > is simply wrong.  I hadn't picked that one at all, and I would suggest
>> > > coordinating anything in that area with ebiederman - he has some work
>> > > around fs/pnode.c and you risk stepping on his toes.
>> > 
>> > The earlier patches seem to be ok now so how about we talk a little about
>> > this
>> > last one.
>> > 
>> > Eric, Al mentioned that you are working with fs/pnode.c and recommended I
>> > co-
>> > ordinate with you.
>> > 
>> > So is my working on this this (which is most likely going to live in pnode.c
>> > if
>> > I can can get something acceptable) going to cause complications for you?
>> > Is what your doing at a point were it would be worth doing as Al
>> > suggests?
>> > 
>> > Anyway, the problem that this patch is supposed to solve is to check if any
>> > of
>> > the list of mnt_mounts or any of the mounts propagated from each are in use.
>> > 
>> > One obvious problem with it is the propagation could be very large.
>> > 
>> > But now I look at it again there's no reason to have to every tree because
>> > if
>> > one tree is busy then the the set of trees is busy. But every tree would be
>> > visited if the not busy so it's perhaps still a problem.
>> > 
>> > The difficult thing is working out if a tree is busy, more so because there
>> > could be a struct path holding references within any the trees so I don't
>> > know
>> > of a simpler, more efficient way to check for this.
>> 
>> So coordination seems to be in order.  Not so much because of your
>> current implementation (which won't tell you what you want to know)
>
> Umm ... ok I've missed something then because the patch I posted does appear to
> get the calculation right. Perhaps I've missed a case where it gets it wrong
> ....
>
> But now I'm looking deeper into it I'm beginning to wonder why it worked for one
> of the cases. Maybe I need to do some more tests with even more
> printks.

So the case that I am concerned about is that if someone happens to do
mount --bind the mount propagation trees would not just be mirror images
in single filesystems but have leaves in odd places.

Consider .../base/one/two (where one and two are automounts) and base
is the shared mountpoint that is propagated between namespaces.

If someone does mount --bind .../base/one ../somepath/one in any
namespace then there will be places where an unmount of "two" will
propagate to, but that an unmount of "one" won't as their respective
propagation trees are different.

Not accounting for different mount points having different propagation
trees is what I meant when I said your code was wrong.

>> but because an implementation that tells you what you are looking for
>> has really bad > O(N^2) complexity walking the propagation tree in
>> the worst case.
>
> Yes it is bad indeed.
>
>> 
>> To be correct you code would need to use next_mnt and walk the tree and
>> on each mount use propagate_mnt_busy to see if that entry can be
>> unmounted.  Possibly with small variations to match your case.  Mounts
>> in one part of the tree may propagate to places that mounts in other
>> parts of the tree will not.
>
> Right, the point there being use propagate_mnt_busy() for the check.

Or a variant of propagate_mnt_busy.

> I tried to use that when I started this but had trouble, I'll have another look
> at using it.
>
> I thought the reason I couldn't use propagate_mnt_busy() is because it will see
> any mount with submounts as busy and that's not what's need. It's mounts below
> each of mounts having submounts that make them busy in my case.

If you have the count of submounts passed into propagate_mnt_busy() it
will come very close to what you need.  It is still possible to have
false positives in the face of propagation slaves that have had some of
your autofs mounts unmounted, and something else mounted upon them.

If all you need is a better approximation something like your current
code with comments about it's limitations might even be reasonable.

> You probably don't want to read about this but, unfortunately, an example is
> possibly the best way to describe what I need to achieve.

[snip good example]

>> > Anyone have any suggestions at all?
>> 
>> In the short term I recommend just not doing this, but if you want to
>> see if you can find an efficient algorithm with me, I am happy to bring
>> you up to speed on all of the gory details.
>
> I need to do this to make autofs play better in the presence of namespaces and
> that's a problem now and is long overdue to be resolved.
>
> So I'm happy to do whatever I can to work toward that.
>
> I could leave this part of the implementation until later because the false
> positive this solves leads to an expire fail and that is (must be) handled
> properly by the user space daemon.
>
> But when I first noticed the false positive the expire failure was handled ok by
> the daemon (AFAICS) but there was what looked like a reference counting problem
> (but not quite that either, odd) which I was going to return to later.
>
> Maybe I've stumbled onto a subtle propagation bug that really needs
> fixing ....

MNT_DETACH has worst case performance issues when a tree of mounts is
unmounted that would really be nice to fix, as it can propogate pretty
horrible.  You are trying to do something very similar to MNT_DETACH so
an efficient solution for one is likely an efficient solution for the
other.


Eric
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
