From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: fix contained_in_local_fs and improve
 scalability
Date: Tue, 22 Mar 2016 08:24:24 +0800
Message-ID: <1458606264.3014.20.camel@themaw.net>
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
	 <1458531845.3042.36.camel@themaw.net> <56F070F6.7030802@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=4IwyzDq6HOgQQehymx2yGI3uPfM=; b=BYT+Re
	mSQVClwx3LpVcXfq7Ax+yyQ9N9nlj62twvhX1TtP0X9MuoOO+RPVPJCed6tNJqgo
	uKzkSW3nHdKQojZajGQrdxcQJ91O+agmHywgswO2GQLiVfMfwY0R0hn2s5og+6Fd
	oAS6xqfjdOH95xylk/69uNpf666Pa9KZRfPqk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=4IwyzDq6HOgQQeh
	ymx2yGI3uPfM=; b=rMEhdHqz3YRW3F0Vstbl1/qMkyjrDaq77k5/lfTKipR/4dc
	l92PZqsZxFqEX9tJFq1ax/SKqZ/TyeDCTYJsO3JSoMhm3HAPM9PMTHy0eQcXoPLs
	XNjIkciJAFBRPIWGDnUzkbgK+oDkYPrKrHt/qyRaDS0tysbkdkKhe9McCfrM=
In-Reply-To: <56F070F6.7030802@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>, autofs@vger.kernel.org

