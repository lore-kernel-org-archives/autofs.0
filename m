From: James Pearson <james-p@moving-picture.com>
Subject: Re: [NFS] Re: Busy inodes after unmount followed by Oops
Date: Mon, 24 May 2004 16:51:30 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40B21A02.63C4536B@moving-picture.com>
References: <3FFE8B28.1E645E4E@moving-picture.com>
	<40AE23DC.6C240DAE@moving-picture.com>
	<1085157843.3666.75.camel@lade.trondhjem.org>
	<40AE3532.8EBA0D7B@moving-picture.com> <20040522130457.GB15564@sgi.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Greg Banks <gnb@sgi.com>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

Greg Banks wrote:
> 
> On Fri, May 21, 2004 at 05:58:26PM +0100, James Pearson wrote:
> > Not quite sure what you mean by this - I had tried Greg's patch
> > (http://marc.theaimsgroup.com/?l=linux-nfs&m=107604754127538&w=2)
> > previously - but it made no difference in my case. The kernel I'm using
> > now has both Greg's patch and Ian's recent autofs4 patch.
> 
> The error message and subsequent oops are both generic symptoms and
> could come from any kind of race with umount which causes a dentry
> or inode reference count leak, not just the particular one in NFS
> which I fixed.  There could well be another NFS bug like this, or
> one in autofs.  Ian's patch may have fixed it, hidden it, or just
> stopped tickling it.
> 
> The only way to tell for sure is to modify the code that generates
> the message to BUG() instead and use a kernel debugger to figure out
> what has gone wrong.  Note that using a debugger at oops time is
> already too late.
> 
> James, are you able to reproduce this at will?

Unfortunately not. It proved impossible to reproduce in a 'controlled'
way - however since using the latest autofs4 patch we haven't had the
problem. Given that, I'm happy with the situation as it stands.

James Pearson
