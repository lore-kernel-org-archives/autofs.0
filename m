From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Tue, 13 Jan 2009 11:24:58 +0900
Message-ID: <1231813498.3057.12.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<x49mye0ffvg.fsf@segfault.boston.devel.redhat.com>
	<20090109195151.GH32333@shell>
	<408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
	<1231692176.10063.10.camel@zeus.themaw.net>
	<408431290901111525y578a5ba4n634ee8b071718790@mail.gmail.com>
	<1231723189.3073.7.camel@zeus.themaw.net>
	<1231732946.3073.44.camel@zeus.themaw.net>
	<1231736307.3073.68.camel@zeus.themaw.net>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Tue, 2009-01-13 at 12:52 +1100, Paul Wankadia wrote:
> On Mon, Jan 12, 2009 at 3:02 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         Here are a couple of patches we can use to check what is going
>         on (my
>         math may be wrong so it would be good if folks could check).
>         They should
>         apply to the git repo source.
>         
>         The first patch hash-report-stats.patch modifies
>         cache_dump_cache() to
>         report some statistics.
>         
>         The second patch hash-oaat-algo.patch makes the cache use the
>         Vals
>         proposed oaat algorithm without changing the hash table size
>         for
>         comparison.
>         
>         I used an indirect map with 35000 entries as a quick check.
>         
>         There are a couple of problems with this, first the map keys
>         are a bit
>         random and so are not representative of actual maps and since
>         we use
>         multiple caches in v5 the number of entries in a given cache
>         may be
>         quite different from the total number of entries.
>         
>         But, if my math is correct, we can get some marginally useful
>         information from the experiment.
>         
>         The results:
>         
>         Current algorithm:
>         cache: entries 35000 table size 77 ideal chain length 454.55
>         chain length: empty 0 min 381 max 501 avg 454.55 std 22.78
>         
>         oaat algorithm:
>         cache: entries 35000 table size 77 ideal chain length 454.55
>         chain length: empty 0 min 402 max 532 avg 454.55 std 22.27
>         
>         This looks a bit odd, my math is probably broken somehow.
> 
> Perhaps you could calculate the median instead of the mean?

I was thinking that the min and max looked a bit odd.
To calculate the median we would have to assume a normal distribution
(or find some way to work out what type of distribution it is, too hard)
and then it's (min + max)/2.

> 
> 
>         I have to conclude that while the oaat algorithm looks worse
>         some how,
>         if the math is OK, then it is likely that there are more
>         chains closer
>         to the average length with less outliers (smaller variance in
>         chain
>         length) than there are with the current algorithm.
>         
>         It would be good if we could get some real world numbers for
>         both
>         indirect and direct maps (mainly because direct maps have
>         somewhat
>         different keys, full path compared to directory component).
>         
>         I will do some more checks with the proposed large hash table
>         size to
>         see if the small table size is hiding any bias in the
>         distribution.
> 
> On Mon, Jan 12, 2009 at 3:58 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         Here are some more stats.
>         
>         cache: entries 35000 table size 977 ideal chain length 35.82
>         chain length: empty 627 min 0 max 284 avg 35.82 std 72.14
>         
>         cache: entries 35000 table size 977 ideal chain length 35.82
>         chain length: empty 0 min 17 max 59 avg 35.82 std 6.05
>         
>         
>         cache: entries 35000 table size 2039 ideal chain length 17.17
>         chain length: empty 1689 min 0 max 284 avg 17.17 std 53.05
>         
>         cache: entries 35000 table size 2039 ideal chain length 17.17
>         chain length: empty 0 min 6 max 32 avg 17.17 std 4.18
>         
>         
>         cache: entries 35000 table size 4093 ideal chain length 8.55
>         chain length: empty 3743 min 0 max 284 avg 8.55 std 38.41
>         
>         cache: entries 35000 table size 4093 ideal chain length 8.55
>         chain length: empty 2 min 0 max 21 avg 8.55 std 2.99
>         
>         
>         There's clearly something wrong with my min and probably max
>         calculation
>         but the stats still show some interesting information.
> 
> Why do you think that you've miscalculated the minimum?

Well, maybe I haven't but I thought min should be > 0.
But, it's not worth worrying about as I think we've managed to show a
clear improvement.

> 
> 
>         It looks like the additive algorithm is biased toward a small
>         range of
>         hash indexes which becomes more significant as the table size
>         increases.
>         So the distribution is significantly better as table size
>         increases.
>         
>         I'm not clear on what the graphs (Pauls) are displaying but my
>         impression is that they also show this same distribution bias
>         toward
>         clustering for the additive hash. Assuming they were done
>         using actual
>         map keys that would indicate that the benefit is likely fairly
>         general.
> 
> I plotted the number of elements in each bucket.
> 
> As you now see, the additive hash function doesn't scale.

Sure and now we can say why it doesn't scale in the patch description.

> 
> 
>         The only question remaining is how large should we make the
>         table.
>         A size of around 4k will lead to a lot of wasted space for
>         many common
>         configurations (including configurations that have many map
>         entries
>         spread over several individual maps) but a size around 1k
>         still gives
>         fairly long chains for large maps.
>         
>         Suggestions?
> 
> Perhaps you could make it configurable?

Perhaps, but I don't think this is the sort of thing that should be
configurable so I'd prefer to make it a compile time option rather than
a run time configuration setting.

> 
> 
>         PS. I'll need to make a couple of other changes as well, eg.
>         the null
>         map entry cache is typically very small.
> 
