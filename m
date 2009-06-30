From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch,
	rfc] autofs4: add trace points to the mount and unmount paths
Date: Tue, 30 Jun 2009 14:40:40 -0400
Message-ID: <x493a9h36qf.fsf@segfault.boston.devel.redhat.com>
References: <x49fxdh3b0a.fsf@segfault.boston.devel.redhat.com>
	<4A4A5A56.1040308@RedHat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A4A5A56.1040308@RedHat.com> (Steve Dickson's message of "Tue,
	30 Jun 2009 14:32:54 -0400")
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
To: Steve Dickson <SteveD@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

Steve Dickson <SteveD@redhat.com> writes:

> Hey,
>
> Comments in-line...
>
> On 06/30/2009 01:08 PM, Jeff Moyer wrote:
>> Hi, Ian,
>> 
>> I got a fairly simply request from a customer.  They wanted to use
>> systemtap to track automounter mount and unmount activity.
>> Unfortunately, the compiler inlined the expire functions I wanted to
>> instrument, so I needed to add a tracepoint to get at useful
>> information.
>> 
>> This patch, then, adds a few trace points so that we don't have to worry
>> about compiler inlining.  I have an example script using these trace
>> points that I'll be sending along to the systemtap mailing list
>> shortly.  Let me know what you think.  If you're interested in trying it
>> out, I've made my systemtap patch available at:
>>   http://people.redhat.com/jmoyer/systemtap
>> 
>> You can try running testsuite/systemtap.examples/general/autofs.stp.  It
>> should run with or without the below patch applied, though the results
>> are not as accurate (can't get full paths for unmounts) without the
>> tracepoint in autofs4_do_expire_multi.
>> 
>> Cheers,
>> Jeff
>> 
>> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>> 
>> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
>> index aa39ae8..6c86df9 100644
>> --- a/fs/autofs4/expire.c
>> +++ b/fs/autofs4/expire.c
>> @@ -13,6 +13,7 @@
>>   * ------------------------------------------------------------------------- */
>>  
>>  #include "autofs_i.h"
>> +#include <trace/events/autofs4.h>
>>  
>>  static unsigned long now;
>>  
>> @@ -496,6 +497,7 @@ int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
>>  		/* This is synchronous because it makes the daemon a
>>                     little easier */
>>  		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
>> +		trace_autofs4_do_expire_multi(mnt, dentry, ret);
>>  
>>  		spin_lock(&sbi->fs_lock);
>>  		if (ino->flags & AUTOFS_INF_MOUNTPOINT) {
>> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
>> index b96a3c5..cbb17b7 100644
>> --- a/fs/autofs4/root.c
>> +++ b/fs/autofs4/root.c
>> @@ -19,6 +19,9 @@
>>  #include <linux/time.h>
>>  #include "autofs_i.h"
>>  
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/autofs4.h>
>> +
>>  static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
>>  static int autofs4_dir_unlink(struct inode *,struct dentry *);
>>  static int autofs4_dir_rmdir(struct inode *,struct dentry *);
>> @@ -216,6 +219,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
>>  	    (!d_mountpoint(dentry) && __simple_empty(dentry))) {
>>  		spin_unlock(&dcache_lock);
>>  
>> +		trace_autofs4_follow_link(nd, dentry);
>>  		status = try_to_fill_dentry(dentry, 0);
> Would it make sense to put the trace point after the 
> try_to_fill_dentry() so the status could be recorded in the 
> trace point? Similar to the trace point above?
>
>>  		if (status)
>>  			goto out_error;
>> @@ -540,6 +544,8 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
>>  			dput(expiring);
>>  		}
>>  
>> +		trace_autofs4_lookup(nd, dentry);
> Same kinda idea here... would it make sense to move this
> trace point some where so the status can be recorded?
>
> The main point with these two question is I have found it 
> very handy to write system tap scripts that only fire 
> when there is a non-zero status.... Which means instead 
> of getting pages and pages of info scrolling off the 
> screen, I get one (or few) lines of error conditions that
> generally have a bit more meaning... 
>
> Just a suggestion...  

Yeah, that's a good suggestion, thanks!  I'll respin with that changed after
I've heard from Ian.

Cheers,
Jeff
