From: Gordon Lack <gordon.m.lack@gsk.com>
Subject: RE: [PATCH 00/25] Current autofs patch queue
Date: Mon, 2 Sep 2013 14:20:18 +0000
Message-ID: <DE458807B28C664184FA0C63B022162801D04AA2@019-AM1MPN1-043.019D.MGD.MSFT.NET>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
 <522469BD.1030709@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <522470D3.3050105@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <522481D3.4@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D04A42@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <52248F84.2070704@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D04A67@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <52249C93.7060501@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <52249C93.7060501@ts.fujitsu.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Martin Wilck <martin.wilck@ts.fujitsu.com>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

>>>> What my patch does is to run the map script under the UID of the user requesting the mount, rather than root.
>>>> That is actually an improvement of the security situation, AFAICS.
>>
>> Possibly not.
>
> Can you explain?

It won't be an improvement if it enables something that is inherently insecure.

>> Which I take to mean that if you are specifying $UID in the mount options then you've just foiled this bit, the bit that you actually want.
>
> Permission checks are done on the server.

Then why do you need to specify a specific UID at mount time?

> On the client,  without unix extensions, the user/group IDs of files may be displayed wrongly.
> That may confuse users because they may not be able to open files listed as owned by themselves, but
> it's not a security problem.

OK - so now I'm confused. you mentioned the multiuser option to mount.cifs as something that enables individual users to get
their own individual access permissions.  But you're also saying (above) that they won't.

It's this lack of specificity that worries me.

If we add this code
  it will enable this feature
  and remove this current anomaly/mis-feature
    which will provide this end-user enhancement.


________________________________

This e-mail was sent by GlaxoSmithKline Services Unlimited
(registered in England and Wales No. 1047315), which is a
member of the GlaxoSmithKline group of companies. The
registered address of GlaxoSmithKline Services Unlimited
is 980 Great West Road, Brentford, Middlesex TW8 9GS.

