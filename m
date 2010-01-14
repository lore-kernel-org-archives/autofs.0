From: Valerie Aurora <vaurora@redhat.com>
Subject: Re: [PATCH 1/7] autofs4: Save autofs trigger's vfsmount in super block info
Date: Thu, 14 Jan 2010 14:18:47 -0500
Message-ID: <20100114191847.GD24005@shell>
References: <1261611423-4396-1-git-send-email-vaurora@redhat.com> <1261611423-4396-2-git-send-email-vaurora@redhat.com> <20100102004423.GA2131@zeus.themaw.net> <20100114054322.GA16106@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100114054322.GA16106@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>, linux-fsdevel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, autofs@linux.kernel.org

On Thu, Jan 14, 2010 at 05:43:22AM +0000, Al Viro wrote:
> On Sat, Jan 02, 2010 at 08:44:25AM +0800, Ian Kent wrote:
> > On Wed, Dec 23, 2009 at 03:36:57PM -0800, Valerie Aurora wrote:
> > > From: Jan Blunck <jblunck@suse.de>
> > > 
> > > This is a bugfix/replacement for commit
> > > 051d381259eb57d6074d02a6ba6e90e744f1a29f:
> > > 
> > >     During a path walk if an autofs trigger is mounted on a dentry,
> > >     when the follow_link method is called, the nameidata struct
> > >     contains the vfsmount and mountpoint dentry of the parent mount
> > >     while the dentry that is passed in is the root of the autofs
> > >     trigger mount.  I believe it is impossible to get the vfsmount of
> > >     the trigger mount, within the follow_link method, when only the
> > >     parent vfsmount and the root dentry of the trigger mount are
> > >     known.
> > > 
> > > The solution in this commit was to replace the path embedded in the
> > > parent's nameidata with the path of the link itself in
> > > __do_follow_link().  This is a relatively harmless misuse of the
> > > field, but union mounts ran into a bug during follow_link() caused by
> > > the nameidata containing the wrong path (we count on it being what it
> > > is all other places - the path of the parent).
> > > 
> > > A cleaner and easier to understand solution is to save the necessary
> > > vfsmount in the autofs superblock info when it is mounted.  Then we
> > > can easily update the vfsmount in autofs4_follow_link().
> > > 
> > > Signed-off-by: Jan Blunck <jblunck@suse.de>
> > > Signed-off-by: Valerie Aurora <vaurora@redhat.com>
> > Acked-by: <raven@themaw.net>
> > 
> > Don't know how I missed such an obvious solution when I did this.
> > Thanks, Ian
> 
> TBH, I don't like either variant (both the in-tree one and that).
> The reason why vfsmount does *NOT* belong in superblock, TYVM: you've
> messed the lifetime rules.  You can't pin it down, or the damn thing will
> be impossible to kill.  OTOH, you have no promise whatsoever that superblock
> won't outlive the initial vfsmount.  You might get another vfsmount over
> the same thing and once the original one is gone...
> 
> So this is simply broken.

Ian, you're the expert - any ideas?  What are the constraints here?

-VAL
