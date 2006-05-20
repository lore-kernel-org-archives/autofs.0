From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: AutoFS Problems with Laptops
Date: Sat, 20 May 2006 16:34:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0605201539370.6824@xena.cft.ca.us>
References: <20060519081703.10370.qmail@web36805.mail.mud.yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060519081703.10370.qmail@web36805.mail.mud.yahoo.com>
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
To: Daniel Qarras <dqarras@yahoo.com>
Cc: autofs@linux.kernel.org

On Fri, 19 May 2006, Daniel Qarras wrote:

> However, when I go out to a different network where those directories
> are not available, I would like autofs to figure that out and not to
> try mount them and cause jams. What should the script output if those
> mounts are available?

If I remember correctly, if the programmatic map prints nothing and exits 
with a nonzero exit code, autofs will realize it has failed and give up. So 
now, how does the script realize that the 10.0.0.x IP address assigned to 
eth0 is not *your* 10.0.0.x, but a customer's net or an Internet cafe 
somewhere?  Perhaps a less obvious choice of subnet could be helpful; this 
is what I do on my own net.

But I'm wondering, what's in server:/home or server:/work?  The ideal is to 
set up the laptop so the NFS mounted directories are not touched without 
voluntary user action, upon which autofs swings into action, and if the 
user forgets that he's not at headquarters, he deserves the 30 second 
timeout (unless the programmatic map script heads off NFS mounting).  It 
isn't going to fly, if the user's home directory is in server:/home/$USER.  
On my own laptop the homedir is local, with backups to the server (and from 
there to removeable media), initiated manually.

If ever you might expand to have two or more NFS servers, it's important to 
use separate subtrees for each, e.g. 
    /var/autofs/server1/home
    /var/autofs/server1/work
    /var/autofs/server2/home
    /var/autofs/server2/work
The reason is like this:  Suppose the mount points were all jumbled 
together, e.g.
    /var/autofs/home1
    /var/autofs/home2
    /var/autofs/work1
    /var/autofs/work2

(UCLA-Mathnet actually made this mistake in the distant past.)  Suppose one 
server is down and the other isn't, and a user hosted on the working server 
tries to log in.  Let's say his homedir is /var/autofs/home2/luser.  
Several "pwd" operations can't be avoided, and it needs to stat all 
memebers of /var/autofs to find out which name goes with the inode 
which is the parent of the homedir.  Frequently it will stat a mount point
from the dead server before getting the right one, and suffer a 30 
second timeout, several times.  Hiss, boo.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
