From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Wed, 16 Mar 2016 10:10:29 +0800
Message-ID: <1458094229.2967.72.camel@themaw.net>
References: <1391145206.2486.25.camel@perseus.fritz.box>
		 <52EB7694.20707@molgen.mpg.de> <52EB7B07.2070707@molgen.mpg.de>
		 <530484B7.6030305@molgen.mpg.de>
		 <1392896501.2508.16.camel@perseus.fritz.box>
		 <1392898704.2508.26.camel@perseus.fritz.box>
		 <530625D0.7020808@molgen.mpg.de>
		 <1392946952.2495.3.camel@perseus.fritz.box>
		 <53076D91.7050703@molgen.mpg.de> <53107D4A.90904@molgen.mpg.de>
		 <20140228132906.GM15017@sh-el6.eng.rdu2.redhat.com>
		 <1393726942.9725.5.camel@perseus.fritz.box>
		 <1393744241.9725.16.camel@perseus.fritz.box>
		 <5313467C.9080102@molgen.mpg.de>
		 <1393814402.2787.19.camel@perseus.fritz.box>
	 <1393913207.2781.20.camel@perseus.fritz.box>
	 <56E0610F.9020704@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=8VeIX9Vq4Utlyk7qb1dw7f5VykQ=; b=gjmhSJ
	RHsAGE9XGtIsIZRDOy5DEfAes6kgVNwkxFl57LuGOhJ7Da/Amds1FOD61+8nxDXa
	vFGv+uEAMkZvfMtMJg1EsDrkaOF/J/s1mQkhN1qDjmCu5QvaKBds+6yFy5ZZu/3I
	U7yVsFAra9iyDWEulvAfLSvC1SZ23PTDuuyqA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=8VeIX9Vq4Utlyk7
	qb1dw7f5VykQ=; b=Q3T9YrfVRxRVLZb3rYVKT3YWrU8tL7wF0NgycP9A2GIVecX
	d2BX3K0Wp+tl6McsC0OxL7F66gWK11iXu7l8mH3GcspJq96f0m4H+kVZVGQiuMfJ
	QkjQJ06+Ki/SpNtlGmZpQMxAS8jqPZaNzbZ5GxPEgcoMDMd/l+fYsGOZWBqI=
In-Reply-To: <56E0610F.9020704@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Wed, 2016-03-09 at 18:44 +0100, Donald Buczek wrote:
> As a reminder, here is the script we used to demonstrate the problem (
> assuming /project/mariux32 is served by autofs) :
> 
> ===
> #! /bin/sh
> 
> ls -ld /project/mariux32/.
> unshare -m -- bash -c "sleep 6;ls -ld /project/mariux32/.;echo
> exit..." &
> kill -USR1  `cat /var/run/autofs-running`
> sleep 3
> ls -ld /project/mariux32/.
> wait
> ===
> 
> In your mail quoted below you wrote, the error would be avoided if "/"
> was set to shared before automount is started, but I can't confirm
> this.
> 
> ===
> root:nsa:/scratch/local/# systemctl stop automount.service
> root:nsa:/scratch/local/# mount --make-rshared /
> root:nsa:/scratch/local/# systemctl start automount.service
> root:nsa:/scratch/local/# ./test.sh
> drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
> ls: cannot access /project/mariux32/.: Too many levels of symbolic
> links
> drwxrwsr-x 6 mx32prj mx32grp 56 Feb 24  2011 /project/mariux32/.
> exit...
> root:nsa:/scratch/local/#
> ===

Actually, assuming /project is an indirect mount, I think that should
have been OK.

Again, there's more going on, probably unshare not cloning file handles
(the -m clones only the mount namespace I think). Without a way of
sending mount requests to the automount daemon, which needs to be done
via a file handle (the current pipe implementation or even if it was
socket based) the symptom will be the same as when / is propagation
private.

This is just a guess though.

> 
> Thank you!
> 
>    Donald
> 
> 
> On 03/04/14 07:06, Ian Kent wrote:
> > On Mon, 2014-03-03 at 10:40 +0800, Ian Kent wrote:
> > > > That doesn't solve the problem, however, that mounts cloned by a
> > > > unshare(CLONE_NEWNS) would never expire. Also there is another
> > > > bug
> > > > somewhere, because I see, that the mount, visible to the
> > > > /usr/lib/colord/colord process was logged as "unmounted" in the
> > > > nfs
> > > > server when it expired in the global namespace. So I doubt it
> > > > would be
> > > > working even for that process. So possibly automounted mounts
> > > > shouldn't
> > > > be cloned at all? Together with chroot or pivot_root the
> > > > sematics would
> > > > be more than unclear anyway. Your problem now :-)
> > > Hehe, like I said some people are going to be disappointed.
> > > 
> > > There's just one question about this that remains.
> > > 
> > > Assuming systemd is setting "/" shared what happens if "mount
> > > --make-rprivate /" is run before autofs is started?
> > > 
> > > So if you can spend a little more time on this an answer to this
> > > would
> > > be helpful.
> > No need for this, thanks to your reproducer.
> > 
> > In fact the problem doesn't appear happen if "/" is set shared so in
> > your case "/" must be set either slave or private.
> > 
> > And expanding the reproducer a bit I see another failure case too,
> > and
> > it doesn't appear to be the unreliable d_mountpoint() check, not
> > sure
> > yet exactly what it is.
> > 
> > Thanks
> > Ian
> > 
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
