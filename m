From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Fri, 16 Jan 2009 15:24:17 +0900
Message-ID: <1232087057.3166.88.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1232032573.3100.53.camel@zeus.themaw.net>
	<408431290901151233q33699529r6119788c998866ed@mail.gmail.com>
	<x49d4eouwt6.fsf@segfault.boston.devel.redhat.com>
	<408431290901151257i70400351yc3ab9360136c8e9c@mail.gmail.com>
	<1232065653.3166.19.camel@zeus.themaw.net>
	<1232066406.3166.28.camel@zeus.themaw.net>
	<1232070195.3166.36.camel@zeus.themaw.net>
	<408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
	<1232079714.3166.56.camel@zeus.themaw.net>
	<408431290901152204i8d2da71vbf8ee5f2e2f84fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901152204i8d2da71vbf8ee5f2e2f84fa@mail.gmail.com>
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

On Fri, 2009-01-16 at 17:04 +1100, Paul Wankadia wrote:
> On Fri, Jan 16, 2009 at 3:21 PM, Ian Kent <raven@themaw.net> wrote:
> 
>         >         +               if (me && ctxt->mtime <= me->age)
>         >
>         > You have to call stat(2) or fstat(2) at some point or else
>         ctxt->mtime
>         > will never change.
>         
>         
>         We set the mtime when we read the entire map, see
>         modules/lookup_file.c:lookup_read_map(). This is totally
>         taking
>         advantage of the existing code to read a map that is marked as
>         stale. It
>         doesn't however attempt to simplify the code which works out
>         if we need
>         to mark the map stale but we probably don't want to anyway as
>         we need to
>         ensure we use up to date entries for lookups done while
>         waiting for the
>         map update to be done.
> 
> Sorry, I don't understand how that condition will evaluate to false.
> You won't read the map until ctxt->mtime changes, but it won't change
> until you read the map.

Mmmm .. before that last change I was assuming the code which sets the
stale flag would cause the read but then I removed that bit and ...
oops!

Ian
