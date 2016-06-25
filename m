From: "Cyril B." <cbay@excellency.fr>
Subject: Regular deadlocks
Date: Sun, 26 Jun 2016 01:41:59 +0200
Message-ID: <3eece3d9-ea5a-ee47-100d-6fccf58f5356@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=alwaysdata.net; s=ad;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:Subject:To:From; bh=8Wkb7kT9/Mw4i2kV/WoaXPL0THilIFwXuco61Ucn2J4=;
	b=c3QRZ8SP99XJeq4mVzreQ05ijz7dWYYD5uHNTIk+5YAE0OOiAy1ueY9W29p1R5NZGrYyz57LA0uACWyERZlR5avKI0Ns/woXCx71qb/iH6AViq/RiuryxXcHFsR15+MDiUHF1Tr4ZUeUxQf18dcv0ev6nR99qo+xDpizE+C8U58=;
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@vger.kernel.org

Hello,

I have occasional deadlocks using autofs 4.1.2 (but it happened on 4.1.1 
as well) on my servers, typically about once every 2 or 3 days.

I already posted on this mailing-list back in 2015 for a bug that also 
triggered deadlocks (which was fixed), so I'll copy/paste parts of my 
original message as my config hasn't changed.

/etc/auto.master:
--
/nfs program:/etc/auto.nfs
/home program:/etc/auto.home
--

/etc/auto.nfs is basically returning:

-fstype=nfs4,noatime,nosuid,_netdev,soft,intr,timeo=1000 $1:/

/etc/auto.home:
--
#!/bin/sh

if [ ! -h /var/home/$1 ]
then
    exit 1
fi

echo -fstype=bind :$(readlink --no-newline /var/home/$1)
--

So for instance, /var/home/foo would be a symlink pointing to
/nfs/serverX/foo.

Kernel: Linux 4.4.7.

My servers have cronjobs that trigger /home/userX mounts basically at 
the same time (when the jobs do start). I have 2 servers with the same 
config, but one of them has MANY more users/cronjobs and oddly enough, 
the deadlock happens much more infrequently.

Anyway, here's a 'ps faux' a few hours after the deadlock started:

root        3437  0.0  0.0 217644  5428 ?        Ssl  Jun24   0:14 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1269869  0.0  0.0 209420  1904 ?        S    18:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1269915  0.0  0.0 209420  1904 ?        S    18:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1269920  0.0  0.0      0     0 ?        Z    18:00   0:00  \_ 
[auto.nfs] <defunct>
root     1269923  0.0  0.0 209420  1904 ?        S    18:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1269931  0.0  0.0 209420  1904 ?        S    18:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1269932  0.0  0.0 209420  1904 ?        S    18:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1269933  0.0  0.0 209420  1904 ?        S    18:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1269934  0.0  0.0 209420  1904 ?        S    18:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1269937  0.0  0.0 209420  1904 ?        S    18:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1271340  0.0  0.0 209420  1904 ?        S    18:01   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1271943  0.0  0.0 209420  1904 ?        S    18:03   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1272408  0.0  0.0 209420  1904 ?        S    18:05   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1273323  0.0  0.0 210448  1936 ?        S    18:08   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1274002  0.0  0.0 211476  1968 ?        S    18:10   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1276131  0.0  0.0 213532  2032 ?        S    18:20   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1278540  0.0  0.0 213532  2032 ?        S    18:30   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1302389  0.0  0.0 214560  2064 ?        S    20:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1317670  0.0  0.0 215588  2096 ?        S    20:52   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid
root     1319408  0.0  0.0 216616  2128 ?        S    21:00   0:00  \_ 
/usr/sbin/automount --pid-file /var/run/autofs.pid


Backtraces of the main process (3437):

Thread 24 (Thread 0x404a2950 (LWP 3438)):
#0  0x00007f438c7e8fad in pthread_cond_timedwait@@GLIBC_2.3.2 () from 
/lib/libpthread.so.0
#1  0x000055e6c5bd28e6 in alarm_handler (arg=<optimized out>) at alarm.c:191
#2  0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#3  0x00007f438b9ad64d in clone () from /lib/libc.so.6
#4  0x0000000000000000 in ?? ()

