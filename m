From: Martin Wilck <martin.wilck@ts.fujitsu.com>
Subject: Re: [PATCH 00/25] Current autofs patch queue
Date: Mon, 02 Sep 2013 15:15:48 +0200
Message-ID: <52248F84.2070704@ts.fujitsu.com>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box> <522469BD.1030709@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET> <522470D3.3050105@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET> <522481D3.4@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04A42@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ts.fujitsu.com; i=@ts.fujitsu.com; q=dns/txt;
  s=s1536b; t=1378127742; x=1409663742;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=KSNbXA935EsUl7XIYgIDPaMEB41oOn+k7flsKscak70=;
  b=pHC3Z6QTVhvT0Nw/wsnP8gmaQbKt/oxXvJBRdtokwSN0g2eJ9WSUMfZG
   fvM/dehpKw9Sa1+21vM4vZDne5/3vnDEr79fUYGRcNFT8yfmT5xcF/72b
   Jc4u5On7UQhBfof18Y13yB7uUiqh1DUKcDksduXMf7xHJEP9pMBd8B/RE
   dUdmQrAnEx59Pj/zABaRlGufD5VLEP4Ls34MJFRhtya1Z5hXNe2WM1Rou
   r6VkcuWxT0LJs6og1oMbb3rlSkfB+;
In-Reply-To: <DE458807B28C664184FA0C63B022162801D04A42@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Gordon Lack <gordon.m.lack@gsk.com>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On 09/02/2013 02:55 PM, Gordon Lack wrote:
>>> But that leaves the mount permission dependent on who make the first call.
> 
>> True. But that holds in the manual "mount -t cifs ..." case as well.
> 
> The manual mount will be done by a specific individual who (hopefully) knows what they are doing.
> 
> An automount can be done by a non-determined account and so have a non-determinate outcome once you put per-caller variables into the rule.

What my patch does is to run the map script under the UID of the user
requesting the mount, rather than root. That is actually an improvement
of the security situation, AFAICS.

>>> And once you've done that the UID that needs to be used for each of
>>> these mounts is mount-specific, not "who caused the mount"-specific. Which is why I see a problem with it.
> 
>> Do you have security concerns, or is it just that you don't consider it useful?
> 
> Both.
> Its presence would encourage its use.
> You will then find users who set it up for themselves and then get confused when another account has made the mount and access is wrong, but everything "looks" correct.
> Mind you - the security issue is about using cifs mounts on a system which has the potential for >1 concurrent user anyway.

Please check the "multiuser" option of mount.cifs ("With this option,
the client ... creates a new session with the server using the user's
credentials whenever a new user accesses the mount"). With that option,
I see no major difference between CIFS and NFS automounts,
security-wise. IMO combining autofs and "multiuser" is exactly the
desired behavior in an AD environment. It lets the server decide access
rights based on the credentials provided.

>> But I admit I have been using it mostly on my workstation, where I am the only user.
> 
> So you can set-up the rules so that they contain just your id.
> And make sure you lock-out all other users once you have anything mounted.

I don't think that's necessary, see above.

Your arguments would apply equally well to users clicking on "Network
Environment" or similar in their GUI. It's a (sad) fact in life that
many of us have to work in Windows-dominated IT environments.

Martin

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
