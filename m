From: Ian Kent <raven@themaw.net>
Subject: Re: 'browse mode' issue
Date: Tue, 23 Sep 2008 10:05:35 +0800
Message-ID: <1222135535.8564.58.camel@raven.themaw.net>
References: <48D7BF38.5020709@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48D7BF38.5020709@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Mon, 2008-09-22 at 17:52 +0200, Guillaume Rousse wrote:
> Hello list. I've several questions about browse mode option.
> 
> First, I have opposite reports about the effects of 'browse mode' option 
> in automount configuration. Some times ago, a user reported than setting 
> it to 'no' was CPU-unfriendly, so we turned it to 'yes' by default in 
> mandriva package:
> https://qa.mandriva.com/show_bug.cgi?id=31901

That is a bit puzzling for sure.

Debugging this will be difficult but we would need to look at the debug
log and the maps at least.

> 
> However, I now have another report than allowing browse was harmful on 
> large networks, causing lots of IP collisions.

Setting browse to "yes" shouldn't make a great deal of difference for
small configurations but for large configurations it will impact both
CPU and network traffic.

If the maps are large then autofs needs to read the entire map at
startup and again every time it thinks there has been a change. This
will significantly impact network traffic. Also, given that we have a
large map and the mount point directories all exist, when an expire is
run every directory key must be checked which will lead to increased CPU
usage, mostly within the kernel module.

The exception to this is direct maps which must always be read at start
and when a change is detected, the difference being that the CPU
overhead during expire is largely within user space.

To make matters worse there may be a bug which causes maps to be re-read
more often than they need to be but that is quite hard to pick. Maybe a
debug log will give a clue as to whether this is the case.

> 
> So, I'm curious at what should be a good default value for this option.
> 
> Second, having a look at the code, it seems 'yes' is the default in the 
> binary, but, but default configuration file set it to 'no', which is 
> quite disturbing. If there is a good default value for this option (and 
> even if there was not), I'd rather have consistent default values in 
> both places.

That's right.

First the reason for this is that for the industry standard automounter
(not mentioning it by name) the default browse option is "yes" so the
program internal default is this but the version 4 default is "no".
Given the large map issue and the v4 default, the v5 default
configuration overrides this and sets it to "no". I hope that one day we
not need to override this in the configuration but that isn't the case
now.

Also, in v4 maps were always read entirely so it didn't make a lot of
difference but large maps were a killer so in v5 this was changed so
that, when browse is set to "no", maps (other than direct maps) are
never read in full so it can make a big difference. Once again the
reason for the over-ride in the configuration.  

> 
> Last issue, I can't find a correct description on what this option does 
> exactly anywhere :)

So the recommended setting for this is "no" for large maps and either
for smallish maps. Just what constitutes a "large" map is very much site
dependent but a couple of hundred entries is usually ok but a few
thousand almost certainly won't be.

Ian
