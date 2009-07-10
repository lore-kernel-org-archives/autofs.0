From: Ian Kent <raven@themaw.net>
Subject: Re: [patch,
 rfc] autofs4: add trace points to the mount and unmount paths
Date: Fri, 10 Jul 2009 14:08:57 +0800
Message-ID: <4A56DAF9.1010405@themaw.net>
References: <x49fxdh3b0a.fsf@segfault.boston.devel.redhat.com>	<4A4A5A56.1040308@RedHat.com>
	<4A4B005D.9000901@themaw.net>
	<x49ws6hd1yi.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49ws6hd1yi.fsf@segfault.boston.devel.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

Jeff Moyer wrote:
> Ian Kent <raven@themaw.net> writes:
> 
>> Steve Dickson wrote:
> 
>>> The main point with these two question is I have found it 
>>> very handy to write system tap scripts that only fire 
>>> when there is a non-zero status.... Which means instead 
>>> of getting pages and pages of info scrolling off the 
>>> screen, I get one (or few) lines of error conditions that
>>> generally have a bit more meaning... 
> 
> Given Ian's point about logging entire paths, this updated patch will
> still log before determining the final status of a request.  If you
> want, you could cache that in systemtap until the status is received and
> try to correlate the two events (which would address your request of
> logging only on failures).  For the lookup routine, you need to check if
> dentry is -ENOENT.  for follow_link etc, there's a status code.  The
> associated systemtap patch can be found here:
>   http://people.redhat.com/jmoyer/systemtap

One thing to be wary of is the status return in "autofs4_lookup_status".
With the new ioctl implementation we are now able to pass the actual
status return back to kernel space (although the daemon hasn't been
updated to take advantage of this yet).

So this (please excuse the line wrap):

+probe kernel.trace("autofs4_lookup_status")
+{
+	if (!isinstr(execname(), "automount")) {
+		printf("%s process %s[%d] lookup %s\n",
+		       ctime(gettimeofday_s()), execname(), pid(),
+		       $dentry == -2 /* ENOENT */ ? "failed" : "succeeded")
+	}
+}
+

should probably be something like (or however we use IS_ERR() in these
scripts):

+probe kernel.trace("autofs4_lookup_status")
+{
+	if (!isinstr(execname(), "automount")) {
+		printf("%s process %s[%d] lookup %s\n",
+		       ctime(gettimeofday_s()), execname(), pid(),
+		       IS_ERR($dentry) ? "failed" : "succeeded")
+	}
+}
+

> 
> Ian, let me know what you think.
> 
> Cheers,
> Jeff
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index aa39ae8..6c86df9 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -13,6 +13,7 @@
>   * ------------------------------------------------------------------------- */
>  
>  #include "autofs_i.h"
> +#include <trace/events/autofs4.h>
>  
>  static unsigned long now;
>  
> @@ -496,6 +497,7 @@ int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
>  		/* This is synchronous because it makes the daemon a
>                     little easier */
>  		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
> +		trace_autofs4_do_expire_multi(mnt, dentry, ret);

Is this what we want?
I'm not sure what we are trying to do here but I thought the trace
should occur before the expire. If we wanted to get a path after the
expire that probably can't be done as the mount should have been
detached from the tree once the expire is complete.

