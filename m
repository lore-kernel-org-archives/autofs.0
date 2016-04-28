From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Thu, 28 Apr 2016 10:56:30 +0800
Message-ID: <1461812190.3083.101.camel@themaw.net>
References: <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
	 <1460166126.3073.20.camel@themaw.net>
	 <20160409095659.GB15153@bccms.uni-bremen.de>
	 <1461559248.3012.24.camel@themaw.net>
	 <20160425150638.GC30271@bccms.uni-bremen.de>
	 <1461632818.3218.29.camel@themaw.net> <1461664433.3218.42.camel@themaw.net>
	 <20160426152711.GF30271@bccms.uni-bremen.de>
	 <1461722078.4208.31.camel@themaw.net>
	 <20160427165250.GM30271@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=g8cOJcKq1wz7ZwlwV/+jGvuKuag=; b=dSRvC7
	SMgXcI4RuiJYnewRwsDr64vmvvQBuhHItCB+NT/YkW1kJ5cPIUd3GzaweLN6MYkR
	cWxjzBxtH0IwO/crAybL7FLpb7tm/MRgvDPGmFJJ+bf/EqahBdSQ/uaR4bxBc53D
	Bs602zEgD3N26o2dAUe9AujdUH3uwSxBVNsSs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=g8cOJcKq1wz7Zwl
	wV/+jGvuKuag=; b=FIWkzCS2hh+lfRYVyJIgOSwOZupFWbC+595cp+n9e6lJYOH
	+9UOdu+tcxWhvfxRiChcjBPjSRyDllH6xf3DtywQX6mjdZ3ZnAcmVR4Gr8vs86XN
	rWsuAxuB9Aj+ulAIwvsptaz8j1p9NckuVrMTVJ9PoYsbtb1bapvDsWVS3qVM=
In-Reply-To: <20160427165250.GM30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Wed, 2016-04-27 at 18:52 +0200, Christof Koehler wrote:
> Hello,
> 
> I have the system running and did first tests. This was 
> interesting although I observed basically the behaviour you were 
> expecting.
> 

I might not get this quite right but I'll try.

What release of Ubuntu are we talking about here?

The thing to keep in mind in all of this is that autofs always needs to
check availability so it doesn't try to mount something where there is
no host available. But that can get in the way sometimes and results
with no host to try the mount.

The history of the availability check for single hosts is a little
interesting.

It was present in the original version 5 release but people wanted to
eliminate the extra traffic so it was removed for the single host case.

Then when the mount option processing was taken into the NFS kernel
client we saw that the kernel RPC can't give up on RPC IOs so easily as
the glibc RPC (for NFS file system corruption reasons) and we started
seeing lengthy waits.

After some discussion that was mitigated to a degree but not enough so
the single host availability check was brought back.

You will probably notice a bug with all of this and that is even though
each protocol (TCP and UDP) is checked, IIRC, the proto= option is not
then added to the mount command (when the original option don't provide
a proto= option). But I digress.

So that's the reason for the availability check and why it's used for
single as well as hosts that resolve to multiple addresses.

The other thing to be aware of is that autofs can't know if a host that
resolves to multiple addresses corresponds to a single host that has
multiple address or if there are multiple distinct hosts that have the
same file system available and the addresses are being used for load
balancing in some way.

Since what's needed for multiple hosts and hosts that resolve to
multiple addresses is essentially the same as what's needed for the
single host availability check the same code is used to check single
host availability. So you will see what appears to be redundant checks
that aren't used.

The other thing is that if libtirpc isn't being used the IPv6 code
exclusion isn't quite right which results in some unexpected behaviour
and is what causes some of the unexpected results we are seeing. 

Even so I'm not sure what to do about the IPv6 code exclusion because
I'm more inclined to make the package require libtirpc and remove the
option to not use it altogether given that libtirpc has been generally
available in distros for quite a while now.

> From what I see without libtirpc (standard package), autofs is as
> expected oblivious to IPv6. It passes the servers hostname to mount,
> which 
> in the case of IPv4 and a single IPv6 address in the end uses the IPv6
> one. 
> In the case of two IPv6 addresses it falls back to IPv4 for some
> reason. So 
> that is unrelated to autofs then (and I should ask somewhere else) ? I
> attached two syslog ouputs (debug level) covering the single IPv6 
> (single_log_wo_tirpc.txt.gz) and double IPv6
> (multi_log_wo_tirpc.txt.gz) cases.

Umm ... we are talking without libtirpc, right?

