From: Ian Kent <raven@themaw.net>
Subject: Re: cross automount issue
Date: Fri, 7 Apr 2006 23:47:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0604072342530.24984@wombat.indigo.net.au>
References: <Pine.LNX.4.64.0604062047510.13380@q7.q7.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0604062047510.13380@q7.q7.com>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

On Thu, 6 Apr 2006, Joe Pruett wrote:

> maybe there is a better way to do this, so i'll lay out my plan first, 
> then my problem, and then my solution.
> 
> to avoid 100s or 1000s of nfs mounts i would like to have one mount per 
> exported file system and then bind mounts (or symlinks) for each directory 
> within each mount point.  like so:
> 
> real mounts:
> /disks/foo.0 -> foo:/0
> /disks/foo.1 -> foo:/1
> /disks/bar.0 -> bar:/0
> 
> etc.
> 
> and then bind mounts:
> 
> /home/user -> /disks/foo.0/user
> /home/other -> /disks/foo.1/other
> /home/another -> /disks/bar.0/another
> 
> now this kinda works, but since there is one global lock file for all 
> automount daemons the first reference to /home/user will try to touch 
> /disks/foo.0 and that will hang for 10 seconds waiting for the lock file. 
> once the real mounts are done, things work well.  and since there are a 
> few thousand entries in /home it keeps the nfs mounts from getting out of 
> control.
> 
> so my solution would be to make one lock per daemon.  that will keep each 
> daemon happy and they won't interfere with each other.
> 
> is that a reasonable idea?  is there a better way to cope with this?  i 
> know that long ago you used to be able to do things like:

Another possibility is to disable the locking.
I have a patch to do this but you must be aware that you need to 
make sure mounts' locking is not broken if you use it.

Ian