On Mon, 2016-03-21 at 18:08 -0400, Jeff Mahoney wrote:
> On 3/20/16 11:44 PM, Ian Kent wrote:
> > On Fri, 2016-03-18 at 17:25 -0400, Jeff Mahoney wrote:
> > > Commit d3ce65e05d1 (autofs-5.0.3 - allow directory create on NFS
> > > root),
> > > introduced a bug where contained_in_local_fs would *always* return
> > > true. 
> > > 
> > > Since the goal of contained_in_local_fs is only to determine if
> > > the
> > > path would be created on a local file system, it's enough to check
> > > a
> > > few things directly without parsing the mount table at all.
> > > 
> > > We can check via stat calls:
> > > 1) If parent is the root directory
> > > 2) If the parent is located on the root file system
> > > 3) If the parent is located within a file system mounted
> > >    via a block device
> > > 
> > > Large numbers of direct mounts when using /proc/self/mounts
> > > instead
> > > of /etc/mtab result in very slow startup time.  In testing, we
> > > observed
> > > ~8k mounts taking over 6 hours to complete.
> > 
> > When this was originally done the mtab was (usually) an actual file
> > so
> > the autofs mounts weren't present. So mostly it was fairly small.
> > 
> > But now, with the symlinking of the mtab to a proc filesystem, this
> > is a
> > big problem. 
> > 
> > > 
> > > This is due to reading /proc/self/mounts for every path component
> > > of
> > > every mount.  For my test case, that turns out to be about 119k
> > > times
> > > for a total of just under 400 GB read.  If it were a flat file, it
> > > would be also be slow, but /proc/self/mounts is dynamically
> > > generated
> > > every time it's read.
> > > 
> > > By avoiding reading /proc/self/mounts many times, startup time
> > > with 8k
> > > direct mounts drops from ~6 hours to about 25 seconds.
> > 
> > Yeah, I get that.
> > 
> > In some tests done before the symlinking became the norm I saw
> > direct
> > mount tables of over 20k entries taking between 20-30 seconds or a
> > bit
> > more (can't quite remember now, it was a long time ago) but nothing
> > like
> > this.
> 
> Yep, I figured you'd remember what was up since it's in the README,
> but
> the context is mostly for a complete commit log entry.
> 
> > I thought that was bad so this really needs to be fixed.
> > 
> > I am puzzled why I haven't seen other bug reports.
> 
> Yeah, I usually see all of the autofs bugs reported against our
> products
> and it's the first time I've seen it too.
> 
> > > 
> > > Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> > > ---
> > >  daemon/automount.c |   47
> > > ++++++++++++++++++++++++++++++++++++++++++++---
> > >  include/mounts.h   |    1 -
> > >  lib/mounts.c       |   45 ---------------------------------------
> > > ----
> > > --
> > >  3 files changed, 44 insertions(+), 49 deletions(-)
> > > 
> > > --- a/daemon/automount.c
> > > +++ b/daemon/automount.c
> > > @@ -98,6 +98,46 @@ static int umount_all(struct autofs_poin
> > >  
> > >  extern struct master *master_list;
> > >  
> > > +#define SYSFS_PATTERN "/sys/dev/block/%d:%d"
> > > +static int contained_in_local_fs(const char *parent)
> > > +{
> > > +	char buf[128];
> > > +	struct stat st, root;
> > > +	int ret;
> > > +
> > > +	/* The root directory is always considered local, even if
> > > it's not. */
> > > +	if (!*parent)
> > > +		return 1;
> > > +
> > > +	ret = stat("/", &root);
> > > +	if (ret != 0) {
> > > +		logerr("error: stat failed on /: %s",
> > > strerror(errno));
> > > +		return 0;
> > > +	}
> > > +
> > > +	ret = stat(parent, &st);
> > > +	if (ret)
> > > +		return 0;
> > > +	/*
> > > +	 * If the parent is on the root file system, it's local.
> > > +	 */
> > > +	if (root.st_dev == st.st_dev)
> > > +		return 1;
> > 
> > I'm struggling to remember now.
> > 
> > I think the problem was only when the root itself was an NFS file
> > system
> > and automount was trying to create a directory.
> 
> That sounds like the problem that the patch that caused it to always
> return true was supposed to solve.
> 
> Git tells me that contained_in_local_fs matches up with:
> commit 8293b030944eb402893a008a7d2ed1f8969ebee8
> Author: Ian Kent <raven@raven.themaw.net>
> Date:   Wed Oct 25 15:51:13 2006 +0800
> 
>     - deal with changed semantics of mkdir in 2.6.19.
> 
> Does that ring a bell?  Google associates it with a patch called
> "don't
> create remote dirs" which makes sense on its own but I can't find
> anything in the kernel changelog between v2.6.18 and v2.6.19 that
> stands
> out as changed mkdir semantics that would necessitate the work being
> done here.

There was a log going on at that time, it was around the initial v5
development.

I had started cataloguing the patches for each release at that time but
by the look of the path order there's nothing else related that went in
with it. Not only that, at that time, my change log entries were either
non-existent or less than stellar.

You can see the patch series for each release at:
https://www.kernel.org/pub/linux/daemons/autofs/v5/

I think this all arose from a discussion on the NFS mailing list due to
problems when trying to create mount point directories that resulted in
something like "automount shouldn't be creating directories on NFS file
systems". So the changed semantics were probably wrt. NFS and not the
VFS.

But the same logic extends to remote file systems in general.

> 
> At the point where that commit was added, the test for an autofs
> parent
> wasn't in the caller.  That searched through the mount table to see if
> there was a match and if it was autofs.  The statfs call was
> originally
> in the loop and was rightly moved out of it since statfs() doesn't
> actually require that its path argument be a mountpoint.  So that just
> makes the loop test whether it's a block device.  Sort of, since it
> uses
> /[^/] as a pattern to mean block device.  Later that was extended to
> include UUID/LABEL and also with the patch that was intended to match
> NFS roots.

There's not really enough context, we'll just need to resolve it based
on what's sensible.

> 
> So, I suppose the question is this: if that patch was accepted based
> on
> its intent, it should be ok to write to a remote file system if it's
> the
> root file system, right?  The root file system should be assumed to be
> private, but once we follow a path off of the root file system we
> shouldn't write anymore.

The mount table scan has to go, whatever we come up with is going to get
committed with the next bunch of patches.

> 
> > > +
> > > +	/*
> > > +	 * If the sysfs node for the block device exists, it's
> > > local.
> > > +	 */
> > > +	ret = snprintf(buf, sizeof(buf), SYSFS_PATTERN,
> > > +		       major(st.st_dev), minor(st.st_dev));
> > > +	if (ret != 0) {
> > > +		logerr("error: not enough space for sysfs path");
> > > +		return 0;
> > > +	}
> > 
> > This is the only bit that concerns me.
> > 
> > Not because I think it's wrong, on the contrary, it looks ok.
> > 
> > I just can't think of cases where it might not cover what's needed.
> 
> I realized shortly after posting the patch that anything using
> anonymous
> device nodes would fail the lookup test since they don't register a
> node
> in /sys/dev/block (nor should they.)  This includes btrfs since it
> uses
> anonymous devices to account for the fact that virtualizes the file
> system across multiple devices and also needs separate namespace for
> inode numbers between snapshots.  Ubifs also uses an anonymous device,
> but I've never actually seen an ubifs file system in the wild.

Or perhaps pass down the statfs buffer and check for remote fs magic
numbers. That's got to be a smaller list and should be much less likely
to change.

> Overlayfs will use an anonymous device for directories since they're
> also virtualized.  That's a separate issue, though, since it reports
> the
> device as 'none' in the mount table so direct mounts don't work on
> overlayfs yet anyway.
> 
> > After all, it's already been checked if the parent is an autofs
> > filesystem which should take care of the bulk of cases except for
> > longer
> > direct mount paths, but will often not be the case for offset
> > mounts.
> > 
> > For example a mount entry with offset mounts like:
> > 
> > <direct or indirect key>     /      server:/path \
> >                              /other server:/otherpath \
> >                              ...
> > 
> > But the intermediate path components of a direct mount path (and
> > offset
> > mount path) must already exist if within a remote mount. So the
> > existenc
> > e case, checked before this, should cover these cases.
> > 
> > Let me think about it a little longer.
> 
> Sure.  It seems like the solution, whatever it ends up being, will
> simplify this code a lot.  It seems like it boils down to "don't
> create
> directories on a remote file system unless it's the root file system."
> 
> As noted above, my patch is incomplete.  I think a complete solution
> would look like this:
> 
> 1/ Test whether the parent is autofs.
> 2/ Test whether the parent resides on a type of file system known to
> be
> local.  This is mostly because we'll need to at least test for btrfs,
> and if we're already testing file system type, we might as well test
> for
> the common local file systems as well.
> 3/ Test whether the parent resides on the root file system.
> 4/ Test whether the file system is mounted on a block device using the
> /sys/dev/block lookup.  This is mostly a fallback for the test in (2)
> being imperfect WRT new file systems.
> 
> Is this missing any other cases?

The only bit that looks tricky is the test for a block device, the rest
covers many of the cases.

And the point is to prohibit mount point directory creation on remote
file systems, so if we get that far then just checking the magic number
of of the statfs struct we already have for known remote file systems
should be enough and be a fairly short list.

> 
> -Jeff
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
