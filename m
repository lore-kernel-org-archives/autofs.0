From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Thu, 08 Jan 2004 09:34:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3FFD9498.6030905@zytor.com>
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Ian Kent wrote:
> 
> If wildcard map entries are not in autofs v3 then Jeremy implemented this
> in v4.
> 

v3 has had wildcard map entries and substitutions for a very, very, very 
long time... it was a v2 feature, in fact.

> And yes the host map is basically a program map and that's all. Worse, as
> pointed out in the paper it mounts everything under it. This is a source
> of stress for mount and umount. I have put in a fair bit of time on ugly
> hacks to work around this. This same problem is also evident in startup
> and shutdown for master maps with a good number of entries (~50 or more).
> A consequence of the current multiple daemon approach.

This is why one wants to implement a mount tree with "direct mount 
pads"; which also means keeping some state in the daemon.

For example, let's say one has a mount tree like:

/foo		server1:/export/foo \
/foo/bar	server1:/export/bar \
/bar		server2:/export/bar

... then you actually have four diffenent filesystems involved: first, 
some kind of "scaffolding" (this can be part of the autofs filesystem 
itself or a ramfs) that hold the "foo" and "bar" directories, and then 
foo, foo/bar, and bar.

Consider the following implementation: when one encounters the above, 
the daemon stashes this away as an already-encountered map entry (in 
case the map entries change, we don't want to be inconsistent), creates 
a ramfs for the scaffolding, creates the "foo" and "bar" subdirectories 
and mount-traps "foo" and "bar".  Then it releases userspace.  When it 
encounters an access on "foo", it gets invoked again, looks it up in its 
"partial mounts" state, then mounts "foo" and mount-traps "foo/bar", 
then releases userspace.

In many ways this returns to the simplicity of the autofs v3 design 
where the atomicity constraints where guaranteed by the VFS itself, *as 
long as* mount traps can be atomically destroyed with umounting the 
underlying filesystem.

	-hpa
