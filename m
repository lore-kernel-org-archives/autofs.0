From: David Meleedy <david.meleedy@analog.com>
Subject: Re: /net support
Date: Wed, 01 Nov 2006 15:32:32 -0500
Message-ID: <200611012032.kA1KWWQq001340@jetcar.spd.analog.com>
References: <1162348779.3579.19.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Wed, 01 Nov 2006 10:39:39 +0800."
	<1162348779.3579.19.camel@localhost> 
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


> That's a good point actually.
> 
> Solaris uses a proximity metric which I've attempted to put into v5.
> 
> In particular it discriminates between local network, local subnet and
> other network. This happens before ping tests are done. So we do know if
> we are requesting a mount on a network not directly accessible though a
> local interface. Of course that network may not actually be over a WAN
> such as for sites with many local subnets.

Yeah, just FYI at our large site, we have about 7 different subnets
that are all on our LAN.  In order to get my scripts to figure out
which subnets are related I had to create netgroups that the scripts
could use to determine the relationships of the subnets to each other.
(At one point we were converting 137.71.x.x to 10.64.x.x so we had
vastly different network numbers that were still on the same LAN).

At our smaller sites, they usually have 2 subnets on the 10. net.

> I'm not sure yet about the implications or how much effort it would be
> needed to insist that the TCP protocol always and only be used for mount
> requests whose proximity is other network. The proximity check is
> granular in that it is written to be passed the protocols to be checked.
> At the moment it always checks both. I expect I would need to also grab
> the routing information and examine the hop count for this to work in a
> reasonable way.

Well, I think that you'd want some configuration options for the automounter
daemon regarding how to treat proximities (stuff you could put into the
/etc/sysconfig/autofs - on RHE).   You could provide some defaults that
make sense, but it would then allow people to fine tune the settings.  You
could have two proximity settings, one set for "LAN or local" another set
for "WAN or remote".  That way any decisions you make could be modified.


> I'll have a poke around and see what's involved.
> 
> Ian
> 


________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
