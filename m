From: "Brickles, Stephen" <sbrickle@intersil.com>
Subject: RPC: Can't bind to reserved port (98) in autofs 4.1.3-240
Date: Tue, 12 Jul 2011 08:33:26 -0700
Message-ID: <FCE556EDF6801749BB1208C7F6F79FC1BCE14F@MILMX02.intersil.corp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8912673641413376148=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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

--===============8912673641413376148==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CC40A9.0C57E7E2"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC40A9.0C57E7E2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This bug seems to crop up from time to time.  I've never had much luck
in being able
to fix this by running Redhat updates.  It seems to be pretty random.
Finally I found a
machine on which this bug recurred over and over and so I was able to
set up debugging on it.

The mount point listed in these maps below is a fully functioning
mount-point most of the time.
There are other mount points in 'auto.mntpnt' which have the same random
error - I just pruned
these out to make the explanation simpler.

I set up the debugging according to Jeff's instructions at
http://people.redhat.com/jmoyer
and the output is below.

It would appear from Google that "found negative cache entry for key" is
an issue which seems
to have come up before.  Also from the debug log, it's difficult to tell
if this is a problem
with 'autofs' or 'mount'.

Also this machine is part of a simulation server farm.  It would appear
that sending a sequence
of simulation jobs in rapid succession to a host (ie. multiple rsh by a
user in a short period of time)
causing a whole bunch of mount requests at once, seems more likely
trigger this problem.

Thanks,
Stephen


> uname -a
Linux server3 2.6.9-100.ELsmp #1 SMP Tue Feb 1 12:04:42 EST 2011 x86_64
x86_64 x86_64 GNU/Linux

> cat /etc/redhat-release
Red Hat Enterprise Linux WS release 4 (Nahant Update 9)

> rpm -qa | grep autofs
autofs-4.1.3-240

> rpm -qa | grep nfs-utils
nfs-utils-lib-devel-1.0.6-10.el4_8.1
nfs-utils-1.0.6-94.EL4
nfs-utils-lib-1.0.6-10.el4_8.1

auto.master:
/mntpnt auto.mntpnt      -rw,intr,soft,vers=3D3

auto.mntpnt:
mail -rw,actimeo=3D0,vers=3D3       nis_server:/var/mail

/var/log/messages:
Jul 11 23:54:01 server3 automount[6778]: attempting to mount entry
/mntpnt/mail
Jul 11 23:54:01 server3 kernel: RPC: Can't bind to reserved port (98).
Jul 11 23:54:01 server3 kernel: RPC: can't bind to reserved port.
Jul 11 23:54:01 server3 kernel: RPC: error 5 connecting to server
nis_server
Jul 11 23:54:01 server3 kernel: RPC: Can't bind to reserved port (98).
Jul 11 23:54:01 server3 kernel: RPC: can't bind to reserved port.
Jul 11 23:54:01 server3 automount[3564]: >> mount: nis_server:/var/mail:
can't read superblock
Jul 11 23:54:01 server3 kernel: RPC: error 5 connecting to server
nis_server
Jul 11 23:54:01 server3 automount[3564]: mount(nfs): nfs: mount failure
nis_server:/var/mail on /mntpnt/mail
Jul 11 23:54:01 server3 automount[3564]: failed to mount /mntpnt/mail

