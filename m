From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Proposal for map refresh logic
Date: Sun, 23 May 2004 17:24:11 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405231647030.4243@xena.cft.ca.us>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
 <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
 <Pine.LNX.4.58.0405221120001.1524@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405221120001.1524@donald.themaw.net>
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

On Sat, 22 May 2004 raven@themaw.net wrote:
> Much of what is here has been taken from your original suggestions. You 
> probably noticed that.

Yes, thank you.

> Please understand that wildcard map handling is a seperate issue which I 
> have also been thinking about over the past months. In fact I have had a 
> patch for many months from Mark Faseh (think that's how it's spelt, I 
> can't find a post by him) which I'm still not in a position to implement. 
> I have however retained his kernel module changes to support it in my 
> recent submission for 2.6.

Agreed, wildcard maps make impossible (or at least difficult) some things 
that people ask for.

> I'm aware of the NIS order number but don't have an idea of how this can 
> be done for LDAP maps. I want the handling to remain as consistent as 
> possible between map types. This will be an advantage when I add 
> ghosting of nis+ maps.

Good goal.  The date of reading should be good enough for recognizing
entries that are out of date.

> You would be suprised how often the "opendir" equivalent in kernel space 
> is called. 

I didn't know that.  I wonder if there's some other way to distinguish
"the caller is going to hit just one file in the directory" from "the 
caller is going to read the whole thing".  Only in the latter case is it 
important that the directory have only up-to-date entries.

> Checking for a map re-read then means frequent callbacks from 
> kernelspace, essentially from within an existing callback. 

Forget I mentioned it.  We'll have to find another way or do without.

> > (But if you subsequently do "ls /net/server"
> > a new submount will be forked, and it will populate itself with only ghost
> > mounts, right?)
>
> The host type multi-mounts you mention are still handled "as a single 
> entry~, and hence do not allow ghosting yet (4.2.0). So no the "ls 
> /net/server" will not populate itself with ghosted mounts but 
> actual mounts due to the "as a single entry" behaviour.

OK - it's extra work for autofs but not enough to justify hard programmer
work to reduce it.  Also, many people have an alias ls -> ls -F, so ls is
under a compulsion to stat every file it lists, to tag directories and
executables.  Autofs has to mount the filesystem anyway so ls can be
really, really sure that a directory is mounted there.

> The enumeration of exports for host mounts is also part of Marks' patch, 
> some of which is inclued in autofs now but remains unused. And yes, hosts 
> and exports will need to be enumerated in some way to provide a ghosted 
> diectory tree. But please lets not persue this right now. 

No problem.  I brought it up because I saw entanglements, not because I 
wanted them resolved quickly, or in a particular way.

> The flag already exists. It's part of each cache entry. It is set to the 
> time a map is read. It's used to clean stale entries now.

Sorry about not being on top of the code.

> So you are saying we only set a flag when the tests above indicate a map 
> is out of date. But how do we know when user space expects to see an 
> up-to-date map other than a changed map entry? So to use a TTL will give 
> us the oppertunity to check for an outdated map entry. Again only for 
> ghosted maps.

The issue I'm worrying about is, suppose all cache hits until now, that had
timed out and were rechecked from the map, turned out to be correct.  But
suppose there is a map row which we haven't seen yet, either because we
just never read it, or because the map was enumerated some time ago but has
been added to since then?  If the user reads the whole directory you have
to ignore the cache and re-read the NIS map every time (unless you rely on
the NIS order number, not generalizable) (OK to just stat a file map).  
But then, if you can't distinguish "read whole directory" from "hunt for
one file in directory", you end up re-reading the entire map when you don't
want to.

Forgive my meager kernel knowledge, but even if opendir is the same for
both uses, isn't there a separate object method implementing readdir,
versus looking up a file by name?  Readdir should bypass the cache, reading 
the NIS or LDAP map directly, while lookup should and does use the cache.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
