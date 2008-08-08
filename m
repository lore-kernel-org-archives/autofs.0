From: "Jim Dennis" <jdennis@cadence.com>
Subject: Re: autofs Digest, Vol 65, Issue 7
Date: Fri, 8 Aug 2008 12:19:26 -0700
Message-ID: <920746F6DF728345915EF4D6DA610D0F0584C770@MAILSJ2.global.cadence.com>
References: <mailman.1.1218196801.27507.autofs@linux.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <mailman.1.1218196801.27507.autofs@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

 

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of
autofs-request@linux.kernel.org
Sent: Friday, August 08, 2008 5:00 AM
To: autofs@linux.kernel.org
Subject: autofs Digest, Vol 65, Issue 7

Send autofs mailing list submissions to
	autofs@linux.kernel.org

To subscribe or unsubscribe via the World Wide Web, visit
	http://linux.kernel.org/mailman/listinfo/autofs
or, via email, send a message with subject or body 'help' to
	autofs-request@linux.kernel.org

You can reach the person managing the list at
	autofs-owner@linux.kernel.org

When replying, please edit your Subject line so it is more specific than
"Re: Contents of autofs digest..."


Today's Topics:

   1. Re: [PATCH 2/4] autofs4 - track uid and gid of last mount
      requester (Ian Kent)
   2. Re: [PATCH 4/4] autofs4 - add miscelaneous device for	ioctls
      (Andrew Morton)
   3. Re: [PATCH 2/4] autofs4 - track uid and gid of last mount
      requester (Ian Kent)
   4. Re: [PATCH 4/4] autofs4 - add miscelaneous device for	ioctls
      (Ian Kent)
   5. Re: [PATCH 4/4] autofs4 - add miscelaneous device for	ioctls
      (Andrew Morton)


----------------------------------------------------------------------

Message: 1
Date: Fri, 08 Aug 2008 12:44:02 +0800
From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH 2/4] autofs4 - track uid and gid of last
	mount	requester
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,	Andrew
	Morton <akpm@linux-foundation.org>,
containers@lists.osdl.org,
	linux-kernel@vger.kernel.org
Message-ID: <1218170643.17093.88.camel@raven.themaw.net>
Content-Type: text/plain


On Fri, 2008-08-08 at 11:48 +0800, Ian Kent wrote:
> > > 
> > > Please remind me again why autofs's use of current->uid and
> > > current->gid is not busted in the presence of PID namespaces, 
> > > current->where
> > > these things are no longer system-wide unique?
> > 
> > I actually don't see what the autofs4_waitq->pid is used for.  It's 
> > copied from current into wq->pid at autofs4_wait, and into a packet 
> > to send to userspace (I assume) at autofs4_notify_daemon.
> > 
> > So as long as a daemon can serve multiple pid namespaces (which 
> > doubtless it can), the pid could be confusing (or erroneous) for the

> > daemon.
> 
> Your point is well taken.
> 
> The pid is used purely for logging purposes to aid in debugging in 
> user space. I'm not sure it is worth worrying about it too much as the

> daemon has no business interfering with user space processes it is not

> the owner of.
> 
> > 
> > If I'm remotely right about how the pid is being used, then the 
> > thing to do would be to
> > 	1. store the daemon's pid namespace  (would that belong in
> > 	the autofs_sb_info?)
>  
> Yep.
> 
> > 	2. store the task_pid(current) in the waitqueue
> > 	3. retrieve the pid_t for the waiting task in the daemon's
> > 	pid namespace, and put that into the packet at
> > 	autofs4_notify_daemon.
> > 
> > I realize this patch was about the *uids*, but the pids seem more 
> > urgent.
> 
> OK, I get it.
> I'll have a go at doing this for completeness.

On second thoughts I'm not sure about this.

The pid that is logged needs to relate to a process in the name space of
the one that caused the mount to be done.

For example, suppose a GUI user finds mounts never expiring, then we get
a debug log to try and identify the culprit. So the pid should
correspond to a process that the user sees (So I guess in the namespace
of that user).

This is the only reason I added the pid to the request packet in the
first place.