Thread 23 (Thread 0x4182f950 (LWP 3439)):
#0  0x00007f438c7e8d29 in pthread_cond_wait@@GLIBC_2.3.2 () from 
/lib/libpthread.so.0
#1  0x000055e6c5bc7205 in st_queue_handler (arg=<optimized out>) at 
state.c:1101
#2  0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#3  0x00007f438b9ad64d in clone () from /lib/libc.so.6
#4  0x0000000000000000 in ?? ()

Thread 22 (Thread 0x42030950 (LWP 3442)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bbabce in get_pkt (pkt=<optimized out>, ap=<optimized 
out>) at automount.c:1009
#2  handle_packet (ap=<optimized out>) at automount.c:1160
#3  handle_mounts (arg=<optimized out>) at automount.c:1834
#4  0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#5  0x00007f438b9ad64d in clone () from /lib/libc.so.6
#6  0x0000000000000000 in ?? ()

Thread 21 (Thread 0x417f3950 (LWP 3445)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bbabce in get_pkt (pkt=<optimized out>, ap=<optimized 
out>) at automount.c:1009
#2  handle_packet (ap=<optimized out>) at automount.c:1160
#3  handle_mounts (arg=<optimized out>) at automount.c:1834
#4  0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#5  0x00007f438b9ad64d in clone () from /lib/libc.so.6
#6  0x0000000000000000 in ?? ()

Thread 20 (Thread 0x409a0950 (LWP 1269762)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x4099d9b0 "user1", name_len=12, 
what=0x4099d980 "/nfs/http12/user1", fstype=0x4099d9d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x55e6c642cb00) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x4099d9b0 "user1", name_len=12, 
what=0x4099d980 "/nfs/http12/user1", fstype=0x4099d9d0 "bind",
     options=0x4099d9f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x4099e000 "user1", namelen=12, 
loc=0x55e6c642cbb0 ":/nfs/http12/user1", loclen=25,
     options=0x4099d9f0 "", ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x4099e000 "user1", name_len=12, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x4099e000 "user1", name_len=12, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x4099e000 "user1", name_len=12) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x4099e000 
"user1", name_len=12) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 19 (Thread 0x42232950 (LWP 1269775)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
---Type <return> to continue, or q <return> to quit---
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x4222f9b0 "user2", name_len=8, 
what=0x4222f980 "/nfs/http12/user2", fstype=0x4222f9d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x55e6c64311d0) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x4222f9b0 "user2", name_len=8, 
what=0x4222f980 "/nfs/http12/user2", fstype=0x4222f9d0 "bind",
     options=0x4222f9f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42230000 "user2", namelen=8, 
loc=0x55e6c6431810 ":/nfs/http12/user2", loclen=21, options=0x4222f9f0 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42230000 "user2", name_len=8, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42230000 "user2", name_len=8, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42230000 "user2", name_len=8) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42230000 
"user2", name_len=8) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 18 (Thread 0x42434950 (LWP 1269778)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x424319b0 "user3", name_len=9, 
what=0x42431980 "/nfs/http12/user3", fstype=0x424319d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0xffffffff00000024) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x424319b0 "user3", name_len=9, 
what=0x42431980 "/nfs/http12/user3", fstype=0x424319d0 "bind",
     options=0x424319f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42432000 "user3", namelen=9, 
loc=0x55e6c6431f20 ":/nfs/http12/user3", loclen=22, options=0x424319f0
"",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42432000 "user3", name_len=9, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42432000 "user3", name_len=9, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42432000 "user3", name_len=9) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42432000 
"user3", name_len=9) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 17 (Thread 0x42636950 (LWP 1269781)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x426339b0 "user4", name_len=10, 
what=0x42633980 "/nfs/http12/user4", fstype=0x426339d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x55e6c64316d0) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x426339b0 "user4", name_len=10, 
what=0x42633980 "/nfs/http12/user4", fstype=0x426339d0 "bind",
     options=0x426339f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42634000 "user4", namelen=10, 
