From: Paul Raines <raines@nmr.mgh.harvard.edu>
Subject: rm hangs on symlinks to down mount points
Date: Tue, 30 Dec 2003 16:47:24 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312301639450.24097-100000@gate.nmr.mgh.harvard.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org


I have RedHat7.3 and RedHat9 systems with autofs-3.1.7 and
2.4.20 kernels on all.

Lets say for instance that /autofs/foobar is an automounted mount point
on server foobar and foobar is down.  On your client box you have
a symlink on your local disk as such:

  linkfile -> /autofs/foobar/somefile

If you try to delete linkfile, it hangs forever.  Seems to never timeout
or work.   Doing a strace shows it hanging to a system stat() call
on the pointed to file.

First, it seems fundamentally wrong that doing an unlink() on a symlink
causes a stat() call on the pointed to file.  Seems a huge waste.

One interesting thing, on RH7.3 if the above linkfile is an a directory
and you do a 'rm -rf' on that directory, it works.  On RH9, it still
hangs.

BTW, is there anyway outside a kernel recompile to configure how
long it takes for an access to a mount point on a down server to
timeout?


-- 
---------------------------------------------------------------
Paul Raines                   email: raines@nmr.mgh.harvard.edu
MGH/MIT/HMS Athinoula A. Martinos Center for Biomedical Imaging
149 (2301) 13th Street        Charlestown, MA 02129	USA   