/var/log/debug:
Jul 11 23:54:01 server3 automount[6778]: send_fail: token=3D247707
Jul 11 23:54:01 server3 automount[6778]: handle_packet: type =3D 0
Jul 11 23:54:01 server3 automount[6778]: handle_packet_missing: token
247708, name mail
Jul 11 23:54:01 server3 automount[6778]: handle_packet_missing: expired
negative cache entry for key.
Jul 11 23:54:01 server3 automount[6778]: attempting to mount entry
/mntpnt/mail
Jul 11 23:54:01 server3 automount[3564]: lookup(yp): looking up mail
Jul 11 23:54:01 server3 automount[6778]: mt->key set to mail
Jul 11 23:54:01 server3 automount[3564]: lookup(yp): mail ->
-rw,actimeo=3D0,vers=3D3 nis_server:/var/mail
Jul 11 23:54:01 server3 automount[3564]: parse(sun): expanded entry:
-rw,actimeo=3D0,vers=3D3 nis_server:/var/mail
Jul 11 23:54:01 server3 automount[3564]: parse(sun):
dequote("rw,actimeo=3D0,vers=3D3") -> rw,actimeo=3D0,vers=3D3=20
Jul 11 23:54:01 server3 automount[3564]: parse(sun): gathered options:
7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3
Jul 11 23:54:01 server3 automount[3564]: parse(sun):
dequote("nis_server:/var/mail") -> nis_server:/var/mail
Jul 11 23:54:01 server3 automount[3564]: parse(sun): core of entry:
options=3D7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3,
loc=3Dnis_server:/var/mail
Jul 11 23:54:01 server3 automount[3564]: parse(sun): mounting root
/mntpnt, mountpoint mail, what nis_server:/var/mail, fstype nfs, options
7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3
Jul 11 23:54:01 server3 automount[3564]: mount(nfs):  root=3D/mntpnt
name=3Dmail what=3Dnis_server:/var/mail, fstype=3Dnfs,
options=3D7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3
Jul 11 23:54:01 server3 automount[3564]: mount(nfs): nfs
options=3D"7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3", =
nosymlink=3D0 Jul 11
23:54:01 server3 automount[3564]: mount(nfs): calling mkdir_path
/mntpnt/mail
Jul 11 23:54:01 server3 automount[3564]: mount(nfs): calling mount -t
nfs -s -o 7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3 =
nis_server:/var/mail
/mntpnt/mail
Jul 11 23:54:01 server3 automount[3564]: >> mount: nis_server:/var/mail:
can't read superblock
Jul 11 23:54:01 server3 automount[3564]: mount(nfs): nfs: mount failure
nis_server:/var/mail on /mntpnt/mail
Jul 11 23:54:01 server3 automount[3564]: failed to mount /mntpnt/mail
Jul 11 23:54:01 server3 automount[3564]: umount_multi: =
path=3D/mntpnt/mail
incl=3D1
Jul 11 23:54:01 server3 automount[6778]: handle_child: got pid 3564, sig
0 (0), stat 2
Jul 11 23:54:01 server3 automount[6778]: sig_child: found pending iop
pid 3564: signalled 0 (sig 0), exit status 2
Jul 11 23:54:01 server3 automount[6778]: update_negative_cache: key:
mail
Jul 11 23:54:01 server3 automount[6778]: Adding negative cache entry for
key mail
Jul 11 23:54:01 server3 automount[6778]: Key mail added to negative
cache
Jul 11 23:54:01 server3 automount[6778]: send_fail: token=3D247708
Jul 11 23:54:01 server3 automount[6778]: handle_packet: type =3D 0
Jul 11 23:54:01 server3 automount[6778]: handle_packet_missing: token
247709, name mail
Jul 11 23:54:01 server3 automount[6778]: handle_packet_missing: found
negative cache entry for key.
Jul 11 23:54:01 server3 automount[6778]: send_fail: token=3D247709
Jul 11 23:54:01 server3 automount[6778]: handle_packet: type =3D 0
Jul 11 23:54:01 server3 automount[6778]: handle_packet_missing: token
247710, name mail
Jul 11 23:54:01 server3 automount[6778]: handle_packet_missing: found
negative cache entry for key.
Jul 11 23:54:01 server3 automount[6778]: send_fail: token=3D247710
Jul 11 23:54:01 server3 automount[6778]: handle_packet: type =3D 0
Jul 11 23:54:01 server3 automount[6778]: handle_packet_missing: token
247711, name mail
Jul 11 23:54:01 server3 automount[6778]: handle_packet_missing: found
negative cache entry for key.
Jul 11 23:54:01 server3 automount[6778]: send_fail: token=3D247711

/etc/sysconfig/autofs:
# Define custom options in /etc/sysconfig/autofs
# Use LOCALOPTIONS for defining variables, e.g. OSREL
# Use DAEMONOPTIONS to define the unmount timeout
# Define UNDERSCORETODOT as 1 to convert=20
#     auto_home to auto.home and auto_mnt to auto.mnt
# Mount options, e.g. rsize=3D8192, should go in auto.master or
#     the auto_* map entry for a specific mount point
#
LOCALOPTIONS=3D""
DAEMONOPTIONS=3D"--timeout=3D60 --debug --set-log-priority 7"
LDAPAUTOMASTER=3D""
#  UNDERSCORETODOT changes auto_home to auto.home and auto_mnt to
auto.mnt
UNDERSCORETODOT=3D1
DISABLE_DIRECT=3D1
# Only source one master map if set to 1.  This would mimic Sun
behaviour.
# The default is 0 to maintain backwards compatibility.
ONE_AUTO_MASTER=3D0
# List of directories to be ghosted, separated by white space.
GHOSTDIRS=3D""
# Base DN to use when searching for the master map BASEDN=3D
# The ldap module was updated to only try the first schema that works
# (instead of trying all 3 autofs schemas for each lookup).  It is
# possible, though unlikely, that this could cause problems.  If you
update
# the automounter and find that your ldap schemas doesn't work as it did
# previously, try setting this option to 1.  Please also report the
problem,
# as it is likely that your schema is incompatible with autofs v5.
OLD_LDAP_LOOKUP=3D0

