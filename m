From: Ian Kent <raven@themaw.net>
Subject: Re: Proposal for map refresh logic
Date: Tue, 15 Jun 2004 09:30:22 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406150926540.6253@wombat.indigo.net.au>
References: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
 <Pine.LNX.4.58.0405210855001.28570@simba.math.ucla.edu>
 <Pine.LNX.4.58.0406142246320.16281@donald.themaw.net>
 <Pine.LNX.4.58.0406141255550.3683@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406141255550.3683@xena.cft.ca.us>
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

On Mon, 14 Jun 2004, Jim Carter wrote:

> On Mon, 14 Jun 2004 raven@themaw.net wrote:
> > On Fri, 21 May 2004, Jim Carter wrote:
> 
> > > > For a a cache hit we can:
> > > > 
> > > > 1. Check if the map entry has exceeded a given time to live, say
> > > >    the map expire time.
> > > > 2. If not continue as normal otherwise lookup the individual map
> > > >    entry and compare it to the cached entry.
> > > > 3. If they are identical continue as normal otherwise it's a hint
> > > >    the map has changed so re-read it.
> > > 
> > > Suggestion: set a flag saying "we know that this map is out of date", but 
> > > only re-read the whole thing when userspace expects to see up-to-date ghost 
> > > mounts.  Understood, that to read any one row from a file map you have to 
> > > read the whole thing; the suggestion makes a difference only for NIS and 
> > > LDAP -- where it makes a big difference.
> 
> > What were you thinking of as defining "out of date" Jim?
> 
> Item 3 -- we did the NIS lookup on this one entry because the TTL had
> expired, and NIS gave a different answer than the cache, so every cached
> entry from that map is probably wrong.  But there's no need to read the
> whole map; just clear the cached entries that came from it (except the one
> just read, known to be up to date).

One thing I had in mind with this is that map updates are generally small, 
a few records or so.

> 
> In subsequent discussion we may or may not have agreed that the only time 
> you need to read the whole map is when the caller does readdir, as results 
> from "ls /net" or "ls /net/hostname".  In that case you can't trust the 
> cache, because entries might have been added to the map and you'd never 
> know.  Someone pointed out that readdir may have to be used on an ordinary 
> file lookup if you have to dig through the directory to find the file.  
> I'm assuming that a successful cache lookup bypasses this readdir.

Guilty.

We can distinguish between an open on a file and a directory. I'm still 
investigating the actual behaviour of the module as it is now.

Ian
