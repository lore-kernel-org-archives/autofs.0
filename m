From: Ian Kent <raven@themaw.net>
Subject: Re: /net support
Date: Wed, 01 Nov 2006 10:39:39 +0800
Message-ID: <1162348779.3579.19.camel@localhost>
References: <200610312042.k9VKgBVw009630@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200610312042.k9VKgBVw009630@jetcar.spd.analog.com>
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org

On Tue, 2006-10-31 at 15:42 -0500, David Meleedy wrote:
> > That very much depends on usage.
> > 
> > If you have a bunch of clients that typically open and load files of
> > potentially several hundred megabytes then UDP retransmits can become a
> > problem.
> > 
> > But then if traffic is light there's not much to be gained and if there
> > are traffic spikes possibly something to be lost.
> 
> Well, our CAD software can generate files varying from several hundred
> megabytes up to 1-3 gigabytes.  So yes, we actually do have
> large files being transmitted, which is why I had been looking at not
> using tcp on the LAN.  But tcp is the only reliable WAN method I've
> found.  I think what I'm going to have to do is generate local NIS
> maps for every client and use a "program" script to read them.  That
> way I can insert the appropriate flags in there, depending on whether
> or not a machine is on the LAN vs. WAN.  I had just noticed that on
> Solaris, the behavior seems to work much better than on linux, so I was
> kind of wondering how they had solved it.

That's a good point actually.

Solaris uses a proximity metric which I've attempted to put into v5.

In particular it discriminates between local network, local subnet and
other network. This happens before ping tests are done. So we do know if
we are requesting a mount on a network not directly accessible though a
local interface. Of course that network may not actually be over a WAN
such as for sites with many local subnets.

I'm not sure yet about the implications or how much effort it would be
needed to insist that the TCP protocol always and only be used for mount
requests whose proximity is other network. The proximity check is
granular in that it is written to be passed the protocols to be checked.
At the moment it always checks both. I expect I would need to also grab
the routing information and examine the hop count for this to work in a
reasonable way.

I'll have a poke around and see what's involved.

Ian
