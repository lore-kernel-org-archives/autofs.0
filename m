From: peter.a.harris@exgate.tek.com
Subject: csh/cd not getting the right cwd at the mount point
Date: Fri, 9 Jul 2004 16:21:12 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <BA0E4392AD99D040885C414D992C24BE08264B56@us-bv-m11.bv.tek.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

We have a problem.  Here are the conditions:

1. Shell is (t)csh (does not happen under (ba)sh)
2. cd to an autofs fa=E7ade (e.g. /tools in our case)
3. cd relatively to the subdirectory that is the mount point. =20
   NOTE: The mount must not yet be made. (e.g. perl5.8.3)
4. cd relatively to a subdirectory in the mounted files system=20
   (e.g. bin or lib)

At this point /proc/$$/cwd will point to /fa=E7ade/subdir rather than=20
/fa=E7ade/mntpt/subdir.  To test this out, I wrote two scripts: one
is a /bin/sh script and the other is a /bin/csh script.

In this first test using the /bin/sh script, I have issued USR1=20
to all automount processes to make sure things are unmounted before
running the script.  The script checks /etc/mtab and prints
the mount status of /tools/perl5.8.3, then steps its way down
the path, doing an ls -lAF of /proc/$$/cwd after each cd.  You
can see the cwd points to the correct location each time,
regardless of the initial mount status.

myhost> /tmp/stepit.sh
Running sh
Checking for mount is NOT mounted
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25968/cwd -> /tools/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25968/cwd -> /tools/perl5.8.3/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25968/cwd -> /tools/perl5.8.3/lib/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25968/cwd -> /tools/perl5.8.3/lib/site_perl/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25968/cwd -> /tools/perl5.8.3/lib/site_perl/5.8.3/

myhost> /tmp/stepit.sh
Running sh
Checking for mount is mounted
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25979/cwd -> /tools/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25979/cwd -> /tools/perl5.8.3/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25979/cwd -> /tools/perl5.8.3/lib/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25979/cwd -> /tools/perl5.8.3/lib/site_perl/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/25979/cwd -> /tools/perl5.8.3/lib/site_perl/5.8.3/

OK, now we run the /bin/csh script, same conditions and
process as above.  Notice that when we go from /tools/perl5.8.3
to /tools/perl5.8.3/lib, cwd points to /tools/lib!  However,
if the cd does not cause the mount, things are normal.

myhost > /tmp/stepit.csh=20
Running csh -f
Checking for mount is NOT mounted
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/26029/cwd -> /tools/
**>>> lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
**>>>     /proc/26029/cwd -> /tools/perl5.8.3/
**>>> lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
**>>>     /proc/26029/cwd -> /tools/lib
**>>> lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
**>>>     /proc/26029/cwd -> /tools/lib/site_perl
**>>> lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
**>>>     /proc/26029/cwd -> /tools/lib/site_perl/5.8.3

myhost > /tmp/stepit.csh
Running csh -f
Checking for mount is mounted
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/26040/cwd -> /tools/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/26040/cwd -> /tools/perl5.8.3/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/26040/cwd -> /tools/perl5.8.3/lib/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/26040/cwd -> /tools/perl5.8.3/lib/site_perl/
lrwxrwxrwx    1 phtest   igstaff         0 Jul  9 15:06=20
    /proc/26040/cwd -> /tools/perl5.8.3/lib/site_perl/5.8.3/

Pertinent stats:
  * Red Hat EL 3.0 (no update) 2.4.21-4.ELhugemem=20
  * All available Red Hat updates have been applied EXCEPT for kernel
    autofs, and lpr updates
  * autofs: autofs-4.1.0-2 from January 04
  * autofs4: autofs4-2.4-module-20031201

This problem has just been found.  A new user tends to cd/ls/cd/ls...
and they noticed it when they would sudo and try to do a software
install.  Needless to say the install script was a mite confused at
that point.  The other users tend to use tab completion,
or know enough of the path to blow past the mount point in one cd.
In the above example, "cd /tools/perl5.8.3/lib/site_perl" works
just as you would expect.

Concurrent with this new user and on the machine they are using,
we have had two panics centered on sunrpc.  Previously we had two
panics on two other machines around deleting an inode across nfs.
I'm beginning to wonder if the problem I am reporting here is
related to the panics.

Has anyone else seen this?  I checked the autofs archives and could=20
not find any mention of such a problem.  Was I blind?

Thanks in advance...

Pete Harris                      Tektronix, Inc. / Technical Computing
MS 39-325 / PO BOX 500 / BEAVERTON OR 97077-0500
Ph: 1-503-627-3989 / Fax: 1-503-627-5587
----------------------------------------------------------------------
--          Any opinions expressed are those of the author          --
--               and may not represent Tektronix, Inc.              --
