From: Joseph Mack NA3T <jmack@wm7d.net>
Subject: Re: autofs-4.1 slow to mount
Date: Thu, 13 May 2004 08:38:49 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405130835380.21923@www.wm7d.net>
References: <200405101900.i4AJ09pH031586@hera.kernel.org>
	<40A0CC37.3080003@gxt.com>
	<Pine.LNX.4.58.0405130639030.16060@www.wm7d.net>
	<Pine.LNX.4.58.0405132253300.13693@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405132253300.13693@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 13 May 2004 raven@themaw.net wrote:

> Are you using the latest replicated server fixes patch?
> This aounds like a problem that should have been fixed.

will go try them

> What does your map entry look like please?

auto.master

/removable	/etc/auto.removable

auto.removable

zip	-fstype=ext3	:/dev/zip


> Mmm. That's not good.
>
> Do you get a message like
> mouny(ext2) /path/to/mount : filesystem needs repair, won't mount

ah yes. I found it in syslog, I was looking at debug and messages and
didn't see it.

> I'll see what I can find. I wonder what e2fsck is returning????

running e2fsck 1.32

Thanks

Joe

-- 
Joseph Mack NA3T EME(B,D), FM05lw North Carolina
jmack (at) wm7d (dot) net - azimuthal equidistant map
generator at http://www.wm7d.net/azproj.shtml
Homepage http://www.austintek.com/ It's GNU/Linux!