loc=0x55e6c6431a70 ":/nfs/http12/user4", loclen=23, options=0x426339f0
"",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42634000 "user4", name_len=10, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42634000 "user4", name_len=10, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42634000 "user4", name_len=10) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42634000 
"user4", name_len=10) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 16 (Thread 0x40be5950 (LWP 1269783)):
---Type <return> to continue, or q <return> to quit---
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x40be29b0 "user5", name_len=7, 
what=0x40be2980 "/nfs/http12/user5", fstype=0x40be29d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x55e6c6431a10) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x40be29b0 "user5", name_len=7, 
what=0x40be2980 "/nfs/http12/user5", fstype=0x40be29d0 "bind",
     options=0x40be29f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x40be3000 "user5", namelen=7, 
loc=0x55e6c6431c90 ":/nfs/http12/user5", loclen=20, options=0x40be29f0 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x40be3000 "user5", name_len=7, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x40be3000 "user5", name_len=7, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x40be3000 "user5", name_len=7) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x40be3000 
"user5", name_len=7) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 15 (Thread 0x42a3a950 (LWP 1269785)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42a379b0 "user6", name_len=12, 
what=0x42a37980 "/nfs/http12/user6", fstype=0x42a379d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x0) at mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42a379b0 "user6", name_len=12, 
what=0x42a37980 "/nfs/http12/user6", fstype=0x42a379d0 "bind",
     options=0x42a379f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42a38000 "user6", namelen=12, 
loc=0x55e6c6432660 ":/nfs/http12/user6", loclen=25,
     options=0x42a379f0 "", ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42a38000 "user6", name_len=12, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42a38000 "user6", name_len=12, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42a38000 "user6", name_len=12) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42a38000 
"user6", name_len=12) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 14 (Thread 0x42535950 (LWP 1269810)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x425329c0 "user7", name_len=6, 
what=0x42532990 "/nfs/http12/user7", fstype=0x425329e0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x55e6c6428ff0) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x425329c0 "user7", name_len=6, 
what=0x42532990 "/nfs/http12/user7", fstype=0x425329e0 "bind",
options=0x42532a00 "")
     at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42533000 "user7", namelen=6, 
loc=0x55e6c64322d0 ":/nfs/http12/user7", loclen=19, options=0x42532a00 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42533000 "user7", name_len=6, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42533000 "user7", name_len=6, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42533000 "user7", name_len=6) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42533000 
"user7", name_len=6) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
---Type <return> to continue, or q <return> to quit---
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 13 (Thread 0x42939950 (LWP 1269829)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x429369c0 "user8", name_len=3, 
what=0x429369a0 "/nfs/http12/user8", fstype=0x429369e0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x20) at mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x429369c0 "user8", name_len=3, 
what=0x429369a0 "/nfs/http12/user8", fstype=0x429369e0 "bind", 
options=0x42936a00 "")
     at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42937000 "user8", namelen=3, 
loc=0x55e6c6432100 ":/nfs/http12/user8", loclen=16, options=0x42936a00 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42937000 "user8", name_len=3, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42937000 "user8", name_len=3, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42937000 "user8", name_len=3) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42937000 
"user8", name_len=3) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 12 (Thread 0x42838950 (LWP 1269881)):
#0  0x00007f438c7eb7db in read () from /lib/libpthread.so.0
#1  0x00007f438b017f2d in lookup_one (ap=0x55e6c63f8c30, 
name=0x55e6c6432320 "http12", name_len=<optimized out>, ctxt=<optimized 
out>) at lookup_program.c:291
#2  0x00007f438b01898d in match_key (ctxt=<optimized out>, 
mapent=<optimized out>, name_len=<optimized out>, name=<optimized out>, 
source=<optimized out>, ap=<optimized out>) at lookup_program.c:493
#3  lookup_mount (ap=0x55e6c63f8c30, name=0x42836000 "http12", 
name_len=6, context=0x55e6c63f87c0) at lookup_program.c:682
#4  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f8c30, 
map=0x55e6c63f8d50, name=0x42836000 "http12", name_len=6) at lookup.c:766
#5  0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#6  lookup_nss_mount (ap=0x55e6c63f8c30, source=0x0, name=0x42836000 
"http12", name_len=6) at lookup.c:1110
#7  0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#8  0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#9  0x00007f438b9ad64d in clone () from /lib/libc.so.6
#10 0x0000000000000000 in ?? ()

