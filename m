From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Automounting on /. deleting entire FS!
Date: Mon, 11 Oct 2004 11:39:18 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16746.43302.434588.743693@segfault.boston.redhat.com>
References: <20041011152938.GL21585@lego.fgm.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20041011152938.GL21585@lego.fgm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Martin Fick <fick@fgm.com>
Cc: autofs@linux.kernel.org, Martin Fick <fick@lego.fgm.com>

==> Regarding [autofs] Automounting on /. deleting entire FS!; Martin Fick <fick@fgm.com> adds:

fick> Yup, The #$@!! sys admin of my home machine, (that's me,) decided to
fick> fool the automounter into using '/' to mount his partiions on and
fick> lost his entire filesystem.  Pouff, everything that was not a mounted
fick> partition gone!!!  Now I realize that I shouldn' have been deceitfull
fick> to the poor little autofs daemon, I told hime to use '/.' since he
fick> balked at '/', but did I really deserve this?

fick> So a few questions:

fick>    1) Why does the automounter delete files (or entire filesystems)?

It doesn't, it simply mounted over your '/' mountpoint.  If you umount /,
you get what was there before (I'm guessing.  never really overmounted /
before).

fick>    2) How can one go about automounting a cdrom on /cdrom?

You could automount it in /misc/cdrom, and create a symlink.

# ln -sf /misc/cdrom /cdrom

fick>    3) Should this be fixed? i.e. if it's bad to use slash, then
fick> should any other path that works out to be slash be checked also? :)

Probably.

fick>    4) Are my files really gone?  Is there anything I can do to
fick> recover? (it is an ext3 fs, not ext2)

No, see the answer to 1) above.  If you can't simply umount /, then you can
boot in single user mode.  This shouldn't start the automounter.  Then, you
can edit your automount config files to not overmount /.  You should be
good to go after that.

fick>   Still weeping/laughing,

You gave me a chuckle.

-Jeff
