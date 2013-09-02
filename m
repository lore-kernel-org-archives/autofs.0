From: Gordon Lack <gordon.m.lack@gsk.com>
Subject: RE: [PATCH 00/25] Current autofs patch queue
Date: Mon, 2 Sep 2013 11:13:17 +0000
Message-ID: <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
 <522469BD.1030709@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <522470D3.3050105@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <522470D3.3050105@ts.fujitsu.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Martin Wilck <martin.wilck@ts.fujitsu.com>
Cc: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

>> I'm not sure what you mean.

Just that I've not seen it, so thanks for the example.

>> Users can create user-specific CIFS mounts today with "sudo mount -t cifs -o sec=krb5,cruid=$UID,...".
>> The intention of my patch is just to enable autofs to create such mounts.

But that leaves the mount permission dependent on who make the first call.

>> P.S.: You are correct that there is an issue with autofs caching the list of mount points if the
>> list of mountable shares returned by a server depends on the credentials provided. AFAICS that can
>> be fixed by configuring the such that all users can see the same shares (but not necessarily
>> access/mount them all).

And once you've done that the UID that needs to be used for each of these mounts is mount-specific,
not "who caused the mount"-specific. Which is why I see a problem with it.



________________________________

This e-mail was sent by GlaxoSmithKline Services Unlimited
(registered in England and Wales No. 1047315), which is a
member of the GlaxoSmithKline group of companies. The
registered address of GlaxoSmithKline Services Unlimited
is 980 Great West Road, Brentford, Middlesex TW8 9GS.

