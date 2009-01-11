From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands
	of	entries
Date: Mon, 12 Jan 2009 01:42:56 +0900
Message-ID: <1231692176.10063.10.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<x49mye0ffvg.fsf@segfault.boston.devel.redhat.com>
	<20090109195151.GH32333@shell>
	<408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
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

On Sat, 2009-01-10 at 12:19 +1100, Paul Wankadia wrote:
> On Sat, Jan 10, 2009 at 6:51 AM, Valerie Aurora Henson
> <vaurora@redhat.com> wrote:
> 
>         > Most patches of this nature come with some description of a
>         performance
>         > problem and how the patch solves it.  Which caching
>         algorithm is
>         > implemented below?  There are, of course, many hashing
>         algorithms for
>         > variable length strings.  Can we get some rationale for the
>         change?  I'm
>         > not against it, I'd just like a *little* explanation.
>         
>         This is where I get to blame my cold for being stupid. :)
>         
>         Yes, the original author (Paul Wankadia, now cc'd) gave me a
>         little
>         information on that front, I just forgot to pass it on.  It's
>         the
>         "One-at-a-Time" hash function by Bob Jenkins. See:
>         
>         http://burtleburtle.net/bob/hash/doobs.html
>         
>         What I vaguely recall from our conversation is an order of
>         magnitude
>         improvement in elapsed time for large (thousands) numbers of
>         maps, but
>         I'll let Paul be more specific.  Do we have a test for
>         thousands of
>         entries somewhere in our automated tests?
> 
> It's just that the additive hash function and the tiny, non-prime hash
> table size offended my delicate sensibilities. ;)

Oh .. right, looks like v4 uses a prime to me but I did mean to use a
prime in v5, oops!

> 
> Actually, we discovered that reloading a large file map took well over
> ten seconds. Profiling revealed that the daemon spent most of its time
> calling strcmp(3).
> 
> Oh, and I should note that the problem was observed in autofs v4. I'll
> be looking more closely at autofs v5 in the near future.

It's much the same, the hash size is not much bigger and it can well do
with a healthy increase. I don't know what sort of distribution the
simple additive hash gives and if we are going to change it then we
should do some checking with representative strings to ensure that what
we use is in fact better.

Ian
