From: Gordon Lack <gordon.m.lack@gsk.com>
Subject: RE: [PATCH 00/25] Current autofs patch queue
Date: Mon, 2 Sep 2013 10:41:19 +0000
Message-ID: <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
 <522469BD.1030709@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <522469BD.1030709@ts.fujitsu.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Martin Wilck <martin.wilck@ts.fujitsu.com>, Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

I am wondering about my auto.smb patch (see http://www.spinics.net/lists/autofs/msg00402.html).

I can add a comment about that link...


> > OTOH, setting the uid to
> > the caller is definitely what should be done, IMHO.

That only makes sense if the result is only going to be visible to that one individual.

Linux is a multi-user system, so having automounts that depend on who made the request to do the mount makes no sense if the result is going to be visible to everyone.

I've not seen a system whereby different people have different views of what is mounted.

________________________________

This e-mail was sent by GlaxoSmithKline Services Unlimited
(registered in England and Wales No. 1047315), which is a
member of the GlaxoSmithKline group of companies. The
registered address of GlaxoSmithKline Services Unlimited
is 980 Great West Road, Brentford, Middlesex TW8 9GS.

