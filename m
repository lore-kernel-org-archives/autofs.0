From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
	block info
Date: Sun, 17 Jan 2010 17:57:23 +0000
Message-ID: <20100117175723.GP19799@ZenIV.linux.org.uk>
References: <1261611423-4396-1-git-send-email-vaurora@redhat.com> <1261611423-4396-2-git-send-email-vaurora@redhat.com> <20100102004423.GA2131@zeus.themaw.net> <20100114054322.GA16106@ZenIV.linux.org.uk> <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net> <4806.1263567323@redhat.com> <9927.1263575308@redhat.com> <20100115172633.GM19799@ZenIV.linux.org.uk> <20100116101714.GN19799@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100116101714.GN19799@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, Trond.Myklebust@netapp.com, David Howells <dhowells@redhat.com>

On Sat, Jan 16, 2010 at 10:17:14AM +0000, Al Viro wrote:
> 	* [unsolved, to be dealt along with per-superblock write counts]
> do_remount() plays fast and loose with MNT_READONLY for !MS_BIND case.
> 	* [*really* unsolved] it remains to be seen whether we want to
> propagate modifications of mount flags via shared subtree stuff.  For most
> of those it's trivial (and arguably the right thing to do), but ro/rw is
> really nasty.  Nick's mnt_want_write() implementation will need very careful
> analysis.

	Speaking of autofs4, what the hell is going on in
autofs_dev_ioctl_ismountpoint()?  Checks in there make no sense,
both the "could that dentry be negative?" and whatever the hell
it is trying to do with mnt_mountpoint.  Ian?
