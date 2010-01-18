From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
 block info
Date: Mon, 18 Jan 2010 17:14:58 +0800
Message-ID: <4B542692.2070307@themaw.net>
References: <20100102004423.GA2131@zeus.themaw.net> <20100114054322.GA16106@ZenIV.linux.org.uk> <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net> <4806.1263567323@redhat.com> <9927.1263575308@redhat.com> <20100115172633.GM19799@ZenIV.linux.org.uk> <20100116101714.GN19799@ZenIV.linux.org.uk> <20100117175723.GP19799@ZenIV.linux.org.uk> <4B53E1B5.2080202@themaw.net> <20100118055929.GS19799@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20100118055929.GS19799@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, Trond.Myklebust@netapp.com, David Howells <dhowells@redhat.com>

On 01/18/2010 01:59 PM, Al Viro wrote:
> On Mon, Jan 18, 2010 at 12:21:09PM +0800, Ian Kent wrote:
> 
>> In that case we may find an autofs mount that has something mounted on
>> top of it and user space wants to know the super of the covering mount.
>>
>> If there is something mounted on top of it user space needs to know if
>> it is another autofs file system or some other type of file system. So
>> if the nameidata path, located by autofs_dev_ioctl_find_super(), is not
>> the top (or bottom, depending on the terminology you prefer) then we
>> need to follow the mount and return the magic of the thing mounted on
>> top of it.
> 
> IDGI.  What you are doing there is
>                 if (path.mnt->mnt_mountpoint != path.mnt->mnt_root) {
>                         if (follow_down(&path))
>                                 magic = path.mnt->mnt_sb->s_magic;
>                 }
> and I don't think it means what you think it means.  Just what is that
> mnt_mountpoint check about?  Before that point we'd found the autofs
> vfsmount M that
> 	1) M is mounted on <name>
> 	2) M->mnt_sb has the right s_dev
> 	3) M is the closest one to root in mount tree out of vfsmounts
> satisfying (1) and (2)
> Now we check that
> 	4) the mountpoint M is attached to has dentry different from
> M->mnt_root.  That's an interesting thing to check, seeing that the
> only way to get it false is to have mount --bind name name, with name
> not being the mountpoint before that.  And M being the result of
> that mount --bind.
> 	5) something is mounted on top of root of M.
> 
> Then we proceed to return the s_magic of that something.  For one thing,
> if there *are* several vfsmounts satisfying (1,2), which one do we really
> want?  For another, what's the intent of (4)?  It looks very odd; what's
> really being checked there?

The code here has changed a little from what I originally posted but,
assuming for now the functionality is equivalent, I can't see what the
point of that check is and now I can't remember if there was some odd
special case. follow_mount() should be sufficient. I'll fix this.

The possibility of more than one vfsmount being present is, as you say
possible, but it is not legal for autofs (and last time I checked I
concluded it wasn't possible for me to veto bind mount requests). Other
than bind mounts I'm struggling to think of a case where I would have
more than one autofs fs mount with the same s_dev.

> 
> In another branch we have
>                 if (path.dentry->d_inode &&
>                     path.mnt->mnt_root == path.dentry) {
>                         err = 1;
>                         magic = path.dentry->d_inode->i_sb->s_magic;
>                 }
> and AFAICT, path.dentry->d_inode == NULL is impossible there.  Besides,
> path.mnt->mnt_sb->s_magic would be simpler anyway (and evaluate to
> the same thing).

Yes, the dentry should always be positive here but let me think about it
a little more in case I'm missing something. And yes, using the vfsmount
super block pointer would be better. I'll fix these too.

Ian