Thread 11 (Thread 0x42333950 (LWP 1271292)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x423309b0 "user9", name_len=9, 
what=0x42330980 "/nfs/http12/user9", fstype=0x423309d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x7f438bc2ca40) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x423309b0 "user9", name_len=9, 
what=0x42330980 "/nfs/http12/user9", fstype=0x423309d0 "bind",
     options=0x423309f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42331000 "user9", namelen=9, 
loc=0x55e6c6432740 ":/nfs/http12/user9", loclen=22, options=0x423309f0
"",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42331000 "user9", name_len=9, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42331000 "user9", name_len=9, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42331000 "user9", name_len=9) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42331000 
"user9", name_len=9) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 10 (Thread 0x42737950 (LWP 1271894)):
---Type <return> to continue, or q <return> to quit---
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x427349b0 "user10", name_len=12, 
what=0x42734980 "/nfs/http12/user10", fstype=0x427349d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x0) at mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x427349b0 "user10", name_len=12, 
what=0x42734980 "/nfs/http12/user10", fstype=0x427349d0 "bind",
     options=0x427349f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42735000 "user10", namelen=12, 
loc=0x55e6c64328d0 ":/nfs/http12/user10", loclen=25,
     options=0x427349f0 "", ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42735000 "user10", name_len=12, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42735000 "user10", name_len=12, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42735000 "user10", name_len=12) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42735000 
"user10", name_len=12) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 9 (Thread 0x42131950 (LWP 1272342)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x4212e9b0 "user11", name_len=9, 
what=0x4212e980 "/nfs/http12/user11", fstype=0x4212e9d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x55e6c64353f0) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x4212e9b0 "user11", name_len=9, 
what=0x4212e980 "/nfs/http12/user11", fstype=0x4212e9d0 "bind",
     options=0x4212e9f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x4212f000 "user11", namelen=9, 
loc=0x55e6c6432a30 ":/nfs/http12/user11", loclen=22, options=0x4212e9f0
"",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x4212f000 "user11", name_len=9, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x4212f000 "user11", name_len=9, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x4212f000 "user11", name_len=9) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x4212f000 
"user11", name_len=9) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 8 (Thread 0x407af950 (LWP 1273318)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x407ac9c0 "user12", name_len=5, 
what=0x407ac990 "/nfs/http12/user12", fstype=0x407ac9e0 "bind",
     options=0x7f438a9a9716 "defaults", context=0xffffffffffffffff) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x407ac9c0 "user12", name_len=5, 
what=0x407ac990 "/nfs/http12/user12", fstype=0x407ac9e0 "bind", 
options=0x407aca00
"")
     at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x407ad000 "user12", namelen=5, 
loc=0x55e6c6432cf0 ":/nfs/http12/user12", loclen=18, options=0x407aca00 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x407ad000 "user12", name_len=5, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x407ad000 "user12", name_len=5, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x407ad000 "user12", name_len=5) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x407ad000 
"user12", name_len=5) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
---Type <return> to continue, or q <return> to quit---
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 7 (Thread 0x42b3b950 (LWP 1273997)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42b389c0 "user13", name_len=6, 
what=0x42b38990 "/nfs/http12/user13", fstype=0x42b389e0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x4b1) at mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42b389c0 "user13", name_len=6, 
what=0x42b38990 "/nfs/http12/user13", fstype=0x42b389e0 "bind",
options=0x42b38a00 "")
     at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42b39000 "user13", namelen=6, 
loc=0x55e6c64330c0 ":/nfs/http12/user13", loclen=19, options=0x42b38a00 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42b39000 "user13", name_len=6, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42b39000 "user13", name_len=6, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42b39000 "user13", name_len=6) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42b39000 
"user13", name_len=6) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 6 (Thread 0x405a3950 (LWP 1276040)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x405a09c0 "user14", name_len=5, 
what=0x405a0990 "/nfs/http12/user14", fstype=0x405a09e0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x21) at mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x405a09c0 "user14", name_len=5, 
what=0x405a0990 "/nfs/http12/user14", fstype=0x405a09e0 "bind", 
options=0x405a0a00
"")
     at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x405a1000 "user14", namelen=5, 
