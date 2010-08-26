From: =?ISO-8859-1?Q?Erwan_Loa=EBc?= <erwan.loaec@cgin.fr>
Subject: Problem of concurrent mount/umount call
Date: Thu, 26 Aug 2010 12:39:31 +0200
Message-ID: <4C764463.8000306@cgin.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020906080000020506080203"
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

This is a multi-part message in MIME format.
--------------020906080000020506080203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello everybody!

Versions used:
- Autofs 5.0.5 with all patchs
- Kernel 2.6.26-2-686

/etc/auto.master:
/cifs /etc/auto.cifs --timeout=60

(the timeout is small to make easier to reproduce the issue after I've 
enable debug)

There is an issue which occurred regularly (in August, it happens 3 
times). It seems that when a mount expires, and the same mount is called 
a the "same" time, automount hangs.

Please take a look to my debug log (in attachment), this is the debug 
log when the problem occurred.

Scenario:

Line 121 (10h10m40s) : Call to the share /cifs/SERV2/TM_termoz
Line 351 (10h11m42s) : Mount /cifs/SERV2/TM_termoz expiring
Line 356 (10h11m42s) : New call to the share /cifs/SERV2/TM_termoz
Line 401 (10h11m42s) : Umount /cifs/SERV2/TM_termoz with error

Then, obviously it cannot remove directory /cifs/SERV2

The automount hangs after this, so each I/O on /cifs/SERV2/TM_termoz 
hangs too...

If you want to check debug file through your browser: 
http://paste-it.net/public/n1e7286/

Otherwise, attachment :)

Is anyone has suggestions about my problem...

Thanks!

-- 
Erwan

--------------020906080000020506080203
Content-Type: text/x-log;
 name="autofs.debug.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="autofs.debug.log"

Aug 26 10:10:40 bacchus automount[17827]: handle_packet: type =3D 3
Aug 26 10:10:40 bacchus automount[17827]: handle_packet_missing_indirect:=
 token 1522, name SERV1, request pid 29498
