From: Jan Engelhardt <jengelh@medozas.de>
Subject: Loopback mounting seems to fail
Date: Tue, 8 Jun 2010 14:59:26 +0200 (CEST)
Message-ID: <alpine.LSU.2.01.1006081456230.26148@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi,


I have here an openSUSE 11.2 with 2.6.33.5 and autofs-5.0.4-6.2.1.x86_64

/etc/auto.master:
+auto.master
/-	auto.direct

/etc/auto.direct:
/data/repository/sles11/x64/dvd1	-fstype=iso9660,loop,ro	/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
<and other mounts>

Now, when I try to cd into that directory, autofs tells me:

# /usr/sbin/automount -p /var/run/automount.pid -d -f &
[1] 26412
Starting automounter version 5.0.4, master map auto.master
using kernel protocol version 5.01
lookup_nss_read_master: reading master files auto.master
parse_init: parse(sun): init gathered global options: (null)
lookup_read_master: lookup(file): read entry +auto.master
lookup_nss_read_master: reading master files auto.master
parse_init: parse(sun): init gathered global options: (null)
lookup_nss_read_master: reading master nis auto.master
parse_init: parse(sun): init gathered global options: (null)
lookup(yp): read of master map auto.master failed: Request arguments bad
lookup(file): failed to read included master map auto.master
lookup_read_master: lookup(file): read entry /-
master_do_mount: mounting /-
automount_path_to_fifo: fifo name /var/run/autofs.fifo--
lookup_nss_read_map: reading map files auto.direct
parse_init: parse(sun): init gathered global options: (null)
lookup_nss_read_map: reading map nis auto.direct
parse_init: parse(sun): init gathered global options: (null)
lookup(yp): read of map /- failed: Request arguments bad
mounted direct on /data/repository/sles11/x86/sdk1 with timeout 600, freq 150 seconds
do_mount_autofs_direct: mounted trigger /data/repository/sles11/x86/sdk1
mounted direct on /data/repository/sles11/x64/sdk2 with timeout 600, freq 150 seconds
do_mount_autofs_direct: mounted trigger /data/repository/sles11/x64/sdk2
mounted direct on /F with timeout 600, freq 150 seconds
do_mount_autofs_direct: mounted trigger /F
mounted direct on /data/repository/sles11/x64/dvd2 with timeout 600, freq 150 seconds
do_mount_autofs_direct: mounted trigger /data/repository/sles11/x64/dvd2
mounted direct on /data/repository/sles11/x64/dvd1 with timeout 600, freq 150 seconds
do_mount_autofs_direct: mounted trigger /data/repository/sles11/x64/dvd1
mounted direct on /data/repository/sles11/x86/dvd2 with timeout 600, freq 150 seconds
do_mount_autofs_direct: mounted trigger /data/repository/sles11/x86/dvd2
mounted direct on /data/repository/sles11/x64/sdk1 with timeout 600, freq 150 seconds
do_mount_autofs_direct: mounted trigger /data/repository/sles11/x64/sdk1
mounted direct on /data/repository/sles11/x86/sdk2 with timeout 600, freq 150 seconds
do_mount_autofs_direct: mounted trigger /data/repository/sles11/x86/sdk2
mounted direct on /data/repository/sles11/x86/dvd1 with timeout 600, freq 150 seconds
do_mount_autofs_direct: mounted trigger /data/repository/sles11/x86/dvd1
st_ready: st_ready(): state = 0 path /-

# ls -l /data/repository/sles11/x64/dvd1
handle_packet: type = 5
handle_packet_missing_direct: token 157, name /data/repository/sles11/x64/dvd1, request pid 26425
attempting to mount entry /data/repository/sles11/x64/dvd1
lookup_mount: lookup(file): looking up /data/repository/sles11/x64/dvd1
lookup_mount: lookup(file): /data/repository/sles11/x64/dvd1 -> -fstype=iso9660,loop,ro /data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
parse_mount: parse(sun): expanded entry: -fstype=iso9660,loop,ro        /data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
parse_mount: parse(sun): gathered options: fstype=iso9660,loop,ro
parse_mount: parse(sun): dequote("/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso") -> /data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
parse_mapent: parse(sun): gathered options: fstype=iso9660,loop,ro
parse(sun): invalid location 
lookup_mount: lookup(yp): looking up /data/repository/sles11/x64/dvd1
ioctl_send_fail: token = 157
failed to mount /data/repository/sles11/x64/dvd1
ls: cannot open directory /data/repository/sles11/x64/dvd1: No such file or directory


Why is that, or did I miss something?


thanks,
Jan
