From: Greg Bradner <gregb@rhythm.com>
Subject: autofs v4
Date: Thu, 23 Oct 2003 09:05:34 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F97FC4E.5070809@rhythm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

It is not making the mount  points for program mounts. Any ideas?

This is from /etc/auto_maps/autofs_host_mount.pl, my program for program 
mounts.
PARGS /usr/sbin/automount --timeout 60 /n program 
/etc/auto_maps/autofs_host_mount.pl vers=2,mountvers=2 
rsize=32768,wsize=32768
TEST = --timeout
TEST = 60
TEST = /n
BASEDIR = /n (2)
MOUNT OPTS: -o  vers=2,mountvers=2,rsize=32768,wsize=32768
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/etc 
/n/linn/etc
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/usr 
/n/linn/usr
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/local/b 
/n/linn/local/b
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/local/a 
/n/linn/local/a
/n/linn

[34] lid2:/# tail /var/log/messages
Oct 23 08:55:50 lid2 am_mount[11720]: am_mount /n/linn/usr
Oct 23 08:55:50 lid2 automount[2281]: attempting to mount entry /n/linn
Oct 23 08:55:50 lid2 am_mount[11725]: am_mount /n/linn/etc
Oct 23 08:55:50 lid2 am_mount[11726]: am_mount /n/linn/usr
Oct 23 08:55:50 lid2 am_mount[11727]: am_mount /n/linn/local/b
Oct 23 08:55:50 lid2 am_mount[11728]: am_mount /n/linn/local/a
Oct 23 08:55:50 lid2 automount[11722]: >> mount: wrong fs type, bad 
option, bad superblock on ,
Oct 23 08:55:50 lid2 automount[11722]: >>        or too many mounted 
file systems