Aug 26 10:10:40 bacchus automount[17827]: attempting to mount entry /cifs=
/SERV1
Aug 26 10:10:40 bacchus automount[17827]: lookup_mount: lookup(program): =
SERV1 -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gid=3D=
uniok,credentials=3D/etc/mycredfile  #011 /mediatheque_termox ://SERV1/me=
diatheque_termox  #011 /TM_termoz ://SERV1/TM_termoz  #011 /C\$ ://SERV1/=
C\$  #011 /logfz ://SERV1/logfz  #011 /ORL_jobs ://SERV1/ORL_jobs  #011 /=
termozOblo ://SERV1/termozOblo  #011 /ADMIN\$ ://SERV1/ADMIN\$  #011 /ter=
mozAFT ://SERV1/termozAFT  #011 /tmp_dev_termox ://SERV1/tmp_dev_termox  =
#011 /nescafe ://SERV1/nescafe  #011 /E\$ ://SERV1/E\$  #011 /termozs ://=
SERV1/termozs
Aug 26 10:10:40 bacchus automount[17827]: lookup_mount: lookup(program): =
looking up SERV1
Aug 26 10:10:40 bacchus automount[17827]: lookup_mount: lookup(program): =
SERV1 -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gid=3D=
uniok,credentials=3D/etc/mycredfile  #011 /mediatheque_termox ://SERV1/me=
diatheque_termox  #011 /TM_termoz ://SERV1/TM_termoz  #011 /C\$ ://SERV1/=
C\$  #011 /logfz ://SERV1/logfz  #011 /ORL_jobs ://SERV1/ORL_jobs  #011 /=
termozOblo ://SERV1/termozOblo  #011 /ADMIN\$ ://SERV1/ADMIN\$  #011 /ter=
mozAFT ://SERV1/termozAFT  #011 /tmp_dev_termox ://SERV1/tmp_dev_termox  =
#011 /nescafe ://SERV1/nescafe  #011 /E\$ ://SERV1/E\$  #011 /termozs ://=
SERV1/termozs
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): expand=
ed entry: -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gid=
=3Duniok,credentials=3D/etc/mycredfile  #011 /mediatheque_termox ://SERV1=
/mediatheque_termox  #011 /TM_termoz ://SERV1/TM_termoz  #011 /C\$ ://SER=
V1/C\$  #011 /logfz ://SERV1/logfz  #011 /ORL_jobs ://SERV1/ORL_jobs  #01=
1 /termozOblo ://SERV1/termozOblo  #011 /ADMIN\$ ://SERV1/ADMIN\$  #011 /=
termozAFT ://SERV1/termozAFT  #011 /tmp_dev_termox ://SERV1/tmp_dev_termo=
x  #011 /nescafe ://SERV1/nescafe  #011 /E\$ ://SERV1/E\$  #011 /termozs =
://SERV1/termozs
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): gather=
ed options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gi=
d=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/mediatheque_termox") -> /mediatheque_termox
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/mediatheque_termox") -> ://SERV1/mediatheque_termox
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /mediatheque_termox -> -fstype=3Dcifs,file_mode=3D=
0644,dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfil=
e ://SERV1/mediatheque_termox
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/TM_termoz") -> /TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/TM_termoz") -> ://SERV1/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /TM_termoz -> -fstype=3Dcifs,file_mode=3D0644,dir=
_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SER=
V1/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/C\$") -> /C$
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/C\$") -> ://SERV1/C$
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /C$ -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D=
0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV1/C$
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/logfz") -> /logfz
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/logfz") -> ://SERV1/logfz
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /logfz -> -fstype=3Dcifs,file_mode=3D0644,dir_mod=
e=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV1/l=
ogfz
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/ORL_jobs") -> /ORL_jobs
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/ORL_jobs") -> ://SERV1/ORL_jobs
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /ORL_jobs -> -fstype=3Dcifs,file_mode=3D0644,dir_=
mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV=
1/ORL_jobs
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/termozOblo") -> /termozOblo
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/termozOblo") -> ://SERV1/termozOblo
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /termozOblo -> -fstype=3Dcifs,file_mode=3D0644,di=
r_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SE=
RV1/termozOblo
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/ADMIN\$") -> /ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/ADMIN\$") -> ://SERV1/ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /ADMIN$ -> -fstype=3Dcifs,file_mode=3D0644,dir_mo=
de=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV1/=
ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/termozAFT") -> /termozAFT
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/termozAFT") -> ://SERV1/termozAFT
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /termozAFT -> -fstype=3Dcifs,file_mode=3D0644,dir=
_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SER=
V1/termozAFT
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/tmp_dev_termox") -> /tmp_dev_termox
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/tmp_dev_termox") -> ://SERV1/tmp_dev_termox
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /tmp_dev_termox -> -fstype=3Dcifs,file_mode=3D064=
4,dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile :=
//SERV1/tmp_dev_termox
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/nescafe") -> /nescafe
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/nescafe") -> ://SERV1/nescafe
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /nescafe -> -fstype=3Dcifs,file_mode=3D0644,dir_m=
ode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV1=
/nescafe
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/E\$") -> /E$
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/E\$") -> ://SERV1/E$
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /E$ -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D=
0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV1/E$
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/termozs") -> /termozs
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV1/termozs") -> ://SERV1/termozs
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /termozs -> -fstype=3Dcifs,file_mode=3D0644,dir_m=
ode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV1=
/termozs
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/ADMIN$ at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/A=
DMIN$ with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/ADMIN$ at /cifs/SERV1/ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/C$ at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/C$
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/C=
$ with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/C$ at /cifs/SERV1/C$
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/E$ at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/E$
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/E=
$ with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/E$ at /cifs/SERV1/E$
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/ORL_jobs at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/ORL_jobs
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/O=
RL_jobs with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/ORL_jobs at /cifs/SERV1/ORL_jobs
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/TM_termoz at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/T=
M_termoz with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/TM_termoz at /cifs/SERV1/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/termozAFT at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/termozAFT
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/t=
ermozAFT with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/termozAFT at /cifs/SERV1/termozAFT
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/termozOblo at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/termozOblo
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/t=
ermozOblo with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/termozOblo at /cifs/SERV1/termozOblo
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/termozs at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/termozs
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/t=
ermozs with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/termozs at /cifs/SERV1/termozs
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/logfz at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/logfz
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/l=
ogfz with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/logfz at /cifs/SERV1/logfz
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/mediatheque_termox at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/mediatheque_termox
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/m=
ediatheque_termox with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/mediatheque_termox at /cifs/SERV1/mediatheque_termox
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/tmp_dev_termox at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/tmp_dev_termox
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/t=
mp_dev_termox with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/tmp_dev_termox at /cifs/SERV1/tmp_dev_termox
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV1/nescafe at /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV1/nescafe
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV1/n=
escafe with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV1/nescafe at /cifs/SERV1/nescafe
Aug 26 10:10:40 bacchus automount[17827]: ioctl_send_ready: token =3D 152=
2
Aug 26 10:10:40 bacchus automount[17827]: mounted /cifs/SERV1
Aug 26 10:10:40 bacchus automount[17827]: handle_packet: type =3D 5
Aug 26 10:10:40 bacchus automount[17827]: handle_packet_missing_direct: t=
oken 1523, name /cifs/SERV1/TM_termoz, request pid 29498
Aug 26 10:10:40 bacchus automount[17827]: attempting to mount entry /cifs=
/SERV1/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: lookup_mount: lookup(program): =
/cifs/SERV1/TM_termoz -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,=
uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV1/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): expand=
ed entry: -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gid=
=3Duniok,credentials=3D/etc/mycredfile ://SERV1/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): gather=
ed options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gi=
d=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: sun_mount: parse(sun): mounting=
 root /tmp/auto00JJof, mountpoint /cifs/SERV1/TM_termoz, what //SERV1/TM_=
