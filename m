From: raven@themaw.net
Subject: Re: Severe problem with 4.1.2: automount caches NIS maps
 forever
Date: Sat, 8 May 2004 13:44:38 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405081333390.2371@donald.themaw.net>
References: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com> 
	<Pine.LNX.4.58.0405070956590.6274@wombat.indigo.net.au>
	<1083952697.18740.86.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1083952697.18740.86.camel@serpentine.internal.keyresearch.com>
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
To: Bryan O'Sullivan <bos@serpentine.com>
Cc: autofs@linux.kernel.org

On Fri, 7 May 2004, Bryan O'Sullivan wrote:

> On Thu, 2004-05-06 at 19:10, Ian Kent wrote:
> 
> > It is wrong to say the daemon never checks any more. It never did and to 
> > do so I need information about NIS and LDAP that I don't have at this 
> > stage.
> 
> In that case, I'd suggest that you put a time-to-live value on each
> map.  Permit a configuration option to vary the value, but the default
> can be something long, like an hour.
> 
> When automount reads a map, it sets the TTL for that map to a random
> value between some lower limit (say TTL/4) and the configured or default
> TTL.  This ensures that you won't get periodic storms of map-reading
> network activity after a globally synchronous event like power
> restoration or an automated package update (like a nightly yum update).

Maybe. As I've said I want to limit reading the entire map to a minimum.
But I would need to re-read the map sometime to clean the stale entries 
from "at mount time" changes.

> 
> If a mount fails, you have an option: should you invalidate the cache
> for that map, or not?  I don't have a good answer there.  The mount may
> have failed because the map got updated, but it may also have failed
> because the server was misconfigured, and you have no way of knowing
> which.  Either way, the consequences are annoying: you run the risk of
> software failures on the one hand, or excessive reads of automount maps
> on the other.

Dealing with mount fails is often a source of pain for a bunch of reasons. 
I think the idea of using that as a trigger to re-read the map is likely 
not the best as this is potentially the time the map might not be available.

Ian
