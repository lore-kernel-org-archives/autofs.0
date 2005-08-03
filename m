From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Here's a new really odd auto.net bug
Date: Wed, 3 Aug 2005 08:45:43 -0400
Message-ID: <17136.48247.23554.149449@segfault.boston.redhat.com>
References: <200508022052.j72Kqs8F015586@cornholio.qualcomm.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200508022052.j72Kqs8F015586@cornholio.qualcomm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Michael Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Here's a new really odd auto.net bug ; Michael Marion <mmarion@qualcomm.com> adds:

mmarion> Had a similar problem in the past that turned out to be my fault,
mmarion> wrong /etc/auto.net script in place.  Today, I'm seeing similar
mmarion> mount issue, but I've made sure the right script is in place.

Are you certain you are capturing all debug output?  Add an entry to
syslog.conf like so:

*.*		 /var/log/debug

Then trigger the bug and send the logs.  I think the logs you sent were
incomplete.


-Jeff

mmarion> If a host has >1 export, it works sort of as expected:
mmarion> kydland mmarion {728}$ /etc/auto.net cornholio
mmarion> -fstype=nfs,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,nodev,nosuid
mmarion> \
mmarion>         /local/mnt cornholio:/local/mnt \
mmarion>         /tftpboot cornholio:/tftpboot
mmarion> kydland mmarion {729}$ ls /net/cornholio
mmarion> local  tftpboot
mmarion> kydland mmarion {730}$ mount | grep cornholio
mmarion> cornholio:/local/mnt on /net/cornholio/local/mnt type nfs
mmarion> (rw,nosuid,nodev,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,addr=129.46.234.38)

mmarion> but /tftpboot isn't there and debug/verbose output in syslog shows:
mmarion> Aug  2 13:43:01 kydland automount[32588]: attempting to mount entry
mmarion> /net/cornholio
mmarion> Aug  2 13:43:01 kydland kernel: nfs_get_root: getattr error = 116
mmarion> Aug  2 13:43:01 kydland kernel: nfs_read_super: get root inode failed
mmarion> Aug  2 13:43:01 kydland kernel: nfs_get_root: getattr error = 116
mmarion> Aug  2 13:43:01 kydland kernel: nfs_read_super: get root inode failed
mmarion> Aug  2 13:43:01 kydland automount[581]: >> mount: wrong fs type, bad option,
mmarion> bad superblock on cornholio:/tftpboot,
mmarion> Aug  2 13:43:01 kydland automount[581]: >>        or too many mounted file
mmarion> systems
mmarion> Aug  2 13:43:01 kydland automount[581]: mount(nfs): nfs: mount failure
mmarion> cornholio:/tftpboot on /net/cornholio/tftpboot

mmarion> trying to ls that tftpboot path gives more logs:
mmarion> Aug  2 13:43:54 kydland automount[32588]: attempting to mount entry
mmarion> /net/cornholio/tftpboot
mmarion> Aug  2 13:43:54 kydland automount[631]: >> showmount: can't get address for
mmarion> cornholio/tftpboot
mmarion> Aug  2 13:43:54 kydland automount[631]: lookup(program): lookup for
mmarion> cornholio/tftpboot failed
mmarion> Aug  2 13:43:54 kydland automount[631]: failed to mount
mmarion> /net/cornholio/tftpboot
mmarion> Aug  2 13:43:54 kydland automount[631]: umount_multi: no mounts found under
mmarion> /net/cornholio/tftpboot
mmarion> Aug  2 13:43:54 kydland automount[631]: rm_unwanted: /net/cornholio/tftpboot
mmarion> Aug  2 13:43:54 kydland automount[32588]: attempting to mount entry
mmarion> /net/cornholio/tftpboot
mmarion> Aug  2 13:43:54 kydland automount[643]: >> showmount: can't get address for
mmarion> cornholio/tftpboot
mmarion> Aug  2 13:43:54 kydland automount[643]: lookup(program): lookup for
mmarion> cornholio/tftpboot failed
mmarion> Aug  2 13:43:54 kydland automount[643]: failed to mount
mmarion> /net/cornholio/tftpboot
mmarion> Aug  2 13:43:54 kydland automount[643]: umount_multi: no mounts found under
mmarion> /net/cornholio/tftpboot


mmarion> Even worse, trying to mount a host with a single export mounts at the wrong
mmarion> place (this is similar to what I saw before):
mmarion> kydland mmarion {733}$ /etc/auto.net tau
mmarion> -fstype=nfs,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,nodev,nosuid
mmarion> \
mmarion>         /local/mnt tau:/local/mnt
mmarion> kydland mmarion {734}$ ls /net/tau
mmarion> licenses  lost+found  mlb  usr2  workspace
mmarion> kydland mmarion {735}$ mount | grep tau
mmarion> tau:/local/mnt on /net/tau type nfs
mmarion> (rw,nosuid,nodev,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,addr=129.46.234.39)

mmarion> It should have mounted as /net/tau/local/mnt not /net/tau

mmarion> and syslog debug output shows:
mmarion> Aug  2 13:45:34 kydland automount[32588]: attempting to mount entry /net/tau
mmarion> Aug  2 13:45:34 kydland automount[977]: mount(nfs): host /local/mnt: lookup
mmarion> failure
mmarion> Aug  2 13:45:34 kydland automount[977]: >> nfs server reported tcp not
mmarion> available, falling back to udp

mmarion> Host has been up for 61 days, and I could swear it was ok when first booted 
mmarion> (though I could be wrong).

mmarion> Module loaded is autofs4, not autofs... patched up to 61 days ago.. :)
mmarion> automount daemon is 4.1.4 with patches from same timeframe.. added patches:
mmarion> autofs-4.1.4-misc-fixes.patch
mmarion> autofs-4.1.4-multi-parse-fix.patch
mmarion> autofs-4.1.4-non-replicated-ping.patch 

mmarion> Seeing same effect on multiple 64bit sles9 hosts, but same level of
mmarion> daemon/patches and exact same kernel (built from exact same src.rpm anyway) on 
mmarion> a 32bit host (with same /etc/auto.net script) is working fine.

mmarion> -- 
mmarion> Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
mmarion> Marge: "Homer, I couldn't help overhearing you warp Bart's mind."
mmarion> Homer: "And?"
==> The Simpsons

mmarion> _______________________________________________
mmarion> autofs mailing list
mmarion> autofs@linux.kernel.org
mmarion> http://linux.kernel.org/mailman/listinfo/autofs