termoz, fstype cifs, options file_mode=3D0644,dir_mode=3D0755,uid=3Duniok=
,gid=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: do_mount: //SERV1/TM_termoz /ci=
fs/SERV1/TM_termoz type cifs options file_mode=3D0644,dir_mode=3D0755,uid=
=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile using module generic
Aug 26 10:10:40 bacchus automount[17827]: mount_mount: mount(generic): ca=
lling mkdir_path /tmp/auto00JJof
Aug 26 10:10:40 bacchus automount[17827]: mount_mount: mount(generic): ca=
lling mount -t cifs -s -o file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gi=
d=3Duniok,credentials=3D/etc/mycredfile //SERV1/TM_termoz /tmp/auto00JJof=

Aug 26 10:10:40 bacchus automount[17827]: mount_mount: mount(generic): mo=
unted //SERV1/TM_termoz type cifs on /tmp/auto00JJof
Aug 26 10:10:40 bacchus automount[17827]: move_mount: moved mount tree fr=
om /tmp/auto00JJof to /cifs/SERV1/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: ioctl_send_ready: token =3D 152=
3
Aug 26 10:10:40 bacchus automount[17827]: mounted /cifs/SERV1/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: handle_packet: type =3D 3
Aug 26 10:10:40 bacchus automount[17827]: handle_packet_missing_indirect:=
 token 1524, name SERV2, request pid 29498
Aug 26 10:10:40 bacchus automount[17827]: attempting to mount entry /cifs=
/SERV2
Aug 26 10:10:40 bacchus automount[17827]: lookup_mount: lookup(program): =
SERV2 -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gid=3D=
uniok,credentials=3D/etc/mycredfile  #011 /TM_termoz ://SERV2/TM_termoz  =
#011 /C\$ ://SERV2/C\$  #011 /01_MARKETING ://SERV2/01_MARKETING  #011 /0=
6_UTILISATEURS ://SERV2/06_UTILISATEURS  #011 /04_SERVICE-CLIENTS ://SERV=
2/04_SERVICE-CLIENTS  #011 /Projets ://SERV2/Projets  #011 /F\$ ://SERV2/=
F\$  #011 /02_ADMINISTRATIF ://SERV2/02_ADMINISTRATIF  #011 /03_EXPLOITAT=
ION ://SERV2/03_EXPLOITATION  #011 /05_TELECHARGEMENTS ://SERV2/05_TELECH=
ARGEMENTS  #011 /powervault ://SERV2/powervault  #011 /07_PRODUCTION ://S=
ERV2/07_PRODUCTION  #011 /packages ://SERV2/packages  #011 /08_BDD ://SER=
V2/08_BDD  #011 /ADMIN\$ ://SERV2/ADMIN\$  #011 /CGIN ://SERV2/CGIN  #011=
 /ImageMagick-6.3.3V6 ://SERV2/ImageMagick-6.3.3V6  #011 /D\$ ://SERV2/D\=
$  #011 /temp ://SERV2/temp  #011 /termozs ://SERV2/termozs  #011 /Projet=
s_Air ://SERV2/Projets_Air
Aug 26 10:10:40 bacchus automount[17827]: lookup_mount: lookup(program): =
looking up SERV2
Aug 26 10:10:40 bacchus automount[17827]: lookup_mount: lookup(program): =
SERV2 -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gid=3D=
uniok,credentials=3D/etc/mycredfile  #011 /TM_termoz ://SERV2/TM_termoz  =
#011 /C\$ ://SERV2/C\$  #011 /01_MARKETING ://SERV2/01_MARKETING  #011 /0=
6_UTILISATEURS ://SERV2/06_UTILISATEURS  #011 /04_SERVICE-CLIENTS ://SERV=
2/04_SERVICE-CLIENTS  #011 /Projets ://SERV2/Projets  #011 /F\$ ://SERV2/=
F\$  #011 /02_ADMINISTRATIF ://SERV2/02_ADMINISTRATIF  #011 /03_EXPLOITAT=
ION ://SERV2/03_EXPLOITATION  #011 /05_TELECHARGEMENTS ://SERV2/05_TELECH=
ARGEMENTS  #011 /powervault ://SERV2/powervault  #011 /07_PRODUCTION ://S=
ERV2/07_PRODUCTION  #011 /packages ://SERV2/packages  #011 /08_BDD ://SER=
V2/08_BDD  #011 /ADMIN\$ ://SERV2/ADMIN\$  #011 /CGIN ://SERV2/CGIN  #011=
 /ImageMagick-6.3.3V6 ://SERV2/ImageMagick-6.3.3V6  #011 /D\$ ://SERV2/D\=
