From: Ian Kent <raven@themaw.net>
Subject: Re: "simultaneous" mounts causing weird behavior
Date: Wed, 5 Nov 2003 08:46:56 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311050836180.8092-100000@wombat.indigo.net.au>
References: <1067956957.2208.13.camel@aluminum>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1067956957.2208.13.camel@aluminum>
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
To: Matthew Mitchell <matthew@geodev.com>
Cc: autofs@linux.kernel.org

On Tue, 4 Nov 2003, Matthew Mitchell wrote:

> Hello,
>
> On some SMP processing nodes we have in our cluster we are noticing the
> following odd behavior.  It seems like there might be a race condition
> somewhere in automount that results in the same (in this case NFS)
> device mounted twice on the same mountpoint.
>
> In our case we have a (closed-source, vendor provided) data processing
> app that runs 2-4 processes at a time on each of these nodes.  The
> processes communicate via MPI.  What ends up happening is that each of
> them tries to read data from these NFS-mounted volumes at exactly the
> same time, and sometimes (about one node out of every 10) we get unlucky
> and the disk gets double-mounted.
>
> Here is the entry from the messages file where the disks are getting
> mounted:
> Nov  2 16:52:53 fir32 automount[674]: attempting to mount entry
> /etvf/data0
> Nov  2 16:52:53 fir32 automount[674]: attempting to mount entry
> /etvf/data0
>
> (Yes, there are two of them.)
>
> /proc/mounts looks as follows:
>
> rootfs / rootfs rw 0 0
> /dev/root / ext3 rw 0 0
> /proc /proc proc rw 0 0
> usbdevfs /proc/bus/usb usbdevfs rw 0 0
> /dev/hda1 /boot ext3 rw 0 0
> none /dev/pts devpts rw 0 0
> none /dev/shm tmpfs rw 0 0
> automount(pid626) /etvp autofs rw 0 0
> automount(pid674) /etvf autofs rw 0 0
> automount(pid695) /nova autofs rw 0 0
> automount(pid589) /home autofs rw 0 0
> automount(pid601) /etve autofs rw 0 0
> automount(pid649) /etvo autofs rw 0 0
> odin:/export/users /home/users nfs
> rw,v3,rsize=8192,wsize=8192,hard,intr,tcp,lock,addr=odin 0 0
> pecan:/etvp/data8 /etvp/data8 nfs
> rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,addr=pecan 0 0
> fenris:/etvf/data0 /etvf/data0 nfs
> rw,v3,rsize=8192,wsize=8192,hard,intr,tcp,lock,addr=fenris 0 0
> fenris:/etvf/data0 /etvf/data0 nfs
> rw,v3,rsize=8192,wsize=8192,hard,intr,tcp,lock,addr=fenris 0 0
> odin:/export/prog /home/prog nfs
> rw,v3,rsize=8192,wsize=8192,hard,intr,tcp,lock,addr=odin 0 0
>
> The mount in question is "fenris:/etvf/data0".  (We have an automount
> process running for each of our big disk servers.  Each has a different,
> NIS provided map of disks to serve.)
>
> Something odd, possibly related: when you use 'df', you get a strange
> message:
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/hda3             74754492   1524216  69432912   3% /
> /dev/hda1               101089      6976     88894   8% /boot
> none                   2069232         0   2069232   0% /dev/shm
> df: `/tmp/autofs-bind-3fa390d2-259/dir2': No such file or directory
> odin:/export/users    44038844  39681000   4357844  91% /home/users
> pecan:/etvp/data8    872779558 682596377 181455386  79% /etvp/data8
> fenris:/etvf/data0   1662282384 1409676396 168166904  90% /etvf/data0
> fenris:/etvf/data0   1662282384 1409676396 168166904  90% /etvf/data0
> odin:/export/prog     31456316  18282432  13173884  59% /home/prog

The /tmp entry is caused by mount failing to handle overlapping requests.
Aaron Ogden and I have been there recently with autofs v4.

The overlapping mount problem is likely causing the other problem as well.
I put some altogether ugly code, which shouldn't work at all, but seems
to, into autofs v4 to deal with this. In fact I hated it so much, I
removed it at one point and Aaron was horrified to find everything broken
again.

Also, since the bind mount was only a test I added the -n flag to it to
get rid of the /tmp mount entries. Maybe Peter would like to try something
like that in autofs v3.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
