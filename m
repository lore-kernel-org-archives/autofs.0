From: Ian Kent <raven@themaw.net>
Subject: Re: Re: autofs map updates not working properly for
	multi-mounts
Date: Fri, 18 Feb 2005 12:37:42 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502181218290.20922@wombat.indigo.net.au>
References: <16905.15217.105499.777724@segfault.boston.redhat.com>
	<Pine.LNX.4.61.0502092116510.2140@donald.themaw.net>
	<Pine.LNX.4.61.0502171331200.19710@simba.math.ucla.edu>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.61.0502171331200.19710@simba.math.ucla.edu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 17 Feb 2005, Jim Carter wrote:

> Maybe I shouldn't be doing the "talk without patching" thing, but I'm not 
> exactly at guru level with the autofs code, so...
> 
> On Wed, 9 Feb 2005 raven@themaw.net wrote:
> 
> > Multi-mount map entries must be treated as a single unit.
> > This is so because nested mounts are allowed within them.
> > Consider
> > 
> > foo	-rw \
> > /one/a	server:/one/a \
> > /one/b	server:/one/b \
> > /one/b/c server:/one/b/c
> > 
> > If this isn't handled as a single unit then it's possible for /one/b/c to be
> > mounted before /one/b. This could happen due to a map update, for example.
> 
> I've always wondered about that.  To mount on /net/foo/one/b/c, don't we 
> have to readdir /net/foo/one/b first, find the inode of mount point c, and 
> stat it?  That would (should :-) trigger an attempt by the module to have 
> /net/foo/one/b mounted.  

Yes. But if lazy mounting is used that would trigger a mount of 
/net/foo/one/b and autofs would never see the mount request for 
/net/foo/one/b/c as it is now in a different filesystem.

> 
> Or is it a single thread issue, so the daemon can't begin mounting 
> /net/foo/one/b until it's finished mounting /net/foo/one/b/c (which it 
> can't do until after /net/foo/one/b is mounted)?

No. Just the reverse. Nesting order has to be preserved to maintain any 
sanity at all.

> 
> > So, just as with individual mount entries, it can't be updated until it's
> > umounted and mounted again.
> 
> I think you're saying that if the new map says to mount /net/foo/one/b/c on 
> a different mount point (or to obtain it from a different place), the 
> daemon will remember the new map but (obviously) can't make it happen until 
> the old mount times out.  If ever.  Using the "multiple uni-mounts" model 
> described below, actually there should be no problem obeying new map 
> content for directories that aren't mounted; it's just not possible to get 
> rid of old content immediately.
> 
> > So the key in the example below that is sent to the daemon is "foo/dir/aaa"
> > when in fact the key for the map entry is "foo".
> > 
> > Consequently it's not found in the map.
> 
> Hmm.  It sounds like the map lookup algorithm needs to have foo/dir/aaa 
> available as a key and not just the first word of the map row, "foo".  In
> other words, multiple keys point to one map row.  
> 
> Alternatively, you might think of transforming the multi-mount into a set 
> of uni-mounts.  The example above would turn into:
> 
> foo		mkdir but don't mount anything
> foo/one		mkdir but don't mount anything
> foo/one/a	-rw	server:/one/a
> foo/one/b	-rw	server:/one/b
> foo/one/b/c	-rw	server:/one/b/c
> 
> Not that you would accept this syntax from a map file, but the term on the
> left is just what the module would send up, and the term on the right is
> what the daemon needs to do when it sees that key.

Been there, done that.
Never completed the implementation.

The approach does have merit but not without some difficulty.
I'll get back to it sooner or later.

What if foo/one/b is not initially present and is added later and 
foo/one/b/c is already mounted!
 
> 
> Does any of this make any sense?

Yep. It's pretty much the only way I think I can get it to work but there 
are some big thorns.

Ian
