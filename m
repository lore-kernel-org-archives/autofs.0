From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Thu, 15 Jan 2009 10:41:50 +0900
Message-ID: <1231983710.3100.38.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
	<1231813498.3057.12.camel@zeus.themaw.net>
	<1231820126.3057.14.camel@zeus.themaw.net>
	<408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
	<1231823945.3057.20.camel@zeus.themaw.net>
	<408431290901131943t2c678c8ej10c1829c71b5a557@mail.gmail.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
	<408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
	<1231939076.3168.53.camel@zeus.themaw.net>
	<408431290901140620k11a8cf7evb667895a59c7e204@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901140620k11a8cf7evb667895a59c7e204@mail.gmail.com>
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

On Thu, 2009-01-15 at 01:20 +1100, Paul Wankadia wrote:
> On Thu, Jan 15, 2009 at 12:17 AM, Ian Kent <raven@themaw.net> wrote:
> 
>         
>         > Sorry, I meant the logic that reloads the file map if it's
>         been
>         > modified. I know that autofs v4 checked the mtime, but I
>         can't see
>         > where autofs v5 does that.
>         
>         
>         Yeah, I didn't think I got rid of that.
>         
>         But the check for a mismatch between the cache and a file key
>         lookup
>         should be sufficient to only cause a read when the map has
>         actually
>         changed. I guess we could get multiple HUP signals, one
>         following just
>         after the other has finished, but that would be a system admin
>         error and
>         you'd probably want to know about that since we can't make a
>         similar
>         check some other map sources. I probably should get around to
>         removing
>         the mtime stuff all-together, perhaps you could let me know if
>         things
>         work as they should (or not) so I can clean (or fix) that up.
> 
> Are you saying that every lookup for an indirect map will hit the
> file? If that's the case, then what's the point of the cache? If
> that's not the case, but you're not checking the mtime either, then
> how do you know when the file has been modified? (Please excuse the
> silly questions.)
> 

Umm .... yeah (runs and hides behind a large bookshelf in office).

This isn't a silly question at all.

It's something that could make the poor performance of the hash function
look efficient and needs to be fixed (at least it matters for large
maps).

In the beginning I used the cache, well, like a cache, and required a
HUP signal to update the maps. That was seen to be "just not good
enough" as people required the map entry used to be up to date at the
time of use. This lead to the cache gradually becoming more of a
reference used to check currency of map entries to trigger map re-reads
when differences were spotted. This seemed better than just using
periodic map re-reads and seems to work OK. Remember that in v5 the
cache starts empty for nobrowse indirect mounts and old entries get
cleaned out upon receiving a HUP signal. That's OK for maps that have
direct key lookup but for really large file maps it's almost certainly
worse than the poor hashing algorithm.

We use the cache a lot, for a bunch of other checks, to maintain context
for multi-mount map entries and for direct maps. Map entries with
multiple offsets (the so called multi-mount map entries) the entry is
expanded, each offset added to the cache and a mount trigger mounted.
This is part of the mount/umount "as you go" functionality in v5 which
is really useful for servers with really large export lists, for
example. Because of the nature of direct mounts the entire map must be
read at startup and a HUP signal must be sent to the daemon for changes
to be seen and we never go to the map during lookups, only the cache.

But onto the problem.

It should be fairly straight forward to start using the map mtime again.
The time stamp on cache entries that have been added will be later than
the mtime if the file map hasn't changed so we can use that. But we also
need to prevent re-reading the map from the beginning as we populate the
cache. I was thinking that I could add each entry read during a lookup
to the cache so that they would be found on subsequent lookups (as long
as the mtime is earlier than the time stamp). Additionally, I could keep
track of the file position so I don't read entries already read. It
likely won't be quite as simple in the end but we really need to do
something to for really large maps.

Any other thoughts?

Ian