loc=0x55e6c6433360 ":/nfs/http12/user14", loclen=18, options=0x405a0a00 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x405a1000 "user14", name_len=5, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x405a1000 "user14", name_len=5, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x405a1000 "user14", name_len=5) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x405a1000 
"user14", name_len=5) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 5 (Thread 0x42c3c950 (LWP 1278498)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42c399c0 "user15", name_len=6, 
what=0x42c39990 "/nfs/http12/user15", fstype=0x42c399e0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x6974616877040020) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42c399c0 "user15", name_len=6, 
what=0x42c39990 "/nfs/http12/user15", fstype=0x42c399e0 "bind",
options=0x42c39a00 "")
     at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42c3a000 "user15", namelen=6, 
loc=0x55e6c6435160 ":/nfs/http12/user15", loclen=19, options=0x42c39a00 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42c3a000 "user15", name_len=6, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42c3a000 "user15", name_len=6, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42c3a000 "user15", name_len=6) at lookup.c:766
---Type <return> to continue, or q <return> to quit---
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42c3a000 
"user15", name_len=6) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 4 (Thread 0x42d3d950 (LWP 1302366)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42d3a9b0 "user16", name_len=8, 
what=0x42d3a980 "/nfs/http12/user16", fstype=0x42d3a9d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0xffffffffffffffff) at 
mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42d3a9b0 "user16", name_len=8, 
what=0x42d3a980 "/nfs/http12/user16", fstype=0x42d3a9d0 "bind",
     options=0x42d3a9f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42d3b000 "user16", namelen=8, 
loc=0x55e6c6435420 ":/nfs/http12/user16", loclen=21, options=0x42d3a9f0 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42d3b000 "user16", name_len=8, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42d3b000 "user16", name_len=8, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42d3b000 "user16", name_len=8) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42d3b000 
"user16", name_len=8) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 3 (Thread 0x42e3e950 (LWP 1317665)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42e3b9b0 "user17", name_len=7, 
what=0x42e3b980 "/nfs/http12/user17", fstype=0x42e3b9d0 "bind",
     options=0x7f438a9a9716 "defaults", context=0x0) at mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42e3b9b0 "user17", name_len=7, 
what=0x42e3b980 "/nfs/http12/user17", fstype=0x42e3b9d0 "bind",
     options=0x42e3b9f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42e3c000 "user17", namelen=7, 
loc=0x55e6c64358a0 ":/nfs/http12/user17", loclen=20, options=0x42e3b9f0 "",
     ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42e3c000 "user17", name_len=7, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42e3c000 "user17", name_len=7, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42e3c000 "user17", name_len=7) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42e3c000 
"user17", name_len=7) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 2 (Thread 0x42f3f950 (LWP 1319319)):
#0  0x00007f438b9a4bd6 in poll () from /lib/libc.so.6
#1  0x000055e6c5bc1474 in timed_read (time=<optimized out>, 
len=<optimized out>, buf=<optimized out>, pipe=<optimized out>) at 
spawn.c:107
#2  do_spawn (logopt=0, wait=4294967295, options=<optimized out>, 
prog=<optimized out>, argv=<optimized out>) at spawn.c:272
#3  0x000055e6c5bc2050 in spawn_bind_mount (logopt=0) at spawn.c:538
#4  0x00007f438a9a88f8 in mount_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42f3c9a0 "user18", name_len=18, 
what=0x42f3c970 "/nfs/http12/user18",
     fstype=0x42f3c9d0 "bind", options=0x7f438a9a9716 "defaults", 
context=0xffffffffffffffff) at mount_bind.c:170
#5  0x000055e6c5bc34ad in do_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42f3c9a0 "user18", name_len=18, 
what=0x42f3c970 "/nfs/http12/user18",
     fstype=0x42f3c9d0 "bind", options=0x42f3c9f0 "") at mount.c:78
#6  0x00007f438ade8a43 in sun_mount (ap=0x55e6c63f9030, 
root=0x55e6c63f9130 "/home", name=0x42f3d000 "user18", namelen=18, 
loc=0x55e6c6435b40 ":/nfs/http12/user18", loclen=31,
---Type <return> to continue, or q <return> to quit---
     options=0x42f3c9f0 "", ctxt=0x55e6c63f7770) at parse_sun.c:712
