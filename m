From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Thu, 15 Jan 2009 15:41:09 -0500
Message-ID: <x49d4eouwt6.fsf@segfault.boston.devel.redhat.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231823945.3057.20.camel@zeus.themaw.net>
	<408431290901131943t2c678c8ej10c1829c71b5a557@mail.gmail.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
	<408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
	<1231939076.3168.53.camel@zeus.themaw.net>
	<408431290901140620k11a8cf7evb667895a59c7e204@mail.gmail.com>
	<1231983710.3100.38.camel@zeus.themaw.net>
	<x49vdsgvcdk.fsf@segfault.boston.devel.redhat.com>
	<1232032573.3100.53.camel@zeus.themaw.net>
	<408431290901151233q33699529r6119788c998866ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901151233q33699529r6119788c998866ed@mail.gmail.com>
	(Paul Wankadia's message of "Fri, 16 Jan 2009 07:33:30 +1100")
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
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Paul Wankadia <junyer@google.com> writes:

> On 1/16/09, Ian Kent <raven@themaw.net> wrote:
>
>>> Sure, just read the whole map.  Even large maps aren't that big.  What
>>> are we talking, 10k?  50k?  You're better off reading the whole thing in
>>> at once.
>>
>> Yeah, that would be best. I'll have a think about how to detect when to
>> do that. Maybe we can rip out that convoluted change detection logic for
>> file maps, after all they should be fairly simple to deal with.
>
> If inotify can play nicely with the existing event handling, then it
> could be worth considering.

Ian was coming up with a scheme to only read part of the map.  Because
the map is just a flat file, he surmised that a lookup could happen like
so:

first lookup, start at the beginning of the file

walk the entries, adding each to the cache until you find the entry
you're looking for

cache the offset into the file and stop reading

When a cache miss comes in, start reading the file again at the last
offset (so long as the file hasn't changed on disk)


My argument is that you're not really saving much.  Just cache the whole
file.  I agree that you probably want to detect changes, still.  For
that, you can use mtime or inotify.  You could make a case for either
side, though I think I'd argue for keeping the mtime approach (as the
map may change multiple times before we actually try to read it, and
doing the read in the lookup path really shouldn't be that big of a
deal).  Of course, I haven't profiled this, so that may be worth doing.

Cheers,
Jeff
