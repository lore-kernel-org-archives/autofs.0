From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Tue, 13 Jan 2009 12:52:56 +1100
Message-ID: <408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1867394879452307061=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231736307.3073.68.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--===============1867394879452307061==
Content-Type: multipart/alternative; boundary=0016e652f4e87490d80460537b22

--0016e652f4e87490d80460537b22
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jan 12, 2009 at 3:02 PM, Ian Kent <raven@themaw.net> wrote:

Here are a couple of patches we can use to check what is going on (my
> math may be wrong so it would be good if folks could check). They should
> apply to the git repo source.
>
> The first patch hash-report-stats.patch modifies cache_dump_cache() to
> report some statistics.
>
> The second patch hash-oaat-algo.patch makes the cache use the Vals
> proposed oaat algorithm without changing the hash table size for
> comparison.
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
> This looks a bit odd, my math is probably broken somehow.


Perhaps you could calculate the median instead of the mean?

I have to conclude that while the oaat algorithm looks worse some how,
> if the math is OK, then it is likely that there are more chains closer
> to the average length with less outliers (smaller variance in chain
> length) than there are with the current algorithm.
>
> It would be good if we could get some real world numbers for both
> indirect and direct maps (mainly because direct maps have somewhat
> different keys, full path compared to directory component).
>
> I will do some more checks with the proposed large hash table size to
> see if the small table size is hiding any bias in the distribution.


On Mon, Jan 12, 2009 at 3:58 PM, Ian Kent <raven@themaw.net> wrote:

Here are some more stats.
>
> cache: entries 35000 table size 977 ideal chain length 35.82
> chain length: empty 627 min 0 max 284 avg 35.82 std 72.14
>
> cache: entries 35000 table size 977 ideal chain length 35.82
> chain length: empty 0 min 17 max 59 avg 35.82 std 6.05
>
>
> cache: entries 35000 table size 2039 ideal chain length 17.17
> chain length: empty 1689 min 0 max 284 avg 17.17 std 53.05
>
> cache: entries 35000 table size 2039 ideal chain length 17.17
> chain length: empty 0 min 6 max 32 avg 17.17 std 4.18
>
>
> cache: entries 35000 table size 4093 ideal chain length 8.55
> chain length: empty 3743 min 0 max 284 avg 8.55 std 38.41
>
> cache: entries 35000 table size 4093 ideal chain length 8.55
> chain length: empty 2 min 0 max 21 avg 8.55 std 2.99
>
>
> There's clearly something wrong with my min and probably max calculation
> but the stats still show some interesting information.


Why do you think that you've miscalculated the minimum?

It looks like the additive algorithm is biased toward a small range of
> hash indexes which becomes more significant as the table size increases.
> So the distribution is significantly better as table size increases.
>
> I'm not clear on what the graphs (Pauls) are displaying but my
> impression is that they also show this same distribution bias toward
> clustering for the additive hash. Assuming they were done using actual
> map keys that would indicate that the benefit is likely fairly general.


I plotted the number of elements in each bucket.

As you now see, the additive hash function doesn't scale.

The only question remaining is how large should we make the table.
> A size of around 4k will lead to a lot of wasted space for many common
> configurations (including configurations that have many map entries
> spread over several individual maps) but a size around 1k still gives
> fairly long chains for large maps.
>
> Suggestions?


Perhaps you could make it configurable?

PS. I'll need to make a couple of other changes as well, eg. the null
> map entry cache is typically very small.

