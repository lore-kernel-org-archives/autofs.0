From: Gordon Lack <gordon.m.lack@gsk.com>
Subject: RE: [PATCH 00/25] Current autofs patch queue
Date: Mon, 2 Sep 2013 12:55:55 +0000
Message-ID: <DE458807B28C664184FA0C63B022162801D04A42@019-AM1MPN1-043.019D.MGD.MSFT.NET>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
 <522469BD.1030709@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <522470D3.3050105@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <522481D3.4@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <522481D3.4@ts.fujitsu.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Martin Wilck <martin.wilck@ts.fujitsu.com>, "autofs@vger.kernel.org" <autofs@vger.kernel.org>

>> But that leaves the mount permission dependent on who make the first call.

> True. But that holds in the manual "mount -t cifs ..." case as well.

The manual mount will be done by a specific individual who (hopefully) knows what they are doing.

An automount can be done by a non-determined account and so have a non-determinate outcome once you put per-caller variables into the rule.

>> And once you've done that the UID that needs to be used for each of
>> these mounts is mount-specific, not "who caused the mount"-specific. Which is why I see a problem with it.

> Do you have security concerns, or is it just that you don't consider it useful?

Both.
Its presence would encourage its use.
You will then find users who set it up for themselves and then get confused when another account has made the mount and access is wrong, but everything "looks" correct.
Mind you - the security issue is about using cifs mounts on a system which has the potential for >1 concurrent user anyway.

> But I admit I have been using it mostly on my workstation, where I am the only user.

So you can set-up the rules so that they contain just your id.
And make sure you lock-out all other users once you have anything mounted.


________________________________

This e-mail was sent by GlaxoSmithKline Services Unlimited
(registered in England and Wales No. 1047315), which is a
member of the GlaxoSmithKline group of companies. The
registered address of GlaxoSmithKline Services Unlimited
is 980 Great West Road, Brentford, Middlesex TW8 9GS.

