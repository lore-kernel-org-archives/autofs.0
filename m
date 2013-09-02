From: Martin Wilck <martin.wilck@ts.fujitsu.com>
Subject: Re: [PATCH 00/25] Current autofs patch queue
Date: Mon, 02 Sep 2013 16:49:32 +0200
Message-ID: <5224A57C.9000404@ts.fujitsu.com>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box> <522469BD.1030709@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET> <522470D3.3050105@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET> <522481D3.4@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04A42@019-AM1MPN1-043.019D.MGD.MSFT.NET> <52248F84.2070704@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04A67@019-AM1MPN1-043.019D.MGD.MSFT.NET> <52249C93.7060501@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04AA2@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ts.fujitsu.com; i=@ts.fujitsu.com; q=dns/txt;
  s=s1536b; t=1378133366; x=1409669366;
  h=message-id:date:from:mime-version:to:subject:references:
   in-reply-to:content-transfer-encoding;
  bh=2gYPa089vRfvsiNsToreyKVjuplzgq9OrogmK59OIYs=;
  b=p4omGhrFbjLeAVXFCn69NEPjgxC+Gqo7MQxFGJKulQVq1dRMFT8WXRZA
   Pxnpm8+jAFqnCVR+JpvyTDBcd+ZU26BMAMJA4uj2VR6AUsG8Fq6YPMT2c
   1/XB1PbmaRzBvDR3zOidQvRQkORwrYm1EHDMsEaS/lIcAyFzDh+WWLKnl
   V2xuWlkhtmqvqUe1Al4m0OKHXzX6wbPLDKKVOEH8rssfLn3HCd9XghFx3
   YuhluAOUSIDxcOe76POHp3z0k8q13;
In-Reply-To: <DE458807B28C664184FA0C63B022162801D04AA2@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Gordon Lack <gordon.m.lack@gsk.com>, "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On 09/02/2013 04:20 PM, Gordon Lack wrote:
>>>>> What my patch does is to run the map script under the UID of the user requesting the mount, rather than root.
>>>>> That is actually an improvement of the security situation, AFAICS.
>>>
>>> Possibly not.
>>
>> Can you explain?
> 
> It won't be an improvement if it enables something that is inherently insecure.

I don't think that it's inherently insecure, at least not any more than
clicking on a network share in nautilus et al.

UID/GID mapping between client and server and permission control is a
general security challenge for Network file systems. That's not specific
to CIFS, NFS has similar problems. Yet aufofs has had the "-hosts" map
for a long time. My patch aims at something similar to '-hosts' for
CIFS, using kerberos credentials for access control. For both NFS and
CIFS, this kind of feature must not be enabled without proper security
considerations, but that shouldn't be used as an argument not to
implement the feature at all.

>>> Which I take to mean that if you are specifying $UID in the mount options then you've just foiled this bit, the bit that you actually want.
>>
>> Permission checks are done on the server.
> 
> Then why do you need to specify a specific UID at mount time?

Depending on configuration, CIFS won't let you mount anything without
credentials. You may have to be authorized just to see the list of shares.

Once a user on a Windows client is logged in in AD (Kerberos), he will
usually see all relevant shares and be able to access them in various
ways. My goal is to provide a similarly easy access to users with AD
credentials on Linux clients, and one that works on the command line
too, not only from the GUI.

>> On the client,  without unix extensions, the user/group IDs of files may be displayed wrongly.
>> That may confuse users because they may not be able to open files listed as owned by themselves, but
>> it's not a security problem.
> 
> OK - so now I'm confused. you mentioned the multiuser option to mount.cifs as something that enables individual users to get
> their own individual access permissions.  But you're also saying (above) that they won't.

They will have individual access permissions. But without CIFS Unix
extensions, stat(2) will not return real Unix user and group IDs on
files or directories; instead every user will see his own user and group
ID. The real user and group IDs on the server are the Active Directory
Ids of the user owning the file.

Regards
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
