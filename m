From: canon@nersc.gov
Subject: Re: fsck and already mounted filesystems
Date: Sun, 30 May 2004 19:53:33 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200405310253.i4V2rXGT021322@pookie.nersc.gov>
References: <Pine.LNX.4.58.0405301259240.18235@donald.themaw.net>
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: Your message of "Sun, 30 May 2004 13:08:34 +0800."
             <Pine.LNX.4.58.0405301259240.18235@donald.themaw.net> 
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org


Ian,

I'm not sure I'm following your message.  So if my response
doesn't make since, I may have misunderstood you.

I changed the entry to -fstype=auto and it looks like the
fsck didn't get called.  I guess this is the mount_generic
portion?  So this did work.  I didn't know about the auto
option.

My original test fix was just to have the daemon ignore the
failed fsck and attempt the mount.  This would work, since
Linux allows multiple mounts of a file system.  My
proposed solution would be for the automounter to check
if the file system was already mounted.  If so, it would
skip the fsck and just go on to the mount.  Also having some
option flags in the map entry to skip the fsck would be useful.

Thanks,

--Shane

> On Fri, 28 May 2004, Ian Kent wrote:
> 
> Had a brief look at this.
> 
> So far all I can see is that, when using the above it uses the 
> mount_generic module which doesn't do an fsck and mounts the fs. 
> This is probably not what we want but is what happens now.
> 
> If ext2 is specified, with appropriate changes to allow for fsck failures, 
> then after passing the mount fails with an already mounted message?
> 
> Anymore thoughts.
> 
> Ian
> 