>  
>  		spin_lock(&sbi->fs_lock);
>  		if (ino->flags & AUTOFS_INF_MOUNTPOINT) {
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index b96a3c5..7cefdad 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -19,6 +19,9 @@
>  #include <linux/time.h>
>  #include "autofs_i.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/autofs4.h>
> +
>  static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
>  static int autofs4_dir_unlink(struct inode *,struct dentry *);
>  static int autofs4_dir_rmdir(struct inode *,struct dentry *);
> @@ -216,6 +219,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
>  	    (!d_mountpoint(dentry) && __simple_empty(dentry))) {
>  		spin_unlock(&dcache_lock);
>  
> +		trace_autofs4_follow_link(nd, dentry);
>  		status = try_to_fill_dentry(dentry, 0);
>  		if (status)
>  			goto out_error;
> @@ -237,9 +241,11 @@ follow:
>  	}
>  
>  done:
> +	trace_autofs4_follow_link_status(dentry, 0);
>  	return NULL;
>  
>  out_error:
> +	trace_autofs4_follow_link_status(dentry, status);
>  	path_put(&nd->path);
>  	return ERR_PTR(status);
>  }
> @@ -540,6 +546,8 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
>  			dput(expiring);
>  		}
>  
> +		trace_autofs4_lookup(nd, dentry);
> +
>  		spin_lock(&dentry->d_lock);
>  		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
>  		spin_unlock(&dentry->d_lock);
> @@ -595,12 +603,16 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
>  		if (unhashed)
>  			dput(unhashed);
>  
> +		trace_autofs4_lookup_status(dentry);
>  		return dentry;
>  	}
>  
> -	if (unhashed)
> +	if (unhashed) {
> +		trace_autofs4_lookup_status(unhashed);
>  		return unhashed;
> +	}
>  
> +	trace_autofs4_lookup_status(NULL);
>  	return NULL;
>  }
>  
> diff --git a/include/trace/events/autofs4.h b/include/trace/events/autofs4.h
> index 39f04c9..6feae79 100644
> --- a/include/trace/events/autofs4.h
> +++ b/include/trace/events/autofs4.h
> @@ -1,26 +1,115 @@
>  #if !defined(_TRACE_AUTOFS4_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_AUTOFS4_H
>  
> +#include <linux/dcache.h>
> +#include <linux/mount.h>
> +#include <linux/limits.h>
>  #include <linux/tracepoint.h>
>  
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM autofs4
>  
>  TRACE_EVENT(autofs4_do_expire_multi,
> -	    TP_PROTO(struct vfsmount *mnt, struct dentry *dentry),
> -	    TP_ARGS(mnt, dentry),
> +	    TP_PROTO(struct vfsmount *mnt, struct dentry *dentry, int status),
> +	    TP_ARGS(mnt, dentry, status),
>  	    TP_STRUCT__entry(
>  		    __array(char, comm, TASK_COMM_LEN)
>  		    __field(pid_t, pid)
> +		    __array(char, path, MAX_FILTER_STR_VAL)
> +		    __field(int, status)
>  	    ),
>  	    TP_fast_assign(
>  		    __entry->pid = current->pid;
>  		    memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> +		    snprintf(__entry->path,
> +			     dentry->d_name.len < MAX_FILTER_STR_VAL ?
> +			     dentry->d_name.len : MAX_FILTER_STR_VAL,
> +			     "%s", dentry->d_name.name);
> +		    __entry->status = status;
>  	    ),
> -	    TP_printk("%s[%d]: expiring %.*s", __entry->comm, __entry->pid,
> -		      dentry->d_name.len, dentry->d_name.name);
> +	    TP_printk("%s[%d]: expiry of %s %s",
> +		      __entry->comm, __entry->pid, __entry->path,
> +		      __entry->status == 0 ? "succeeded" : "failed")
>  );
>  
>  TRACE_EVENT(autofs4_lookup,
> -	    TP_PROTO(
> +	    TP_PROTO(struct nameidata *nd, struct dentry *dentry),
> +	    TP_ARGS(nd, dentry),
> +	    TP_STRUCT__entry(
> +		    __array(char, comm, TASK_COMM_LEN)
> +		    __array(char, path, MAX_FILTER_STR_VAL)
> +		    __field(char *, pathptr)
> +		    __field(pid_t, pid)
> +	    ),
> +	    TP_fast_assign(
> +		    __entry->pid = current->pid;
> +		    memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> +		    __entry->pathptr = d_path(&nd->path,
> +					     __entry->path, MAX_FILTER_STR_VAL);
> +	    ),
> +	    TP_printk("%s[%d]: looking up %s",
> +		      __entry->comm, __entry->pid, __entry->pathptr)
> +);
> +
> +TRACE_EVENT(autofs4_lookup_status,
> +	    TP_PROTO(struct dentry *dentry),
> +	    TP_ARGS(dentry),
> +	    TP_STRUCT__entry(
> +		    __array(char, comm, TASK_COMM_LEN)
> +		    __field(void *, dentry)
> +		    __field(pid_t, pid)
> +	    ),
> +	    TP_fast_assign(
> +		    __entry->dentry = dentry;
> +		    memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> +		    __entry->pid = current->pid;
> +	    ),
> +	    TP_printk("%s[%d]: lookup %s",
> +		      __entry->comm, __entry->pid,
> +		      __entry->dentry ? "succeeded" : "failed")
> +);
> +
> +TRACE_EVENT(autofs4_follow_link,
> +	    TP_PROTO(struct nameidata *nd, struct dentry *dentry),
> +	    TP_ARGS(nd, dentry),
> +	    TP_STRUCT__entry(
> +		    __array(char, comm, TASK_COMM_LEN)
> +		    __array(char, path, MAX_FILTER_STR_VAL)
> +		    __field(char *, pathptr)
> +		    __field(pid_t, pid)
> +	    ),
> +	    TP_fast_assign(
> +		    __entry->pid = current->pid;
> +		    memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> +		    __entry->pathptr = d_path(&nd->path,
> +					     __entry->path, MAX_FILTER_STR_VAL);
> +	    ),
> +	    TP_printk("%s[%d]: looking up trigger %s",
> +		      __entry->comm, __entry->pid, __entry->pathptr)
> +);
> +
> +TRACE_EVENT(autofs4_follow_link_status,
> +	    TP_PROTO(struct dentry *dentry, int status),
> +	    TP_ARGS(dentry, status),
> +	    TP_STRUCT__entry(
> +		    __array(char, comm, TASK_COMM_LEN)
> +		    __array(char, linkname, MAX_FILTER_STR_VAL)
> +		    __field(int, status)
> +		    __field(pid_t, pid)
> +	    ),
> +	    TP_fast_assign(
> +		    __entry->status = status;
> +		    snprintf(__entry->linkname, dentry->d_name.len, "%s",
> +			     dentry->d_name.name);
> +		    memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> +		    __entry->pid = current->pid;
> +	    ),
> +	    TP_printk("%s[%d]: lookup for trigger %s %s",
> +		      __entry->comm, __entry->pid, __entry->linkname,
> +		      __entry->status == 0 ? "succeeded" : "failed")
> +);
> +
>  #endif /* _TRACE_AUTOFS4_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
