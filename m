From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Thu, 1 Jan 2004 21:12:15 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0401012101380.6621-100000@raven.themaw.net>
References: <Pine.LNX.4.53.0311261008100.2363@xena.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0311261008100.2363@xena.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>


I've just been re-reading your mail after looking at your patch ....

On Wed, 26 Nov 2003, Jim Carter wrote:

> 
> A possible non-kludge fix might go like this.  The daemon walks the tree of
> (its own sub-) mounts and for each, it may or may not make a judgment that
> the mount might (or might not) be expired.  On likely-looking mounts, it
> asks the driver "is this expired" or "when was it really last used"?
> If the mount is really expired, the daemon attempts to dismounts it.  But,
> if the filesystem fails to go away, the daemon will not return to it until
> the next USR1 or ALRM, avoiding the infinite loop.

I'm thinking I like this approach.
It may be fairly straight forward to do and should be quite effective.

This approach has the advantage that it can be done entirely in the 
daemon and should also work for older versions of the kernel module.

> 
> Here's another possibility: you shouldn't go around updating the atime of
> the mounted filesystem, but the mount point belongs to the driver, and if
> you stat the mount point's inode, the driver can provide the last access
> time (what it uses to decide about expiration) as the atime of that inode.
> Then the daemon can do the entire logic of picking expired mounts.  That
> would be preferable as design, and it avoids all infinite loop
> possibilities.  Presumably to stat the inode, you would open(2) the mount
> point directory before mounting on it, and then use lstat.  I hope that
> will actually work.  Of course, both of these fixes require protocol
> changes in the driver.

This sounds a bit complicated considering what needs to be achieved. I 
keep thinking that there would be changes needed in the kernel module for 
this.

Have you had any other thoughts on this?

Ian
