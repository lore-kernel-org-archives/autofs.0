From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [VFS-RFC] autofs4 and bind, rbind and move mount requests
Date: Mon, 23 May 2005 19:09:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.61.0505231847470.6229@xena.cft.ca.us>
References: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505232041410.8361@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 23 May 2005 raven@themaw.net wrote:

> I've been investigating a bug report about bind mounting an autofs 
> controlled mount point. It is indeed disastrous for autofs. It would be 
> simple enough it to check and fail silently but that won't give sensible 
> behavior.
> 
> What should the semantics be for these type of mount requests against 
> autofs?

So in the reported bug, the person did a bind mount on the toplevel autofs 
mount point.  I was expecting to see a particular server, or more likely a 
particular NFS-mounted dir from that server, as the subject of the mount.  
It's not too unreasonable to expect any of these to work transparently, 
since autofs does its magic when the user looks up a name in the autofs 
directory, and it shouldn't matter whether he got there from the original 
mount point or the bind target.  The kernel module would send the name to 
the userspace daemon, which would spawn a submount daemon or mount 
something in the original location, and the subdir and whatever is mounted 
on it ought to be visible even from the bind target.

But evidently that's not true.  As you say, if it can't be made to work 
transparently, the next best is to make the bind mount fail.  A distant 
third choice is to say "don't do that" in the documnetation.  Sorry, no 
insights in the code; I'm just acting as a sounding board.

I wonder what the person is trying to do.  Maybe a chroot jail, but it's 
unlikely that the client would be allowed to use the whole automount 
mechanism.  How about this concept (not what's described in the bug 
report): the client's homedir server is autofs mounted (i.e. a submount 
process is spawned) and the server dir is bind-mounted into the jail.  
Then a shell is jailed.  He can use anything on his server, using the 
out-of-jail autofs daemon to mount the filesystems, but no other host will 
be accessible.

Certainly a "move" mount should be illegal: how would the userspace daemon 
know where the main mount point had gone?

Am I correct that if a filesystem is unmounted by force majeure, e.g. 
manually by the sysadmin or any other reason, the userspace daemon that 
mounted it may be a little unhappy but it will not suffer any permanent 
damage?  I've always assumed that to be true, in case of stubborn messed-up 
mounts.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