Please correct me if my understanding of this is not right.

Ian


> 
> Ian
> 



------------------------------

Message: 2
Date: Thu, 7 Aug 2008 22:31:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [autofs] [PATCH 4/4] autofs4 - add miscelaneous device
	for	ioctls
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <20080807223109.e67f46e4.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII

On Fri, 08 Aug 2008 11:39:19 +0800 Ian Kent <raven@themaw.net> wrote:

> 
> On Thu, 2008-08-07 at 14:10 -0700, Andrew Morton wrote:
> > On Thu, 07 Aug 2008 19:40:31 +0800
> > Ian Kent <raven@themaw.net> wrote:
> > >
> > > Subject: [PATCH 4/4] autofs4 - add miscelaneous device for ioctls
> > 
> > I fixed that spello
> > 
> > > Patch to add a miscellaneous device to the autofs4 module for 
> > > routing ioctls. This provides the ability to obtain an ioctl file 
> > > handle for an autofs mount point that is possibly covered by
another mount.
> > > 
> > > The actual problem with autofs is that it can't reconnect to 
> > > existing mounts. Immediately one things of just adding the ability

> > > to remount autofs file systems would solve it, but alas, that 
> > > can't work. This is because autofs direct mounts and the 
> > > implementation of "on demand mount and expire" of nested mount 
> > > trees have the file system mounted on top of the mount trigger
dentry.
> > > 
> > > To resolve this a miscellaneous device node for routing ioctl 
> > > commands to these mount points has been implemented in the autofs4

> > > kernel module and a library added to autofs. This provides the 
> > > ability to open a file descriptor for these over mounted autofs
mount points.
> > > 
> > > Please refer to 
> > > Documentation/filesystems/autofs4-mount-control.txt for a 
> > > discussion of the problem, implementation alternatives considered
and a description of the interface.
> > > 
> > >
> > > ...
> > >
> > > +
> > > +#define AUTOFS_DEV_IOCTL_SIZE	sizeof(struct autofs_dev_ioctl)
> > > +
> > > +typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *, 
> > > +struct autofs_dev_ioctl *);
> > 
> > Weird layout, which I fixed.
> 
> Auuuhh .. didn't want to do this. I personally like declarations like 
> this to be on a single line but checkpatch.pl complained about it.

Well, that's why it's a checkpatch warning, not an error.  The way I
look at checkpatch is that it is for detecting possible mistakes.  Did
you _really_ mean to do that?  Usually the answer is "nope, and I
wouldn't have noticed unless you told me".  But sometimes the answer is
"yes, I really did mean that".

I routinely ignore checkpatch 80-col warnings, unless they are flagging
something which is just egregiously revolting.

Anyway, that's an aside.  Given that you decided to fit that typedef
into 80 cols, the way you did it was weird ;)

> > > +static void autofs_dev_ioctl_fd_install(unsigned int fd, struct 
> > > +file *file) {
> > > +	struct files_struct *files = current->files;
> > > +	struct fdtable *fdt;
> > > +
> > > +	spin_lock(&files->file_lock);
> > > +	fdt = files_fdtable(files);
> > > +	rcu_assign_pointer(fdt->fd[fd], file);
> > > +	FD_SET(fd, fdt->close_on_exec);
> > > +	spin_unlock(&files->file_lock);
> > > +}
> > 
> > urgh, it's bad to have done a copy-n-paste on fd_install() here.  It

> > means that if we go and change the locking in core kernel (quite
> > possible) then people won't udpate this code.
> > 
> > Do we have alternative here?  Can we set close_on_exec outside the 
> > lock and just call fd_install()?  Probably not.
> > 
> > Can we export set_close_on_exec() then call that after having called

> > fd_install()?  I think so.
> > 
> > But not this, please.
> 
> No problem.
> You mentioned this last time as well.
> 
> Since there are a couple of possible approaches and I wasn't sure 
> which way to go I thought I'd post it as is and get feedback then make

> it a followup patch.
> 
> Could the pthreads user space daemon exec something between 
> fd_install() and set_close_on_exec()?

