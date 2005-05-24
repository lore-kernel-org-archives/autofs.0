From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests
Date: Tue, 24 May 2005 07:59:06 +0200
Message-ID: <E1DaSRW-0003V9-00@dorka.pomaz.szeredi.hu>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
 <E1DaERw-0002cC-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.62.0505232339250.3469@donald.themaw.net>
 <E1DaG04-0002hk-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0505240846410.26293@wombat.indigo.net.au>
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261364AbVEXGjR@vger.kernel.org>
In-reply-to: <Pine.LNX.4.58.0505240846410.26293@wombat.indigo.net.au> (message
	from Ian Kent on Tue, 24 May 2005 09:06:07 +0800 (WST))
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, linux-kernel@vger.kernel.org

> > > Perhaps not in this case.
> > 
> > Maybe I'm misunderstanding.
> > 
> > Are you talking about an automounted filesystem, or the autofs
> > filesystem itself.
> 
> I'm talking about the autofs filesystem (actually the autofs4 module).

OK.

> > 
> > With the later I can well imagine that you have problems with bind and
> > move.
> 
> yep.
> 
> I'm not really concerned about whether bind and move mounts work or not. I 
> just need to establish whether these should be supported and if so, how 
> they should work so I can resolve the problem. Personally, I would be 
> happy to say these types of mounts are not supported by autofs if I could 
> veto the requests.

Does it work if somebody renames a directory in the path leading to
the autofs mountpoint?  The result is very similar to move mount.

You could solve both, by having the automoutnter daemon chdir to the
autofs root, and then it would just not care about any namespace
changes outside it's own filesystem.

Bind and clone(... CLONE_NEWNS) are trickier if you want to make
automounting work in the new instance.  It should be workable, if the
autofs kernel module returns a reference not just to the dentry but
the dentry/vfsmount pair to the daemon.  For example it could open a
file descriptor with dentry_open() refering to the mountpoint, and
pass that to userspace.  The daemon then can do the mount on in
(either by doing fchdir(fd) and 'mount blah .', or 'mount blah
/proc/PID/fd/FD').

This is all very theoretical, I don't know how the internals of
autofs...

On a related note, have you looked at using the kernel atumounter
support for autofs? (Documentation/filesystems/automount-support.txt)

Miklos
