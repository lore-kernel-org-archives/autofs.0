From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Subject: automount 4.1.3 - strange behaviour in hearachy (PART II - logs)
Date: Tue, 22 Jun 2004 19:58:48 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B384E3A30@frodo.avalon.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

--- normal log ---
Jun 22 19:50:48 amarie automount[23005]: shut down, path = /mnt/autofs
Jun 22 19:50:48 amarie kernel: VFS: Busy inodes after unmount.
Self-destruct in 5 seconds.  Have a nice day...
Jun 22 19:50:48 amarie autofs: Stopping automounter: succeeded
Jun 22 19:50:48 amarie automount[23343]: starting automounter version
4.1.3, path = /mnt/autofs, maptype = program, mapname = /etc/auto.autofs
Jun 22 19:50:48 amarie autofs: automounter startup succeeded
Jun 22 19:50:48 amarie automount[23343]: using kernel protocol version
4.00
Jun 22 19:50:48 amarie automount[23343]: using timeout 50 seconds; freq
13 secs
Jun 22 19:51:02 amarie automount[23343]: attempting to mount entry
/mnt/autofs/a
Jun 22 19:51:02 amarie automount[23385]: starting automounter version
4.1.3, path = /mnt/autofs/a, maptype = program, mapname =
/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23385]: using kernel protocol version
4.00
Jun 22 19:51:02 amarie automount[23385]: using timeout 50 seconds; freq
13 secs
Jun 22 19:51:02 amarie automount[23385]: attempting to mount entry
/mnt/autofs/a/b
Jun 22 19:51:02 amarie automount[23391]: starting automounter version
4.1.3, path = /mnt/autofs/a/b, maptype = program, mapname =
/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23391]: using kernel protocol version
4.00
Jun 22 19:51:02 amarie automount[23391]: using timeout 50 seconds; freq
13 secs
Jun 22 19:51:02 amarie automount[23391]: attempting to mount entry
/mnt/autofs/a/b/c
Jun 22 19:51:02 amarie automount[23397]: starting automounter version
4.1.3, path = /mnt/autofs/a/b/c, maptype = program, mapname =
/etc/auto.autofs
Jun 22 19:51:03 amarie automount[23397]: using kernel protocol version
4.00
Jun 22 19:51:03 amarie automount[23397]: using timeout 50 seconds; freq
13 secs
Jun 22 19:51:26 amarie automount[23397]: umount /mnt/autofs/a/b/c
failed: retrying... 
Jun 22 19:51:27 amarie automount[23397]: umount /mnt/autofs/a/b/c
failed: retrying... 
Jun 22 19:51:28 amarie automount[23397]: can't unmount /mnt/autofs/a/b/c

Jun 22 19:51:28 amarie automount[23397]: shut down, path =
/mnt/autofs/a/b/c
Jun 22 19:51:28 amarie automount[23397]: failed to remove dir
/mnt/autofs/a/b/c: Device or resource busy
Jun 22 19:51:58 amarie automount[23485]: rm_unwanted: /mnt/autofs/a/b/c 
Jun 22 19:51:58 amarie automount[23485]: expired /mnt/autofs/a/b/c
Jun 22 19:51:59 amarie automount[23391]: shut down, path =
/mnt/autofs/a/b
Jun 22 19:52:05 amarie automount[23385]: shut down, path = /mnt/autofs/a
--- debug log ---
Jun 22 19:50:36 amarie automount[23005]: sig 14 switching from 1 to 2
Jun 22 19:50:36 amarie automount[23005]: get_pkt: state 1, next 2
Jun 22 19:50:36 amarie automount[23005]: st_expire(): state = 1 
Jun 22 19:50:36 amarie automount[23005]: expire_proc: exp_proc=23181
Jun 22 19:50:36 amarie automount[23005]: handle_child: got pid 23181,
sig 0 (0), stat 0 
Jun 22 19:50:36 amarie automount[23005]: sigchld: exp 23181 finished,
switching from 2 to 1
Jun 22 19:50:36 amarie automount[23005]: get_pkt: state 2, next 1
Jun 22 19:50:36 amarie automount[23005]: st_ready(): state = 2 
Jun 22 19:50:48 amarie automount[23005]: sig 12 switching from 1 to 5
Jun 22 19:50:48 amarie automount[23005]: get_pkt: state 1, next 5
Jun 22 19:50:48 amarie automount[23005]: expire_proc: exp_proc=23201
Jun 22 19:50:48 amarie automount[23005]: prep_shutdown: expire returns 1