Gee, I don't know, it would depend on the context.

Is that a private file*?  Was it just created, and is there no
possibility that any other thread can be sharing it anyway?  If so,
there's no problem.

> Perhaps there are some other alternative approaches to this.
> 
> Suggestions?

I don't know enough about autofs nor about what problem you're attacking
here to be able to say, sorry.  I don't even know why close_on_exec is
being set?




------------------------------

Message: 3
Date: Fri, 08 Aug 2008 13:37:41 +0800
From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH 2/4] autofs4 - track uid and gid of last
	mount	requester
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
	containers@lists.osdl.org, linux-kernel@vger.kernel.org
Message-ID: <1218173863.17093.98.camel@raven.themaw.net>
Content-Type: text/plain


On Fri, 2008-08-08 at 11:25 +0800, Ian Kent wrote:
> On Thu, 2008-08-07 at 13:46 -0700, Andrew Morton wrote:
> > On Thu, 07 Aug 2008 19:40:14 +0800
> > Ian Kent <raven@themaw.net> wrote:
> > 
> > > Patch to track the uid and gid of the last process to request a 
> > > mount for on an autofs dentry.
> > 
> > pet peeve: changelog should not tell the reader that this is a
"patch".
> > Because when someone is reading the changelog in the git repository,

> > they hopefully already know that.
> > 
> > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > 
> > > ---
> > > 
> > >  fs/autofs4/autofs_i.h |    3 +++
> > >  fs/autofs4/inode.c    |    2 ++
> > >  fs/autofs4/waitq.c    |   34 ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 39 insertions(+), 0 deletions(-)
> > > 
> > > 
> > > diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h index 
> > > ea024d8..fa76d18 100644
> > > --- a/fs/autofs4/autofs_i.h
> > > +++ b/fs/autofs4/autofs_i.h
> > > @@ -63,6 +63,9 @@ struct autofs_info {
> > >  	unsigned long last_used;
> > >  	atomic_t count;
> > >  
> > > +	uid_t uid;
> > > +	gid_t gid;
> > > +
> > >  	mode_t	mode;
> > >  	size_t	size;
> > >  
> > > diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c index 
> > > 9ca2d07..9408507 100644
> > > --- a/fs/autofs4/inode.c
> > > +++ b/fs/autofs4/inode.c
> > > @@ -53,6 +53,8 @@ struct autofs_info *autofs4_init_ino(struct
autofs_info *ino,
> > >  		atomic_set(&ino->count, 0);
> > >  	}
> > >  
> > > +	ino->uid = 0;
> > > +	ino->gid = 0;
> > >  	ino->mode = mode;
> > >  	ino->last_used = jiffies;
> > >  
> > > diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c index 
> > > 6d87bb1..7c60c0b 100644
> > > --- a/fs/autofs4/waitq.c
> > > +++ b/fs/autofs4/waitq.c
> > > @@ -457,6 +457,40 @@ int autofs4_wait(struct autofs_sb_info *sbi, 
> > > struct dentry *dentry,
> > >  
> > >  	status = wq->status;
> > >  
> > > +	/*
> > > +	 * For direct and offset mounts we need to track the requestrer
> > 
> > typo which I'll fix.
> > 
> > > +	 * uid and gid in the dentry info struct. This is so it can be
> > > +	 * supplied, on request, by the misc device ioctl interface.
> > > +	 * This is needed during daemon resatart when reconnecting
> > > +	 * to existing, active, autofs mounts. The uid and gid (and
> > > +	 * related string values) may be used for macro substitution
> > > +	 * in autofs mount maps.
> > > +	 */
> > > +	if (!status) {
> > > +		struct autofs_info *ino;
> > > +		struct dentry *de = NULL;
> > > +
> > > +		/* direct mount or browsable map */
> > > +		ino = autofs4_dentry_ino(dentry);
> > > +		if (!ino) {
> > > +			/* If not lookup actual dentry used */
> > > +			de = d_lookup(dentry->d_parent,
&dentry->d_name);
> > > +			if (de)
> > > +				ino = autofs4_dentry_ino(de);
> > > +		}
> > > +
> > > +		/* Set mount requester */
> > > +		if (ino) {
> > > +			spin_lock(&sbi->fs_lock);
> > > +			ino->uid = wq->uid;
> > > +			ino->gid = wq->gid;
> > > +			spin_unlock(&sbi->fs_lock);
> > > +		}
> > > +
> > > +		if (de)
> > > +			dput(de);
> > > +	}
> > > +
> > 
> > Please remind me again why autofs's use of current->uid and
> > current->gid is not busted in the presence of PID namespaces, where
> > these things are no longer system-wide unique?
> 
> We didn't really get to the bottom of that last time I posted this but

> hopefully Serge will get right on this and we can sort out what, idf 
> anything I need to do.

But, at this stage, I believe that if namespaces are being used then
there would also need to be a daemon within the container which would
have the same namespace view as other processes in the container. I
expect that the situation is not nearly as straight forward as I think
so I'll need to wait for further comments.

Ian




------------------------------

Message: 4
Date: Fri, 08 Aug 2008 14:12:21 +0800
From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH 4/4] autofs4 - add miscelaneous device
	for	ioctls
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <1218175943.17093.107.camel@raven.themaw.net>
Content-Type: text/plain


On Thu, 2008-08-07 at 22:31 -0700, Andrew Morton wrote:
> On Fri, 08 Aug 2008 11:39:19 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > 
> > On Thu, 2008-08-07 at 14:10 -0700, Andrew Morton wrote:
> > > On Thu, 07 Aug 2008 19:40:31 +0800 Ian Kent <raven@themaw.net> 
> > > wrote:
> > > >
> > > > Subject: [PATCH 4/4] autofs4 - add miscelaneous device for 
> > > > ioctls
> > > 
> > > I fixed that spello
> > > 
> > > > Patch to add a miscellaneous device to the autofs4 module for 
> > > > routing ioctls. This provides the ability to obtain an ioctl 
> > > > file handle for an autofs mount point that is possibly covered
by another mount.
> > > > 
> > > > The actual problem with autofs is that it can't reconnect to 
> > > > existing mounts. Immediately one things of just adding the 
> > > > ability to remount autofs file systems would solve it, but alas,

> > > > that can't work. This is because autofs direct mounts and the 
> > > > implementation of "on demand mount and expire" of nested mount 
> > > > trees have the file system mounted on top of the mount trigger
dentry.
> > > > 
> > > > To resolve this a miscellaneous device node for routing ioctl 
> > > > commands to these mount points has been implemented in the 
> > > > autofs4 kernel module and a library added to autofs. This 
> > > > provides the ability to open a file descriptor for these over
mounted autofs mount points.
> > > > 
> > > > Please refer to 
> > > > Documentation/filesystems/autofs4-mount-control.txt for a 
> > > > discussion of the problem, implementation alternatives
considered and a description of the interface.
> > > > 
> > > >
> > > > ...
> > > >
> > > > +
> > > > +#define AUTOFS_DEV_IOCTL_SIZE	sizeof(struct autofs_dev_ioctl)
> > > > +
> > > > +typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,

> > > > +struct autofs_dev_ioctl *);
> > > 
> > > Weird layout, which I fixed.
> > 
> > Auuuhh .. didn't want to do this. I personally like declarations 
> > like this to be on a single line but checkpatch.pl complained about
it.
> 
> Well, that's why it's a checkpatch warning, not an error.  The way I 
> look at checkpatch is that it is for detecting possible mistakes.  Did

