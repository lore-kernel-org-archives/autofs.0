From: "Fletcher Mattox" <fletcher@cs.utexas.edu>
Subject: Re: automount errors under high load
Date: Fri, 3 Nov 2006 18:55:57 -0600
Message-ID: <200611040055.kA40tweg018563@cs.utexas.edu>
References: <x49zmb8ysld.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49zmb8ysld.fsf@segfault.boston.devel.redhat.com>
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

Jeff Moyer writes:
> ==> Regarding [autofs] automount errors under high load; "Fletcher Mattox" <fletcher+autofs@cs.utexas.edu> adds:
> 
> fletcher> Hi,
> fletcher> Under high load (100 mount/sec) automount will fail with either
> fletcher> of these error messages from mount.
> 
> fletcher>     mount: filer3:/vol/vol2/v2q017: can't read superblock
> fletcher>     mount: RPC: Authentication error; why = Client credential too weak
> 
> fletcher> I find these error messages suspicious, and do not believe either of
> fletcher> them represent the true problem.  I have appended the debug output in
> fletcher> case that is useful.  I notice that it seems to try the mount seven
> fletcher> times each, before giving up with one of the above errors (usually
> fletcher> it is the superblock error).
> 
> The mount program performs the retries.  What errors are reported in the
> server logs?  This really feels like more of an NFS problem than an autofs
> one.

Jeff,

This is the only error in the server logs:

  Mon Oct 30 10:58:05 CST [mountd_main:warning]: Client 128.83.120.210 (xid 160302913),\
  from mount is trying to mount from a nonreserved port = 43645 as uid = 0

which would explain the weak credentials error.  I wonder why mount would
use a non-privileged port?  If it runs out of privileged ports, does it
start using non-privileged ports?  Seems like it should just return an error.

In any event, Im now wondering if the problem is caused because all 1024 privileged
ports are in use.  Hmm.

But the superblock error is still unexplained.

> fletcher> I have also noticed corruption of /etc/mtab.  Sometimes static
> fletcher> mounts just disappear from it during busy times.  I assume this
> fletcher> is some type of race condition where file locking fails.  I do
> fletcher> not know if this is the same problem or a different problem, but
> fletcher> I thought I would mention it.
> 
> I posted one method for fixing that problem to the list some time ago.  The
> idea is to simply use /proc/mounts instead aof /etc/mtab.  That way we
> avoid the whole lock-file mess.  I've attached the patch, here, but I
> didn't try to apply it to 4.1.4, so it may need some massaging.  (I'll post
> a proper patch later on, but I have to work through my backlog first.)

Thanks.  I just joined the list.  And I have to get up to speed using
ubuntu's source building environment before I can start applying patches.
But it's good to know they exist.

> I don't think the corruption of /etc/mtab will cause the problems you are
> seeing, but I could be wrong.

I agree.   I just though it was worth mentioning.

Thank you for responding!
Fletcher