Jun 22 19:50:48 amarie automount[23005]: handle_child: got pid 23201,
sig 0 (0), stat 0 
Jun 22 19:50:48 amarie automount[23005]: sigchld: exp 23201 finished,
switching from 5 to 6
Jun 22 19:50:48 amarie automount[23005]: get_pkt: state 5, next 6
Jun 22 19:50:48 amarie automount[23005]: umount_multi: path=/mnt/autofs
incl=0 
Jun 22 19:50:48 amarie automount[23343]: mount(bind): bind_works = 1 
Jun 22 19:50:48 amarie automount[23343]: kproto sub: Function not
implemented
Jun 22 19:51:02 amarie automount[23343]: handle_packet: type = 0 
Jun 22 19:51:02 amarie automount[23343]: handle_packet_missing: token
357, name a 
Jun 22 19:51:02 amarie automount[23383]: lookup(program): looking up a
Jun 22 19:51:02 amarie automount[23383]: lookup(program): a ->
-fstype=autofs program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23383]: parse(sun): expanded entry:
-fstype=autofs program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23383]: parse(sun):
dequote("fstype=autofs") -> fstype=autofs
Jun 22 19:51:02 amarie automount[23383]: parse(sun): gathered options:
fstype=autofs
Jun 22 19:51:02 amarie automount[23383]: parse(sun):
dequote("program:/etc/auto.autofs") -> program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23383]: parse(sun): core of entry:
options=fstype=autofs, loc=program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23383]: parse(sun): mounting root
/mnt/autofs, mountpoint a, what program:/etc/auto.autofs, fstype autofs,
options  
Jun 22 19:51:02 amarie automount[23383]: do_mount
program:/etc/auto.autofs /mnt/autofs/a type autofs options  using module
autofs
Jun 22 19:51:02 amarie automount[23383]: mount(autofs): calling
mkdir_path /mnt/autofs/a
Jun 22 19:51:02 amarie automount[23383]: mount(autofs):
fullpath=/mnt/autofs/a what=program:/etc/auto.autofs options=
Jun 22 19:51:02 amarie automount[23385]: parse(sun): init gathered
options: 
Jun 22 19:51:02 amarie automount[23385]: mount(bind): bind_works = 1 
Jun 22 19:51:02 amarie automount[23385]: kproto sub: Function not
implemented
Jun 22 19:51:02 amarie automount[23383]: mount(autofs): mounted
program:/etc/auto.autofs on /mnt/autofs/a
Jun 22 19:51:02 amarie automount[23343]: handle_child: got pid 23383,
sig 0 (0), stat 0 
Jun 22 19:51:02 amarie automount[23343]: sig_child: found pending iop
pid 23383: signalled 0 (sig 0), exit status 0
Jun 22 19:51:02 amarie automount[23343]: send_ready: token=357 
Jun 22 19:51:02 amarie automount[23385]: handle_packet: type = 0 
Jun 22 19:51:02 amarie automount[23385]: handle_packet_missing: token
358, name b 
Jun 22 19:51:02 amarie automount[23389]: lookup(program): looking up b
Jun 22 19:51:02 amarie automount[23389]: lookup(program): b ->
-fstype=autofs program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23389]: parse(sun): expanded entry:
-fstype=autofs program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23389]: parse(sun):
dequote("fstype=autofs") -> fstype=autofs
Jun 22 19:51:02 amarie automount[23389]: parse(sun): gathered options:
fstype=autofs
Jun 22 19:51:02 amarie automount[23389]: parse(sun):
dequote("program:/etc/auto.autofs") -> program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23389]: parse(sun): core of entry:
options=fstype=autofs, loc=program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23389]: parse(sun): mounting root
/mnt/autofs/a, mountpoint b, what program:/etc/auto.autofs, fstype
autofs, options  
Jun 22 19:51:02 amarie automount[23389]: do_mount
program:/etc/auto.autofs /mnt/autofs/a/b type autofs options  using
module autofs
Jun 22 19:51:02 amarie automount[23389]: mount(autofs): calling
mkdir_path /mnt/autofs/a/b
Jun 22 19:51:02 amarie automount[23389]: mount(autofs):
fullpath=/mnt/autofs/a/b what=program:/etc/auto.autofs options=
Jun 22 19:51:02 amarie automount[23391]: parse(sun): init gathered
options: 
Jun 22 19:51:02 amarie automount[23391]: mount(bind): bind_works = 1 
Jun 22 19:51:02 amarie automount[23391]: kproto sub: Function not
implemented
Jun 22 19:51:02 amarie automount[23389]: mount(autofs): mounted
program:/etc/auto.autofs on /mnt/autofs/a/b
Jun 22 19:51:02 amarie automount[23385]: handle_child: got pid 23389,
sig 0 (0), stat 0 
Jun 22 19:51:02 amarie automount[23385]: sig_child: found pending iop
pid 23389: signalled 0 (sig 0), exit status 0
Jun 22 19:51:02 amarie automount[23385]: send_ready: token=358 
Jun 22 19:51:02 amarie automount[23391]: handle_packet: type = 0 
Jun 22 19:51:02 amarie automount[23391]: handle_packet_missing: token
359, name c 
Jun 22 19:51:02 amarie automount[23395]: lookup(program): looking up c
Jun 22 19:51:02 amarie automount[23395]: lookup(program): c ->
-fstype=autofs program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23395]: parse(sun): expanded entry:
-fstype=autofs program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23395]: parse(sun):
dequote("fstype=autofs") -> fstype=autofs
Jun 22 19:51:02 amarie automount[23395]: parse(sun): gathered options:
fstype=autofs
Jun 22 19:51:02 amarie automount[23395]: parse(sun):
dequote("program:/etc/auto.autofs") -> program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23395]: parse(sun): core of entry:
options=fstype=autofs, loc=program:/etc/auto.autofs
Jun 22 19:51:02 amarie automount[23395]: parse(sun): mounting root
/mnt/autofs/a/b, mountpoint c, what program:/etc/auto.autofs, fstype
autofs, options  
Jun 22 19:51:02 amarie automount[23395]: do_mount
program:/etc/auto.autofs /mnt/autofs/a/b/c type autofs options  using
module autofs
Jun 22 19:51:02 amarie automount[23395]: mount(autofs): calling
mkdir_path /mnt/autofs/a/b/c
Jun 22 19:51:02 amarie automount[23395]: mount(autofs):
fullpath=/mnt/autofs/a/b/c what=program:/etc/auto.autofs options=
Jun 22 19:51:02 amarie automount[23397]: parse(sun): init gathered
options: 
Jun 22 19:51:02 amarie automount[23397]: mount(bind): bind_works = 1 
Jun 22 19:51:03 amarie automount[23397]: kproto sub: Function not
implemented
Jun 22 19:51:03 amarie automount[23395]: mount(autofs): mounted
program:/etc/auto.autofs on /mnt/autofs/a/b/c
Jun 22 19:51:03 amarie automount[23391]: handle_child: got pid 23395,
sig 0 (0), stat 0 
Jun 22 19:51:03 amarie automount[23391]: sig_child: found pending iop
pid 23395: signalled 0 (sig 0), exit status 0
Jun 22 19:51:03 amarie automount[23391]: send_ready: token=359 
Jun 22 19:51:09 amarie automount[23343]: sig 14 switching from 1 to 2
Jun 22 19:51:09 amarie automount[23343]: get_pkt: state 1, next 2
Jun 22 19:51:09 amarie automount[23343]: st_expire(): state = 1 
Jun 22 19:51:09 amarie automount[23343]: expire_proc: exp_proc=23408
Jun 22 19:51:09 amarie automount[23408]: expire_proc: 1 remaining in
/mnt/autofs 
Jun 22 19:51:09 amarie automount[23343]: handle_child: got pid 23408,
sig 0 (0), stat 1 
Jun 22 19:51:09 amarie automount[23343]: sigchld: exp 23408 finished,
switching from 2 to 1
Jun 22 19:51:09 amarie automount[23343]: get_pkt: state 2, next 1
Jun 22 19:51:09 amarie automount[23343]: st_ready(): state = 2 
Jun 22 19:51:19 amarie automount[23391]: sig 14 switching from 1 to 2
Jun 22 19:51:19 amarie automount[23391]: get_pkt: state 1, next 2
Jun 22 19:51:19 amarie automount[23391]: st_expire(): state = 1 
Jun 22 19:51:19 amarie automount[23391]: expire_proc: exp_proc=23424
Jun 22 19:51:19 amarie automount[23424]: expire_proc: 1 remaining in
/mnt/autofs/a/b 
Jun 22 19:51:19 amarie automount[23391]: handle_child: got pid 23424,
sig 0 (0), stat 1 
Jun 22 19:51:19 amarie automount[23391]: sigchld: exp 23424 finished,
switching from 2 to 1
Jun 22 19:51:19 amarie automount[23391]: get_pkt: state 2, next 1
Jun 22 19:51:19 amarie automount[23391]: st_ready(): state = 2 
Jun 22 19:51:22 amarie automount[23343]: sig 14 switching from 1 to 2
Jun 22 19:51:22 amarie automount[23343]: get_pkt: state 1, next 2
Jun 22 19:51:22 amarie automount[23343]: st_expire(): state = 1 
Jun 22 19:51:22 amarie automount[23343]: expire_proc: exp_proc=23428
Jun 22 19:51:22 amarie automount[23428]: expire_proc: 1 remaining in
/mnt/autofs 
Jun 22 19:51:22 amarie automount[23343]: handle_child: got pid 23428,
sig 0 (0), stat 1 
Jun 22 19:51:22 amarie automount[23343]: sigchld: exp 23428 finished,
switching from 2 to 1
Jun 22 19:51:22 amarie automount[23343]: get_pkt: state 2, next 1
Jun 22 19:51:22 amarie automount[23343]: st_ready(): state = 2 
Jun 22 19:51:25 amarie automount[23397]: sig 14 switching from 1 to 2
Jun 22 19:51:25 amarie automount[23397]: get_pkt: state 1, next 2
Jun 22 19:51:25 amarie automount[23397]: st_expire(): state = 1 
Jun 22 19:51:25 amarie automount[23397]: expire_proc: exp_proc=23432
Jun 22 19:51:25 amarie automount[23397]: handle_child: got pid 23432,
sig 0 (0), stat 0 
Jun 22 19:51:25 amarie automount[23397]: sigchld: exp 23432 finished,
switching from 2 to 5
Jun 22 19:51:25 amarie automount[23397]: get_pkt: state 2, next 5
Jun 22 19:51:25 amarie automount[23397]: expire_proc: exp_proc=23433
Jun 22 19:51:25 amarie automount[23397]: prep_shutdown: expire returns 1