$  #011 /temp ://SERV2/temp  #011 /termozs ://SERV2/termozs  #011 /Projet=
s_Air ://SERV2/Projets_Air
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): expand=
ed entry: -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gid=
=3Duniok,credentials=3D/etc/mycredfile  #011 /TM_termoz ://SERV2/TM_termo=
z  #011 /C\$ ://SERV2/C\$  #011 /01_MARKETING ://SERV2/01_MARKETING  #011=
 /06_UTILISATEURS ://SERV2/06_UTILISATEURS  #011 /04_SERVICE-CLIENTS ://S=
ERV2/04_SERVICE-CLIENTS  #011 /Projets ://SERV2/Projets  #011 /F\$ ://SER=
V2/F\$  #011 /02_ADMINISTRATIF ://SERV2/02_ADMINISTRATIF  #011 /03_EXPLOI=
TATION ://SERV2/03_EXPLOITATION  #011 /05_TELECHARGEMENTS ://SERV2/05_TEL=
ECHARGEMENTS  #011 /powervault ://SERV2/powervault  #011 /07_PRODUCTION :=
//SERV2/07_PRODUCTION  #011 /packages ://SERV2/packages  #011 /08_BDD ://=
SERV2/08_BDD  #011 /ADMIN\$ ://SERV2/ADMIN\$  #011 /CGIN ://SERV2/CGIN  #=
011 /ImageMagick-6.3.3V6 ://SERV2/ImageMagick-6.3.3V6  #011 /D\$ ://SERV2=
/D\$  #011 /temp ://SERV2/temp  #011 /termozs ://SERV2/termozs  #011 /Pro=
jets_Air ://SERV2/Projets_Air
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): gather=
ed options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gi=
d=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/TM_termoz") -> /TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/TM_termoz") -> ://SERV2/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /TM_termoz -> -fstype=3Dcifs,file_mode=3D0644,dir=
_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SER=
V2/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/C\$") -> /C$
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/C\$") -> ://SERV2/C$
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /C$ -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D=
0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2/C$
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/01_MARKETING") -> /01_MARKETING
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/01_MARKETING") -> ://SERV2/01_MARKETING
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /01_MARKETING -> -fstype=3Dcifs,file_mode=3D0644,=
dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://=
SERV2/01_MARKETING
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/06_UTILISATEURS") -> /06_UTILISATEURS
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/06_UTILISATEURS") -> ://SERV2/06_UTILISATEURS
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /06_UTILISATEURS -> -fstype=3Dcifs,file_mode=3D06=
44,dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile =
://SERV2/06_UTILISATEURS
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/04_SERVICE-CLIENTS") -> /04_SERVICE-CLIENTS
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/04_SERVICE-CLIENTS") -> ://SERV2/04_SERVICE-CLIENTS
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /04_SERVICE-CLIENTS -> -fstype=3Dcifs,file_mode=3D=
0644,dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfil=
e ://SERV2/04_SERVICE-CLIENTS
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/Projets") -> /Projets
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/Projets") -> ://SERV2/Projets
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /Projets -> -fstype=3Dcifs,file_mode=3D0644,dir_m=
ode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2=
/Projets
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/F\$") -> /F$
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/F\$") -> ://SERV2/F$
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /F$ -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D=
0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2/F$
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/02_ADMINISTRATIF") -> /02_ADMINISTRATIF
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/02_ADMINISTRATIF") -> ://SERV2/02_ADMINISTRATIF
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /02_ADMINISTRATIF -> -fstype=3Dcifs,file_mode=3D0=
644,dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile=
 ://SERV2/02_ADMINISTRATIF
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/03_EXPLOITATION") -> /03_EXPLOITATION
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/03_EXPLOITATION") -> ://SERV2/03_EXPLOITATION
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /03_EXPLOITATION -> -fstype=3Dcifs,file_mode=3D06=
44,dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile =
://SERV2/03_EXPLOITATION
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/05_TELECHARGEMENTS") -> /05_TELECHARGEMENTS
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/05_TELECHARGEMENTS") -> ://SERV2/05_TELECHARGEMENTS
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /05_TELECHARGEMENTS -> -fstype=3Dcifs,file_mode=3D=
0644,dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfil=
e ://SERV2/05_TELECHARGEMENTS
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/powervault") -> /powervault
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/powervault") -> ://SERV2/powervault
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /powervault -> -fstype=3Dcifs,file_mode=3D0644,di=
r_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SE=
RV2/powervault
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/07_PRODUCTION") -> /07_PRODUCTION
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/07_PRODUCTION") -> ://SERV2/07_PRODUCTION
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /07_PRODUCTION -> -fstype=3Dcifs,file_mode=3D0644=
,dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile :/=
/SERV2/07_PRODUCTION
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/packages") -> /packages
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/packages") -> ://SERV2/packages
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /packages -> -fstype=3Dcifs,file_mode=3D0644,dir_=
mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV=
2/packages
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/08_BDD") -> /08_BDD
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/08_BDD") -> ://SERV2/08_BDD
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /08_BDD -> -fstype=3Dcifs,file_mode=3D0644,dir_mo=
de=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2/=
08_BDD
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/ADMIN\$") -> /ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/ADMIN\$") -> ://SERV2/ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /ADMIN$ -> -fstype=3Dcifs,file_mode=3D0644,dir_mo=
de=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2/=
ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/CGIN") -> /CGIN
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/CGIN") -> ://SERV2/CGIN
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /CGIN -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=
=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2/CG=
IN
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/ImageMagick-6.3.3V6") -> /ImageMagick-6.3.3V6
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/ImageMagick-6.3.3V6") -> ://SERV2/ImageMagick-6.3.3V6
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /ImageMagick-6.3.3V6 -> -fstype=3Dcifs,file_mode=3D=
0644,dir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfil=
e ://SERV2/ImageMagick-6.3.3V6
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/D\$") -> /D$
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/D\$") -> ://SERV2/D$
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /D$ -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D=
0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2/D$
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/temp") -> /temp
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/temp") -> ://SERV2/temp
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /temp -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=
=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2/te=
mp
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/termozs") -> /termozs
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/termozs") -> ://SERV2/termozs
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /termozs -> -fstype=3Dcifs,file_mode=3D0644,dir_m=
ode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2=
/termozs
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): dequot=
e("/Projets_Air") -> /Projets_Air
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): gathe=
red options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,g=
id=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: parse_mapent: parse(sun): dequo=
te("://SERV2/Projets_Air") -> ://SERV2/Projets_Air
Aug 26 10:10:40 bacchus automount[17827]: add_offset_entry: parse(sun): a=
dded multi-mount offset /Projets_Air -> -fstype=3Dcifs,file_mode=3D0644,d=
ir_mode=3D0755,uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://S=
ERV2/Projets_Air
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/01_MARKETING at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/01_MARKETING
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/0=
1_MARKETING with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/01_MARKETING at /cifs/SERV2/01_MARKETING
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/02_ADMINISTRATIF at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/02_ADMINISTRATIF
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/0=
2_ADMINISTRATIF with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/02_ADMINISTRATIF at /cifs/SERV2/02_ADMINISTRATIF
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/03_EXPLOITATION at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/03_EXPLOITATION
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/0=
3_EXPLOITATION with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/03_EXPLOITATION at /cifs/SERV2/03_EXPLOITATION
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/04_SERVICE-CLIENTS at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/04_SERVICE-CLIENTS
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/0=
4_SERVICE-CLIENTS with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/04_SERVICE-CLIENTS at /cifs/SERV2/04_SERVICE-CLIENTS
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/05_TELECHARGEMENTS at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/05_TELECHARGEMENTS
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/0=
5_TELECHARGEMENTS with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/05_TELECHARGEMENTS at /cifs/SERV2/05_TELECHARGEMENTS
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/06_UTILISATEURS at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/06_UTILISATEURS
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/0=
6_UTILISATEURS with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/06_UTILISATEURS at /cifs/SERV2/06_UTILISATEURS
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/07_PRODUCTION at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/07_PRODUCTION
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/0=
7_PRODUCTION with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/07_PRODUCTION at /cifs/SERV2/07_PRODUCTION
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/08_BDD at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/08_BDD
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/0=
8_BDD with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/08_BDD at /cifs/SERV2/08_BDD
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/ADMIN$ at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/A=
DMIN$ with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/ADMIN$ at /cifs/SERV2/ADMIN$
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/C$ at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/C$
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/C=
$ with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/C$ at /cifs/SERV2/C$
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/CGIN at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/CGIN
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/C=
GIN with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/CGIN at /cifs/SERV2/CGIN
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/D$ at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/D$
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/D=
$ with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/D$ at /cifs/SERV2/D$
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/F$ at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/F$
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/F=
$ with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/F$ at /cifs/SERV2/F$
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/ImageMagick-6.3.3V6 at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/ImageMagick-6.3.3V6
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/I=
mageMagick-6.3.3V6 with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/ImageMagick-6.3.3V6 at /cifs/SERV2/ImageMagick-6.3.3V6
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/TM_termoz at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/T=
M_termoz with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/TM_termoz at /cifs/SERV2/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/Projets at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/Projets
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/P=
rojets with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/Projets at /cifs/SERV2/Projets
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/Projets_Air at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/Projets_Air
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/P=
rojets_Air with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/Projets_Air at /cifs/SERV2/Projets_Air
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/termozs at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/termozs
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/t=
ermozs with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/termozs at /cifs/SERV2/termozs
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/packages at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/packages
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/p=
ackages with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/packages at /cifs/SERV2/packages
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/powervault at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/powervault
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/p=
owervault with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/powervault at /cifs/SERV2/powervault
Aug 26 10:10:40 bacchus automount[17827]: mount_multi_triggers: mount off=
set /cifs/SERV2/temp at /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: calling mo=
unt -t autofs -s  -o fd=3D6,pgrp=3D17827,minproto=3D5,maxproto=3D5,offset=
 automount /cifs/SERV2/temp