/etc/nsswitch.conf:
#
# /etc/nsswitch.conf
#
# An example Name Service Switch config file. This file should be #
sorted with the most-used services at the beginning.
#
# The entry '[NOTFOUND=3Dreturn]' means that the search for an # entry
should stop if the search in the previous entry turned # up nothing.
Note that if the search failed due to some other reason # (like no NIS
server responding) then the search continues with the # next entry.
#
# Legal entries are:
#
#	nis or yp		Use NIS (NIS version 2), also called YP
#	dns			Use DNS (Domain Name Service)
#	files			Use the local files
#	db			Use the local database (.db) files
#	compat			Use NIS on compat mode
#	hesiod			Use Hesiod for user lookups
#	ldap			Use LDAP (only if nss_ldap is installed)
#	nisplus or nis+		Use NIS+ (NIS version 3), unsupported
#	[NOTFOUND=3Dreturn]	Stop searching if not found so far
#

# To use db, put the "db" in front of "files" for entries you want to be
# looked up first in the databases # # Example:
#passwd:    db files ldap nis
#shadow:    db files ldap nis
#group:     db files ldap nis

passwd:     files nis
shadow:     files nis
group:      files nis

#hosts:     db files ldap nis dns
hosts:      files nis dns

# Example - obey only what ldap tells us...
#services:  ldap [NOTFOUND=3Dreturn] files
#networks:  ldap [NOTFOUND=3Dreturn] files
#protocols: ldap [NOTFOUND=3Dreturn] files
#rpc:       ldap [NOTFOUND=3Dreturn] files
#ethers:    ldap [NOTFOUND=3Dreturn] files

bootparams: files
ethers:     files
netmasks:   files
networks:   files
protocols:  files nis
rpc:        files
services:   files nis
netgroup:   files nis
publickey:  files
automount:  files nis
aliases:    files



