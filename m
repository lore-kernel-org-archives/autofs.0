From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: [patch] buffer overflow, failure to auto-dismount,
 log file diarrhea
Date: Fri, 9 Jan 2004 13:43:22 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0401091330490.9335@simba.math.ucla.edu>
References: <Pine.LNX.4.44.0401031051350.4413-100000@raven.themaw.net>
	<3FFF1CCF.2070904@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FFF1CCF.2070904@sun.com>
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
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

On Fri, 9 Jan 2004, Mike Waychison wrote:

> Jim Carter wrote:
> >No, I meant that when the sys_stat method fills in the mode field of
> >the returning stat structure, it would be reported as 555 for a busy
> >filesystem, or 755 if it looks idle and dismountable.  The mode field as
> >seen by the VFS layer can stay at 755.  This would be when statting
> >autofs's directory inode, not whatever is mounted on it.

> This hijacking of the st_mode is just that, hijacking.  You'd be
> changing the mode of the directory on the NFS filesystem..  This
> wouldn't work well in the VFS when it tries to check permissions, but it
> also wouldn't work for more than one NFS client accessing the same
> filehandle.

There are 2 inodes here: the mount point (owned by autofs) and what's
mounted on it.  We mustn't monkey with the mountee's data, of course.  I'm
talking about statting the mount point itself.  You can't do that by name,
but in a prior discussion we were talking about opening the mount point
before the mount, and later doing fstat on the file descriptor.  HPA
mentioned providing a readlink method and doing lstat on the mount point by
name, which would intercept the path walk before the mountee was noticed.

So the caller gets the mode of the mount point, which autofs can create or
interpret any way it wants, rather than the mountee's data.

> >I would really like it if, when autofs decided to forcibly unmount, it
> >could kill the using processes, as in "fuser -k -m /net/host/mountpoint".
> >Actually this is a general issue for unmount(8), not specific to autofs.
> >But one wonders whether fuser is going to run wild...

> Like HPA already mentioned, this is bad.  I don't even think you could
> reliably detect this.

Agreed, you wonder if the right processes are going to be picked.  But...
"Ask for the moon; they might give it to you."  In the present case it
should be possible to stick the fuser execution into the autofs shutdown
script -- it already is aware that unmounts haven't finished, and it
probably knows or can find out which filesystems are involved.

P.S.  "Be careful what you wish for; you might get it."

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