Aug 26 10:10:40 bacchus automount[17827]: mounted offset on /cifs/SERV2/t=
emp with timeout 60, freq 15 seconds
Aug 26 10:10:40 bacchus automount[17827]: mount_autofs_offset: mounted tr=
igger /cifs/SERV2/temp at /cifs/SERV2/temp
Aug 26 10:10:40 bacchus automount[17827]: ioctl_send_ready: token =3D 152=
4
Aug 26 10:10:40 bacchus automount[17827]: handle_packet: type =3D 5
Aug 26 10:10:40 bacchus automount[17827]: handle_packet_missing_direct: t=
oken 1525, name /cifs/SERV2/TM_termoz, request pid 29498
Aug 26 10:10:40 bacchus automount[17827]: attempting to mount entry /cifs=
/SERV2/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: lookup_mount: lookup(program): =
/cifs/SERV2/TM_termoz -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,=
uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): expand=
ed entry: -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gid=
=3Duniok,credentials=3D/etc/mycredfile ://SERV2/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: parse_mount: parse(sun): gather=
ed options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gi=
d=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: sun_mount: parse(sun): mounting=
 root /tmp/autoC7eymh, mountpoint /cifs/SERV2/TM_termoz, what //SERV2/TM_=
termoz, fstype cifs, options file_mode=3D0644,dir_mode=3D0755,uid=3Duniok=
,gid=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:10:40 bacchus automount[17827]: do_mount: //SERV2/TM_termoz /ci=
fs/SERV2/TM_termoz type cifs options file_mode=3D0644,dir_mode=3D0755,uid=
=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile using module generic
Aug 26 10:10:40 bacchus automount[17827]: mount_mount: mount(generic): ca=
lling mkdir_path /tmp/autoC7eymh
Aug 26 10:10:40 bacchus automount[17827]: mount_mount: mount(generic): ca=
lling mount -t cifs -s -o file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gi=
d=3Duniok,credentials=3D/etc/mycredfile //SERV2/TM_termoz /tmp/autoC7eymh=

