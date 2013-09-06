From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/2, 2nd attempt] samples/auto.smb: add logic to obtain
 credentials
Date: Fri, 06 Sep 2013 17:26:31 +0800
Message-ID: <1378459591.2311.28.camel@perseus.fritz.box>
References: <51081EF4.20105@ts.fujitsu.com>
	  <1359549686-7246-1-git-send-email-martin.wilck@ts.fujitsu.com>
	  <1359549686-7246-3-git-send-email-martin.wilck@ts.fujitsu.com>
	 <1378454358.2311.1.camel@perseus.fritz.box>
	 <52299118.4080103@ts.fujitsu.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=cCr5rjH4GrIhPGJjvbeyzqTn3cE=; b=p4dsZpaGWu+7f7nGhm6vqtbBcL8G
	wH5u8A4TQIGJJMXCLw6AHnBpKAmdoKHrRWabSlK7ZYOVjXkzju9lCfU8BxjwbKFh
	Sve8psoEbOPuOtDj3xJ4hBAJ6unyuS9raD3QwpjDyVqqrP7FbIbGdlMnb/5XEGWR
	V9p4oUquP48pdZI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=cCr5rjH4GrIhPGJjvbeyzq
	Tn3cE=; b=Gr63PEZlcnDxJpg3mGg6ECvGXLBELH7/7/d9SQmkR1DQr96VGjbPxu
	Q51qGSDM8TM/tEHrvuycLg52mZzmtRwtPCJRPFKjMqdbdfePXvyOXw44DCLqHot+
	tlPv2j4bBPKswdPwuED27iPpibyV9cRsa9pxroONtv7wRQoLPYNZo=
In-Reply-To: <52299118.4080103@ts.fujitsu.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Wilck <martin.wilck@ts.fujitsu.com>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Fri, 2013-09-06 at 10:23 +0200, Martin Wilck wrote:
> On 09/06/2013 09:59 AM, Ian Kent wrote:
> 
> >> -$SMBCLIENT -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
> >> +creds=/etc/creds/$key
> >> +if [ -f "$creds" ]; then
> >> +    opts="$opts"',uid=$UID,gid=$GID,credentials='"$creds"
> >> +    smbopts="-A $creds"
> >> +else
> >> +    get_krb5_cache
> >> +    if [ -n "$cache" ]; then
> >> +        opts="$opts"',multiuser,cruid=$UID,sec=krb5i'
> >> +        smbopts="-k"
> >> +        export KRB5CCNAME=$cache 
> >> +    else
> >> +        opts="$opts"',guest'
> > 
> > Why add guest?
> 
> "guest" means "don't prompt for a password" which is what mount.cifs
> will attempt to do if no credentials are available already (e.g. via
> kerberos ticket). IMO that's what's needed for autofs, otherwise the
> mount attempt might hang waiting for password input.
> 
> > Is that going to change the behavior of the existing script.
> 
> "guest" mode was all the previous script could do, thus it seems to have
> been written with servers in mind that only offered guest access in the
> first place (und thus wouldn't prompt for a password, either).

From my POV auto.smb is an example program map that happens to get
installed. I don't think it was never meant to be sophisticated.

You are saying that adding guest doesn't change anything as it is the
default when no credentials are provided, correct?

> 
> Martin
> 


