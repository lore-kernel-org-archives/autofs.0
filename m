From: Ion Badulescu <lists@news.cs.columbia.edu>
Subject: Re: [NFS] Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Fri, 26 Sep 2003 14:31:23 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200309261831.h8QIVNVw026806@buggy.badula.org>
References: <16243.34641.819894.763746@charged.uio.no>
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16243.34641.819894.763746@charged.uio.no>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trond.myklebust@fys.uio.no
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

On Thu, 25 Sep 2003 17:24:49 -0700, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> I would rather then have something like the appended patch go in to
> which force the last process to close the file to actually wait on
> completion (unless someone signals it with a 'kill -9' - in which case
> they are knowingly breaking things).

Ugh, that's ugly -- and potentially a DoS issue as well. Since you don't
need any privileges to issue the 'kill -9' for your own processes, it   
becomes fairly easy to write some code that exploits this and causes 
kernel crashes across the board...

Not that the current situation is any better, of course.

Perhaps making that wait an uninterruptable wait would be enough to take
care of the problem?

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