Aug 26 10:10:40 bacchus automount[17827]: mounted /cifs/SERV2
Aug 26 10:10:40 bacchus automount[17827]: mount_mount: mount(generic): mo=
unted //SERV2/TM_termoz type cifs on /tmp/autoC7eymh
Aug 26 10:10:40 bacchus automount[17827]: move_mount: moved mount tree fr=
om /tmp/autoC7eymh to /cifs/SERV2/TM_termoz
Aug 26 10:10:40 bacchus automount[17827]: ioctl_send_ready: token =3D 152=
5
Aug 26 10:10:40 bacchus automount[17827]: mounted /cifs/SERV2/TM_termoz
Aug 26 10:10:42 bacchus automount[17827]: st_expire: state 1 path /cifs
Aug 26 10:10:42 bacchus automount[17827]: expire_proc: exp_proc =3D 30744=
03216 path /cifs
Aug 26 10:10:42 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV1/TM_termoz
Aug 26 10:10:42 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV2/TM_termoz
Aug 26 10:10:42 bacchus automount[17827]: 2 remaining in /cifs
Aug 26 10:10:42 bacchus automount[17827]: expire_cleanup: got thid 307440=
3216 path /cifs stat 36
Aug 26 10:10:42 bacchus automount[17827]: expire_cleanup: sigchld: exp 30=
74403216 finished, switching from 2 to 1
Aug 26 10:10:42 bacchus automount[17827]: st_ready: st_ready(): state =3D=
 2 path /cifs
Aug 26 10:10:57 bacchus automount[17827]: st_expire: state 1 path /cifs
Aug 26 10:10:57 bacchus automount[17827]: expire_proc: exp_proc =3D 30744=
03216 path /cifs
Aug 26 10:10:57 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV1/TM_termoz
Aug 26 10:10:57 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV2/TM_termoz
Aug 26 10:10:57 bacchus automount[17827]: 2 remaining in /cifs
Aug 26 10:10:57 bacchus automount[17827]: expire_cleanup: got thid 307440=
3216 path /cifs stat 36
Aug 26 10:10:57 bacchus automount[17827]: expire_cleanup: sigchld: exp 30=
74403216 finished, switching from 2 to 1
Aug 26 10:10:57 bacchus automount[17827]: st_ready: st_ready(): state =3D=
 2 path /cifs
Aug 26 10:11:12 bacchus automount[17827]: st_expire: state 1 path /cifs
Aug 26 10:11:12 bacchus automount[17827]: expire_proc: exp_proc =3D 30744=
03216 path /cifs
Aug 26 10:11:12 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV1/TM_termoz
Aug 26 10:11:12 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV2/TM_termoz
Aug 26 10:11:12 bacchus automount[17827]: 2 remaining in /cifs
Aug 26 10:11:12 bacchus automount[17827]: expire_cleanup: got thid 307440=
3216 path /cifs stat 36
Aug 26 10:11:12 bacchus automount[17827]: expire_cleanup: sigchld: exp 30=
74403216 finished, switching from 2 to 1
Aug 26 10:11:12 bacchus automount[17827]: st_ready: st_ready(): state =3D=
 2 path /cifs
