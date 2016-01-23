From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: show pipe inode in mount options
Date: Sat, 23 Jan 2016 08:30:17 +0800
Message-ID: <1453509017.3042.7.camel@themaw.net>
References: <20151216120222.19097.54512.stgit@localhost.localdomain>
	 <568E8840.3010801@odin.com> <1452237640.2973.19.camel@themaw.net>
	 <568F9D85.6070601@odin.com> <1452257913.7030.25.camel@themaw.net>
	 <568FD028.5090207@odin.com> <1452303110.3067.29.camel@themaw.net>
	 <5693931F.9070101@odin.com> <56A213CA.5090704@odin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=t6z2KVHEfhDFiC/0cwCilYEKr0o=; b=FL5JQW
	AiX0ei/4rbschuBNqTQfmPcX0usdf5vv8N12MMLDga6lz93axuBgfwB/UO1DdzoY
	v0aBLq0Rw835VuN1A8Ht6Ulsl0aF424ZuSYOuYmrj4IjlOq7TQYTpPfVL8u/TpDi
	iM1RsQ9h7H/HMLAgOfwqF5MKwIf7FzMA594pw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=t6z2KVHEfhDFiC/
	0cwCilYEKr0o=; b=hJos5NMDeg2UznzvBzLJkvLvlOWxtjt7wbjdipy6hLC8R1/
	TIrKZwe1YzN1UN9zoK8ka5/4CYpYcne5R/Ij63jPOdofwhsKt4yHHajLGUa9Maj1
	Ip2vYREo0LiwFxkQRr7P1DmWRz07jRhyJDnW9cjpxge7P0JWx9mDXMW5hGhg=
In-Reply-To: <56A213CA.5090704@odin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: skinsbursky@virtuozzo.com
Cc: criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>

On Fri, 2016-01-22 at 12:34 +0100, Stanislav Kinsburskiy wrote:
> Hi again,
> 
> I would like to ask about any progress with this patch?
> Any other requirements to make it able to merge?

Sorry for the delay.

Since there haven't been any comments from Al or Stephen I'm think I
should include it in the series I plan on sending to linux-next to
rename autofs4 to autofs (among other things).

I haven't had anything significant enough for autofs to warrant
maintaining a tree and sending push requests so I'll need to ask
Stephen what I need to do (perhaps you could offer some advise on that
now Stephen, please).

I'm also struggling to get back to this and carry out the needed
testing and I'll need to re-base the series too now but I'm getting
there.

I didn't see a follow up patch with an updated description, did I miss
it?

Ian
