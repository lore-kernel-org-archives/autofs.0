From: Ian Kent <raven@themaw.net>
Subject: Re: get_proximity() crashes on interfaces with no addresses
Date: Tue, 14 May 2013 12:13:25 +0800
Message-ID: <1368504805.2464.13.camel@perseus.fritz.box>
References: <518FB9DC.3000304@nazar.ca>
	 <CAEySpB5ugEzVKNpZPy1PR5baeoN-Z1auET0W0M_OoQwSjTPVtA@mail.gmail.com>
	 <518FFC16.9090507@nazar.ca>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=NZYZkq/GGl0GCpJlD4A1zYEJtmQ=; b=ZY7VyQseUCaSUJzPQees+d1XYwdA
	3IyPqvVR+raazO6NRlTE181/PJryKzu6xEfQ6JIm0GG51/WxQhHPTKSgPijHrlGt
	dZ5IOfpXw7y7xkw3uS7WEk5NURtfdHktum94/YwYKITMXw0kDF35o9QskI2Qjb/S
	JbJS7D3qxaHG7jE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=NZYZkq/GGl0GCpJlD4A1zY
	EJtmQ=; b=klA0DMT8X+9BfkfevvE8728Hezq3x+OXxbsqCGg2SRPmwTuqumXvJr
	z6blSNCDuPWVs77y27ZZvUec7cuJTlh4rc117xpbAEk11f6IwC6B3FHovmaqjahf
	Hln4t7aSQboy1Ab6OCkhd2LTGTgfmFePTB5QxPqxGvUGwGfIpIHLc=
In-Reply-To: <518FFC16.9090507@nazar.ca>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Doug Nazar <nazard@nazar.ca>
Cc: Leonardo Chiquitto <leonardo.lists@gmail.com>, autofs@vger.kernel.org

On Sun, 2013-05-12 at 16:31 -0400, Doug Nazar wrote:
> On 5/12/2013 2:26 PM, Leonardo Chiquitto wrote:
> > On Sun, May 12, 2013 at 5:48 PM, Doug Nazar <nazard@nazar.ca> wrote:
> >> Since commit aa6f7793 [autofs-5.0.7 - fix ipv6 proximity calculation] uses
> >> getifaddrs however it crashes on interfaces with no addresses. Fix the NULL
> >> check to ignore interfaces with no addresses.
> > Your patch removes the check on ifa_addr->sa_data. I'm wondering if
> > it's possible to have a valid ifa_addr and a NULL sa_data. Do you know?
> > Maybe it's safer to just test both:
> 
> I don't see how. ifa_addr is of type struct sockaddr. The sa_data field 
> is a char array and only has meaning after interpreting the sa_family field.

You would think so, I'll go with this.

> 
> >> Should it also check for the IFF_UP flag?
> > I think it makes sense to test it.

Indeed that's probably good to do too.

I'd be interested to hear if this patch functions OK with the IFF_UP
check in place.

In the mean time I'll add the patch to my queue for the next commit.

Ian


