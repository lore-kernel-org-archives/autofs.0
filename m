From: Ian Kent <raven@themaw.net>
Subject: Re: Severe problem with 4.1.2: automount caches NIS maps
 forever
Date: Fri, 7 May 2004 10:10:26 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405070956590.6274@wombat.indigo.net.au>
References: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
 <409AAC9E.9000505@sedona.intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <409AAC9E.9000505@sedona.intel.com>
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
To: Michael Blandford <mlblandf@sedona.ch.intel.com>
Cc: autofs@linux.kernel.org

On Thu, 6 May 2004, Michael Blandford wrote:

> Bryan O'Sullivan wrote:
> 
> >Hi -
> >
> >The autofs 4.1.2 release has a change in behaviour from earlier releases
> >(4.1.0, I think, and 4.0.0 for sure) in that it never checks to see if a
> >NIS-based automount map has changed.  This means that if I change the
> >location of an autofs-mounted filesystem, I have to SIGHUP the automount
> >daemons on every machine that care about that filesystem so that they'll
> >forget the contents of the map and reload it.
> >
> >Needless to say, this doesn't scale in even a tiny way :-(
> >  
> >
> Agreed.  You would think with all the testing I have done, I would have 
> seen this one.
> 
> I can easily replicate it and fix it with a SIGHUP.
> 
> Ian, do you have any thoughts on this one?

Yes.

This changed in 4.1.0 because, to do browsable directoties the entire map 
must be known in advance.

It is wrong to say the daemon never checks any more. It never did and to 
do so I need information about NIS and LDAP that I don't have at this 
stage.

In early stages I kept the "discover at mount time" behaviour but was 
concerned that this lead to a missleading picture of the mount tree.

So guys, the options here are:

1) leave as is and use HUP signal to refresh maps.
2) reintroduce the "discover at mount time" behaviour (possibly
   with a periodic resync).
3) add a periodic map refresh whose frequency is perhaps configurable.

I must retain the cache that is used internally as when (if I ever) get to 
working on fixing the current limitations the design will be heavily based 
on that.
 
Ian
