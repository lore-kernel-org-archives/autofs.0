From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Severe problem with 4.1.2: automount caches NIS maps
 forever
Date: Sat, 8 May 2004 23:11:54 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0405082253230.4600@xena.cft.ca.us>
References: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
	<Pine.LNX.4.58.0405070956590.6274@wombat.indigo.net.au>
	<409BD958.2080202@sedona.intel.com>
	<Pine.LNX.4.58.0405081308220.2371@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405081308220.2371@donald.themaw.net>
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
Cc: autofs@linux.kernel.org

On Sat, 8 May 2004 raven@themaw.net wrote:

> > I think a periodic map refresh +  verify the map entry at mount time
> > could resolve the issue.
> >
>
> The main reason I have avoided this is because of potential problems
> accessing the map server. If your NIS server is not available, for
> some reason, but your NFS servers are OK then autofs comes to a grinding
> halt. NIS in particular is problematic like this.

Good point here; it's happened to us.  So specify a time-to-live.

1.  If the needed map row is in the cache AND is younger than the TTL,
    use it as-is.  Deletions from the map, or changed mount options, will
    not be seen until the TTL  expires.
2.  Otherwise, read the map row (needing YP for some maps).  This might
    fail, because the server is dead or the row is no longer in the map.
    You need to distinguish these cases; wipe the cache row for the latter.
3.  If now the row is in the cache (either from YP or a stale cache entry),
    use it.
4.  If the row is not in the cache, you lose.

Then you go on to the conditional on whether the mount works:

5.  If the requested filesystem can be mounted, you're done.
6.  If it failed to mount, and this is the first try, the problem might be
    with the map rather than the server, so toss the cached map row and
    retry from step 2.
7.  If this is the 2nd try at mounting, you lose.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
