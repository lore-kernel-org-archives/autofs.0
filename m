From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Proposal for map refresh logic
Date: Fri, 21 May 2004 09:44:05 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 21 May 2004 raven@themaw.net wrote:

> 1. Re-reading a map also removes stale entries unless they are
>    mounted. In this case they would not be removed until the
>    refresh following their umount.

Good.

> 2. Using the success or failure of the mount operation is
>    unreliable at best and could, at best, lead to unwanted
>    map refreshes and at worst lead to a map reading storm.

If the algo below is followed, map rereads will be controlled by the TTL, 
avoiding reread storms.  However, there may be cases where it's hard to 
recognize a changed map. 

> 3. For file maps we cannot read a single entry so instead
>    the lookup of an individual entry amounts to checking the
>    map files' modification time. This value will be recorded
>    when the map is read.

Good.  This is certainly sufficient.  

> 4. We need to take advantage of hints that the map may have
>    changed frequently in order to catch updated maps without
>    a large time lag.

We need to frequently glim the hints... right?  Your point isn't about 
vacillating maps.  For updating the ghost mounts this is true, but for 
actual mounting it's irrelevant if the cache contains outdated info because 
of the TTL rule.  NIS maps have an "order number" which you can get if you 
know what key to ask for, rather than having to read the whole map.  I 
don't know about LDAP.  Suggestion for ghost mounts: only refresh the map 
when a userspace process does opendir on the containing directory, as in 
"ls /net/hostname".  In any other case, outdated or missing ghost mounts 
cannot be seen by userspace, so let sleeping dogs lie.

Question about ghost mounts: if you did "ls /net", you would like to see
all servers from which anything potentially could be mounted, but with a
wildcard map this is impossible, right?  But with explicitly listed
servers, there would be ghost mounts but no actual submount processes.
Also, server submounts will time out if unused, and the ghost mounts from
those servers will no longer be visible.  Am I right, that a submount with
all ghost mounts counts as idle, not in use, and will exit after the
timeout?  This is important.  (But if you subsequently do "ls /net/server"
a new submount will be forked, and it will populate itself with only ghost
mounts, right?)

> 5. The HUP signal handling will remain to allow map refresh
>    on demand.

Good.  This is important for setup and debugging.

> For a a cache hit we can:
> 
> 1. Check if the map entry has exceeded a given time to live, say
>    the map expire time.
> 2. If not continue as normal otherwise lookup the individual map
>    entry and compare it to the cached entry.
> 3. If they are identical continue as normal otherwise it's a hint
>    the map has changed so re-read it.

Suggestion: set a flag saying "we know that this map is out of date", but 
only re-read the whole thing when userspace expects to see up-to-date ghost 
mounts.  Understood, that to read any one row from a file map you have to 
read the whole thing; the suggestion makes a difference only for NIS and 
LDAP -- where it makes a big difference.

Brainwave: You could also set the TTL of every other cache row from that
map to an expired state, since some of them might have been read more
recently.  That's dumb, because we're trying to re-read the map row by row,
and we don't want to invalidate rows that came from the new version of the
map.  If each row had an associated order number or date, we could
recognize and purge truly obsolete rows.  Don't monkey with the TTL, toss 
them.  Hmm, for an order number you can use the date when the particular 
row was read, and if row X is seen to be wrong then all older rows are 
surely wrong too.  

> For a cache miss we can:
> 
> 1. Lookup the individual map entry.
> 2. If this fails consider it as a real failure and continue.
> 3. If it succeeds re-read the entire map as it must be out of date.

Same comment applies.

> One further consideration remains.
> 
> Should a time based (say 6-10 times the expire timeout) map refresh be 
> added to the above logic?
> 
> I would prefer not...

I agree with your points on this.  Cached stale data doesn't hurt until you 
actually mount something or do "ls /net/server", and pre-re-reading will be
wasted effort 99% of the time.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
