From: Ian Kent <raven@themaw.net>
Subject: Re: get_proximity() crashes on interfaces with no addresses
Date: Thu, 16 May 2013 08:45:44 +0800
Message-ID: <1368665144.2414.0.camel@perseus.fritz.box>
References: <518FB9DC.3000304@nazar.ca>
		 <CAEySpB5ugEzVKNpZPy1PR5baeoN-Z1auET0W0M_OoQwSjTPVtA@mail.gmail.com>
		 <518FFC16.9090507@nazar.ca> <1368504805.2464.13.camel@perseus.fritz.box>
	 <519200C4.5050909@nazar.ca>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=m9nH8tGci3dmA/GLo7KsPrTHCK0=; b=YLo1z+1HrQTOwIgNoJ5vjMBZdd99
	Hbe/0xDCxSbJIVMp4x4F3Fwwm6lsbyDe2jtxw7E02QPNCmaET4ZsSD+OPy7jldrK
	xTOEfsVVbls0mM1ZPu579xCyAeoBwdq8zUeeF+19vTdWil98bcTlAQWELwcRHIvC
	/aJcOfFGByOHkDk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=m9nH8tGci3dmA/GLo7KsPr
	THCK0=; b=kTixmFjmpWDdO5poif3fV2y9l5BfLMP70RnB9vXWmH62+UdpKPDQTk
	9hhacKoK5hfD6CQHNsSAXbafKm6WZH8NK1TT7yZ3Zyvq3P6ZqyXilez5CVmcEs6j
	dKPELCrsbUO6zDuv+uOxojMcrzFTMKX/RJjW3uGfnt/cGWxQlgtiE=
In-Reply-To: <519200C4.5050909@nazar.ca>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Doug Nazar <nazard@nazar.ca>
Cc: Leonardo Chiquitto <leonardo.lists@gmail.com>, autofs@vger.kernel.org

On Tue, 2013-05-14 at 05:15 -0400, Doug Nazar wrote:
> On 5/14/2013 12:13 AM, Ian Kent wrote:
> > Indeed that's probably good to do too. I'd be interested to hear if 
> > this patch functions OK with the IFF_UP check in place. In the mean 
> > time I'll add the patch to my queue for the next commit.
> 
> I've been running it for a day on a few boxes with no problems. The only 
> additional line is a logging line I had when originally testing.
> 
> May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
> getifaddrs: ifa_name lo, ifa_flags 0x00010049
> May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
> getifaddrs: ifa_name eql, ifa_flags 0x00000400
> May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
> getifaddrs: ifa_name eth0, ifa_flags 0x00011043
> May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
> getifaddrs: ifa_name wlan0, ifa_flags 0x00001002
> May 14 04:58:47 cockatrice automount[365]: get_proximity:168: 
> getifaddrs: ifa_name wmon0, ifa_flags 0x00011043
> 
> IFF_UP is 0x01 so that looks correct. eql was the one that it was 
> crashing on with no ifa_addr.

OK, thanks for this.

> 
> Doug
> 