Jun 22 19:51:25 amarie automount[23397]: handle_child: got pid 23433,
sig 0 (0), stat 0 
Jun 22 19:51:25 amarie automount[23397]: sigchld: exp 23433 finished,
switching from 5 to 6
Jun 22 19:51:25 amarie automount[23397]: get_pkt: state 5, next 6
Jun 22 19:51:25 amarie automount[23397]: umount_multi:
path=/mnt/autofs/a/b/c incl=0 
Jun 22 19:51:26 amarie automount[23397]: >> umount: /mnt/autofs/a/b/c:
device is busy
Jun 22 19:51:26 amarie automount[23385]: sig 14 switching from 1 to 2
Jun 22 19:51:26 amarie automount[23385]: get_pkt: state 1, next 2
Jun 22 19:51:26 amarie automount[23385]: st_expire(): state = 1 
Jun 22 19:51:26 amarie automount[23385]: expire_proc: exp_proc=23437
Jun 22 19:51:26 amarie automount[23437]: expire_proc: 1 remaining in
/mnt/autofs/a 
Jun 22 19:51:26 amarie automount[23385]: handle_child: got pid 23437,
sig 0 (0), stat 1 
Jun 22 19:51:26 amarie automount[23385]: sigchld: exp 23437 finished,
switching from 2 to 1
Jun 22 19:51:26 amarie automount[23385]: get_pkt: state 2, next 1
Jun 22 19:51:26 amarie automount[23385]: st_ready(): state = 2 
Jun 22 19:51:27 amarie automount[23397]: >> umount: /mnt/autofs/a/b/c:
device is busy
Jun 22 19:51:28 amarie automount[23397]: >> umount: /mnt/autofs/a/b/c:
device is busy
Jun 22 19:51:32 amarie automount[23391]: sig 14 switching from 1 to 2
Jun 22 19:51:32 amarie automount[23391]: get_pkt: state 1, next 2
Jun 22 19:51:32 amarie automount[23391]: st_expire(): state = 1 
Jun 22 19:51:32 amarie automount[23391]: expire_proc: exp_proc=23448
Jun 22 19:51:32 amarie automount[23448]: expire_proc: 1 remaining in
/mnt/autofs/a/b 
Jun 22 19:51:32 amarie automount[23391]: handle_child: got pid 23448,
sig 0 (0), stat 1 
Jun 22 19:51:32 amarie automount[23391]: sigchld: exp 23448 finished,
switching from 2 to 1
Jun 22 19:51:32 amarie automount[23391]: get_pkt: state 2, next 1
Jun 22 19:51:32 amarie automount[23391]: st_ready(): state = 2 
Jun 22 19:51:35 amarie automount[23343]: sig 14 switching from 1 to 2
Jun 22 19:51:35 amarie automount[23343]: get_pkt: state 1, next 2
Jun 22 19:51:35 amarie automount[23343]: st_expire(): state = 1 
Jun 22 19:51:35 amarie automount[23343]: expire_proc: exp_proc=23453
Jun 22 19:51:35 amarie automount[23453]: expire_proc: 1 remaining in
/mnt/autofs 
Jun 22 19:51:35 amarie automount[23343]: handle_child: got pid 23453,
sig 0 (0), stat 1 
Jun 22 19:51:35 amarie automount[23343]: sigchld: exp 23453 finished,
switching from 2 to 1
Jun 22 19:51:35 amarie automount[23343]: get_pkt: state 2, next 1
Jun 22 19:51:35 amarie automount[23343]: st_ready(): state = 2 
Jun 22 19:51:39 amarie automount[23385]: sig 14 switching from 1 to 2
Jun 22 19:51:39 amarie automount[23385]: get_pkt: state 1, next 2
Jun 22 19:51:39 amarie automount[23385]: st_expire(): state = 1 
Jun 22 19:51:39 amarie automount[23385]: expire_proc: exp_proc=23459
Jun 22 19:51:39 amarie automount[23459]: expire_proc: 1 remaining in
/mnt/autofs/a 
Jun 22 19:51:39 amarie automount[23385]: handle_child: got pid 23459,
sig 0 (0), stat 1 
Jun 22 19:51:39 amarie automount[23385]: sigchld: exp 23459 finished,
switching from 2 to 1
Jun 22 19:51:39 amarie automount[23385]: get_pkt: state 2, next 1
Jun 22 19:51:39 amarie automount[23385]: st_ready(): state = 2 
Jun 22 19:51:45 amarie automount[23391]: sig 14 switching from 1 to 2
Jun 22 19:51:45 amarie automount[23391]: get_pkt: state 1, next 2
Jun 22 19:51:45 amarie automount[23391]: st_expire(): state = 1 
Jun 22 19:51:45 amarie automount[23391]: expire_proc: exp_proc=23466
Jun 22 19:51:45 amarie automount[23466]: expire_proc: 1 remaining in
/mnt/autofs/a/b 
Jun 22 19:51:45 amarie automount[23391]: handle_child: got pid 23466,
sig 0 (0), stat 1 
Jun 22 19:51:45 amarie automount[23391]: sigchld: exp 23466 finished,
switching from 2 to 1
Jun 22 19:51:45 amarie automount[23391]: get_pkt: state 2, next 1
Jun 22 19:51:45 amarie automount[23391]: st_ready(): state = 2 
Jun 22 19:51:48 amarie automount[23343]: sig 14 switching from 1 to 2
Jun 22 19:51:48 amarie automount[23343]: get_pkt: state 1, next 2
Jun 22 19:51:48 amarie automount[23343]: st_expire(): state = 1 
Jun 22 19:51:48 amarie automount[23343]: expire_proc: exp_proc=23470
Jun 22 19:51:48 amarie automount[23470]: expire_proc: 1 remaining in
/mnt/autofs 
Jun 22 19:51:48 amarie automount[23343]: handle_child: got pid 23470,
sig 0 (0), stat 1 
Jun 22 19:51:48 amarie automount[23343]: sigchld: exp 23470 finished,
switching from 2 to 1
Jun 22 19:51:48 amarie automount[23343]: get_pkt: state 2, next 1
Jun 22 19:51:48 amarie automount[23343]: st_ready(): state = 2 
Jun 22 19:51:52 amarie automount[23385]: sig 14 switching from 1 to 2
Jun 22 19:51:52 amarie automount[23385]: get_pkt: state 1, next 2
Jun 22 19:51:52 amarie automount[23385]: st_expire(): state = 1 
Jun 22 19:51:52 amarie automount[23385]: expire_proc: exp_proc=23475
Jun 22 19:51:52 amarie automount[23475]: expire_proc: 1 remaining in
/mnt/autofs/a 
Jun 22 19:51:52 amarie automount[23385]: handle_child: got pid 23475,
sig 0 (0), stat 1 
Jun 22 19:51:52 amarie automount[23385]: sigchld: exp 23475 finished,
switching from 2 to 1
Jun 22 19:51:52 amarie automount[23385]: get_pkt: state 2, next 1
Jun 22 19:51:52 amarie automount[23385]: st_ready(): state = 2 
Jun 22 19:51:58 amarie automount[23391]: sig 14 switching from 1 to 2
Jun 22 19:51:58 amarie automount[23391]: get_pkt: state 1, next 2
Jun 22 19:51:58 amarie automount[23391]: st_expire(): state = 1 
Jun 22 19:51:58 amarie automount[23391]: expire_proc: exp_proc=23484
Jun 22 19:51:58 amarie automount[23391]: handle_packet: type = 2 
Jun 22 19:51:58 amarie automount[23391]: handle_packet_expire_multi:
token 360, name c 
Jun 22 19:51:58 amarie automount[23485]: expiring path /mnt/autofs/a/b/c
Jun 22 19:51:58 amarie automount[23485]: umount_multi:
path=/mnt/autofs/a/b/c incl=1 
Jun 22 19:51:58 amarie automount[23485]: umount_multi: unmounting
dir=/mnt/autofs/a/b/c 
Jun 22 19:51:58 amarie automount[23391]: handle_child: got pid 23485,
sig 0 (0), stat 0 
Jun 22 19:51:58 amarie automount[23391]: sig_child: found pending iop
pid 23485: signalled 0 (sig 0), exit status 0
Jun 22 19:51:58 amarie automount[23391]: send_ready: token=360 
Jun 22 19:51:59 amarie automount[23391]: handle_child: got pid 23484,
sig 0 (0), stat 0 
Jun 22 19:51:59 amarie automount[23391]: sigchld: exp 23484 finished,
switching from 2 to 5
Jun 22 19:51:59 amarie automount[23391]: get_pkt: state 2, next 5
Jun 22 19:51:59 amarie automount[23391]: expire_proc: exp_proc=23487
Jun 22 19:51:59 amarie automount[23391]: prep_shutdown: expire returns 1

