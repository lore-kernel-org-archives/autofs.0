From: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: Severe problem with 4.1.2: automount caches NIS maps
	forever
Date: Fri, 07 May 2004 10:58:17 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1083952697.18740.86.camel@serpentine.internal.keyresearch.com>
References: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
	 <409AAC9E.9000505@sedona.intel.com>
	 <Pine.LNX.4.58.0405070956590.6274@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Thu, 2004-05-06 at 19:10, Ian Kent wrote:

> It is wrong to say the daemon never checks any more. It never did and to 
> do so I need information about NIS and LDAP that I don't have at this 
> stage.

In that case, I'd suggest that you put a time-to-live value on each
map.  Permit a configuration option to vary the value, but the default
can be something long, like an hour.

When automount reads a map, it sets the TTL for that map to a random
value between some lower limit (say TTL/4) and the configured or default
TTL.  This ensures that you won't get periodic storms of map-reading
network activity after a globally synchronous event like power
restoration or an automated package update (like a nightly yum update).

If a mount fails, you have an option: should you invalidate the cache
for that map, or not?  I don't have a good answer there.  The mount may
have failed because the map got updated, but it may also have failed
because the server was misconfigured, and you have no way of knowing
which.  Either way, the consequences are annoying: you run the risk of
software failures on the one hand, or excessive reads of automount maps
on the other.

One thing you could do in such a case is halve the remaining TTL on each
mount failure, to at least bring forward the next time the map will be
read.

	<b
