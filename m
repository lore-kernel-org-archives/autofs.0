From: raven@themaw.net
Subject: Re: Re: [NFS] Re: Busy inodes after unmount followed by
 Oops
Date: Sat, 22 May 2004 23:15:32 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405222250470.6824@donald.themaw.net>
References: <3FFE8B28.1E645E4E@moving-picture.com>
	<40AE23DC.6C240DAE@moving-picture.com>
	<40AE3532.8EBA0D7B@moving-picture.com>
	<20040522130457.GB15564@sgi.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040522130457.GB15564@sgi.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Banks <gnb@sgi.com>
Cc: autofs@linux.kernel.org, James Pearson <james-p@moving-picture.com>, nfs@lists.sourceforge.net, Trond Myklebust <trond.myklebust@fys.uio.no>

On Sat, 22 May 2004, Greg Banks wrote:

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

Probably a little of the first two.

The changes I made were a result of working on another problem. I noticed 
that it was possible for two execution paths to raise seperate waits for 
the same mount. I changed the spin lock I had used to a semaphore and 
extended the critical region to force correct wait q handling. It was 
after this that James contacted me and I sent him the my latest patch.

It's worth pointing out that in 2.4 there was previously no locking 
during access to the wait q struct yet there is at least one possibility 
of two execution paths accessing it concurently. 

The oops seems to occur some fair amount of time after the damage was 
done and his log hinted that there was some sort of corruption in the wait 
q struct.

There is the possibility that it is now hidden as I cannot give you an 
exact decription of how this occurs except for the above observations.

There's not much doubt in my mind that there was a potential race for the 
wait q. There are 4 possible execution paths that modify the wait q 
struct. Two are syncronous (so really are only one) but two are not.

Ian
