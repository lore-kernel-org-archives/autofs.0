From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Mon, 12 Jan 2009 10:19:49 +0900
Message-ID: <1231723189.3073.7.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<x49mye0ffvg.fsf@segfault.boston.devel.redhat.com>
	<20090109195151.GH32333@shell>
	<408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
	<1231692176.10063.10.camel@zeus.themaw.net>
	<408431290901111525y578a5ba4n634ee8b071718790@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901111525y578a5ba4n634ee8b071718790@mail.gmail.com>
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

On Mon, 2009-01-12 at 10:25 +1100, Paul Wankadia wrote:
> On Mon, Jan 12, 2009 at 3:42 AM, Ian Kent <raven@themaw.net> wrote:
> 
>         > It's just that the additive hash function and the tiny,
>         non-prime hash
>         > table size offended my delicate sensibilities. ;)
>         
>         Oh .. right, looks like v4 uses a prime to me but I did mean
>         to use a
>         prime in v5, oops!
> 
> $ factor 27 77
> 27: 3 3 3
> 77: 7 11
> $ 
> 
> 
>         > Actually, we discovered that reloading a large file map took
>         well over
>         > ten seconds. Profiling revealed that the daemon spent most
>         of its time
>         > calling strcmp(3).
>         >
>         > Oh, and I should note that the problem was observed in
>         autofs v4. I'll
>         > be looking more closely at autofs v5 in the near future.
>         
>         It's much the same, the hash size is not much bigger and it
>         can well do
>         with a healthy increase. I don't know what sort of
>         distribution the
>         simple additive hash gives and if we are going to change it
>         then we
>         should do some checking with representative strings to ensure
>         that what
>         we use is in fact better.
> 

Oh .. didn't see this before.

> How could it be worse? :P

Hehe, there's an assumption without evidence in there some where.

> 
> I'll check our large file map just to satisfy my curiosity.
> 

Give me a chance and I'll do a couple of patches to add some statistical
calculations to cache_dump_cache() so we can see the state of the hash
table after a map is loaded.

Ian
