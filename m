From: Ian Kent <raven@themaw.net>
Subject: Re: Near-simultaneous automount of multiple directories fails
Date: Sun, 10 Apr 2016 10:34:09 +0800
Message-ID: <1460255649.3508.24.camel@themaw.net>
References: <alpine.LRH.2.11.1604080846130.26210@carrot.ant.ipd.priv>
	  <1460105679.2979.2.camel@themaw.net> <1460108794.2979.22.camel@themaw.net>
	 <alpine.LRH.2.11.1604081231040.26210@carrot.ant.ipd.priv>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=AxaTviio9YagCuUc44Oj/fW4M0I=; b=h0c0Pr
	2An6FcOfZaBI8cQVRnUiijIDut9mwS1UYDtnzAQuZuXab2VB3Q2evvVTIiungKTZ
	dDUMC9Mb+8Y5AvtOsft0Btc4cm6omDhAw7mew2jGk3O2H+gQI0CZZcmyD4yDM2Nx
	NrY5sVMVflM7DD7C94fvqlKel/LvsM94xAtj8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=AxaTviio9YagCuU
	c44Oj/fW4M0I=; b=MT+1Up5xO3L7/+ndvrdM7gzGQhS8sPUAZStI2lLNgSbrMa/
	7/8BdXF0q3kNeDIKtTIG4e2Qp6wSQk0RfsvmZwnsA5h0Er/SXlOc1pP76FMFbVHS
	rataXeSBkutpzxd1Lfgmv0rFg+mfx2TALtPXfYOivazhSn/IRYGgP16G+bVk=
In-Reply-To: <alpine.LRH.2.11.1604081231040.26210@carrot.ant.ipd.priv>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Marcel De Boer <marcel.de_boer@nokia.com>
Cc: autofs@vger.kernel.org

On Fri, 2016-04-08 at 13:37 +0200, Marcel De Boer wrote:
> Hi!
> 
> > > Whatever the problem is it isn't access to either of these two 
> > > variables or the lists they may represent.
> > > 
> > > They are both local variables of the mount_mount() function and so
> > > cannot be accessed simultaneously by any other function.
> 
> Too bad... that means my changes probably just mixed up the timing
> enough 
> to avoid the problem.
> 
> > Btw, there has been no actual RHEL release of revision 115.
> > 
> > Only 113 in RHEL-6.7 and (probably) revision 122 will be RHEL-6.8.
> > So I wonder what else went into revision 115.
> <...>
> > We probably shouldn't work with revision 122 yet so may be we should
> > work with revision 113, not sure about that though.
> 
> Ah wait... because it was just for local testing, I also changed the 
> patchlevel so yum wouldn't complain. Judging from the build machine 
> history, it actually is -113. Postponing writing this mail for too
> long 
> made me forget too much...
> 
> > I'm not sure I could reproduce this because I have a stress test
> > (used
> > for RHEL) that uses (IIRC) 8 concurrent threads to test mount
> > concurrency and to test for mount to expire races.
> > 
> > The maps used are somewhat more complex than what you have here so
> > perhaps I missed this point with that test.
> 
> The configuration for the server uses indirect maps from the local 
> filesystem. All other machines get a slightly different config through
> NIS.
> 
> > However, I've recently written another RHEL test (based on this
> > test)
> > that uses a simple indirect map with the 8 concurrent threads to try
> > and
> > duplicate a different problem.
> > 
> > I would have though this test would expose this sort of problem but
> > after (I can't actually remember the longest run) about three days
> > of
> > continuous running I didn't see any problems.
> > 
> > Granted it was a different scenario to yours though.
> 
> Of course it also looks timing-related, so there's no telling in
> exactly 
> which configuration it'll pop up. For the machine I used for testing
> (not 
> the same hardware as the server), the issue already disappeared when I
> locally rebuilt the same RPM as the one that was already installed.
> 
> I already noticed changes in the frequency when I changed the versions
> of 
> supporting packages (libtirpc) or ran it in the foreground or with 
> debugging.
> 
> > So I think we need to narrow down where this is occurring.
> > 
> > To start with I'd add mutexes around just the parse_location() and
> > prune_host_list() functions and then if that also resolves the
> > problem
> > drill down from there.
> 
> I'll see if I can do that next week (even though the server is busy,
> it's 
> not a disaster if it happens, but I prefer to be around to unwedge
> it.)

I can help with that by providing patches.

To start with the change here is quite conservative, next one would be
much less so (and quite a bit more difficult to write). The idea being
much like a kernel bi-sect to narrow the search quickly.

> 
> Thanks!
> 
> Kind regards,
>  	Marcel de Boer
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
