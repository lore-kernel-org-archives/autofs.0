From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Thu, 1 Jan 2004 14:49:09 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0401011415290.2977@xena.cft.ca.us>
References: <Pine.LNX.4.44.0401012101380.6621-100000@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401012101380.6621-100000@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 1 Jan 2004, Ian Kent wrote:
> > asks the driver "is this expired" or "when was it really last used"?
-- snip --
> This approach has the advantage that it can be done entirely in the
> daemon and should also work for older versions of the kernel module.

Definitely an advantage that it can be done entirely in the daemon.  But I
didn't notice if you can make the older (and newer) drivers divulge the
last access time.  If that will work, great.  I was just reading some of
the sources (see below), and I didn't spot the reference to last_usage.

> > possibilities.  Presumably to stat the inode, you would open(2) the mount
> > point directory before mounting on it, and then use lstat.  I hope that
> > will actually work.  Of course, both of these fixes require protocol
> > changes in the driver.
>
> This sounds a bit complicated considering what needs to be achieved. I
> keep thinking that there would be changes needed in the kernel module for
> this.

Oops, I meant fstat (works on open file descriptors) rather than lstat.

Complicated?  The module has to return something when you stat the inode,
and a newly improved module can easily fill in the last used time rather
than whatever it provides now.  Presently (kernel 2.4.20) in
fs/autofs/inode.c, autofs_read_inode() puts CURRENT_TIME in all of mtime,
atime, ctime.  I don't quite see how to get from its argument (struct
inode*) to struct autofs_dir_ent* which has the last_usage field, but it
should be doable without a lot of drama.

Also, with autofs_oz_mode(), the userspace daemon would not even need to do
the open() - fstat() thing; it should be getting the mount point's inode
directly, and not that which is mounted on it.  I think.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
