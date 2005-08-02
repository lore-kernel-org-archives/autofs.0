From: Michael Marion <mmarion@qualcomm.com>
Subject: Here's a new really odd auto.net bug
Date: Tue, 2 Aug 2005 13:52:54 -0700 (PDT)
Message-ID: <200508022052.j72Kqs8F015586@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: INLINE
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Had a similar problem in the past that turned out to be my fault, wrong
/etc/auto.net script in place.  Today, I'm seeing similar mount issue, but
I've made sure the right script is in place.

If a host has >1 export, it works sort of as expected:
kydland mmarion {728}$ /etc/auto.net cornholio
-fstype=nfs,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,nodev,nosuid
\
        /local/mnt cornholio:/local/mnt \
        /tftpboot cornholio:/tftpboot
kydland mmarion {729}$ ls /net/cornholio
local  tftpboot
kydland mmarion {730}$ mount | grep cornholio
cornholio:/local/mnt on /net/cornholio/local/mnt type nfs
(rw,nosuid,nodev,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,addr=129.46.234.38)

but /tftpboot isn't there and debug/verbose output in syslog shows:
Aug  2 13:43:01 kydland automount[32588]: attempting to mount entry
/net/cornholio
Aug  2 13:43:01 kydland kernel: nfs_get_root: getattr error = 116
Aug  2 13:43:01 kydland kernel: nfs_read_super: get root inode failed
Aug  2 13:43:01 kydland kernel: nfs_get_root: getattr error = 116
Aug  2 13:43:01 kydland kernel: nfs_read_super: get root inode failed
Aug  2 13:43:01 kydland automount[581]: >> mount: wrong fs type, bad option,
bad superblock on cornholio:/tftpboot,
Aug  2 13:43:01 kydland automount[581]: >>        or too many mounted file
systems
Aug  2 13:43:01 kydland automount[581]: mount(nfs): nfs: mount failure
cornholio:/tftpboot on /net/cornholio/tftpboot

trying to ls that tftpboot path gives more logs:
Aug  2 13:43:54 kydland automount[32588]: attempting to mount entry
/net/cornholio/tftpboot
Aug  2 13:43:54 kydland automount[631]: >> showmount: can't get address for
cornholio/tftpboot
Aug  2 13:43:54 kydland automount[631]: lookup(program): lookup for
cornholio/tftpboot failed
Aug  2 13:43:54 kydland automount[631]: failed to mount
/net/cornholio/tftpboot
Aug  2 13:43:54 kydland automount[631]: umount_multi: no mounts found under
/net/cornholio/tftpboot
Aug  2 13:43:54 kydland automount[631]: rm_unwanted: /net/cornholio/tftpboot
Aug  2 13:43:54 kydland automount[32588]: attempting to mount entry
/net/cornholio/tftpboot
Aug  2 13:43:54 kydland automount[643]: >> showmount: can't get address for
cornholio/tftpboot
Aug  2 13:43:54 kydland automount[643]: lookup(program): lookup for
cornholio/tftpboot failed
Aug  2 13:43:54 kydland automount[643]: failed to mount
/net/cornholio/tftpboot
Aug  2 13:43:54 kydland automount[643]: umount_multi: no mounts found under
/net/cornholio/tftpboot


Even worse, trying to mount a host with a single export mounts at the wrong
place (this is similar to what I saw before):
kydland mmarion {733}$ /etc/auto.net tau
-fstype=nfs,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,nodev,nosuid
\
        /local/mnt tau:/local/mnt
kydland mmarion {734}$ ls /net/tau
licenses  lost+found  mlb  usr2  workspace
kydland mmarion {735}$ mount | grep tau
tau:/local/mnt on /net/tau type nfs
(rw,nosuid,nodev,rsize=8192,wsize=8192,hard,intr,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,addr=129.46.234.39)

It should have mounted as /net/tau/local/mnt not /net/tau

and syslog debug output shows:
Aug  2 13:45:34 kydland automount[32588]: attempting to mount entry /net/tau
Aug  2 13:45:34 kydland automount[977]: mount(nfs): host /local/mnt: lookup
failure
Aug  2 13:45:34 kydland automount[977]: >> nfs server reported tcp not
available, falling back to udp

Host has been up for 61 days, and I could swear it was ok when first booted 
(though I could be wrong).

Module loaded is autofs4, not autofs... patched up to 61 days ago.. :)
automount daemon is 4.1.4 with patches from same timeframe.. added patches:
autofs-4.1.4-misc-fixes.patch
autofs-4.1.4-multi-parse-fix.patch
autofs-4.1.4-non-replicated-ping.patch 

Seeing same effect on multiple 64bit sles9 hosts, but same level of
daemon/patches and exact same kernel (built from exact same src.rpm anyway) on 
a 32bit host (with same /etc/auto.net script) is working fine.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Marge: "Homer, I couldn't help overhearing you warp Bart's mind."
Homer: "And?"
==> The Simpsons
