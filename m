From: Martin Wilck <martin.wilck@ts.fujitsu.com>
Subject: Re: [PATCH 00/25] Current autofs patch queue
Date: Mon, 02 Sep 2013 16:11:31 +0200
Message-ID: <52249C93.7060501@ts.fujitsu.com>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box> <522469BD.1030709@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET> <522470D3.3050105@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET> <522481D3.4@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04A42@019-AM1MPN1-043.019D.MGD.MSFT.NET> <52248F84.2070704@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04A67@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ts.fujitsu.com; i=@ts.fujitsu.com; q=dns/txt;
  s=s1536b; t=1378131086; x=1409667086;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=WnT0pe36U2nFumU0oTyRjSq98pjCR1FSXrUlnpw2H2I=;
  b=D4F986h6vCeeDZP2juHUS9Va7jh2VOBhaZQCUC9Amhz633pMeuzhBqAi
   3Dl+a3XVMd2iBJjkF49QF68NJul4yVumVg+FgdCmuAXvcNtf6mOb4UGvN
   Exmrv41A5GTQvza95yRwdfZHbYfoyuBez2BzcdLalHCzObQRal0VUhI6I
   jsonD7bpgo28QqxPxxvlXbgmuH7iDXPedMcKrbP08FbgRo0p1+SgXieos
   PHoJNsSkV2yB3wDSl3cEqWwlKnrSh;
In-Reply-To: <DE458807B28C664184FA0C63B022162801D04A67@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Gordon Lack <gordon.m.lack@gsk.com>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On 09/02/2013 03:41 PM, Gordon Lack wrote:
>>> What my patch does is to run the map script under the UID of the user requesting the mount, rather than root.
>>> That is actually an improvement of the security situation, AFAICS.
> 
> Possibly not.

Can you explain?

>>> Please check the "multiuser" option of mount.cifs ("With this option, the client ... creates a new session with
>>> the server using the user's credentials whenever a new user accesses the mount").
> 
> It also says:
> 
>            Furthermore, when unix extensions aren't in use and the
>            administrator has not overriden ownership using the uid= or gid=
>            options, ownership of files is presented as the current user
>            accessing the share.
> 
> Which I take to mean that if you are specifying $UID in the mount options then you've just foiled this bit, the bit that you actually want.

Permission checks are done on the server.

On the client,  without unix extensions, the user/group IDs of files may
be displayed wrongly. That may confuse users because they may not be
able to open files listed as owned by themselves, but it's not a
security problem.

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
