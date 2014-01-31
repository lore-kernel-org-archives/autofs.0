From: Ian Kent <raven@themaw.net>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Fri, 31 Jan 2014 13:13:26 +0800
Message-ID: <1391145206.2486.25.camel@perseus.fritz.box>
References: <52E92627.9050801@molgen.mpg.de>
	 <1391139080.2486.19.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=4pyL+zh2CfU2GnjI8L65mFFx5GE=; b=l13o1Gcy7ewCDU3gPGDFX3e4FL3a
	m52lP7Bdr9NhUFseyTSpHXOjc6w3+7ZbbCMi4Cn7CMJ/memZzQtf7eebCeKXdCn3
	+hq0p0ZKTCEa6bXUKBF5ZNQSwQxqQRUyrrNsn5QZxbNDea5DYOwMth1Joym2Hf/R
	3XWZlm6mFfTWN54=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=4pyL+zh2CfU2GnjI8L65mF
	Fx5GE=; b=TX+WGa6kF2N9Kg5CxwfwlL408iWnZpTZ2mXlQjs+6nejHo8TRT7pWy
	DV7uHxxoyyNLqJgdanAiSHq648YGSDYuo0spXmmi0nMMCoGZLq00jZ4Jm27nRZSc
	BsuOVE1LJt1eyQijmAQTf3rnFsgS15j6qq/Tv6sdnxlESBBmnbwLI=
In-Reply-To: <1391139080.2486.19.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Fri, 2014-01-31 at 11:31 +0800, Ian Kent wrote:
> On Wed, 2014-01-29 at 17:02 +0100, Donald Buczek wrote:
> > Hello,
> > 
> > we are trying to switch from amd to autofs. After successfully testing 
> > and rolling it out to the first several machines, from time to time we 
> > get directories stuck with "Too many levels of symbolic links" on a path 
> > which should be automounted via an indirect map.
> > 
> > linux 3.8.13
> > autofs 5.0.8
> > 
> > As an example, here is data from a system where the path /scratch/tmp is 
> > stuck:
> > 
> > http://www.molgen.mpg.de/~buczek/autofs-demo/
> > 
> >    auto.master    # master map
> >    auto.scratch    # indirect map for /scratch
> >    autofs            # from /etc/defaults
> >    typescript       # shows the problem and a bit of gdb dump of kernel 
> > structures
> >    typescript.l     # same with line numbers for reference
> >    gdb-macros     # macros used in the gdb session
> > 
> >  From typescript.l , line 122ff it is clear, that /scratch/tmp is not 
> > currently mounted. On the other hand, the gdb session finds the dentry 
> > of /scratch/tmp which has d_flags 0x70080 (line 99,120). This is 
> > DCACHE_MANAGE_TRANSIT+DCACHE_NEED_AUTOMOUNT+DCACHE_MOUNTED+DCACHE_RCUACCESS 
> > with DCACHE_MOUNTED indicating that there should be something mounted 
> > there(?). I think, this state is faulty and necessarily leads to ELOOP 
> > during path walk. Probably the situation is known by the gurus here?
> 
> Yes, I can see how DCACHE_MOUNTED being set would lead to ELOOP in this
> case. But, having been there before too, I couldn't see any way the
> DCACHE_MOUNTED would not be cleared on umount. Also, DCACHE_MOUNTED is
> only changed within the VFS and isn't changed very often. It can't see
> how a code path that should lead to one of those changes doesn't go
> there.
> 
> I'll have another look .....

Then the question becomes ....

Can a dentry be a mount point for more than one mount ....
Obviously not you say ... but what about clone(2) with CLONE_NEWNS?

If you still have that kernel you used to get the info above could you
check the mount (ie. struct mount not struct vfsmount) structures to see
if there is one with its mnt_mountpoint set to the dentry in question?

Ian


