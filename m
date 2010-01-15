From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super
	block info
Date: Fri, 15 Jan 2010 08:03:23 +0000
Message-ID: <20100115080323.GK19799@ZenIV.linux.org.uk>
References: <1261611423-4396-1-git-send-email-vaurora@redhat.com> <1261611423-4396-2-git-send-email-vaurora@redhat.com> <20100102004423.GA2131@zeus.themaw.net> <20100114054322.GA16106@ZenIV.linux.org.uk> <20100114191847.GD24005@shell> <4B5005A4.7080508@themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4B5005A4.7080508@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Valerie Aurora <vaurora@redhat.com>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org, sfrench@samba.org, dhowells@redhat.com, Trond.Myklebust@netapp.com

[AFS, CIFS and NFS maintainers added to Cc]

On Fri, Jan 15, 2010 at 02:05:24PM +0800, Ian Kent wrote:
> >> So this is simply broken.
> > 
> > Ian, you're the expert - any ideas?  What are the constraints here?
> 
> It looks to me like the struct path coming to __do_follow_link() has
> what I need. A potentially big change, but using the struct path instead
> of the dentry in the inode op follow_link() call would get me what I
> need in my follow_link() call without having to store anything.

Yuck.  If we go for change of ->follow_link() prototype, we might as
well DTRT and split the damn thing instead of trying to overload an
unsuitable method.

Let's see what's really going on there.  AFAICT, we have several, er,
oddities in the area:
	* abuse of mnt_devname by nfs; do we ever want it to differ
(for nfs automounting purposes) for different vfsmounts over the same
superblock?
	* inconsistent behaviour when something had managed to mount
first.  Some expect the possibility of -EBUSY, some do not.
	* WTF is CIFS doing setting MNT_SHRINKABLE on *parent* vfsmount?
Blindly, not even bothering to cooperate with mnt_make_readonly() and
its ilk.  Most of all, _why_?  It's child that should be marked so, not
the parent...
	* speaking of which, what should happen to other vfsmount flags?
NFS seems to want them all inherited and MNT_SHRINKABLE set, which is
reasonable enough; CIFS sets MNT_SHRINKABLE on parent and inherits everything;
AFS can't be arsed and just sets MNT_SHRINKABLE, all flags on parent be
damned.
	* what's going on with use of intent flags in case of autofs4?

Other than that, it'd seem that we would be better off if we treated these
guys as "if we try to follow mountpoint and that sucker turns out to be
the end of the road, do something fs-specific and either try to go further
or see if we could attach the mountpoint given to us here".  Which might
be better done in VFS, with fs method returning vfsmount, NULL or ERR_PTR.

And yes, it'd mean rework of vfsmount expiry interface; we'd need to put the
vfsmount on expiry list before attaching it anywhere.  Not a big deal,
that...

Comments?  It's obviously not a solution yet and this direction might
very well turn out to be unfeasible, but let's at least see where that
might lead.  There are, after all, 4 users of that stuff.  Should be
enough to figure out what we really need and come up with a sane design...
