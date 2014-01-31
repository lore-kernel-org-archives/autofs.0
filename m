From: Ian Kent <raven@themaw.net>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Fri, 31 Jan 2014 09:36:24 +0800
Message-ID: <1391132184.2486.10.camel@perseus.fritz.box>
References: <52E92627.9050801@molgen.mpg.de>
	 <1391041164.2620.10.camel@perseus.fritz.box>
	 <52EA2963.9070709@molgen.mpg.de>
	 <E2163B9E-3214-477B-BB93-91FA4B424CE9@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=yIzP59l9oDbHPxwELcrG5LmLmoI=; b=hfGClqgloG5goV6hZGvGe0VwCljN
	EJUrmVwBf5J7b7UfxIjns/twG31zYhu6l8JLpE1BNmYnVSSpc1Nmnrj/SYcrFw1x
	bo4oPLdPsYLsnkbsxQt2c8BZ7kafvPxzgZxoVwi80YD4GM+gz8GNughms4UesOvn
	18QGoXKozc3GqoM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=yIzP59l9oDbHPxwELcrG5L
	mLmoI=; b=KMQLMIglqpQ/R+o5A76eDNneCPYXCemFGXXJjwtRsT3zkmod6/Amya
	c8W+fbH6RSxcHAoqxPdfeWeXd3axVJBxVk53GF1zZX168uOCfhF1KILSoPay+mqW
	OoRY5iVRpNK0MxLxvNYmRDJ+kfzrD1l4eZIyvXf6W5guy28YILrKs=
In-Reply-To: <E2163B9E-3214-477B-BB93-91FA4B424CE9@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: "leonardo.lists@gmail.com" <leonardo.lists@gmail.com>, autofs <autofs@vger.kernel.org>

On Thu, 2014-01-30 at 22:30 +0800, Ian Kent wrote:
> > > I hoped to get autofs running cleanly before that. There isn't so
> much change in "git log -p v3.8.13..master  fs/autofs4" anyway.
> 
> This probably isn't the autofs module, it's probably in the automount
> code in the VFS.
> 
> Specific automount support has been added to the VFS around 2.6.32 so
> this sort of problem could be in the NFS module (assuming your seeing
> this with autofs NFS auto mounts), the autofs module itself or
> somewhere in the VFS (most likely the path walking code). Since this
> automount support was added the path walking code been continuously
> changed, pretty much re-written, so there's a lot of ground to cover.
> 

Actually I think the merge was at 2.6.38 not 32.

Ian

