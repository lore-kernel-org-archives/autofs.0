From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Performance of autofs/amd-managed directory
Date: Wed, 26 May 2004 08:47:09 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40B491CD.1070707@sun.com>
References: <20040526030234.47115.qmail@web20025.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <20040526030234.47115.qmail@web20025.mail.yahoo.com>
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
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kenny Simpson wrote:
> What is the performance penalty for write access to files in a managed
> directory vs. a fstab entry?
> I have a program that is very sensitive to write latency, and am being
> pressured to use amd or automount to access a NAS instead of my trusty
fstab
> entry.
>
> My app uses a transactional log file that resides on a NAS.  I'd
prefer to keep
> a simple fstab entry and use O_DIRECT to access the file, but if there
is no
> penalty, I would switch.  Does O_DIRECT have meaning for automount or
> amd-managed files?  (isn't amd user-space, so it would need to copy data
> anyway?)
>

As Ian already pointed out, automount simply mounts filesystems in place
when requested and does not affect any file access fast-paths.

Similarly, amd also simply mounts the NFS filesystems, albeit in a
different location and uses symlinks to redirect the user.  This has the
side-effect that a chdir('..') will drop you in a different directory.

As long as you have O_DIRECT support in your NFS client, neither
solution will have any real adverse effects on your transactional log.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAtJHNdQs4kOxk3/MRAuBmAJ9Ax8CPblvJOiil5CNvFJYerkyMSACeL3wI
ckLOQO+1oIecf0q2Ujoqwe8=
=Z5rB
-----END PGP SIGNATURE-----
