From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
 block info
Date: Tue, 19 Jan 2010 15:05:29 +0800
Message-ID: <4B5559B9.2050500@themaw.net>
References: <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net> <4806.1263567323@redhat.com> <9927.1263575308@redhat.com> <20100115172633.GM19799@ZenIV.linux.org.uk> <20100116101714.GN19799@ZenIV.linux.org.uk> <20100117175723.GP19799@ZenIV.linux.org.uk> <4B53E1B5.2080202@themaw.net> <20100118055929.GS19799@ZenIV.linux.org.uk> <4B542692.2070307@themaw.net> <20100118102732.GU19799@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20100118102732.GU19799@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, Trond.Myklebust@netapp.com, David Howells <dhowells@redhat.com>

On 01/18/2010 06:27 PM, Al Viro wrote:
> On Mon, Jan 18, 2010 at 05:14:58PM +0800, Ian Kent wrote:
> 
>> The possibility of more than one vfsmount being present is, as you say
>> possible, but it is not legal for autofs (and last time I checked I
>> concluded it wasn't possible for me to veto bind mount requests). Other
>> than bind mounts I'm struggling to think of a case where I would have
>> more than one autofs fs mount with the same s_dev.
> 
> That's interesting...  Other place where we go through the stack of mounts
> is where we look for one with given bits in type; do we have a possibility
> of multiple candidates there and which one do we really want?  Same function,
> case when we have ioctlfd == -1, !autofs_type_any(type).  Current code
> (as well as original) goes for one closest to root; it would certainly be
> simpler to go for one on top of stack...

We shouldn't have multiple candidates for the same reason autofs can't
support bind mounts. The mounts in an autofs tree of mounts are tied to
a map of mounts in user space which means they are tied to a specific
path. And, we won't (or at least shouldn't unless user space uses the
facility incorrectly) have multiple mounts of the same autofs type on
the stack due to the way autofs must use these mounts.

As far as going from the top of the stack goes I don't think it makes
any real difference since the stack is small (2 or possibly 3). The
find_autofs_mount() function does go from the (terminology?) bottom of
the mount stack using follow_up() whereas the original code went from
the top using the path_lookup() to get the parent and then
follow_down(). So there is additional following with the current code
since kern_path() will go down to the bottom of the stack and then we
proceed to go back up in find_autofs_mount().

> 
>> Yes, the dentry should always be positive here but let me think about it
>> a little more in case I'm missing something. And yes, using the vfsmount
>> super block pointer would be better. I'll fix these too.
> 
> FWIW, I'd rather have that stuff in vfs tree; that's not the only patch
> eliminating mnt_mountpoint use.  AFAICT, none of the uses outside of
> core VFS code are legitimate (and BTW, NFSv4 one is contrary to RFC - it
> should do follow_down() in loop before reporting mount_fileid instead of
> just picking the immediate ancestor for one thing and I'm not at all sure
> that check around that thing is correct; it ignores export path.dentry
> and looks at path.mnt.root instead, which seems to be wrong).  Other places
> would be just as happy with mnt/mnt->mnt_root instead of mnt->mnt_parent/
> mnt->mnt_mountpoint or, worse, mnt/mnt->mnt_mountpoint.  Pohmelfs is even
> nastier, with its d_path() abuses, but that's a separate story.
> 
> IMO we ought to get rid of mnt_mountpoint/mnt_parent uses outside of core
> VFS and I'd rather do that in one patch queue.
> 
> Back to another question: which syscalls should and which syscalls should not 
> trigger automount on the last component?  Note that it's something we'd better
> be consistent about between autofs4 and cifs/afs/nfs...

That's actually a difficult question.

stat(2) is the most problematic call for much the same reasons as
described by Trond.

A (hopefully fairly simple) description of a couple of specific cases
will be useful to clarify the situation.

First, terminology, an "indirect autofs mount" is an autofs fs mount
that implements single path components as mount points within the autofs
fs directory. There are two cases, indirect mounts that are "nobrose"
and ones that "browse"able. The later is just an autofs indirect mount
with pre-created mount point directories so they can be seen by listing
the directory whereas a nobrowse mount corresponds to an autofs mount we
have seen historically where a directory listing of an autofs mount with
no current active automounted mounts returns nothing.

There is no problem with stat(2) for nobrowse autofs indirect mounts
because directories that can potentially trigger mounts simply don't
exist and the user space tools tend to behave as people expect.

But, for browse autofs indirect mounts we get into trouble. For example
a long or colour ls will stat(2) each directory to get needed
information causing all the potential mounts to be mounted. Which is an
pbvious problem for autofs maps that have more than a few entries and a
disaster for anything with more than a hundred or so entries.

Currently stat(2) is honoured for the nobrowse case (the case were we
are creating a dentry) and not for the browse case, unless of course the
mount has already been triggered. This gives rise to the stat() ->
chdir() (or other mount triggering call) -> stat() inconsistency we see
in user space utilities. In Solaris browse is the default for indirect
mounts and we see the same lies in directory listings as mounts aren't
triggered in that case either.

statfs(2) is an interesting case for autofs direct mounts.

More terminology, a "direct autofs mount" is an autofs mount that
implements a mount trigger for a given path. An autofs direct map
consists of entries with a full and a target mount and so each map entry
is a distinct mount within the host file system (mmm ... sounds a bit
like the description in the Solaris man page). When a direct mount is
crossed the corresponding mount is triggered and is mounted on top of
the autofs direct mount point.

We probably should honour statfs(2) calls but without also necessarily
honouring stat(2) calls. Currently the statfs(2) calls get caught by the
exclusion above for stat(2) calls but we don't see many complaints
because we don't list autofs mounts in /etc/mtab, where the user space
utilities usually look for their information. Once again, this approach
is similar to what we see in Solaris. In Solaris /etc/mnttab is similar
to our /proc/mounts but there is a pseudo option ("hide" or something
similar, I can't remember now) used to prevent user space utilities from
considering entries that shouldn't be reported.

So the stat(2) call is the big problem while other related system calls
(in that they use very similar lookup flags), like statfs(2) have the
opposite problem.

This probably isn't really what you wanted to hear but I've tried to
give a decent warts and all description of the difficulty.

Ian