> you _really_ mean to do that?  Usually the answer is "nope, and I 
> wouldn't have noticed unless you told me".  But sometimes the answer 
> is "yes, I really did mean that".
> 
> I routinely ignore checkpatch 80-col warnings, unless they are 
> flagging something which is just egregiously revolting.
> 
> Anyway, that's an aside.  Given that you decided to fit that typedef 
> into 80 cols, the way you did it was weird ;)
> 
> > > > +static void autofs_dev_ioctl_fd_install(unsigned int fd, struct

> > > > +file *file) {
> > > > +	struct files_struct *files = current->files;
> > > > +	struct fdtable *fdt;
> > > > +
> > > > +	spin_lock(&files->file_lock);
> > > > +	fdt = files_fdtable(files);
> > > > +	rcu_assign_pointer(fdt->fd[fd], file);
> > > > +	FD_SET(fd, fdt->close_on_exec);
> > > > +	spin_unlock(&files->file_lock); }
> > > 
> > > urgh, it's bad to have done a copy-n-paste on fd_install() here.  
> > > It means that if we go and change the locking in core kernel 
> > > (quite
> > > possible) then people won't udpate this code.
> > > 
> > > Do we have alternative here?  Can we set close_on_exec outside the

> > > lock and just call fd_install()?  Probably not.
> > > 
> > > Can we export set_close_on_exec() then call that after having 
> > > called fd_install()?  I think so.
> > > 
> > > But not this, please.
> > 
> > No problem.
> > You mentioned this last time as well.
> > 
> > Since there are a couple of possible approaches and I wasn't sure 
> > which way to go I thought I'd post it as is and get feedback then 
> > make it a followup patch.
> > 
> > Could the pthreads user space daemon exec something between 
> > fd_install() and set_close_on_exec()?
> 
> Gee, I don't know, it would depend on the context.
> 
> Is that a private file*?  Was it just created, and is there no 
> possibility that any other thread can be sharing it anyway?  If so, 
> there's no problem.

