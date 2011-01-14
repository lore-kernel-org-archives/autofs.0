From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 19/18] Unexport do_add_mount() and add in
 follow_automount(), not ->d_automount()
Date: Fri, 14 Jan 2011 18:06:25 +0000
Message-ID: <20110114180625.GI19804@ZenIV.linux.org.uk>
References: <20110114154652.GD19804@ZenIV.linux.org.uk>
 <20110114070224.GB19804@ZenIV.linux.org.uk>
 <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
 <2443.1295005428@redhat.com>
 <6672.1295025969@redhat.com>
 <20110114174340.GG19804@ZenIV.linux.org.uk>
 <20110114175648.GH19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110114175648.GH19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jan 14, 2011 at 05:56:48PM +0000, Al Viro wrote:
> 	BTW, speaking of mntput_long(): I really hate that API.  It's
> asking for subtle leaks - use mntget_long() in pair with mntput() and
> you are fucked.  Worse, these suckers are created with long reference
> now, so any code that used to use mntput() to kill a cloned/freshly
> created vfsmount got silently b0rken.  A quick look already caught
> one such case - fs/nfsctl.c do_open() uses mntput() in pair with
> do_kern_mount(), which leads to longrefs left at 1.
> 
> 	Rationale for that mess, please...

FWIW, what I intend to do is to keep these longrefs _only_ for
cwd/root/attached or possibly hashed and set them alongside the
normal ref.  I.e. require the callers of mntput_long() (not exported,
local to core VFS) to keep the normal reference.

That way it would turn into hint for mntput() - "we have persistent
refs, just decrement count on this CPU and piss off", with mntput_long()
never going into the whole "and now we are dropping the last ref" part.

AFAICS, it keeps your write-free objectives and gets much saner API.
Shout if you have problems with that...
