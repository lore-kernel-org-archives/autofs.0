From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Severe problem with 4.1.2: automount caches NIS maps
 forever
Date: Thu, 6 May 2004 20:45:59 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0405062024330.6910@xena.cft.ca.us>
References: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
	<Pine.LNX.4.58.0405070956590.6274@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405070956590.6274@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Fri, 7 May 2004, Ian Kent wrote:
> This changed in 4.1.0 because, to do browsable directoties the entire map
> must be known in advance...
>
> So guys, the options here are:
>
> 1) leave as is and use HUP signal to refresh maps.
> 2) reintroduce the "discover at mount time" behaviour (possibly
>    with a periodic resync).
> 3) add a periodic map refresh whose frequency is perhaps configurable.

Another idea: if the map row is in the cache AND the mount succeeds,
fine, leave it in the cache.  If either one fails, the problem
might be with the map -- we've cached a row that was removed (and so was
its server), or we've failed to cache a newly added row.  So flush the
cache (for that map) and enumerate the map again.  But if a second mount
attempt fails, believe in the failure.  I think it likely that you can
get away with reading (or trying and failing to read) just that one row,
with random access data sources.

The only fly in the ointment is, if the mount options change, you won't
know.  I'd say, include a time to live (with a configurable timeout), so
if a row is needed that hasn't been read authoritatively in (let's say) one
hour, you should re-read just that one row, for random-access data sources
like NIS or LDAP or a programmatic map (or read the whole map if it's a
file).  Again, for ghost mounts, if someone does "ls /net/$host" and a full
enumeration hasn't been done within the timeout, you have to do it over.

I believe you said that wildcard maps are still going to work OK.  That's
important to me -- all my maps are wildcard maps.

The current HUP behavior needs to be retained if the sysop wants to update
an entire map immediately, but as one of the writers said, HUP is not very
scalable.  I have an automated script for doing this kind of thing, but if
there were 1000 machines it would still be a burden.

I think periodic refresh is not such a good idea because (at least in my
case) each machine can potentially use a whole lot of maps, but each one
has a few favorites, and it's a waste to refresh the others.  Refresh when
the data is requested and is stale.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
