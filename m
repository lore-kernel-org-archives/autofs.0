From: Olivier Galibert <galibert@pobox.com>
Subject: Race condition with 4.1.4 and a symlink
Date: Wed, 17 Jan 2007 17:16:57 +0100
Message-ID: <20070117161657.GA66984@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Fedora Core 5 on x86_64, autofs-4.1.4-29, kernel-2.6.18-1.2200.fc5

The situation:
- /people is on autofs, /people/gadda points to m179:/disk05/disk11/gadda
- /hosts in on autofs so that /hosts/host/disk mounts host:/disk
- m179:/disk05/disk11/gadda/normalisation (aka /people/gadda/normalisation) is
  a symlink to /hosts/m179/disk03/gadda/lemonde

A script in /people/gadda/normalisation that opens and closes files
repeatedly in normalisation has random ENOENT failures.  Crossing a
strace and a tcpdump gave me this trace:

 01:49:17.429638 open("/people/gadda/normalisation/bugs2.norm")
 01:49:17.429703 getattr(bugs2.norm)
 01:49:17.430163 getattr ok
 01:49:17.432830 open ok
 01:49:17.443308 open("/people/gadda/normalisation/bugs2.norm")
 01:49:17.443360 getattr(bugs2.norm)
 01:49:17.443798 getattr ok
 01:49:17.446893 open ok
 01:49:17.451674 open("/people/gadda/normalisation/bugs2")
 01:49:17.451752 getattr(bugs2)
 01:49:17.452232 getattr ok
 01:49:17.452268 open ok
 01:49:17.457657 open("/people/gadda/normalisation/bugs2.norm")
 01:49:17.457706 getattr(bugs2.norm)
 01:49:17.458152 getattr ok
 01:49:17.465475 open ok
 01:49:17.473659 open("/people/gadda/normalisation/bugs2")
 01:49:17.473707 getattr(bugs2)
 01:49:17.474156 getattr ok
 01:49:17.474189 open ok
 01:49:17.478682 open("/people/gadda/normalisation/bugs2.norm")
 01:49:17.478728 getattr(bugs2.norm)
 01:49:17.479180 getattr ok
 01:49:17.479407 open ok
 01:49:17.480524 open("/people/gadda/normalisation/bugs2")
 01:49:17.480569 getattr(bugs2)
 01:49:17.481018 getattr ok
 01:49:17.481513 open ok
 01:49:17.486468 start TCP to sunrpc to do the getport
 01:49:17.487203 open("/people/gadda/normalisation/bugs2")
 01:49:17.488679 getport(MOUNT)
 01:49:17.491467 getport reply
 01:49:17.492038 mount_null
 01:49:17.492822 mount_null reply
 01:49:17.496420 umount("/disk05/disk11/gadda") (mounted on /people/gadda)
 01:49:17.499833 umount ok
 01:49:17.525547 getattr(general.log)
 01:49:17.525596 open fail ENOENT  <---- script failure here
 01:49:17.526026 getattr ok
 01:49:17.526201 write(general.log)
 01:49:17.526421 getattr(general.log)
 01:49:17.527115 getattr ok
 01:49:17.529122 write ok
 01:49:17.529170 write(general.log)
 01:49:17.531651 write ok
 01:49:17.575045 getattr(general3.cmd)
 01:49:17.575515 getattr ok
 01:49:17.620203 getport(NFS)
 01:49:17.620728 getport reply
 01:49:17.620747 nfs_null
 01:49:17.621167 nfs_null ok
 01:49:17.621184 getport(MOUNT)
 01:49:17.621682 getport reply
 01:49:17.621699 mount_null
 01:49:17.622182 mount_null ok
 01:49:17.622209 mount("/disk05/disk11/gadda")
 01:49:17.626987 mount ok
 [...]
 01:49:17.685213 readlink("normalisation")
 01:49:17.685678 readlink reply "/hosts/m179/disk03/gadda/lemonde"

Looks like having the link looked up all the time does not count as
being busy for a mountpoint (not that surprising), and for that reason
autofs unmounts on timeout.  It asks for the remount fast but there is
a window between unmounting and remounting where opens through the
link fail.

Is there something I can do?

  OG.
