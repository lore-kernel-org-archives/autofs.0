From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
 block info
Date: Mon, 18 Jan 2010 12:21:09 +0800
Message-ID: <4B53E1B5.2080202@themaw.net>
References: <1261611423-4396-1-git-send-email-vaurora@redhat.com> <1261611423-4396-2-git-send-email-vaurora@redhat.com> <20100102004423.GA2131@zeus.themaw.net> <20100114054322.GA16106@ZenIV.linux.org.uk> <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net> <4806.1263567323@redhat.com> <9927.1263575308@redhat.com> <20100115172633.GM19799@ZenIV.linux.org.uk> <20100116101714.GN19799@ZenIV.linux.org.uk> <20100117175723.GP19799@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20100117175723.GP19799@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, Trond.Myklebust@netapp.com, David Howells <dhowells@redhat.com>

On 01/18/2010 01:57 AM, Al Viro wrote:
> On Sat, Jan 16, 2010 at 10:17:14AM +0000, Al Viro wrote:
>> 	* [unsolved, to be dealt along with per-superblock write counts]
>> do_remount() plays fast and loose with MNT_READONLY for !MS_BIND case.
>> 	* [*really* unsolved] it remains to be seen whether we want to
>> propagate modifications of mount flags via shared subtree stuff.  For most
>> of those it's trivial (and arguably the right thing to do), but ro/rw is
>> really nasty.  Nick's mnt_want_write() implementation will need very careful
>> analysis.
> 
> 	Speaking of autofs4, what the hell is going on in
> autofs_dev_ioctl_ismountpoint()?  Checks in there make no sense,
> both the "could that dentry be negative?" and whatever the hell
> it is trying to do with mnt_mountpoint.  Ian?

In that case we may find an autofs mount that has something mounted on
top of it and user space wants to know the super of the covering mount.

If there is something mounted on top of it user space needs to know if
it is another autofs file system or some other type of file system. So
if the nameidata path, located by autofs_dev_ioctl_find_super(), is not
the top (or bottom, depending on the terminology you prefer) then we
need to follow the mount and return the magic of the thing mounted on
top of it.

Ian