--0016e652f4e87490d80460537b22
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2009 at 3:02 PM, Ian Kent <span dir=3D"ltr">&lt;<a href=3D"=
mailto:raven@themaw.net">raven@themaw.net</a>&gt;</span> wrote:<br>
<br>
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">Here are a couple of patches we can use to check what is going on=
 (my<br>

math may be wrong so it would be good if folks could check). They should<br=
>
apply to the git repo source.<br>
<br>
The first patch hash-report-stats.patch modifies cache_dump_cache() to<br>
report some statistics.<br>
<br>
The second patch hash-oaat-algo.patch makes the cache use the Vals<br>
proposed oaat algorithm without changing the hash table size for<br>
comparison.<br>
<br>
I used an indirect map with 35000 entries as a quick check.<br>
<br>
There are a couple of problems with this, first the map keys are a bit<br>
random and so are not representative of actual maps and since we use<br>
multiple caches in v5 the number of entries in a given cache may be<br>
quite different from the total number of entries.<br>
<br>
But, if my math is correct, we can get some marginally useful<br>
information from the experiment.<br>
<br>
The results:<br>
<br>
Current algorithm:<br>
cache: entries 35000 table size 77 ideal chain length 454.55<br>
chain length: empty 0 min 381 max 501 avg 454.55 std 22.78<br>
<br>
oaat algorithm:<br>
cache: entries 35000 table size 77 ideal chain length 454.55<br>
chain length: empty 0 min 402 max 532 avg 454.55 std 22.27<br>
<br>
This looks a bit odd, my math is probably broken somehow.</blockquote><div>=
<br>Perhaps you could calculate the median instead of the mean?<br><br></di=
v><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204=
, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I have to conclude that while the oaat algorithm looks worse some how,<br>
if the math is OK, then it is likely that there are more chains closer<br>
to the average length with less outliers (smaller variance in chain<br>
length) than there are with the current algorithm.<br>
<br>
It would be good if we could get some real world numbers for both<br>
indirect and direct maps (mainly because direct maps have somewhat<br>
different keys, full path compared to directory component).<br>
<br>
I will do some more checks with the proposed large hash table size to<br>
see if the small table size is hiding any bias in the distribution.</blockq=
uote></div><br>On Mon, Jan 12, 2009 at 3:58 PM, Ian Kent <span dir=3D"ltr">=
&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt;</span> wro=
te:<br>
<div class=3D"gmail_quote"><br><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">Here are some more stats.<br>
<br>
cache: entries 35000 table size 977 ideal chain length 35.82<br>
chain length: empty 627 min 0 max 284 avg 35.82 std 72.14<br>
<br>
cache: entries 35000 table size 977 ideal chain length 35.82<br>
chain length: empty 0 min 17 max 59 avg 35.82 std 6.05<br>
<br>
<br>
cache: entries 35000 table size 2039 ideal chain length 17.17<br>
chain length: empty 1689 min 0 max 284 avg 17.17 std 53.05<br>
<br>
cache: entries 35000 table size 2039 ideal chain length 17.17<br>
chain length: empty 0 min 6 max 32 avg 17.17 std 4.18<br>
<br>
<br>
cache: entries 35000 table size 4093 ideal chain length 8.55<br>
chain length: empty 3743 min 0 max 284 avg 8.55 std 38.41<br>
<br>
cache: entries 35000 table size 4093 ideal chain length 8.55<br>
chain length: empty 2 min 0 max 21 avg 8.55 std 2.99<br>
<br>
<br>
There&#39;s clearly something wrong with my min and probably max calculatio=
n<br>
but the stats still show some interesting information.</blockquote><div><br=
>Why do you think that you&#39;ve miscalculated the minimum?<br><br></div><=
blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 2=
04, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
It looks like the additive algorithm is biased toward a small range of<br>
hash indexes which becomes more significant as the table size increases.<br=
>
So the distribution is significantly better as table size increases.<br>
<br>
I&#39;m not clear on what the graphs (Pauls) are displaying but my<br>
impression is that they also show this same distribution bias toward<br>
clustering for the additive hash. Assuming they were done using actual<br>
map keys that would indicate that the benefit is likely fairly general.</bl=
ockquote><div><br>I plotted the number of elements in each bucket.<br><br>A=
s you now see, the additive hash function doesn&#39;t scale.<br><br></div>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The only question=
 remaining is how large should we make the table.<br>
A size of around 4k will lead to a lot of wasted space for many common<br>
configurations (including configurations that have many map entries<br>
spread over several individual maps) but a size around 1k still gives<br>
fairly long chains for large maps.<br>
<br>
Suggestions?</blockquote><div><br>Perhaps you could make it configurable?<b=
r><br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">PS. I=
&#39;ll need to make a couple of other changes as well, eg. the null<br>

map entry cache is typically very small.</blockquote></div><br>

--0016e652f4e87490d80460537b22--


--===============1867394879452307061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1867394879452307061==--

