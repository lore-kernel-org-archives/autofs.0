From: Joseph Mack NA3T <jmack@wm7d.net>
Subject: autofs-4.1 slow to mount
Date: Thu, 13 May 2004 07:09:55 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405130639030.16060@www.wm7d.net>
References: <200405101900.i4AJ09pH031586@hera.kernel.org>
	<40A0CC37.3080003@gxt.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40A0CC37.3080003@gxt.com>
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

Linux-2.4.26, autofs4 as module, libc-2.3.2

mounting zip disk by autofs

with automount-4.0.0pre10, the disk mounts in 1sec

(interval between "attempting to mount entry /removable/zip"
and "kernel: kjournald starting. Commit interval 5 seconds"
messages)

with automount-4.1.2 the same interval is 11 secs.

on another similar machine, automount-4.1.2 won't mount
the zip disk, giving "e2fsck: need terminal for interactive repairs".
Running fsck from the command line shows a clean zip disk.
automount-4.0.0pre10 mounts zip disk OK.

Thanks Joe

-- 
Joseph Mack NA3T EME(B,D), FM05lw North Carolina
jmack (at) wm7d (dot) net - azimuthal equidistant map
generator at http://www.wm7d.net/azproj.shtml
Homepage http://www.austintek.com/ It's GNU/Linux!
