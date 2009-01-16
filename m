From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Fri, 16 Jan 2009 09:27:33 +0900
Message-ID: <1232065653.3166.19.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
	<408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
	<1231939076.3168.53.camel@zeus.themaw.net>
	<408431290901140620k11a8cf7evb667895a59c7e204@mail.gmail.com>
	<1231983710.3100.38.camel@zeus.themaw.net>
	<x49vdsgvcdk.fsf@segfault.boston.devel.redhat.com>
	<1232032573.3100.53.camel@zeus.themaw.net>
	<408431290901151233q33699529r6119788c998866ed@mail.gmail.com>
	<x49d4eouwt6.fsf@segfault.boston.devel.redhat.com>
	<408431290901151257i70400351yc3ab9360136c8e9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <408431290901151257i70400351yc3ab9360136c8e9c@mail.gmail.com>
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

On Fri, 2009-01-16 at 07:57 +1100, Paul Wankadia wrote:
> On 1/16/09, Jeff Moyer <jmoyer@redhat.com> wrote:
> 
> > My argument is that you're not really saving much.  Just cache the whole
> > file.  I agree that you probably want to detect changes, still.  For
> > that, you can use mtime or inotify.  You could make a case for either
> > side, though I think I'd argue for keeping the mtime approach (as the
> > map may change multiple times before we actually try to read it, and
> > doing the read in the lookup path really shouldn't be that big of a
> > deal).  Of course, I haven't profiled this, so that may be worth doing.
> 
> If we can simply flag the cached version as stale, then lazy reloads
> should be possible.

Maybe not.

The layer of code above the lookup modules does the re-loads but it is
general wrt. the map type so for a "nobrowse" map it won't read the map.
I'm not sure yet that putting special case exceptions in that code is a
good thing to do or even straight forward. But, for the large map case,
we can consider reading the entire map an expensive operation, so if we
did change the layer above and we found the map needed to be modified
then marked the map as stale we would need to scan the file map for the
key (as the map is out of date) and then read the whole map later. That
means we would end up reading the map at least one and a half times (on
average) instead of once (assuming no lookups between marking the map
stale and re-reading).

I'm tending toward reading the map during the lookup so the map is up to
date when we look for the key in the cache.

Ian
