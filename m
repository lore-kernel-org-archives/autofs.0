From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: 	Is it normal for autofs to remount a file system more
	than once?
Date: Thu, 02 Sep 2004 22:48:14 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4137DB6E.3020204@sun.com>
References: <41379549.2040305@physics.ucsd.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <41379549.2040305@physics.ucsd.edu>
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
To: Terrence Martin <tmartin@physics.ucsd.edu>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Terrence Martin wrote:
> Hi,
>
> I am not sure if this is related to my NFS mount hanging problems, but I
> have noticed that autofs will often remount a file system multiple
> times.  Is this normal? I think I have pretty straight forward auto.
> files....
>
> Terrence Martin
> UCSD Physics
>
> mount

>
> df


Both of these tools get their mount information from /etc/mtab, a plain
text file.  This file can get out of sync for a variety of reasons
unfortunately.  Some common reasons I usually see are:

- - You may be using multiple namespaces.  [u]mount(8) doesn't know how to
handle this.
- - [u]mount(8) has trouble getting a lock on the file, so it has trouble
updating.

The only way to see an accurate picture of your mount tree is to look at
/proc/mounts.  If this file has multiple entries for your automounted
filesystem, then there indeed is a problem.

Btw, you didn't mention which kernel(+patches?) and automount version
are you using.  That would help :)

Thanks,

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBN9ttdQs4kOxk3/MRAnxeAJ9EU/vVu0J2OIl8hjFPWWkGd6IvMACeMkY5
VUKsB/GK2poT2NBx5AEZD30=
=AqLw
-----END PGP SIGNATURE-----
