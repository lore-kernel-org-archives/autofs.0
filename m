From: Erik Mckee <emckee@cs.tamu.edu>
Subject: autofs doesn't work anymore for me
Date: Wed, 12 Oct 2005 16:38:17 -0500 (CDT)
Message-ID: <Pine.GSO.4.58.0510121631440.19649@sun>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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

Hello :)

I have both a gentoo box and a fedora core 4 box, neither of them will
speak to my nfs server and automount.  Nothing shows up on my nfs server
that it is even being contacted.  The nfs server is a SGI running IRIX64
6.5.  Automount gives me logs like the following:

Jun 19 20:01:23 bluefin automount[22097]: starting automounter version
4.1.3, path = /helm, maptype = file, mapname = /etc/autofs/auto_rooms
Jun 19 20:01:23 bluefin automount[22097]: parse(sun): init gathered
options: nosuid,vers=3
Jun 19 20:01:23 bluefin automount[22097]: mount(bind): bind_works = 1
Jun 19 20:01:23 bluefin automount[22103]: starting automounter version
4.1.3, path = /binio, maptype = file, mapname = /etc/autofs/auto_binio
Jun 19 20:01:23 bluefin automount[22103]: parse(sun): init gathered
options: nosuid,vers=3
Jun 19 20:01:23 bluefin automount[22103]: mount(bind): bind_works = 1
Jun 19 20:01:23 bluefin automount[22097]: using kernel protocol version
4.05
Jun 19 20:01:23 bluefin automount[22097]: using timeout 60 seconds; freq
15 secsJun 19 20:01:23 bluefin automount[22103]: using kernel protocol
version 4.05
Jun 19 20:01:23 bluefin automount[22103]: using timeout 60 seconds; freq
15 secsJun 19 20:01:24 bluefin automount[22093]: failed to load map,
exiting
Jun 19 20:01:28 bluefin su(pam_unix)[22113]: session opened for user
emckee by (uid=0)
Jun 19 20:01:28 bluefin automount[22097]: handle_packet: type = 0
Jun 19 20:01:28 bluefin automount[22097]: handle_packet_missing: token 1,
name txusr
Jun 19 20:01:28 bluefin automount[22097]: attempting to mount entry
/helm/txusr
Jun 19 20:01:28 bluefin automount[22115]: lookup(file): txusr ->
pompano:/txusr
Jun 19 20:01:28 bluefin automount[22115]: parse(sun): expanded entry:
pompano:/txusr
Jun 19 20:01:28 bluefin automount[22115]: parse(sun): gathered options:
nosuid,vers=3
Jun 19 20:01:28 bluefin automount[22115]: parse(sun):
dequote("pompano:/txusr")
-> pompano:/txusr
Jun 19 20:01:28 bluefin automount[22115]: parse(sun): core of entry:
options=nosuid,vers=3, loc=pompano:/txusr
Jun 19 20:01:28 bluefin automount[22115]: parse(sun): mounting root /helm,
mountpoint txusr, what pompano:/txusr, fstype nfs, options nosuid,vers=3
Jun 19 20:01:28 bluefin automount[22115]: mount(nfs):  root=/helm
name=txusr what=pompano:/txusr, fstype=nfs, options=nosuid,vers=3
Jun 19 20:01:28 bluefin automount[22115]: mount(nfs): nfs
options="nosuid,vers=3", nosymlink=0
Jun 19 20:01:28 bluefin automount[22115]: mount(nfs): winner = (null)
local = 0
Jun 19 20:01:28 bluefin automount[22115]: mount(nfs): no host elected
Jun 19 20:01:28 bluefin automount[22115]: failed to mount /helm/txusr
Jun 19 20:01:28 bluefin automount[22115]: umount_multi: path=/helm/txusr
incl=1
Jun 19 20:01:28 bluefin automount[22097]: handle_child: got pid 22115, sig
0 (0), stat 1
Jun 19 20:01:28 bluefin automount[22097]: sig_child: found pending iop pid
22115: signalled 0 (sig 0), exit status 1
Jun 19 20:01:28 bluefin automount[22097]: send_fail: token=1
Jun 19 20:01:32 bluefin su(pam_unix)[22113]: session closed for user
emckee
Jun 19 20:01:40 bluefin automount[22097]: sig 14 switching from 1 to 2
Jun 19 20:01:40 bluefin automount[22097]: get_pkt: state 1, next 2
Jun 19 20:01:40 bluefin automount[22097]: st_expire(): state = 1
Jun 19 20:01:40 bluefin automount[22097]: expire_proc: exp_proc=22124
Jun 19 20:01:40 bluefin automount[22097]: handle_child: got pid 22124, sig
0 (0), stat 0
Jun 19 20:01:40 bluefin automount[22097]: sigchld: exp 22124 finished,
switching from 2 to 1
Jun 19 20:01:40 bluefin automount[22097]: get_pkt: state 2, next 1
Jun 19 20:01:40 bluefin automount[22097]: st_ready(): state = 2
Jun 19 20:01:46 bluefin automount[22103]: sig 14 switching from 1 to 2
Jun 19 20:01:46 bluefin automount[22103]: get_pkt: state 1, next 2
Jun 19 20:01:46 bluefin automount[22103]: st_expire(): state = 1
Jun 19 20:01:46 bluefin automount[22103]: expire_proc: exp_proc=22126
Jun 19 20:01:46 bluefin automount[22103]: handle_child: got pid 22126, sig
0 (0), stat 0
Jun 19 20:01:46 bluefin automount[22103]: sigchld: exp 22126 finished,
switching from 2 to 1
Jun 19 20:01:46 bluefin automount[22103]: get_pkt: state 2, next 1
Jun 19 20:01:46 bluefin automount[22103]: st_ready(): state = 2
Jun 19 20:01:55 bluefin automount[22097]: sig 14 switching from 1 to 2
Jun 19 20:01:55 bluefin automount[22097]: get_pkt: state 1, next 2
Jun 19 20:01:55 bluefin automount[22097]: st_expire(): state = 1

...

And these just keep going on and on...

My auto.master is:
# $Id: auto.master,v 1.1 2000/08/08 17:53:33 achim Exp $
# Sample auto.master file
# Format of this file:
# mountpoint map options
# For details of the format look at autofs(8).
#/misc  /etc/autofs/auto.misc --timeout 60
#/home  /etc/autofs/auto.home
/helm   /etc/autofs/auto_rooms -nosuid,vers=3
/binio  /etc/autofs/auto_binio -nosuid,vers=3
#/helm  /etc/autofs/auto_rooms
#/binio /etc/autofs/auto_binio

auto_rooms is:
bass    mackerel:/nd
n0cr    mackerel:/n0

mack    mackerel:/usr/people

redd    reddrum:/usr/people
buff    reddrum:/nd
n0re    reddrum:/n0

sail    sailfish:/usr/people

mako    puffer:/nd
star    puffer:/ne

pom1    pompano:/u1
pom2    pompano:/u2
pom3    pompano:/u3
pom4    pompano:/u4
pom5    pompano:/u5
pom6    pompano:/u6
pom7    pompano:/u7
pom8    pompano:/u8
pom9    pompano:/u9
pom10   pompano:/u10
pom11   pompano:/u11
pom12   pompano:/u12
pom13   pompano:/u13
pom14   pompano:/u14
sync    pompano:/sync
txusr   pompano:/txusr
pomp    pompano:/usr/people
pomd    pompano:/data1

and auto_binio is:
yray    pompano:/xraz/xray


Mounting these by hand with mount is perfectly happy

I have autofs 4.1.3 on my gentoo box...