Aug 26 10:11:27 bacchus automount[17827]: st_expire: state 1 path /cifs
Aug 26 10:11:27 bacchus automount[17827]: expire_proc: exp_proc =3D 30744=
03216 path /cifs
Aug 26 10:11:27 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV1/TM_termoz
Aug 26 10:11:27 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV2/TM_termoz
Aug 26 10:11:27 bacchus automount[17827]: 2 remaining in /cifs
Aug 26 10:11:27 bacchus automount[17827]: expire_cleanup: got thid 307440=
3216 path /cifs stat 36
Aug 26 10:11:27 bacchus automount[17827]: expire_cleanup: sigchld: exp 30=
74403216 finished, switching from 2 to 1
Aug 26 10:11:27 bacchus automount[17827]: st_ready: st_ready(): state =3D=
 2 path /cifs
Aug 26 10:11:42 bacchus automount[17827]: st_expire: state 1 path /cifs
Aug 26 10:11:42 bacchus automount[17827]: expire_proc: exp_proc =3D 30744=
03216 path /cifs
Aug 26 10:11:42 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV1/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: handle_packet: type =3D 6
Aug 26 10:11:42 bacchus automount[17827]: handle_packet_expire_direct: to=
ken 1526, name /cifs/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: expiring path /cifs/SERV2/TM_te=
rmoz
Aug 26 10:11:42 bacchus automount[17827]: umount_multi: path /cifs/SERV2/=
TM_termoz incl 1
Aug 26 10:11:42 bacchus automount[17827]: umount_subtree_mounts: unmounti=
ng dir =3D /cifs/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: expired /cifs/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: ioctl_send_ready: token =3D 152=
6
Aug 26 10:11:42 bacchus automount[17827]: handle_packet: type =3D 5
Aug 26 10:11:42 bacchus automount[17827]: handle_packet_missing_direct: t=
oken 1527, name /cifs/SERV2/TM_termoz, request pid 29523
Aug 26 10:11:42 bacchus automount[17827]: attempting to mount entry /cifs=
/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: lookup_mount: lookup(program): =
/cifs/SERV2/TM_termoz -> -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,=
uid=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile ://SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: parse_mount: parse(sun): expand=
ed entry: -fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gid=
=3Duniok,credentials=3D/etc/mycredfile ://SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: parse_mount: parse(sun): gather=
ed options: fstype=3Dcifs,file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gi=
d=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:11:42 bacchus automount[17827]: sun_mount: parse(sun): mounting=
 root /tmp/auto1I7gB7, mountpoint /cifs/SERV2/TM_termoz, what //SERV2/TM_=
termoz, fstype cifs, options file_mode=3D0644,dir_mode=3D0755,uid=3Duniok=
,gid=3Duniok,credentials=3D/etc/mycredfile
Aug 26 10:11:42 bacchus automount[17827]: do_mount: //SERV2/TM_termoz /ci=
fs/SERV2/TM_termoz type cifs options file_mode=3D0644,dir_mode=3D0755,uid=
=3Duniok,gid=3Duniok,credentials=3D/etc/mycredfile using module generic
Aug 26 10:11:42 bacchus automount[17827]: mount_mount: mount(generic): ca=
lling mkdir_path /tmp/auto1I7gB7
Aug 26 10:11:42 bacchus automount[17827]: mount_mount: mount(generic): ca=
lling mount -t cifs -s -o file_mode=3D0644,dir_mode=3D0755,uid=3Duniok,gi=
d=3Duniok,credentials=3D/etc/mycredfile //SERV2/TM_termoz /tmp/auto1I7gB7=

