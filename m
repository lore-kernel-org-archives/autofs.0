From: Christian Vogel <vogelchr@vogel.cx>
Subject: Re: rm hangs on symlinks to down mount points
Date: Wed, 31 Dec 2003 11:58:15 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031231115815.44107c3d.vogelchr@vogel.cx>
References: <3FF21106.4000907@zytor.com>
	<Pine.LNX.4.44.0312301903460.24097-100000@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312301903460.24097-100000@gate.nmr.mgh.harvard.edu>
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
To: Paul Raines <raines@nmr.mgh.harvard.edu>
Cc: autofs@linux.kernel.org

Hi,

have you ever tried to compile a automount daemon that uses not
/bin/mount and /bin/umount but special shellscripts? You can change the
defines in $autofs_source/include/config.h.

There you could probably apply all the magic you want to the process of
mounting/unmounting filesystems...

	Chris