Jun 22 19:51:59 amarie automount[23391]: handle_child: got pid 23487,
sig 0 (0), stat 0 
Jun 22 19:51:59 amarie automount[23391]: sigchld: exp 23487 finished,
switching from 5 to 6
Jun 22 19:51:59 amarie automount[23391]: get_pkt: state 5, next 6
Jun 22 19:51:59 amarie automount[23391]: umount_multi:
path=/mnt/autofs/a/b incl=0 
Jun 22 19:52:01 amarie automount[23343]: sig 14 switching from 1 to 2
Jun 22 19:52:01 amarie automount[23343]: get_pkt: state 1, next 2
Jun 22 19:52:01 amarie automount[23343]: st_expire(): state = 1 
Jun 22 19:52:01 amarie automount[23343]: expire_proc: exp_proc=23494
Jun 22 19:52:01 amarie automount[23494]: expire_proc: 1 remaining in
/mnt/autofs 
Jun 22 19:52:01 amarie automount[23343]: handle_child: got pid 23494,
sig 0 (0), stat 1 
Jun 22 19:52:01 amarie automount[23343]: sigchld: exp 23494 finished,
switching from 2 to 1
Jun 22 19:52:01 amarie automount[23343]: get_pkt: state 2, next 1
Jun 22 19:52:01 amarie automount[23343]: st_ready(): state = 2 
Jun 22 19:52:05 amarie automount[23385]: sig 14 switching from 1 to 2
Jun 22 19:52:05 amarie automount[23385]: get_pkt: state 1, next 2
Jun 22 19:52:05 amarie automount[23385]: st_expire(): state = 1 
Jun 22 19:52:05 amarie automount[23385]: expire_proc: exp_proc=23499
Jun 22 19:52:05 amarie automount[23385]: handle_child: got pid 23499,
sig 0 (0), stat 0 
Jun 22 19:52:05 amarie automount[23385]: sigchld: exp 23499 finished,
switching from 2 to 5
Jun 22 19:52:05 amarie automount[23385]: get_pkt: state 2, next 5
Jun 22 19:52:05 amarie automount[23385]: expire_proc: exp_proc=23500
Jun 22 19:52:05 amarie automount[23385]: prep_shutdown: expire returns 1

Jun 22 19:52:05 amarie automount[23385]: handle_child: got pid 23500,
sig 0 (0), stat 0 
Jun 22 19:52:05 amarie automount[23385]: sigchld: exp 23500 finished,
switching from 5 to 6
Jun 22 19:52:05 amarie automount[23385]: get_pkt: state 5, next 6
Jun 22 19:52:05 amarie automount[23385]: umount_multi:
path=/mnt/autofs/a incl=0 
