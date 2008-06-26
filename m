From: Ian Kent <raven@themaw.net>
Subject: Re: Direct mount newbie question
Date: Thu, 26 Jun 2008 21:42:05 +0800
Message-ID: <1214487726.3087.9.camel@raven.themaw.net>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A578E@hqemmail01.nvidia.com>
	<Pine.LNX.4.64.0806251647250.15233@xena.cft.ca.us>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A5793@hqemmail01.nvidia.com>
	<x49wskc5o9c.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49wskc5o9c.fsf@segfault.boston.devel.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org


On Thu, 2008-06-26 at 09:17 -0400, Jeff Moyer wrote:
> "Stephen Biggs" <sbiggs@nvidia.com> writes:
> 
> >> -----Original Message-----
> >> From: jimc@xena.cft.ca.us [mailto:jimc@xena.cft.ca.us] On 
> >> Behalf Of Jim Carter
> >> Sent: Wednesday, June 25, 2008 5:07 PM
> >> To: Stephen Biggs
> >> Cc: autofs@linux.kernel.org
> >> Subject: Re: [autofs] Direct mount newbie question
> ...
> > The only time this becomes a problem is when it tries to open
> > /home/.junk.  This triggers the automounter to go across the net to find
> > the directory in the map.  I may be wrong about any NFS chatter. In any
> > case, this access of the map across the network can take up to 300 ms to
> > query and then return a failure.
> >
> > It has nothing to do with which user is running. The problem is that "Q"
> > is stupidly written and does this futile search many, MANY times in the
> > running of a job, not taking no for an answer. Again, as I said before,
> > I have no control over this application and cannot fix its ridiculous
> > behavior.
> 
> Ian, this should be fixed by the negative lookup caching, right?  I take
> it that's not in 5.0.3.

Maybe the function isn't quite right.
Maybe I'm not marking it as a failed mount because it isn't found in the
map, which isn't very sensible but I'll bet that's what it is.

Ian
