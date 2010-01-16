From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
	block info
Date: Sat, 16 Jan 2010 10:17:14 +0000
Message-ID: <20100116101714.GN19799@ZenIV.linux.org.uk>
References: <20100115080323.GK19799@ZenIV.linux.org.uk> <1261611423-4396-1-git-send-email-vaurora@redhat.com> <1261611423-4396-2-git-send-email-vaurora@redhat.com> <20100102004423.GA2131@zeus.themaw.net> <20100114054322.GA16106@ZenIV.linux.org.uk> <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net> <4806.1263567323@redhat.com> <9927.1263575308@redhat.com> <20100115172633.GM19799@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100115172633.GM19799@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Ian Kent <raven@themaw.net>, Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, Trond.Myklebust@netapp.com

On Fri, Jan 15, 2010 at 05:26:33PM +0000, Al Viro wrote:

> Maybe, maybe not...  BTW, even that leaves an unpleasant race with
> mnt_make_readonly() (CIFS and NFS seem to be suffering from one).
> Which flags do we want to be inherited?  Grabbing MNT_WRITE_HOLD,
> for example, would obviously be a bad idea...

Oh, man...  After doing code review re locking rules for mnt_flags
and related stuff, a bunch of races had shown up.  I'll put fixes
into #for-linus tomorrow.

Shit galore:
	* may_umount() ought to take namespace_sem (shared).  Otherwise
we race with clone_mnt() doing add_list() to ->mnt_share/->mnt_slave.
	* attach_recursive_mnt() ought to take vfsmount_lock around
its loop that does set_mnt_shared(); otherwise mount --move can race
with e.g. mount -o remount.
	* do_remount() ought to take vfsmount_lock around the assigment
to mnt_flags *and* take care to leave MNT_SHARED and MNT_UNBINDABLE alone,
especially the former.
	* CIFS shouldn't step on mnt_flags
	* NFS, AFS and CIFS should *not* leave MNT_SHARED and MNT_WRITE_HOLD
in flags passed to do_add_mount(); alternatively, do_add_mount() might
trim those.
	* [unsolved, to be dealt along with per-superblock write counts]
do_remount() plays fast and loose with MNT_READONLY for !MS_BIND case.
	* [*really* unsolved] it remains to be seen whether we want to
propagate modifications of mount flags via shared subtree stuff.  For most
of those it's trivial (and arguably the right thing to do), but ro/rw is
really nasty.  Nick's mnt_want_write() implementation will need very careful
analysis.
	* [#for-next fodder] pnode.c:get_source() cleanup; right now it is
correct, but PITA to prove the correctness.  Incidentally, CL_PROPAGATION
is gone after that one.  Not #for-linus stuff, but I'll be really happier
with it for post-.33
	* [#for-next, but might go into #for-linus as well] explicit
documentation of invariants added to Documentation/filesystems/sharedsubtree.txt
Part of that can be deduced from what's already there, but I'd rather have
it explicit and one crucial bit is simply missing ("if mnt->mnt_master != NULL,
the entire mnt->mnt_share list consists of adjacent elements of mnt->mnt_slaves,
in the same order") and proving correctness without it is Not Fun(tm).  Hell,
I've spent an hour figuring out whether it's broken or not and I'd been
through all that code back when it had been written.  In details.

I'll give that another look after I get some sleep, then to public tree it
goes...