If the name resolve to a single address the probe is essentially an
availability check and the mount just uses the host name.

So you should see the same behaviour as mount.nfs(8).

The faulty IPv6 code exclusion can cause autofs to think there are
multiple addresses even though there aren't (since the IPv6 addresses
are only partly ignored) and that can result in only an IPv4 address
being used.

So I suspect what your seeing is expected and is probably not worth
investigating further.

I will however have a look at the logs to check.

> 
> I note, though, that mount on its own (mount -tnfs4 core330:/locals
> ...)
> always picks one of the IPv6 addresses and never the IPv4 address if
> both IPv6 addresses are in the DNS. So there is some difference to the
> behaviour when called from autofs. Do you have an idea what that might
> be or what I can do to find that out ?

I think I answered that above, without having looked at the log I
believe it is an autofs problem.

> 
> I rebuilt the stock package "--with-libtirpc" (after removing the
> problematic #ifdef block from rpc_subs.c) against the systems libtirpc
> 0.2.5. Then I tested again the two cases mentioned above, log output
> is
> attached as single_log_tirpc.txt.gz and multi_log_tirpc.txt.gz.

I had problems on 14.04 and don't think I bothered with trying that on
16.04 and just brought the link order changes across as a matter of
course.

I had problems with the build in both so I just went for the latest
version of libtirpc.

I still need to cherry pick some recent autofs patches though, one in
particular fixes a program map regression introduced in 5.1.1 so I'm not
quite done yet with the ppa.

> 
> In the "single" case the IPv6 address is always used as far as I could
> see
> (about 10 tries, fewer in log). The response time is apparently not
> used
> e.g. (see single_log_tirpc.txt.gz)
> Apr 27 16:23:33 core400 automount[2473]: get_nfs_info: nfs v4 rpc ping
> time: 0.000115
> Apr 27 16:23:33 core400 automount[2473]: get_nfs_info: nfs v4 rpc ping
> time: 0.000153
> results in
> Apr 27 16:23:33 core400 automount[2473]: mount_mount: mount(nfs):
> calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev core330:/locals
> /local/core330
> which then apparently decides to use the IPv6 address in its own.

Yep, sounds like the availability check I described, that's expected.

> 
> In the double IPv6 address case I see that all available addresses 
> (IPv4 192.168.220.118, IPv6 GUA 2001:...:118 and IPv6 ULA
> fd5f:...:118) are used 
> to mount and that actual IP addresses are passed to mount instead of a
> hostname (see single example above for the opposite behaviour). The
> choice of address is a direct result of the response time as you
> mentioned. 

Again sounds like what's expected.

> 
> It is unclear to me how it decides if an IP address or an
> hostname should be passed to mount, might this be multi-homed or
> failover behaviour ? But then even with IPv4 and a single IPv6 address
> the host
> sould be considered multi-homed for that purpose and not only if it
> has
> multiple IPv6 addresses ?

Yes, that is a problem I mentioned in an earlier post.

There is (I think) a problem with how autofs decides if a host has
multiple addresses which was introduced when there was a complaint about
it.

I can't remember the details now but the bottom line is that autofs will
consider a host to have multiple addresses if the name resolution
results in two or more addresses for either the IPv6 or the IPv4.

I think that's wrong and I should revert it.
I'll need to try and work out what the complaint was but that could be
difficult.

I'll need to have a look at what makes autofs use the address over the
name. There might be a small problem with that too, not sure.

Anyway, first it needs to think the name resolves to multiple addresses
(but consider the problem above).

I think that even if there ends up being only one entry on the list of
available hosts (consisting of distinct and multi-address hosts that are
responding) it must use the address when there were individual hosts
with multiple addresses. Using the name could end up with mount.nfs
trying a host that isn't responding. But it should use the name when the
entry corresponds to a host that resolves to a single address.

I'll check that.

> Or is it working as designed ?
> 
> Now some opinions before some package rebuild and technical questions:
> 
> On Wed, Apr 27, 2016 at 09:54:38AM +0800, Ian Kent wrote:
> > 
> > Then there's the question of order of addresses to try.
> > Should IPv6 addresses be higher priority than IPv4?
> 
> I now see and understand the question. The behaviour of mount (stand
> alone or called from autofs) is puzzling in this context. Stand alone
> mount does IMHO the right thing:
> 
> I always assumed that there was an agreed preference, e.g. observing 
> for http/ssh connections that IPv6 in fact is preferred before
> eventually falling back to IPv4 (perhaps after a timeout).

There probably is but I haven't integrated that into autofs.
That's what I hope to get from this investigation.

> 
> RFC 6724's Abstract says: 
> "In dual-stack implementations, the destination address
> selection algorithm can consider both IPv4 and IPv6 addresses --
> depending on the available source addresses, the algorithm might
> prefer IPv6 addresses over IPv4 addresses, or vice versa."
> 
> and in Section 10.3.
> "The default policy table gives IPv6 addresses higher precedence than
> IPv4 addresses.  This means that applications will use IPv6 in
> preference to IPv4 when the two are equally suitable."

And these certainly imply I should prefer IPv6 over IPv4.
But they also assume IPv6 usage is prevalent and that's been a long time
coming and I'm not sure it's quite here yet either.

Perhaps it is time to add this preference now anyway.

> 
> This is what /etc/gai.conf (source selection) and "ip addrlabel"
> defaults (destination selection) are based on. But may be I am
> overinterpreting the RFC considering its Abstract.
> 
> As far as I read earlier this preference caused/can cause a great deal
> of 
> pain sometimes.
> 
> 
> > 
> > Should I even use IPv4 addresses when IPv6 addresses are present and
> > fall back to IPv4 if all IPv6 addresses fail?
> Fallback after failure might be reasonable. But I agree that there
> will be
> opinions and my use case is not a general or really complicated one,
> so
> I will abstain.
> 
> > 
> > If there is more than one distinct host and a host with only an IPv4
> > address is "closer" (that's the proximity question and also response
> > time) than another host with only an IPv6 address, what selection
> > policy
> > should I use?
> Yes, I see the point. This is obviously out of the RFC's scope.
> 
> One could argue for a configuration file or compile time option(s) to
> influence address selection, but you know pros and cons of that and I
> do
> not. Especially considering that (some) distros are not even using
> libtirpc
> to begin with.

I think a conservative approach is best.

I think just adding a preference is sufficient for now given that the
availability check is done if the service isn't offered the host won't
be tried.

That also implies IPv4 addresses will be retained and tried as well.

I think the only the only question I need to answer is what influence
(if any) response time should play between IPv4 and IPv6. I think it
best to not use it at all to start with (which I think should be the way
it is now, once a v6 over v4 ordering preference is added).

> Now the package rebuild questions:
> You built libtirpc 1.0.1 from the sourceforge source, put include and
> library files in the system locations by hand and then recompiled the
> autofs package against these ? Or is there a neat trick to avoid
> messing
> in the system locations by hand ? 
> I am unsure how to reproduce what you did.

I'm using launchpad to provide a ppa apt source.

So the installed debs will replace existing packages, notably libtirpc,
rpcbind, nfs-common and autofs.

I tried to use the existing distribution package sources (including the
existing package maintainer patches where appropriate) but had to update
to later distribution source version for at least one (nfs-common on
Trusty I think, is using the Xenial package source). That's apart from
libtirpc which is the latest available version.

Form what I can see existing configuration is left untouched so removing
the debs and the ppa source and installing the distributed debs should
result in what you had before the ppa install.

Don't be confused by the change in autofs configuration location in
autofs 5.1.1 (/etc/autofs.conf).

If you only change the autofs configuration in /etc/default/autofs
(IIRC) that will override the new configuration allowing you to switch
between older and newer versions of autofs without configuration
inconsistencies.

We need to keep an eye out in case I've missed something in the Debian
package install configuration file handling. Back them up before hand,
you can then just put them back and all should be fine.

And as I said I still need to add some patches to the autofs deb so the
ppa can't be used just yet.

Because I'm using launchpad the debs from me can be verified as coming
from me and the build packaging files are (I believe, or can be anyway)
publicly available for you to inspect and build from yourself using the
standard Debian build tools if you wish.

> 
> Another question: What is your expectation in a situation where only
> IPv6 is available, no IPv4 for the server ? Is  the one mentioned in
> #25 of
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=737679
> expected to be still a working solution ? I might have an NFS server
> soon
> which, due to a routing conflict difficult to resolve, would only get
> an IPv6 address visible to the clients. I should test this case with a
> dedicated vm as server anyway ...

I think we've covered that above.

The scenario in that bug shows autofs behaving as expected due to lack
of IPv6 support in glibc I think.

I hope that the autofs ppa version will perform the mount fine, as long
as the server is responding but that's one thing we're here to sort out,
;)

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
