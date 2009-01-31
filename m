From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Segfaults in lookup_hosts.c, probably caused by
Date: Sat, 31 Jan 2009 23:05:38 +0100
Message-ID: <4984CB32.8080709@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hello list.

I just released a 5.0.4 package with all current patches applied, and I 
had this report:
https://qa.mandriva.com/show_bug.cgi?id=47423

I can reproduce the issue with this simple master map:
[root@oberkampf guillaume]# cat /etc/autofs/auto.master
/net	-hosts

Here is the logs excerpt:
Jan 31 22:50:28 oberkampf automount[7872]: Starting automounter version 
5.0.4, master map auto.master
Jan 31 22:50:28 oberkampf automount[7872]: using kernel protocol version 
5.01
Jan 31 22:50:28 oberkampf automount[7872]: lookup_nss_read_master: 
reading master files auto.master
Jan 31 22:50:28 oberkampf automount[7872]: parse_init: parse(sun): init 
gathered global options: (null)
Jan 31 22:50:28 oberkampf automount[7872]: lookup_read_master: 
lookup(file): read entry /net
Jan 31 22:50:28 oberkampf automount[7872]: lookup_read_master: 
lookup(file): read entry +auto.master
Jan 31 22:50:28 oberkampf automount[7872]: lookup_nss_read_master: 
reading master files auto.master
Jan 31 22:50:28 oberkampf automount[7872]: parse_init: parse(sun): init 
gathered global options: (null)
Jan 31 22:50:28 oberkampf automount[7872]: lookup(file): failed to read 
included master map auto.master
Jan 31 22:50:28 oberkampf automount[7872]: master_do_mount: mounting /net
Jan 31 22:50:28 oberkampf automount[7872]: automount_path_to_fifo: fifo 
name /var/run/autofs.fifo-net
Jan 31 22:50:28 oberkampf automount[7872]: lookup_nss_read_map: reading 
map hosts (null)
Jan 31 22:50:28 oberkampf automount[7872]: parse_init: parse(sun): init 
gathered global options: (null)
Jan 31 22:50:28 oberkampf automount[7872]: remount_active_mount: trying 
to re-connect to mount /net
Jan 31 22:50:28 oberkampf automount[7872]: mounted indirect on /net with 
timeout 300, freq 75 seconds
Jan 31 22:50:28 oberkampf automount[7872]: remount_active_mount: 
re-connected to mount /net
Jan 31 22:50:28 oberkampf automount[7872]: st_ready: st_ready(): state = 
0 path /net
Jan 31 22:50:28 oberkampf automount[7872]: ghosting enabled
Jan 31 22:50:32 oberkampf automount[7872]: handle_packet: type = 3
Jan 31 22:50:32 oberkampf automount[7872]: 
handle_packet_missing_indirect: token 9, name netchaiev.zarb.org, 
request pid 7885
Jan 31 22:50:32 oberkampf automount[7872]: attempting to mount entry 
/net/netchaiev.zarb.org
Jan 31 22:50:32 oberkampf klogd: automount[7886]: segfault at 60 ip 
00007ffe0749e2f5 sp 00007ffe06413d90 error 4 in 
lookup_hosts.so[7ffe07498000+1c000]

And here is the stack trace:
#0  lookup_mount (ap=0x7ffe086b3a30, name=0x7ffe06414020 
"netchaiev.zarb.org",
     name_len=18, context=0x7ffe08698820) at lookup_hosts.c:151
151			cache_unlock(me->mc);
Missing debug package(s), you should install: gcc-debug-4.3.2-5mnb2.x86_64
(gdb) bt
#0  lookup_mount (ap=0x7ffe086b3a30, name=0x7ffe06414020 
"netchaiev.zarb.org",
     name_len=18, context=0x7ffe08698820) at lookup_hosts.c:151
#1  0x00007ffe08280088 in lookup_nss_mount (ap=0x7ffe086b3a30, source=0x0,
     name=0x7ffe06414020 "netchaiev.zarb.org", name_len=18) at lookup.c:897
#2  0x00007ffe08278df1 in do_mount_indirect (arg=0x7ffe086bc700)
     at indirect.c:760
#3  0x00007ffe07e39263 in start_thread () from /lib64/libpthread.so.0
#4  0x00007ffe0779376d in clone ()
     at ../sysdeps/unix/sysv/linux/x86_64/clone.S:112

As the line where the segfault occurs was added by 
autofs-5.0.4-fix-negative-cache-non-existent-key.patch, I strongly 
suspect it to be the cause of the problem. I tried to rebuild the 
package with just this patch removed, but it would implies to rediff all 
others because of CHANGELOG files changes, and I was too lazy to do it :P

-- 
BOFH excuse #202:

kernel panic: write-only-memory (/dev/wom0) capacity exceeded.