The problem is that autofs threads can exec mount or umount at any time
and we see annoying selinux file descriptor leak security violation
messages. So the point of this is to set the bit at the same time as the
file is inserted into the table.

> 
> > Perhaps there are some other alternative approaches to this.
> > 
> > Suggestions?
> 
> I don't know enough about autofs nor about what problem you're 
> attacking here to be able to say, sorry.  I don't even know why 
> close_on_exec is being set?

OK, sorry.

What I'm really after is:
Should I do this at all, given the above?
If this is sensible, should a parameter be added to fd_insall() to allow
it to be requested at descriptor install or should a new function, say,
fd_install_close_on_exec() be added?

Ian




------------------------------

Message: 5
Date: Thu, 7 Aug 2008 23:33:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [autofs] [PATCH 4/4] autofs4 - add miscelaneous device
	for	ioctls
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Message-ID: <20080807233325.8fb76c8b.akpm@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII

On Fri, 08 Aug 2008 14:12:21 +0800 Ian Kent <raven@themaw.net> wrote:

> > > No problem.
> > > You mentioned this last time as well.
> > > 
> > > Since there are a couple of possible approaches and I wasn't sure 
> > > which way to go I thought I'd post it as is and get feedback then 
> > > make it a followup patch.
> > > 
> > > Could the pthreads user space daemon exec something between 
> > > fd_install() and set_close_on_exec()?
> > 
> > Gee, I don't know, it would depend on the context.
> > 
> > Is that a private file*?  Was it just created, and is there no 
> > possibility that any other thread can be sharing it anyway?  If so, 
> > there's no problem.
> 
> The problem is that autofs threads can exec mount or umount at any 
> time and we see annoying selinux file descriptor leak security 
> violation messages. So the point of this is to set the bit at the same

> time as the file is inserted into the table.
> 
> > 
> > > Perhaps there are some other alternative approaches to this.
> > > 
> > > Suggestions?
> > 
> > I don't know enough about autofs nor about what problem you're 
> > attacking here to be able to say, sorry.  I don't even know why 
> > close_on_exec is being set?
> 
> OK, sorry.
> 
> What I'm really after is:
> Should I do this at all, given the above?

I don't reliably know, sorry.  <does viro summoning dance>

> If this is sensible, should a parameter be added to fd_insall() to 
> allow it to be requested at descriptor install or should a new 
> function, say,
> fd_install_close_on_exec() be added?

If we decide to do it this way, then we can add an extra arg to
fd_install(), I guess.

void fd_install(unsigned int fd, struct file *file,
		void (*callback)(struct file *));



------------------------------

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs


End of autofs Digest, Vol 65, Issue 7
*************************************
