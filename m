From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Proposal for map refresh logic
Date: Mon, 14 Jun 2004 14:10:01 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406141311430.3683@xena.cft.ca.us>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
 <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
 <Pine.LNX.4.58.0406141857480.14098@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406141857480.14098@donald.themaw.net>
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

On Mon, 14 Jun 2004 raven@themaw.net wrote:
> On Fri, 21 May 2004, Jim Carter wrote:

> > don't know about LDAP.  Suggestion for ghost mounts: only refresh the map 
> > when a userspace process does opendir on the containing directory, as in 
> > "ls /net/hostname".  In any other case, outdated or missing ghost mounts 
> > cannot be seen by userspace, so let sleeping dogs lie.
> 
> I wonder how many of those opendir events are actually userspace 
> requests not themselves initiated by the daemon?
> 
> What were your thoughts about frequent opendir events, many users, or just 
> many ls commands?

I think it's relatively rare to users to do "ls /whatever" so as to cause a 
NIS automount map to be enumerated, but I'm sensitive to it because when 
there's a dead NFS server that's mounted, the user process has to wait for 
the NFS timeout.  Actually, "ls" isn't the worst culprit: it's /bin/pwd.
During /bin/csh startup there are (I think) three pwd's, at least with our 
.login/.cshrc standard scripts, and when there's a dead server and the 
user's host is later in directory order than the corpse, the user has to 
wait forever to get logged in, leading to an avalanche at the help desk.

Of course there's nothing the automounter can do about this.  Or is there?  
If autofs could recognize the dead server itself, it could do a forced 
unmount, and only one user would be inconvenienced (beyond the ones whose 
homedirs are on the dead server).  

Hmm, why is there a NFS timeout in /bin/pwd?  It stats its own directory to
find out the inode (e.g. /net/myhost), then it enumerates the /net
directory looking for the name of the file (myhost) which has that inode.  
The inode number should be coming back in the readdir output, right?  Or is
this just the inode of the mount point, and it has to actually stat the
file by name to detect the inode of what's mounted on it.  And statting a
mounted NFS filesystem requires a round-trip to the (dead) server, to get
the directory's mode, owner, etc, even if all you care about is the locally
assigned inode number.

> Perhaps a map needs to be considered up to date for some amount of time 
> after a map re-read?

For individual file lookups a TTL is appropriate on cache entries.  If you
use the cache on a readdir a TTL for the whole map is appropriate.  Hmm, on
"ls" the user wants to see ghost entries for the whole map including
entries added since the last full re-read.  But on /bin/pwd, the looked-for
directory entry is known to contain the current working directory, and
therefore has to be already mounted, and in the cache, but we don't care
whether the rest of the map is complete or even if it's accurate.

Here's a heuristic: when they do opendir, clear cache entries for that map 
which are beyond their TTL.  Then they do readdir repeatedly, and you 
return cache entries one by one.  /bin/pwd will close the directory in the 
middle of this phase, having found its target.  "ls" will read the whole 
cache and ask for more.  Now you enumerate the map (caching it, updating 
entries with changed mount options, and removing cache entries no longer in 
the map).  Then resume returning cached map entries, only those (could be 
none) that were not returned yet.

Issues: 

1.  On a cache miss, you will do opendir/readdir and will want some kludge 
to bypass the saved cache entries, already known to be not what you want.

2.  If a directory is added/deleted to/from the cache in the middle of the 
sequence of readdir operations, it may be missed or returned twice.  
Locking can be a problem.  It's probably sufficient if you only delete 
obsolete cache entries during the map re-read, relying on the TTL so you 
can ignore obsolete entries in other cases.  

3.  If only one user at a time could be doing "ls" or "pwd", you could have
a flag in each entry saying "this was returned", but that's clearly bogus, 
and I'm not sure how to distinguish already-returned entries in
the general case.  The cache being a linked list, is the order sufficiently
stable that you can save a pointer to the last returned item (or list head, 
if nothing was cached), and then resume from there in list order, after the 
NIS map is re-enumerated?  (Suppose the pointed-to item gets deleted?)

4.  If a mounted filesystem has vanished from its map, should you delete 
the cache entry at all?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
