From: Martin Wilck <martin.wilck@ts.fujitsu.com>
Subject: Re: [PATCH 00/25] Current autofs patch queue
Date: Mon, 02 Sep 2013 17:23:20 +0200
Message-ID: <5224AD68.6050806@ts.fujitsu.com>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box> <522469BD.1030709@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04961@019-AM1MPN1-043.019D.MGD.MSFT.NET> <522470D3.3050105@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D049A6@019-AM1MPN1-043.019D.MGD.MSFT.NET> <522481D3.4@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04A42@019-AM1MPN1-043.019D.MGD.MSFT.NET> <52248F84.2070704@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04A67@019-AM1MPN1-043.019D.MGD.MSFT.NET> <52249C93.7060501@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04AA2@019-AM1MPN1-043.019D.MGD.MSFT.NET> <5224A57C.9000404@ts.fujitsu.com> <DE458807B28C664184FA0C63B022162801D04B16@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ts.fujitsu.com; i=@ts.fujitsu.com; q=dns/txt;
  s=s1536b; t=1378135394; x=1409671394;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=o+HdhsJ0gUNa+L+yFYsZkfzCXL+FdEMx3rW6kSPbj60=;
  b=iXNYLuyVGz4S/Tv9AsqV30ugs63kx429K+KMQiOV/l0rR+DFAu1nzwgX
   TueEnh8Ud5w7oYRiPzq/sOPi7js9zMnFqtW8/ip7lS6BLPr4y8SLoQGh8
   FjQEYEdciBpH6H2BCYtufpFuzoMRFUqhS1NNR7IvkyHDGbTaWMaJDTD8K
   u/L3FSwLhmw8SLq0t3Sq0eRPmS/ik+9DTS9256F+K30vyK1ucuoZHIm6g
   NJ2TVAjesEWbBW3EnHQK2ll/g55Eq;
In-Reply-To: <DE458807B28C664184FA0C63B022162801D04B16@019-AM1MPN1-043.019D.MGD.MSFT.NET>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Gordon Lack <gordon.m.lack@gsk.com>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On 09/02/2013 05:08 PM, Gordon Lack wrote:

>>> Depending on configuration, CIFS won't let you mount anything without credentials. You may have to be authorized
>>> just to see the list of shares.
> 
> So are you saying that the example you were giving, to use multiuser on a cifs mount, was so that the mount could
> take place under the user's Kerberos credentials (which might work) rather than root's (who might not have them)?
> But that once the mount was in place each user's access would be under their own credentials (assuming they have them)?
> 
> In which case I'd agree that this isn't a security issue.

This is my understandning of how "multiuser" works, yes.

Martin

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
