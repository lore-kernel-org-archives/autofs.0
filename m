From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 19/18] Unexport do_add_mount() and add in
 follow_automount(), not ->d_automount()
Date: Sat, 15 Jan 2011 13:30:30 +0000
Message-ID: <20110115133029.GN19804@ZenIV.linux.org.uk>
References: <20110114154652.GD19804@ZenIV.linux.org.uk>
 <20110114070224.GB19804@ZenIV.linux.org.uk>
 <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
 <2443.1295005428@redhat.com>
 <6672.1295025969@redhat.com>
 <20110114174340.GG19804@ZenIV.linux.org.uk>
 <20110114175648.GH19804@ZenIV.linux.org.uk>
 <20110114180625.GI19804@ZenIV.linux.org.uk>
 <AANLkTimMVF7HSOqJGWphY2fbaXDbegppe+Vug8e5V1HN@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimMVF7HSOqJGWphY2fbaXDbegppe+Vug8e5V1HN@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>


> > AFAICS, it keeps your write-free objectives and gets much saner API.
> > Shout if you have problems with that...
> 
> No that sounds good, I don't have a problem with it, although I don't
> exactly understand what you're getting at in the second paragraph.

OK, I have a hopefully sane implementation in tip of #untested.

There's a fun problem with what you do in do_lookup(), BTW.  Look:
we enter do_lookup() with LOOKUP_RCU.  We find dentry in dcache,
everything's beautiful.  The sucker has ->d_revalidate().  We go
to need_revalidate.  There we call do_revalidate().  It calls
d_revalidate(), which calls ->d_revalidate() and instead of spitting
into your eye and returning -ECHILD it happily returns 1.  So
do d_revalidate() and then do_revalidate(), without any further
actions.  do_revalidate() has returned our dentry, which is neither
NULL nor ERR_PTR(), so back in do_lookup() we go to done.

There we set path->mnt and path->dentry and call __follow_mount().
And damn, it *is* a mountpoint.  So we
	* do dput() on dentry we'd never grabbed a reference to
	* grab a reference to a different dentry (and remain in happy
belief that we are in LOOKUP_RCU mode, and thus don't need to drop it)
	* grab a reference to vfsmount (via lookup_mnt()).  Ditto (and
I haven't checked if grabbing vfsmount_lock twice shared isn't a recipe
for a deadlocky race with something grabbing it exclusive between these
nested shared grabs).
	* if we are really unlucky and that mountpoint is, in turn,
overmounted, we'll hit mntput().  While under vfsmount_lock.

AFAICS, it's badly b0rken.  And autofs really steps into that mess.

As minimum, we'd need to split need_revalidate: and done: in RCU and non-RCU
variants.  I'm about to fall down right now after an all-nighter (and then
some); if you put something together before I get up, please throw it
my way.

Note that the problem exists both in mainline and in mainline+automount
patches; in the latter it's a bit nastier, but in principle the situation
is the same, so I'd rather see a fix for that in front of automount queue.
