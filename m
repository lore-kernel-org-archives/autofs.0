From: raven@themaw.net
Subject: Re: Proposal for map refresh logic
Date: Sat, 22 May 2004 12:37:32 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405221120001.1524@donald.themaw.net>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
 <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>


Hi Jim,

Much of what is here has been taken from your original suggestions. You 
probably noticed that.

I will have to digest your recent comments for a while. However, at the 
risk of not answering accuratly I will respond to your suggestions 
now anyway (as best I can).

On Fri, 21 May 2004, Jim Carter wrote:

> 
> > 4. We need to take advantage of hints that the map may have
> >    changed frequently in order to catch updated maps without
> >    a large time lag.
> 
> We need to frequently glim the hints... right?  Your point isn't about 
> vacillating maps.  For updating the ghost mounts this is true, but for 
> actual mounting it's irrelevant if the cache contains outdated info because 
> of the TTL rule.  NIS maps have an "order number" which you can get if you 
> know what key to ask for, rather than having to read the whole map.  I 
> don't know about LDAP.  Suggestion for ghost mounts: only refresh the map 
> when a userspace process does opendir on the containing directory, as in 
> "ls /net/hostname".  In any other case, outdated or missing ghost mounts 
> cannot be seen by userspace, so let sleeping dogs lie.

OK. I'm bound to misunderstand this but I'll try.

Please understand that wildcard map handling is a seperate issue which I 
have also been thinking about over the past months. In fact I have had a 
patch for many months from Mark Faseh (think that's how it's spelt, I 
can't find a post by him) which I'm still not in a position to implement. 
I have however retained his kernel module changes to support it in my 
recent submission for 2.6.

We'll be discussing this at some point, when the bug fixes slow down and I 
have time to work on enhancements.

I'm aware of the NIS order number but don't have an idea of how this can 
be done for LDAP maps. I want the handling to remain as consistent as 
possible between map types. This will be an advantage when I add 
ghosting of nis+ maps.

You would be suprised how often the "opendir" equivalent in kernel space 
is called. Checking for a map re-read then means frequent callbacks from 
kernelspace, essentially from within an existing callback. This is likely 
to be a little nightmarish in terms of implementation complexity and bound 
to be full of races.

I feel fairly stubonly about needing to keep this to a userspace procedure.

> 
> Question about ghost mounts: if you did "ls /net", you would like to see
> all servers from which anything potentially could be mounted, but with a
> wildcard map this is impossible, right?  But with explicitly listed
> servers, there would be ghost mounts but no actual submount processes.
> Also, server submounts will time out if unused, and the ghost mounts from
> those servers will no longer be visible.  Am I right, that a submount with
> all ghost mounts counts as idle, not in use, and will exit after the
> timeout?  This is important.  (But if you subsequently do "ls /net/server"
> a new submount will be forked, and it will populate itself with only ghost
> mounts, right?)

Umm ... little bit unclear but ...

This also relates to another issue on the burner. Lazy mounting of host 
(or multi-mount) maps. This will be dealt with in 4.2.0, I hope. I have a 
reasonably clear plan for this but am still pondering the details.

The change in behaviour for the mounts you refer to should not change with 
this proposal because they don't currently support ghosting.

The enumeration of exports for host mounts is also part of Marks' patch, 
some of which is inclued in autofs now but remains unused. And yes, hosts 
and exports will need to be enumerated in some way to provide a ghosted 
diectory tree. But please lets not persue this right now. I'm sure that 
when this functionality is being implemented you will have many valueable 
contributions to refining it's behaviour.

The host type multi-mounts you mention are still handled "as a single 
entry~, and hence do not allow ghosting yet (4.2.0). So no the "ls 
/net/server" will not populate itself with ghosted mounts but 
actual mounts due to the "as a single entry" behaviour.

> 
> > For a a cache hit we can:
> > 
> > 1. Check if the map entry has exceeded a given time to live, say
> >    the map expire time.
> > 2. If not continue as normal otherwise lookup the individual map
> >    entry and compare it to the cached entry.
> > 3. If they are identical continue as normal otherwise it's a hint
> >    the map has changed so re-read it.
> 
> Suggestion: set a flag saying "we know that this map is out of date", but 
> only re-read the whole thing when userspace expects to see up-to-date ghost 
> mounts.  Understood, that to read any one row from a file map you have to 
> read the whole thing; the suggestion makes a difference only for NIS and 
> LDAP -- where it makes a big difference.

The flag already exists. It's part of each cache entry. It is set to the 
time a map is read. It's used to clean stale entries now.

So you are saying we only set a flag when the tests above indicate a map 
is out of date. But how do we know when user space expects to see an 
up-to-date map other than a changed map entry? So to use a TTL will give 
us the oppertunity to check for an outdated map entry. Again only for 
ghosted maps.

> 
> Brainwave: You could also set the TTL of every other cache row from that
> map to an expired state, since some of them might have been read more
> recently.  That's dumb, because we're trying to re-read the map row by row,
> and we don't want to invalidate rows that came from the new version of the
> map.  If each row had an associated order number or date, we could
> recognize and purge truly obsolete rows.  Don't monkey with the TTL, toss 
> them.  Hmm, for an order number you can use the date when the particular 
> row was read, and if row X is seen to be wrong then all older rows are 
> surely wrong too.  

Think I already have that behaviour.

> 
> > For a cache miss we can:
> > 
> > 1. Lookup the individual map entry.
> > 2. If this fails consider it as a real failure and continue.
> > 3. If it succeeds re-read the entire map as it must be out of date.
> 
> Same comment applies.
> 

Ian
