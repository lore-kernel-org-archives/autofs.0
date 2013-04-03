From: Ian Kent <raven@themaw.net>
Subject: Re: Mounts not expiring in setups with nested submounts
Date: Wed, 03 Apr 2013 14:41:29 +0800
Message-ID: <1364971289.2399.7.camel@perseus.fritz.box>
References: <CAEySpB6ZRVmtbFmPuL-k1fVxeHdtnKm8ncmXGt5R0ZTL2dXr1w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=4fRgAMuOri+JVIR6dnSmImUvRbI=; b=xoCeZPIqOD35YFsNECwB9zZ1GyOe
	+pDtzCUq0rZ5EkwmYGvMlQyC0wprzX1yiz9qLwA7vehGS+rE0ni2l665xEal8Nim
	Nr8dxfNQDDYbn0R+aZ5U6lqJNCoQS3Ja+lNI+snH3eJD8CS509wdrHYLXrKdxFrQ
	6kRsbiywQH6m81A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=4fRgAMuOri+JVIR6dnSmIm
	UvRbI=; b=bMRRn4XGhCxNTToi5s7ZXGXIQkLAoXA7T9eodRo2/1x1HsuN7nMxDz
	zKazva+5ewSAg9dFbTzfb/XZyFSZ5MzjI4J59BETb6PjvMYj8tkkWD3Of7YRNXNZ
	h/NAI7d9rFRkDp8z0Ehwemjz2Cemm/QZlPE42iM1A2iJRlx4KAx84=
In-Reply-To: <CAEySpB6ZRVmtbFmPuL-k1fVxeHdtnKm8ncmXGt5R0ZTL2dXr1w@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs <autofs@vger.kernel.org>

On Fri, 2013-03-29 at 17:33 -0300, Leonardo Chiquitto wrote:
> Hi,
> 
> In some configurations that use nested submounts, a busy volume
> can prevent AutoFS from expiring other mounts. This was reported
> by a customer and I'm able to reproduce it with a "minimal" config:
> 
> In your NFS server, export the following structure of directories:
> /nfs/vol/a/mount1
> /nfs/vol/a/mount100
> /nfs/vol/b/mount1
> /nfs/vol/b/mount100
> /nfs/vol/b/mount200
> 
> AutoFS configuration:
> BROWSE_MODE="yes"
> TIMEOUT=60
> 
> auto.master:
> /vol /etc/auto.vol
> --
> auto.vol:
> a -fstype=autofs file:/etc/auto.vol.a
> b -fstype=autofs file:/etc/auto.vol.b
> --
> auto.vol.a:
> disk1 -fstype=autofs file:/etc/auto.vol.a.disk1
> mount1 server:/nfs/vol/a/mount1
> --
> auto.vol.b:
> disk1 -fstype=autofs file:/etc/auto.vol.b.disk1
> disk2 -fstype=autofs file:/etc/auto.vol.b.disk2
> mount1 server:/nfs/vol/b/mount1
> --
> auto.vol.a.disk1:
> mount100 server:/nfs/vol/a/mount100
> --
> auto.vol.b.disk1:
> mount100 server:/nfs/vol/b/mount100
> --
> auto.vol.b.disk2:
> mount200 server:/nfs/vol/b/mount200
> --
> 
> Steps to reproduce the problem:
> 
> 1. Trigger mount of /vol/b/disk2/mount200 first and keep it busy
> 2. Mount all the other exported volumes
> 
> mount(8) output must be something like this (I think the order matters):
> server:/nfs/vol/b/mount200 on /vol/b/disk2/mount200 type nfs
> (rw,addr=10.121.8.27)
> server:/nfs/vol/b/mount1 on /vol/b/mount1 type nfs (rw,addr=10.121.8.27)
> server:/nfs/vol/b/mount100 on /vol/b/disk1/mount100 type nfs
> (rw,addr=10.121.8.27)
> server:/nfs/vol/a/mount1 on /vol/a/mount1 type nfs (rw,addr=10.121.8.27)
> server:/nfs/vol/a/mount100 on /vol/a/disk1/mount100 type nfs
> (rw,addr=10.121.8.27)
> 
> After the timeout, /vol/b/disk1/mount100 will be correctly unmounted,
> but the other mounts will never expire (not even with SIGUSR1).
> In this example only 4 mounts are blocked, but in some occasions
> we've seen dozens of non-expiring mounts because of this bug.
> 
> I debugged the problem and discovered that it happens because
> the recursion implemented in master_notify_submount() stops
> on purpose after the first level of nested submounts. This was
> implemented in autofs-5.0.4-expire-specific-submount-only.patch.
> 
> The patch below fixes the problem, but re-introduces recursion to
> deeper levels. Tests didn't reveal any regression so far.
> 
> Ian: do you think the "occasional deadlocks" mentioned in the
> expire-specific-submount-only patch might have been addressed
> by other changes (so we can use the patch below)? Or do you
> see another way to fix the problem?

Not sure, probably not, but master_notify_submount() should be called
for each submount from expire_proc_(indirect|direct)(). The recursive
step shouldn't actually be done in master_notify_submounts().

I don't see why that isn't being done.
I'll need to spend some time on it when I get a chance.

