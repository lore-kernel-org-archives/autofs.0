From: Martin Wilck <martin.wilck@ts.fujitsu.com>
Subject: Re: [PATCH 00/25] Current autofs patch queue
Date: Mon, 02 Sep 2013 14:17:23 +0200
Message-ID: <522481D3.4@ts.fujitsu.com>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box> <522469BD.1030709@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET> <522470D3.3050105@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ts.fujitsu.com; i=@ts.fujitsu.com; q=dns/txt;
  s=s1536b; t=1378124252; x=1409660252;
  h=message-id:date:from:mime-version:to:subject:references:
   in-reply-to:content-transfer-encoding;
  bh=EUurMWuNQE6zKWp6eJ2nkL+CpvNjKI6KWMHOJIpfl4Q=;
  b=Er2mk8o8EKAxg3sikM01PKasO88vJWBbUJrNWOV2i5MrdteN0LhHSHEb
   8J01b2WyVGbeJML5sJukp9Ok7hXH24dFOjl68jqPUwvB6sshP8Htzp1wJ
   dt1kH55M3e2SIJ3blwhn8RSqsXR1GMbfMRv/AfmF4+Ke7wHP0R7Qeq2cX
   ix8gNi7g1p/T50rXctT33GMLEUgy2rdxS4rCb5cp1PWqLAsr2n28ygeOj
   TBBYkO+ZIJqxMyXIM+faGrgW1LLkQ;
In-Reply-To: <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Gordon Lack <gordon.m.lack@gsk.com>, "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On 09/02/2013 01:13 PM, Gordon Lack wrote:
>>> I'm not sure what you mean.
> 
> Just that I've not seen it, so thanks for the example.
> 
>>> Users can create user-specific CIFS mounts today with "sudo mount -t cifs -o sec=krb5,cruid=$UID,...".
>>> The intention of my patch is just to enable autofs to create such mounts.
> 
> But that leaves the mount permission dependent on who make the first call.

True. But that holds in the manual "mount -t cifs ..." case as well.

>>> P.S.: You are correct that there is an issue with autofs caching the list of mount points if the
>>> list of mountable shares returned by a server depends on the credentials provided. AFAICS that can
>>> be fixed by configuring the such that all users can see the same shares (but not necessarily
>>> access/mount them all).
> 
> And once you've done that the UID that needs to be used for each of these mounts is mount-specific,
> not "who caused the mount"-specific. Which is why I see a problem with it.

Do you have security concerns, or is it just that you don't consider it
useful? I can just say that I find it very useful working on a Linux
workstation in an AD-dominated environment. It's much more practical
than using any of the "Network Browsing" utilities provided by GNOME and
the like. Just my personal opinion.

I admit I have been using it mostly on my workstation, where I am the
only user.

Martin

> 
> 
> 
> ________________________________
> 
> This e-mail was sent by GlaxoSmithKline Services Unlimited
> (registered in England and Wales No. 1047315), which is a
> member of the GlaxoSmithKline group of companies. The
> registered address of GlaxoSmithKline Services Unlimited
> is 980 Great West Road, Brentford, Middlesex TW8 9GS.
> 


-- 
Dr. Martin Wilck
PRIMERGY System Software Engineer
x86 Server Engineering

FUJITSU
Fujitsu Technology Solutions GmbH
Heinz-Nixdorf-Ring 1
33106 Paderborn, Germany
Phone:			++49 5251 525 2796
Fax:			++49 5251 525 2820
Email:			martin.wilck@ts.fujitsu.com
Internet:		http://ts.fujitsu.com
Company Details:	http://ts.fujitsu.com/imprint
