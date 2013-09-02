From: Gordon Lack <gordon.m.lack@gsk.com>
Subject: RE: [PATCH 00/25] Current autofs patch queue
Date: Mon, 2 Sep 2013 13:41:18 +0000
Message-ID: <DE458807B28C664184FA0C63B022162801D04A67@019-AM1MPN1-043.019D.MGD.MSFT.NET>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
 <522469BD.1030709@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <522470D3.3050105@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <522481D3.4@ts.fujitsu.com>
 <DE458807B28C664184FA0C63B022162801D04A42@019-AM1MPN1-043.019D.MGD.MSFT.NET>
 <52248F84.2070704@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <52248F84.2070704@ts.fujitsu.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Martin Wilck <martin.wilck@ts.fujitsu.com>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

>> What my patch does is to run the map script under the UID of the user requesting the mount, rather than root.
>> That is actually an improvement of the security situation, AFAICS.

Possibly not.

>> Please check the "multiuser" option of mount.cifs ("With this option, the client ... creates a new session with
>> the server using the user's credentials whenever a new user accesses the mount").

It also says:

           Furthermore, when unix extensions aren't in use and the
           administrator has not overriden ownership using the uid= or gid=
           options, ownership of files is presented as the current user
           accessing the share.

Which I take to mean that if you are specifying $UID in the mount options then you've just foiled this bit, the bit that you actually want.

Unless cruid is different? (Never used it - or Kerberos - so don't know).

>> With that option, I see no major difference between CIFS and NFS automounts, security-wise.
>> IMO combining autofs and "multiuser" is exactly the desired behavior in an AD environment.
>> It lets the server decide access rights based on the credentials provided.

You could well be right.  I was just raising it as something that may lead to security issues in general.

>> It's a (sad) fact in life that many of us have to work in Windows-dominated IT environments.

True.  Although putting everything on network file servers which can farm out the same files using both cifs and nfs can simplify the clients.


________________________________

This e-mail was sent by GlaxoSmithKline Services Unlimited
(registered in England and Wales No. 1047315), which is a
member of the GlaxoSmithKline group of companies. The
registered address of GlaxoSmithKline Services Unlimited
is 980 Great West Road, Brentford, Middlesex TW8 9GS.