------_=_NextPart_001_01CC40A9.0C57E7E2
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RPC: Can't bind to reserved port (98) in autofs 4.1.3-240</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">This bug seems =
to crop up</FONT></SPAN><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"> =
from time to time.&nbsp; I</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">ve never had much luck in being able</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">to fix this by =
running Redhat updates.&nbsp;</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">It seems to be pretty random.</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas">&nbsp;</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT FACE=3D"Consolas">Finally I found =
a</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">machine on =
which this bug</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">recurred over and over and so I was able to set up =
debugging on it.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">The mount =
point</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">listed in these maps below is a fully functioning =
mount-point most of the time.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">There are =
other mount points in</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">&#8216;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">auto.</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> which have the same random error</FONT></SPAN><SPAN =
LANG=3D"en-us"> <FONT FACE=3D"Consolas">&#8211;</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas"> I just pruned</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">these out to =
make the explanation simpler.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">I set up the =
debu</FONT></SPAN><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">gging =
according to Jeff</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">s instructions at</FONT></SPAN><SPAN LANG=3D"en-us"> =
</SPAN><A HREF=3D"http://people.redhat.com/jmoyer"><SPAN =
LANG=3D"en-us"><U><FONT COLOR=3D"#0000FF" =
FACE=3D"Consolas">http://people.redhat.com/jmoyer</FONT></U></SPAN><SPAN =
LANG=3D"en-us"></SPAN></A><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">and the output =
is below</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">It would =
appear from Google that</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">&#8220;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">found negative cache entry for key</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas">&#8221;</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas"> is an issue which =
seems</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">to have come =
up before.</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">&nbsp; Also from the debug log, it</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas">&#8217;</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas">s difficult to tell if this is a =
problem</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">with</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">&#8216;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">autofs</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> or</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">&#8216;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mount</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">&#8217;</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">.</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Also this =
machine is part of a</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">simulation</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"></FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server farm</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">.&nbsp; It would appear that sending a =
sequence</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">of</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">simulation</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">jobs in rapid succession</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas"> to a host (ie. multiple rsh by a =
user in a short period of time)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">causing a =
whole bunch of mount</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> requests at once,</FONT></SPAN><SPAN LANG=3D"en-us"> =
<FONT FACE=3D"Consolas">seems</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">more likely</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> trigger this problem</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas">.</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">Thanks,</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">Stephen</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">&gt; uname =
-a</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">Linux</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> 2.6.9-100.ELsmp #1 SMP Tue Feb 1 12:04:42 EST 2011 =
x86_64 x86_64 x86_64 GNU/Linux</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">&gt; cat =
/etc/redhat-release</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Red Hat =
Enterprise Linux WS release 4 (Nahant Update 9)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">&gt; rpm -qa | =
grep autofs</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">autofs-4.1.3-240</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">&gt; rpm -qa | =
grep nfs-utils</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">nfs-utils-lib-devel-1.0.6-10.el4_8.1</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">nfs-utils-1.0.6-94.EL4</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">nfs-utils-lib-1.0.6-10.el4_8.1</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">auto.master:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> auto.</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-rw,intr,soft,vers=3D3</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">auto.</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">mail =
-rw,actimeo=3D0,vers=3D3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
nis_server:/var/mail</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/var/log/messages:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: attempting to mount entry =
/</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> kernel: RPC: Can't bind to reserved port =
(98).</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> kernel: RPC: can't bind to reserved =
port.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> kernel: RPC: error 5 connecting to server =
nis_server</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> kernel: RPC: Can't bind to reserved port =
(98).</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> kernel: RPC: can't bind to reserved =
port.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: &gt;&gt; mount: =
nis_server:/var/mail: can't read superblock</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> kernel: RPC: error 5 connecting to server =
nis_server</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: mount(nfs): nfs: mount failure =
nis_server:/var/mail on /</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: failed to mount /</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas">/mail</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/var/log/debug:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: send_fail: =
token=3D247707</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet: type =3D =
0</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet_missing: token 247708, =
name mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet_missing: expired =
negative cache entry for key.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: attempting to mount entry =
/</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: lookup(yp): looking up =
mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: mt-&gt;key set to =
mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: lookup(yp): mail -&gt; =
-rw,actimeo=3D0,vers=3D3 nis_server:/var/mail</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: parse(sun): expanded entry: =
-rw,actimeo=3D0,vers=3D3 nis_server:/var/mail</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: parse(sun): =
dequote(&quot;rw,actimeo=3D0,vers=3D3&quot;) -&gt; =
rw,actimeo=3D0,vers=3D3</FONT></SPAN><SPAN LANG=3D"en-us"> </SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: parse(sun): gathered options: =
7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: parse(sun): =
dequote(&quot;nis_server:/var/mail&quot;) -&gt; =
nis_server:/var/mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: parse(sun): core of entry: =
options=3D7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3, =
loc=3Dnis_server:/var/mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: parse(sun): mounting root =
/</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">, mountpoint mail, what nis_server:/var/mail, fstype =
nfs, options =
7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: mount(nfs):&nbsp; =
root=3D/</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> name=3Dmail what=3Dnis_server:/var/mail, =
fstype=3Dnfs, =
options=3D7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3</FONT></SPAN></=
P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: mount(nfs): nfs =
options=3D&quot;7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3&quot;, =
nosymlink=3D0 Jul 11 23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: mount(nfs): calling mkdir_path =
/</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: mount(nfs): calling mount -t nfs -s =
-o 7,rw,intr,soft,vers=3D3,rw,actimeo=3D0,vers=3D3 nis_server:/var/mail =
/</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: &gt;&gt; mount: =
nis_server:/var/mail: can't read superblock</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: mount(nfs): nfs: mount failure =
nis_server:/var/mail on /</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: failed to mount /</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN =
LANG=3D"en-us"><FONT FACE=3D"Consolas">/mail</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[3564]: umount_multi: =
path=3D/</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">mntpnt</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/mail incl=3D1</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_child: got pid 3564, sig 0 =
(0), stat 2</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: sig_child: found pending iop pid =
3564: signalled 0 (sig 0), exit status 2</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: update_negative_cache: key: =
mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: Adding negative cache entry for key =
mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: Key mail added to negative =
cache</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: send_fail: =
token=3D247708</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet: type =3D =
0</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet_missing: token 247709, =
name mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet_missing: found =
negative cache entry for key.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: send_fail: =
token=3D247709</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet: type =3D =
0</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet_missing: token 247710, =
name mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet_missing: found =
negative cache entry for key.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: send_fail: =
token=3D247710</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet: type =3D =
0</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet_missing: token 247711, =
name mail</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: handle_packet_missing: found =
negative cache entry for key.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">Jul 11 =
23:54:01</FONT></SPAN><SPAN LANG=3D"en-us"> <FONT =
FACE=3D"Consolas">server3</FONT></SPAN><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas"> automount[6778]: send_fail: =
token=3D247711</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/etc/sysconfig/autofs:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># Define =
custom options in /etc/sysconfig/autofs</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># Use =
LOCALOPTIONS for defining variables, e.g. OSREL</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># Use =
DAEMONOPTIONS to define the unmount timeout</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># Define =
UNDERSCORETODOT as 1 to convert </FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp; auto_home to auto.home and =
auto_mnt to auto.mnt</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># Mount =
options, e.g. rsize=3D8192, should go in auto.master =
or</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp; the auto_* map entry for a =
specific mount point</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">LOCALOPTIONS=3D&quot;&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">DAEMONOPTIONS=3D&quot;--timeout=3D60 --debug =
--set-log-priority 7&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">LDAPAUTOMASTER=3D&quot;&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">#&nbsp; =
UNDERSCORETODOT changes auto_home to auto.home and auto_mnt to =
auto.mnt</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">UNDERSCORETODOT=3D1</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">DISABLE_DIRECT=3D1</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># Only source =
one master map if set to 1.&nbsp; This would mimic Sun =
behaviour.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># The default =
is 0 to maintain backwards compatibility.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">ONE_AUTO_MASTER=3D0</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># List of =
directories to be ghosted, separated by white space.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">GHOSTDIRS=3D&quot;&quot;</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># Base DN to =
use when searching for the master map BASEDN=3D</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># The ldap =
module was updated to only try the first schema that =
works</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># (instead of =
trying all 3 autofs schemas for each lookup).&nbsp; It =
is</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># possible, =
though unlikely, that this could cause problems.&nbsp; If you =
update</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># the =
automounter and find that your ldap schemas doesn't work as it =
did</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># previously, =
try setting this option to 1.&nbsp; Please also report the =
problem,</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># as it is =
likely that your schema is incompatible with autofs =
v5.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">OLD_LDAP_LOOKUP=3D0</FONT></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">/etc/nsswitch.conf:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># =
/etc/nsswitch.conf</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># An example =
Name Service Switch config file. This file should be # sorted with the =
most-used services at the beginning.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># The entry =
'[NOTFOUND=3Dreturn]' means that the search for an # entry should stop =
if the search in the previous entry turned # up nothing. Note that if =
the search failed due to some other reason # (like no NIS server =
responding) then the search continues with the # next =
entry.</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># Legal =
entries are:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nis or =
yp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use NIS (NIS version 2), also =
called YP</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dns&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use DNS (Domain Name =
Service)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
files&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use the local =
files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
db&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use the local database (.db) =
files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compat&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use NIS on compat =
mode</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hesiod&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use Hesiod for user =
lookups</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ldap&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use LDAP (only if nss_ldap is =
installed)</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nisplus or nis+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use NIS+ (NIS version 3), =
unsupported</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
[NOTFOUND=3Dreturn]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Stop searching =
if not found so far</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># To use db, =
put the &quot;db&quot; in front of &quot;files&quot; for entries you =
want to be # looked up first in the databases # # =
Example:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#passwd:&nbsp;&nbsp;&nbsp; db files ldap =
nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#shadow:&nbsp;&nbsp;&nbsp; db files ldap =
nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#group:&nbsp;&nbsp;&nbsp;&nbsp; db files ldap =
nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">passwd:&nbsp;&nbsp;&nbsp;&nbsp; files =
nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">shadow:&nbsp;&nbsp;&nbsp;&nbsp; files =
nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">group:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files =
nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#hosts:&nbsp;&nbsp;&nbsp;&nbsp; db files ldap nis =
dns</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">hosts:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files nis =
dns</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas"># Example - =
obey only what ldap tells us...</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#services:&nbsp; ldap [NOTFOUND=3Dreturn] =
files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#networks:&nbsp; ldap [NOTFOUND=3Dreturn] =
files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">#protocols: =
ldap [NOTFOUND=3Dreturn] files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#rpc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ldap =
[NOTFOUND=3Dreturn] files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">#ethers:&nbsp;&nbsp;&nbsp; ldap [NOTFOUND=3Dreturn] =
files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Consolas">bootparams: =
files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">ethers:&nbsp;&nbsp;&nbsp;&nbsp; =
files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">netmasks:&nbsp;&nbsp; files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">networks:&nbsp;&nbsp; files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">protocols:&nbsp; files nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">rpc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">services:&nbsp;&nbsp; files nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">netgroup:&nbsp;&nbsp; files nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">publickey:&nbsp; files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">automount:&nbsp; files nis</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT =
FACE=3D"Consolas">aliases:&nbsp;&nbsp;&nbsp; files</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"></SPAN><SPAN =
LANG=3D"en-us"></SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01CC40A9.0C57E7E2--


--===============8912673641413376148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8912673641413376148==--

