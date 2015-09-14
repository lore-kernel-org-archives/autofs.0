From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 10:31:22 +0800
Message-ID: <1442197882.3030.33.camel@themaw.net>
References: <55F58085.4090509@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=o+vwK2XYP/u15ga3jruZXlsEC7w=; b=dQqXuU
	gaxIwhmeimjC3bxV9hQywduCnsb+KKtZHvU+cG4Y2E6s2zb4hOB7oiERo9sYEKc4
	iJikkEc4n1+xuMJLTYTCulBh3mnf5b4fF6BQD2/DKNP7tMvcH/EnOMjRkZhkZb4p
	qvRNJvneu3799IN1s2x25Dxp0NbSnoj24ZRZM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=o+vwK2XYP/u15ga
	3jruZXlsEC7w=; b=S09LXAxaN9NEOi2CVPMaoK+Uq2qcTpuoTTfHCdAm3hYdGa1
	IoD3VMTdDQFtjUoSfG21K6KUN1EdqjavX9U6UO1xRWmOvkbD0EuMeUF4paOOLV0T
	6MhRDuB2gtaueDzZ5g8lkxenTtFKj9G7b4tilZ+fjsIDJSzRqRXxs0Mo6yd4=
In-Reply-To: <55F58085.4090509@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Sun, 2015-09-13 at 15:56 +0200, Cyril B. wrote:
> Hello,
> 
> It looks like the mount point of the maps have fixed permissions, 755. I 
> need to have different permissions: in my use case, I want /home (which 
> is handled by autofs) to be set to 751.

Why is this needed?

> 
> The initial permissions of /home are overwritten when autofs is started, 
> so changing those doesn't help.

They aren't overwritten.
The permissions are those of the autofs mount that is mounted
over /home.

> 
> I can change the permissions of /home after autofs has started, but it's 
> really not convenient: there's no easy way to do that automatically with 
> either sysvinit or systemd.

I still don't understand why this is needed.

For indirect mounts no-one can copy things into the autofs mount and the
permissions of mounts on mount points will be the same as those of the
mounted file system when they are done.

Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
