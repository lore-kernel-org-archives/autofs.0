From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to
	thousands	of	entries
Date: Mon, 12 Jan 2009 13:58:27 +0900
Message-ID: <1231736307.3073.68.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<x49mye0ffvg.fsf@segfault.boston.devel.redhat.com>
	<20090109195151.GH32333@shell>
	<408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
	<1231692176.10063.10.camel@zeus.themaw.net>
	<408431290901111525y578a5ba4n634ee8b071718790@mail.gmail.com>
	<1231723189.3073.7.camel@zeus.themaw.net>
	<1231732946.3073.44.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231732946.3073.44.camel@zeus.themaw.net>
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

On Mon, 2009-01-12 at 13:02 +0900, Ian Kent wrote:
> 
> I used an indirect map with 35000 entries as a quick check.
> 
> There are a couple of problems with this, first the map keys are a bit
> random and so are not representative of actual maps and since we use
> multiple caches in v5 the number of entries in a given cache may be
> quite different from the total number of entries.
> 
> But, if my math is correct, we can get some marginally useful
> information from the experiment.
> 
> The results:
> 
> Current algorithm:
> cache: entries 35000 table size 77 ideal chain length 454.55
> chain length: empty 0 min 381 max 501 avg 454.55 std 22.78
> 
> oaat algorithm:
> cache: entries 35000 table size 77 ideal chain length 454.55
> chain length: empty 0 min 402 max 532 avg 454.55 std 22.27
> 

Here are some more stats.

cache: entries 35000 table size 977 ideal chain length 35.82
chain length: empty 627 min 0 max 284 avg 35.82 std 72.14

cache: entries 35000 table size 977 ideal chain length 35.82
chain length: empty 0 min 17 max 59 avg 35.82 std 6.05


cache: entries 35000 table size 2039 ideal chain length 17.17
chain length: empty 1689 min 0 max 284 avg 17.17 std 53.05

cache: entries 35000 table size 2039 ideal chain length 17.17
chain length: empty 0 min 6 max 32 avg 17.17 std 4.18


cache: entries 35000 table size 4093 ideal chain length 8.55
chain length: empty 3743 min 0 max 284 avg 8.55 std 38.41

cache: entries 35000 table size 4093 ideal chain length 8.55
chain length: empty 2 min 0 max 21 avg 8.55 std 2.99


There's clearly something wrong with my min and probably max calculation
but the stats still show some interesting information.

It looks like the additive algorithm is biased toward a small range of
hash indexes which becomes more significant as the table size increases.
So the distribution is significantly better as table size increases.

I'm not clear on what the graphs (Pauls) are displaying but my
impression is that they also show this same distribution bias toward
clustering for the additive hash. Assuming they were done using actual
map keys that would indicate that the benefit is likely fairly general.

The only question remaining is how large should we make the table.
A size of around 4k will lead to a lot of wasted space for many common
configurations (including configurations that have many map entries
spread over several individual maps) but a size around 1k still gives
fairly long chains for large maps.

Suggestions?

PS. I'll need to make a couple of other changes as well, eg. the null
map entry cache is typically very small.

Ian
