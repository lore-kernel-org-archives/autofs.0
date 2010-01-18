From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in
	super	block info
Date: Mon, 18 Jan 2010 10:27:32 +0000
Message-ID: <20100118102732.GU19799@ZenIV.linux.org.uk>
References: <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net>
	<4806.1263567323@redhat.com> <9927.1263575308@redhat.com>
	<20100115172633.GM19799@ZenIV.linux.org.uk>
	<20100116101714.GN19799@ZenIV.linux.org.uk>
	<20100117175723.GP19799@ZenIV.linux.org.uk>
	<4B53E1B5.2080202@themaw.net>
	<20100118055929.GS19799@ZenIV.linux.org.uk>
	<4B542692.2070307@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B542692.2070307@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, David Howells <dhowells@redhat.com>, Trond.Myklebust@netapp.com, sfrench@samba.org, Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>

On Mon, Jan 18, 2010 at 05:14:58PM +0800, Ian Kent wrote:

> The possibility of more than one vfsmount being present is, as you say
> possible, but it is not legal for autofs (and last time I checked I
> concluded it wasn't possible for me to veto bind mount requests). Other
> than bind mounts I'm struggling to think of a case where I would have
> more than one autofs fs mount with the same s_dev.

That's interesting...  Other place where we go through the stack of mounts
is where we look for one with given bits in type; do we have a possibility
of multiple candidates there and which one do we really want?  Same function,
case when we have ioctlfd == -1, !autofs_type_any(type).  Current code
(as well as original) goes for one closest to root; it would certainly be
simpler to go for one on top of stack...

> Yes, the dentry should always be positive here but let me think about it
> a little more in case I'm missing something. And yes, using the vfsmount
> super block pointer would be better. I'll fix these too.

FWIW, I'd rather have that stuff in vfs tree; that's not the only patch
eliminating mnt_mountpoint use.  AFAICT, none of the uses outside of
core VFS code are legitimate (and BTW, NFSv4 one is contrary to RFC - it
should do follow_down() in loop before reporting mount_fileid instead of
just picking the immediate ancestor for one thing and I'm not at all sure
that check around that thing is correct; it ignores export path.dentry
and looks at path.mnt.root instead, which seems to be wrong).  Other places
would be just as happy with mnt/mnt->mnt_root instead of mnt->mnt_parent/
mnt->mnt_mountpoint or, worse, mnt/mnt->mnt_mountpoint.  Pohmelfs is even
nastier, with its d_path() abuses, but that's a separate story.

IMO we ought to get rid of mnt_mountpoint/mnt_parent uses outside of core
VFS and I'd rather do that in one patch queue.

Back to another question: which syscalls should and which syscalls should not 
trigger automount on the last component?  Note that it's something we'd better
be consistent about between autofs4 and cifs/afs/nfs...
