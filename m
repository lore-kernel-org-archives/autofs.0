From: Paul Raines <raines@nmr.mgh.harvard.edu>
Subject: Re: rm hangs on symlinks to down mount points
Date: Wed, 31 Dec 2003 09:32:22 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312310928400.24097-100000@gate.nmr.mgh.harvard.edu>
References: <20031231115815.44107c3d.vogelchr@vogel.cx>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20031231115815.44107c3d.vogelchr@vogel.cx>
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
To: Christian Vogel <vogelchr@vogel.cx>
Cc: autofs@linux.kernel.org

On Wed, 31 Dec 2003, Christian Vogel wrote:
> have you ever tried to compile a automount daemon that uses not
> /bin/mount and /bin/umount but special shellscripts? You can change the
> defines in $autofs_source/include/config.h.
> 
> There you could probably apply all the magic you want to the process of
> mounting/unmounting filesystems...

That sounds like a very good idea.  Mainly, I would want to replace
umount with a script that does a 'umount -f' if a regular umount fails.
Better yet, it could read /etc/mtab for the name of the server and ping
it and do a 'umount -f' from the beginning if it fails to ping.