Aug 26 10:11:42 bacchus automount[17827]: mount_mount: mount(generic): mo=
unted //SERV2/TM_termoz type cifs on /tmp/auto1I7gB7
Aug 26 10:11:42 bacchus automount[17827]: move_mount: moved mount tree fr=
om /tmp/auto1I7gB7 to /cifs/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: handle_packet: type =3D 4
Aug 26 10:11:42 bacchus automount[17827]: handle_packet_expire_indirect: =
token 1528, name SERV2
Aug 26 10:11:42 bacchus automount[17827]: expiring path /cifs/SERV2
Aug 26 10:11:42 bacchus automount[17827]: umount_multi: path /cifs/SERV2 =
incl 1
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/01_MARKETING
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/01_MARKETING
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/02_ADMINISTRATIF
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/02_ADMINISTRATIF
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/03_EXPLOITATION
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/03_EXPLOITATION
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/04_SERVICE-CLIENTS
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/04_SERVICE-CLIENTS
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/05_TELECHARGEMENTS
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/05_TELECHARGEMENTS
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/06_UTILISATEURS
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/06_UTILISATEURS
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/07_PRODUCTION
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/07_PRODUCTION
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/08_BDD
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/08_BDD
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/ADMIN$
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/ADMIN$
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/C$
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/C$
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/CGIN
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/CGIN
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/D$
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/D$
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/F$
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/F$
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/ImageMagick-6.3.3V6
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/ImageMagick-6.3.3V6
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: umount_autofs_offset: couldn't =
get ioctl fd for offset /cifs/SERV2/TM_termoz: No such file or directory
Aug 26 10:11:42 bacchus automount[17827]: forcing umount of offset mount =
/cifs/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: failed to remove dir /cifs/SERV=
2/TM_termoz: Device or resource busy
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/Projets
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/Projets
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/Projets_Air
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/Projets_Air
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/termozs
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/termozs
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/packages
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/packages
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/powervault
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/powervault
Aug 26 10:11:42 bacchus automount[17827]: umount_multi_triggers: umount o=
ffset /cifs/SERV2/temp
Aug 26 10:11:42 bacchus automount[17827]: umounted offset mount /cifs/SER=
V2/temp
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/01_MARKETING
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/02_ADMINISTRATIF
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/03_EXPLOITATION
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/04_SERVICE-CLIENTS
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/05_TELECHARGEMENTS
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/06_UTILISATEURS
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/07_PRODUCTION
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/08_BDD
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/ADMIN$
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/C$
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/CGIN
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/D$
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/F$
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/ImageMagick-6.3.3V6
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/Projets
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/Projets_Air
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/termozs
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/packages
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/powervault
Aug 26 10:11:42 bacchus automount[17827]: cache_delete_offset_list: delet=
ing offset key /cifs/SERV2/temp
Aug 26 10:11:42 bacchus automount[17827]: ioctl_send_ready: token =3D 152=
7
Aug 26 10:11:42 bacchus automount[17827]: mounted /cifs/SERV2/TM_termoz
Aug 26 10:11:42 bacchus automount[17827]: handle_packet: type =3D 5
Aug 26 10:11:42 bacchus automount[17827]: rm_unwanted_fn: removing direct=
ory /cifs/SERV2
Aug 26 10:11:42 bacchus automount[17827]: unable to remove directory /cif=
s/SERV2: Directory not empty
Aug 26 10:11:42 bacchus automount[17827]: expired /cifs/SERV2
Aug 26 10:11:42 bacchus automount[17827]: handle_packet_missing_direct:13=
23: can't find map entry for (46,12396497)
Aug 26 10:11:42 bacchus automount[17827]: ioctl_send_ready: token =3D 152=
8
Aug 26 10:11:42 bacchus automount[17827]: 1 remaining in /cifs
Aug 26 10:11:42 bacchus automount[17827]: expire_cleanup: got thid 307440=
3216 path /cifs stat 36
Aug 26 10:11:42 bacchus automount[17827]: expire_cleanup: sigchld: exp 30=
74403216 finished, switching from 2 to 1
Aug 26 10:11:42 bacchus automount[17827]: st_ready: st_ready(): state =3D=
 2 path /cifs
Aug 26 10:11:57 bacchus automount[17827]: st_expire: state 1 path /cifs
Aug 26 10:11:57 bacchus automount[17827]: expire_proc: exp_proc =3D 30744=
03216 path /cifs
Aug 26 10:11:57 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV1/TM_termoz
Aug 26 10:11:57 bacchus automount[17827]: 1 remaining in /cifs
Aug 26 10:11:57 bacchus automount[17827]: expire_cleanup: got thid 307440=
3216 path /cifs stat 15
Aug 26 10:11:57 bacchus automount[17827]: expire_cleanup: sigchld: exp 30=
74403216 finished, switching from 2 to 1
Aug 26 10:11:57 bacchus automount[17827]: st_ready: st_ready(): state =3D=
 2 path /cifs
Aug 26 10:12:12 bacchus automount[17827]: st_expire: state 1 path /cifs
Aug 26 10:12:12 bacchus automount[17827]: expire_proc: exp_proc =3D 30744=
03216 path /cifs
Aug 26 10:12:12 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV1/TM_termoz
Aug 26 10:12:12 bacchus automount[17827]: 1 remaining in /cifs
Aug 26 10:12:12 bacchus automount[17827]: expire_cleanup: got thid 307440=
3216 path /cifs stat 15
Aug 26 10:12:12 bacchus automount[17827]: expire_cleanup: sigchld: exp 30=
74403216 finished, switching from 2 to 1
Aug 26 10:12:12 bacchus automount[17827]: st_ready: st_ready(): state =3D=
 2 path /cifs
Aug 26 10:12:27 bacchus automount[17827]: st_expire: state 1 path /cifs
Aug 26 10:12:27 bacchus automount[17827]: expire_proc: exp_proc =3D 30744=
03216 path /cifs
Aug 26 10:12:27 bacchus automount[17827]: expire_proc_indirect: expire /c=
ifs/SERV1/TM_termoz

--------------020906080000020506080203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------020906080000020506080203--