#7  0x00007f438adeacc2 in parse_mount (ap=0x55e6c63f9030, 
name=0x42f3d000 "user18", name_len=18, mapent=<optimized out>, 
context=<optimized out>) at parse_sun.c:1673
#8  0x00007f438b018be1 in lookup_mount (ap=0x55e6c63f9030, 
name=0x42f3d000 "user18", name_len=18, context=0x55e6c63f76f0) at 
lookup_program.c:691
#9  0x000055e6c5bc4072 in do_lookup_mount (ap=0x55e6c63f9030, 
map=0x55e6c63f9150, name=0x42f3d000 "user18", name_len=18) at lookup.c:766
#10 0x000055e6c5bc4642 in do_name_lookup_mount (name_len=<optimized 
out>, name=<optimized out>, map=<optimized out>, ap=<optimized out>) at 
lookup.c:945
#11 lookup_nss_mount (ap=0x55e6c63f9030, source=0x0, name=0x42f3d000 
"user18", name_len=18) at lookup.c:1110
#12 0x000055e6c5bbb4d6 in do_mount_indirect (arg=<optimized out>) at 
indirect.c:772
#13 0x00007f438c7e4fc7 in start_thread () from /lib/libpthread.so.0
#14 0x00007f438b9ad64d in clone () from /lib/libc.so.6
#15 0x0000000000000000 in ?? ()

Thread 1 (Thread 0x7f438cbfa6e0 (LWP 3437)):
#0  0x00007f438c7ec797 in do_sigwait () from /lib/libpthread.so.0
#1  0x00007f438c7ec83d in sigwait () from /lib/libpthread.so.0
#2  0x000055e6c5bba3c6 in statemachine (arg=<optimized out>) at 
automount.c:1469
#3  main (argc=0, argv=<optimized out>) at automount.c:2476


I cannot attach gdb on subprocesses: gdb just hangs after:
Attaching to program: /usr/sbin/automount, process 1269869

Kernel trace:

# cat /proc/1269869/stack
[<ffffffffc052f3bf>] autofs4_wait+0x3df/0xb60 [autofs4]
[<ffffffffc052e0a5>] autofs4_d_automount+0x235/0x270 [autofs4]
[<ffffffff921cbb8f>] follow_managed+0x1ff/0x2d0
[<ffffffff921cccb3>] walk_component+0x263/0x300
[<ffffffff921cdded>] link_path_walk+0x18d/0x5a0
[<ffffffff921cf48e>] path_openat+0xbe/0x1070
[<ffffffff921d04c5>] do_filp_open+0x85/0xe0
[<ffffffff921bed96>] do_sys_open+0x146/0x220
[<ffffffff921beeae>] SyS_open+0x1e/0x20
[<ffffffff927685b2>] entry_SYSCALL_64_fastpath+0x12/0x71
[<ffffffffffffffff>] 0xffffffffffffffff

Other subprocesses may have a slightly different kernel trace:

~# cat /proc/1269923/stack
[<ffffffffc052f3bf>] autofs4_wait+0x3df/0xb60 [autofs4]
[<ffffffffc052dc97>] autofs4_d_manage+0x117/0x1b0 [autofs4]
[<ffffffff921cbaa6>] follow_managed+0x116/0x2d0
[<ffffffff921cccb3>] walk_component+0x263/0x300
[<ffffffff921cdded>] link_path_walk+0x18d/0x5a0
[<ffffffff921cf48e>] path_openat+0xbe/0x1070
[<ffffffff921d04c5>] do_filp_open+0x85/0xe0
[<ffffffff921bed96>] do_sys_open+0x146/0x220
[<ffffffff921beeae>] SyS_open+0x1e/0x20
[<ffffffff927685b2>] entry_SYSCALL_64_fastpath+0x12/0x71
[<ffffffffffffffff>] 0xffffffffffffffff

When the deadlock happens, I have to kill -9 subprocesses one by one. 
One specific subprocess finally unlocks the deadlock and everything goes 
back to normal (remaining subprocesses disappear as well).

I have no other interesting log, and in particular no kernel log when 
that happens.

Thanks,

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
