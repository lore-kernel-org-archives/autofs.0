From: raven@themaw.net
Subject: Re: autofs-4.1 slow to mount
Date: Thu, 13 May 2004 23:00:01 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405132253300.13693@donald.themaw.net>
References: <200405101900.i4AJ09pH031586@hera.kernel.org>
	<40A0CC37.3080003@gxt.com>
	<Pine.LNX.4.58.0405130639030.16060@www.wm7d.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405130639030.16060@www.wm7d.net>
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
To: Joseph Mack NA3T <jmack@wm7d.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 13 May 2004, Joseph Mack NA3T wrote:

> Linux-2.4.26, autofs4 as module, libc-2.3.2
> 
> mounting zip disk by autofs
> 
> with automount-4.0.0pre10, the disk mounts in 1sec
> 
> (interval between "attempting to mount entry /removable/zip"
> and "kernel: kjournald starting. Commit interval 5 seconds"
> messages)
> 
> with automount-4.1.2 the same interval is 11 secs.

Are you using the latest replicated server fixes patch?
This aounds like a problem that should have been fixed.
What does your map entry look like please?

> 
> on another similar machine, automount-4.1.2 won't mount
> the zip disk, giving "e2fsck: need terminal for interactive repairs".
> Running fsck from the command line shows a clean zip disk.
> automount-4.0.0pre10 mounts zip disk OK.

Mmm. That's not good.

Do you get a message like
mouny(ext2) /path/to/mount : filesystem needs repair, won't mount

I'll see what I can find. I wonder what e2fsck is returning????

Ian
