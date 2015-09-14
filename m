From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 17:45:45 +0800
Message-ID: <1442223945.3030.64.camel@themaw.net>
References: <55F58085.4090509@excellency.fr>
	 <1442197882.3030.33.camel@themaw.net> <55F68878.40803@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Wg3EKeEiSxFjgnNh4CGA9/rhvVE=; b=R/HUI7
	Pt3qH2Vh6yxGe9ubs0vhHwFNIrwDk4g3dGDG8+45D/KMTPbiCU4PoqX3J2VhdGNG
	9HpnoHMfdo+ocrU1wf4L8AbLZ8qy5GtfZCojlUkzFeZrsFjOAOTPds7cplDJIYyp
	34tTkdtozBo6sUpEh8Y/CG4hdDkyyNSYgEi2s=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Wg3EKeEiSxFjgnN
	h4CGA9/rhvVE=; b=cfYE3KVRa141WLuJ99qqL5c0+vW4gBBpKYfOdzejXglbcaL
	KP9T+Hbzur1/FS6toF3IRgM2nX05IS2OFxQSqaRnMfCJugCxkY9Wmsv3RE3qVz8g
	qCJiCMHTmMiNQXkBA7u79ENA49osX62i112Vr5iHLke9RazjCT2tLsJ4b6+o=
In-Reply-To: <55F68878.40803@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: cbay@excellency.fr
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Mon, 2015-09-14 at 10:42 +0200, Cyril B. wrote:
> Ian Kent wrote:
> > On Sun, 2015-09-13 at 15:56 +0200, Cyril B. wrote:
> >> It looks like the mount point of the maps have fixed permissions, 755. I
> >> need to have different permissions: in my use case, I want /home (which
> >> is handled by autofs) to be set to 751.
> >
> > Why is this needed?
> 
> Why do I want to set /home to 751? When it was set to 755, I frequently 
> had users believing there was a serious vulnerability because they could 
> list /home. Stupid, I know, but setting the permissions to 751 was a 
> trivial solution for this.
> 
> >> The initial permissions of /home are overwritten when autofs is started,
> >> so changing those doesn't help.
> >
> > They aren't overwritten.
> > The permissions are those of the autofs mount that is mounted
> > over /home.
> 
> I'm not sure I'm following you. Here's my auto.master:
> 
> /home program:/etc/auto.home

Which means there will be an autofs pseudo file system mounted on /home
when automount(8) starts.

This is how the kernel intercepts accesses to these and calls back to
the automount(8) daemon to request it perform mounts.

> 
> Before launching autofs, permissions are set to 751:
> 
> # ls -ald /home
> drwxr-x--x 2 root root 4096 Aug  7 11:09 /home
> 
> Once I've launched autofs, permissions are reset to 755:

The permissions are those of the root of the autofs pseudo file system,
the permissions of the underlying mount point aren't changed.

> 
> # ls -ald /home
> drwxr-xr-x 2 root root 0 Sep 14 10:32 /home
> 
> And when I quit autofs, my permissions are back to 751:

Because the autofs pseudo file system is then umounted and the
underlying directory is again visible.

> 
> # ls -ald /home
> drwxr-x--x 2 root root 4096 Aug  7 11:09 /home
> 
> What I want is to always have /home permissions set to 751.

I still don't understand how that's an effective security measure.

Anyone determined enough will be able to find out the directory names
and can then change to them, assuming the permissions of the mounts
themselves allow it.

No-one can do anything much in the autofs pseudo file system except the
daemon itself, and usually the request is that the mount points within
an autofs mount be seen, aka. the browse option, not hidden, ;)

So are you saying you don't have sufficient faith in the permissions set
on the file systems your mounting, that contain the information you want
to protect, that you must have the permissions of an intermediate file
system set to ensure that information about that vulnerability is not
seen?

Can't say I can see how this has any actual benefit at all.

Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
