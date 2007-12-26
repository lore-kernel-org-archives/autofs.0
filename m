From: "James Richardson" <jrichardson@x-iss.com>
Subject: Re: Slow mounts when using large round robin sets
Date: Wed, 26 Dec 2007 16:15:44 -0600
Message-ID: <98E55D6E1B3CFD43BDA59EEB56DD7D72443928@sbs01.xiss.private>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724431C0@sbs01.xiss.private>
	<1196921804.3089.28.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private>
	<x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D7244386E@sbs01.xiss.private>
	<1198241367.3488.26.camel@raven.themaw.net>
	<x49odck175r.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724438C2@sbs01.xiss.private>
	<x49fxxvzpp5.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724438CB@sbs01.xiss.private>
	<1198304664.3114.49.camel@raven.themaw.net>
	<1198307519.3114.59.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7800250309588021401=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--===============7800250309588021401==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8480C.D9F79B4F"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8480C.D9F79B4F
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ian,

=20

I applied the last set of patches you sent and have attached the results.

=20

What I have done to run this test is:

=20

      - Installed latest autofs w/ patches

      - Rebooted test server w/ new autofs

      - Updated /etc/syslog.conf to remove debug logging to /var/log/daemon=
.log

      - Restarted syslog daemon

      - Ran 'ls' test

=20

[root@myhost ~]# time ls /home/brian/.bash_history

/home/brian/.bash_history

=20

real    0m5.016s

user    0m0.000s

sys     0m0.004s

=20

The speed at which this test runs seems to take longer with the debug patch=
es provided - my assumption is to the additional debug logged messages. How=
ever, below is what is captured by syslog:

=20

Dec 26 16:00:02 myhost automount[3060]: handle_packet: type =3D 3

Dec 26 16:00:02 myhost automount[3060]: handle_packet_missing_indirect: tok=
en 1, name brian, request pid 3688

Dec 26 16:00:02 myhost automount[3060]: attempting to mount entry /home/bri=
an

Dec 26 16:00:02 myhost automount[3060]: lookup_mount: lookup(yp): looking u=
p brian

Dec 26 16:00:02 myhost automount[3060]: lookup_mount: lookup(yp): brian -> =
-rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3         large-rr:/home/bria=
n

Dec 26 16:00:02 myhost automount[3060]: parse_mount: parse(sun): expanded e=
ntry: -rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3         large-rr:/hom=
e/brian

Dec 26 16:00:02 myhost automount[3060]: parse_mount: parse(sun): gathered o=
ptions: nosuid,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3

Dec 26 16:00:02 myhost automount[3060]: parse_mount: parse(sun): dequote("l=
arge-rr:/home/brian") -> large-rr:/home/brian

Dec 26 16:00:02 myhost automount[3060]: parse_mount: parse(sun): core of en=
try: options=3Dnosuid,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=
=3D3, loc=3Dlarge-rr:/home/brian

Dec 26 16:00:02 myhost automount[3060]: sun_mount: parse(sun): mounting roo=
t /home, mountpoint brian, what large-rr:/home/brian, fstype nfs, options n=
osuid,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3

Dec 26 16:00:02 myhost automount[3060]: mount_mount: mount(nfs): root=3D/ho=
me name=3Dbrian what=3Dlarge-rr:/home/brian, fstype=3Dnfs, options=3Dnosuid=
,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3

Dec 26 16:00:02 myhost automount[3060]: mount_mount: mount(nfs): nfs option=
s=3D"nosuid,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3", nos=
ymlink=3D0, ro=3D0

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:885: gethostbyname_r=
 large-rr

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =C0Tm=B7=C8Tm=B7=D0Tm=B7=D8Tm=B7=E0Tm=B7=E8Tm=B7=F0Tm=B7=F8Tm=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =C8Tm=B7=D0Tm=B7=D8Tm=B7=E0Tm=B7=E8Tm=B7=F0Tm=B7=F8Tm=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =D0Tm=B7=D8Tm=B7=E0Tm=B7=E8Tm=B7=F0Tm=B7=F8Tm=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =D8Tm=B7=E0Tm=B7=E8Tm=B7=F0Tm=B7=F8Tm=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =E0Tm=B7=E8Tm=B7=F0Tm=B7=F8Tm=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =E8Tm=B7=F0Tm=B7=F8Tm=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =F0Tm=B7=F8Tm=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =F8Tm=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
sUm=B7Um=B7Um=B7 Um=B7(Um=B70Um=B78Um=B7@Um=B7HUm=B7PUm=B7XUm=B7`Um=B7hUm=
=B7pUm=B7xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=
=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s Um=B7Um=B7 Um=B7(Um=B70Um=B78Um=B7@Um=B7HUm=B7PUm=B7XUm=B7`Um=B7hUm=B7pUm=
=B7xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=
=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s Um=B7 Um=B7(Um=B70Um=B78Um=B7@Um=B7HUm=B7PUm=B7XUm=B7`Um=B7hUm=B7pUm=B7xU=
m=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=
=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s  Um=B7(Um=B70Um=B78Um=B7@Um=B7HUm=B7PUm=B7XUm=B7`Um=B7hUm=B7pUm=B7xUm=B7U=
m=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=
=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s (Um=B70Um=B78Um=B7@Um=B7HUm=B7PUm=B7XUm=B7`Um=B7hUm=B7pUm=B7xUm=B7Um=B7Um=
=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=
=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s 0Um=B78Um=B7@Um=B7HUm=B7PUm=B7XUm=B7`Um=B7hUm=B7pUm=B7xUm=B7Um=B7Um=B7Um=
=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=
=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s 8Um=B7@Um=B7HUm=B7PUm=B7XUm=B7`Um=B7hUm=B7pUm=B7xUm=B7Um=B7Um=B7Um=B7Um=
=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=
=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s @Um=B7HUm=B7PUm=B7XUm=B7`Um=B7hUm=B7pUm=B7xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=
=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=
=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s HUm=B7PUm=B7XUm=B7`Um=B7hUm=B7pUm=B7xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=
=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=
=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s PUm=B7XUm=B7`Um=B7hUm=B7pUm=B7xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0=
Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=
=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s XUm=B7`Um=B7hUm=B7pUm=B7xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=
=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s `Um=B7hUm=B7pUm=B7xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=
=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s hUm=B7pUm=B7xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=
=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s pUm=B7xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8=
Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s xUm=B7Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=
=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s Um=B7Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=
=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s Um=B7Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8U=
m=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s Um=B7Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=
=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s Um=B7 Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=
=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s  Um=B7=A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8=
Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =A8Um=B7=B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=
=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =B0Um=B7=B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=
=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =B8Um=B7=C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =C0Um=B7=C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =C8Um=B7=D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =D0Um=B7=D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =D8Um=B7=E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:02 myhost automount[3060]: add_host_addrs:901: add host addres=
s =E0Um=B7=E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s =E8Um=B7=F0Um=B7=F8Um=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s =F0Um=B7=F8Um=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s =F8Um=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
sVm=B7Vm=B7Vm=B7 Vm=B7(Vm=B70Vm=B78Vm=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s Vm=B7Vm=B7 Vm=B7(Vm=B70Vm=B78Vm=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s Vm=B7 Vm=B7(Vm=B70Vm=B78Vm=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s  Vm=B7(Vm=B70Vm=B78Vm=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s (Vm=B70Vm=B78Vm=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s 0Vm=B78Vm=B7

Dec 26 16:00:03 myhost automount[3060]: add_host_addrs:901: add host addres=
s 8Vm=B7

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:03 myhost last message repeated 2 times

Dec 26 16:00:03 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:04 myhost last message repeated 2 times

Dec 26 16:00:04 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:05 myhost last message repeated 2 times

Dec 26 16:00:05 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:06 myhost last message repeated 2 times

Dec 26 16:00:06 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:06 myhost last message repeated 2 times

Dec 26 16:00:06 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:06 myhost last message repeated 2 times

Dec 26 16:00:06 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:06 myhost last message repeated 2 times

Dec 26 16:00:06 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:06 myhost last message repeated 2 times

Dec 26 16:00:06 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:06 myhost last message repeated 2 times

Dec 26 16:00:06 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:06 myhost last message repeated 2 times

Dec 26 16:00:06 myhost automount[3060]: create_udp_client:96: gethostbyname=
_r large-rr

Dec 26 16:00:06 myhost last message repeated 2 times

Dec 26 16:00:06 myhost automount[3060]: create_tcp_client:308: gethostbynam=
e_r large-rr

Dec 26 16:00:06 myhost last message repeated 2 times

Dec 26 16:00:06 myhost automount[3060]: mount_mount: mount(nfs): calling mk=
dir_path /home/brian

Dec 26 16:00:06 myhost automount[3060]: mount_mount: mount(nfs): calling mo=
unt -t nfs -s -o nosuid,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp,ve=
rs=3D3 large-rr:/home/brian /home/brian

Dec 26 16:00:06 myhost automount[3060]: mount(nfs): mounted large-rr:/home/=
brian on /home/brian

Dec 26 16:00:06 myhost automount[3060]: send_ready: token =3D 1

Dec 26 16:00:06 myhost automount[3060]: mounted /home/brian

=20





---

James T. Richardson, Jr.

jrichardson@x-iss.com

eXcellence in IS Solutions, Inc.

713-862-9200 x226

=20

Making IT Work for You

HPC & Enterprise IT Solutions

* HPC Application Acceleration

* Cluster Design, Deploy, Manage, Train

* Linux/Windows Integration

* Remote Management, Backup, Anti-Spam/Virus

* Network Assessments, Design

* Security Audits, Design

* Datacenter Design, Relocation

* Messaging and Collaboration

=20

=20

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net]=20
Sent: Saturday, December 22, 2007 1:12 AM
To: James Richardson
Cc: Jeff Moyer; autofs@linux.kernel.org
Subject: RE: [autofs] Slow mounts when using large round robin sets

=20

On Sat, 2007-12-22 at 15:24 +0900, Ian Kent wrote:

> On Fri, 2007-12-21 at 16:56 -0600, James Richardson wrote:

> > Jeff,

> >=20

> > =20

> >=20

> > I applied the patch and here is what was recorded.=20

>=20

> What were the actions carried out from the start to the finish of this

> logging?

>=20

> I think we'll also need to add the hostname to the logging.

=20

Actually it looks like we're adding an entry for every host ip address

and but not using the address to probe availability.

=20

So having multiple IPs associated with a host ends up being the same as

specifying several host names in a mount. autofs then checks to see

which is closest and calculates a load metric based on a ping to the NFS

NULL proc and chooses one.

=20

I don't think we should be doing a name lookup for every address though

and that may be the source of the problem.

=20

How about trying this patch.

I've added the host name and an extra report when an address is added.

I've also attempted to use the addresses from the original lookup.

It replaces Jeffs patch.

=20

---

diff --git a/include/rpc_subs.h b/include/rpc_subs.h

index 3292e01..3f15ef5 100644

--- a/include/rpc_subs.h

+++ b/include/rpc_subs.h

@@ -46,6 +46,7 @@

=20

 struct conn_info {

      const char *host;

+     const char *addr;

      unsigned short port;

      unsigned long program;

      unsigned long version;

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c

index 5797639..0778558 100644

--- a/lib/rpc_subs.c

+++ b/lib/rpc_subs.c

@@ -66,6 +66,7 @@ static CLIENT *create_udp_client(struct conn_info

*info)

      struct hostent *php =3D &hp;

      struct hostent *result;

      char buf[HOST_ENT_BUF_SIZE];

+     const char *haddr;

      size_t len;

=20

      if (info->proto->p_proto !=3D IPPROTO_UDP)

@@ -86,11 +87,13 @@ static CLIENT *create_udp_client(struct conn_info

*info)

      memset(&raddr, 0, sizeof(raddr));

=20

      raddr.sin_family =3D AF_INET;

-     if (inet_aton(info->host, &raddr.sin_addr))

+     haddr =3D info->addr ? info->addr : info->host;

+     if (inet_aton(haddr, &raddr.sin_addr))

            goto got_addr;

=20

      memset(&hp, 0, sizeof(struct hostent));

=20

+     logerr("gethostbyname_r %s", info->host);

      ret =3D gethostbyname_r(info->host, php,

                  buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);

      if (ret || !result) {

@@ -276,6 +279,7 @@ static CLIENT *create_tcp_client(struct conn_info

*info)

      struct hostent *php =3D &hp;

      struct hostent *result;

      char buf[HOST_ENT_BUF_SIZE];

+     const char *haddr;

      int ret;

=20

      if (info->proto->p_proto !=3D IPPROTO_TCP)

@@ -295,11 +299,13 @@ static CLIENT *create_tcp_client(struct conn_info

*info)

      memset(&addr, 0, sizeof(addr));

=20

      addr.sin_family =3D AF_INET;

-     if (inet_aton(info->host, &addr.sin_addr))

+     haddr =3D info->addr ? info->addr : info->host;

+     if (inet_aton(haddr, &addr.sin_addr))

            goto got_addr;

=20

      memset(&hp, 0, sizeof(struct hostent));

=20

+     logerr("gethostbyname_r %s", info->host);

      ret =3D gethostbyname_r(info->host, php,

                  buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);

      if (ret || !result) {

@@ -418,6 +424,7 @@ int rpc_portmap_getclient(struct conn_info *info,

            return 0;

=20

      info->host =3D host;

+     info->addr =3D NULL;

      info->program =3D PMAPPROG;

      info->port =3D PMAPPORT;

      info->version =3D PMAPVERS;

@@ -462,6 +469,7 @@ unsigned short rpc_portmap_getport(struct conn_info

*info, struct pmap *parms)

            client =3D info->client;

      else {

            pmap_info.host =3D info->host;

+           pmap_info.addr =3D NULL;

            pmap_info.port =3D PMAPPORT;

            pmap_info.program =3D PMAPPROG;

            pmap_info.version =3D PMAPVERS;

@@ -589,6 +597,7 @@ static unsigned int __rpc_ping(const char *host,

      struct pmap parms;

=20

      info.host =3D host;

+     info.addr =3D NULL;

      info.program =3D NFS_PROGRAM;

      info.version =3D version;

      info.send_sz =3D 0;

@@ -769,6 +778,7 @@ exports rpc_get_exports(const char *host, long

seconds, long micros, unsigned in

      int status;

=20

      info.host =3D host;

+     info.addr =3D NULL;

      info.program =3D MOUNTPROG;

      info.version =3D MOUNTVERS;

      info.send_sz =3D 0;

diff --git a/modules/replicated.c b/modules/replicated.c

index 90b2925..d64f74a 100644

--- a/modules/replicated.c

+++ b/modules/replicated.c

@@ -551,6 +551,7 @@ static int get_vers_and_cost(unsigned logopt, struct

host *host,

            timeout =3D RPC_TIMEOUT * 8;

=20

      rpc_info.host =3D host->name;

+     rpc_info.addr =3D host->addr;

      rpc_info.program =3D NFS_PROGRAM;

      rpc_info.timeout.tv_sec =3D timeout;

      rpc_info.close_option =3D RPC_CLOSE_DEFAULT;

@@ -606,6 +607,7 @@ static int get_supported_ver_and_cost(unsigned

logopt, struct host *host,

            timeout =3D RPC_TIMEOUT * 8;

=20

      rpc_info.host =3D host->name;

+     rpc_info.addr =3D host->addr;

      rpc_info.program =3D NFS_PROGRAM;

      rpc_info.timeout.tv_sec =3D timeout;

      rpc_info.close_option =3D RPC_CLOSE_DEFAULT;

@@ -880,6 +882,7 @@ static int add_host_addrs(struct host **list, const

char *host, unsigned int wei

      memset(buf, 0, MAX_IFC_BUF);

      memset(&he, 0, sizeof(struct hostent));

=20

+     logerr("gethostbyname_r %s", host);

      ret =3D gethostbyname_r(host, phe,

                  buf, MAX_IFC_BUF, &result, &ghn_errno);

      if (ret || !result) {

@@ -895,6 +898,7 @@ static int add_host_addrs(struct host **list, const

char *host, unsigned int wei

            if (prx =3D=3D PROXIMITY_ERROR)

                  return 0;

=20

+           logerr("add host address %s", haddr);

            if (!(new =3D new_host(host, *haddr, prx, weight)))

                  return 0;

=20

=20

=20


NOTICE:
This message may contain privileged or otherwise confidential information.
If you are not the intended recipient, please immediately advise the sender
by reply email and delete the message and any attachments without using,
copying or disclosing the contents.



------_=_NextPart_001_01C8480C.D9F79B4F
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>

<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:Consolas;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText>Ian,<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>I applied the last set of patches you sent and have
attached the results.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>What I have done to run this test is:<o:p></o:p></p=
>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Installed latest a=
utofs
w/ patches<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Rebooted test serv=
er w/
new autofs<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Updated /etc/syslo=
g.conf
to remove debug logging to /var/log/daemon.log<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Restarted syslog d=
aemon<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Ran 'ls' test<o:p>=
</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><b>[root@myhost ~]# time=
 ls
/home/brian/.bash_history<o:p></o:p></b></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><b>/home/brian/.bash_his=
tory<o:p></o:p></b></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><b><o:p>&nbsp;</o:p></b>=
</p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><b>real&nbsp;&nbsp;&nbsp=
;
0m5.016s<o:p></o:p></b></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><b>user&nbsp;&nbsp;&nbsp=
;
0m0.000s<o:p></o:p></b></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><b>sys&nbsp;&nbsp;&nbsp;=
&nbsp;
0m0.004s<o:p></o:p></b></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><b><o:p>&nbsp;</o:p></b>=
</p>

<p class=3DMsoPlainText>The speed at which this test runs seems to take lon=
ger
with the debug patches provided &#8211; my assumption is to the additional
debug logged messages. However, below is what is captured by syslog:<o:p></=
o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: handle_pack=
et:
type =3D 3<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
handle_packet_missing_indirect: token 1, name brian, request pid 3688<o:p><=
/o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: attempting =
to
mount entry /home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: lookup_moun=
t:
lookup(yp): looking up brian<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: lookup_moun=
t:
lookup(yp): brian -&gt;
-rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
large-rr:/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: parse_mount=
:
parse(sun): expanded entry:
-rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
large-rr:/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: parse_mount=
:
parse(sun): gathered options: nosuid,retry=3D10,rsize=3D8192,wsize=3D8192,p=
roto=3Dtcp,vers=3D3<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: parse_mount=
:
parse(sun): dequote(&quot;large-rr:/home/brian&quot;) -&gt;
large-rr:/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: parse_mount=
:
parse(sun): core of entry: options=3Dnosuid,retry=3D10,rsize=3D8192,wsize=
=3D8192,proto=3Dtcp,vers=3D3,
loc=3Dlarge-rr:/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: sun_mount:
parse(sun): mounting root /home, mountpoint brian, what large-rr:/home/bria=
n,
fstype nfs, options nosuid,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp=
,vers=3D3<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: mount_mount=
:
mount(nfs): root=3D/home name=3Dbrian what=3Dlarge-rr:/home/brian, fstype=
=3Dnfs,
options=3Dnosuid,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3<=
o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: mount_mount=
:
mount(nfs): nfs
options=3D&quot;nosuid,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp,ver=
s=3D3&quot;,
nosymlink=3D0, ro=3D0<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:885: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&Agrave;Tm&middot;&Egrave;Tm&middot;&ETH;Tm&middot;&Oslash;Tm&middot;&agrav=
e;Tm&middot;&egrave;Tm&middot;&eth;Tm&middot;&oslash;Tm&middot;<o:p></o:p><=
/p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&Egrave;Tm&middot;&ETH;Tm&middot;&Oslash;Tm&middot;&agrave;Tm&middot;&egrav=
e;Tm&middot;&eth;Tm&middot;&oslash;Tm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&ETH;Tm&middot;&Oslash;Tm&middot;&agrave;Tm&middot;&egrave;Tm&middot;&eth;T=
m&middot;&oslash;Tm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&Oslash;Tm&middot;&agrave;Tm&middot;&egrave;Tm&middot;&eth;Tm&middot;&oslas=
h;Tm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&agrave;Tm&middot;&egrave;Tm&middot;&eth;Tm&middot;&oslash;Tm&middot;<o:p><=
/o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&egrave;Tm&middot;&eth;Tm&middot;&oslash;Tm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address &eth;Tm&middot;&oslash;Tm&middot;<o:p>=
</o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address &oslash;Tm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host addressUm&middot;Um&middot;Um&middot;
Um&middot;(Um&middot;0Um&middot;8Um&middot;@Um&middot;HUm&middot;PUm&middot=
;XUm&middot;`Um&middot;hUm&middot;pUm&middot;xUm&middot;Um&middot;Um&middot=
;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;U=
m&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&midd=
ot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:=
p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: add_host_ad=
drs:901:
add host address Um&middot;Um&middot;
Um&middot;(Um&middot;0Um&middot;8Um&middot;@Um&middot;HUm&middot;PUm&middot=
;XUm&middot;`Um&middot;hUm&middot;pUm&middot;xUm&middot;Um&middot;Um&middot=
;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;U=
m&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&midd=
ot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:=
p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address Um&middot;
Um&middot;(Um&middot;0Um&middot;8Um&middot;@Um&middot;HUm&middot;PUm&middot=
;XUm&middot;`Um&middot;hUm&middot;pUm&middot;xUm&middot;Um&middot;Um&middot=
;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;U=
m&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&midd=
ot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:=
p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address&nbsp;
Um&middot;(Um&middot;0Um&middot;8Um&middot;@Um&middot;HUm&middot;PUm&middot=
;XUm&middot;`Um&middot;hUm&middot;pUm&middot;xUm&middot;Um&middot;Um&middot=
;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;U=
m&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&midd=
ot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:=
p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
(Um&middot;0Um&middot;8Um&middot;@Um&middot;HUm&middot;PUm&middot;XUm&middo=
t;`Um&middot;hUm&middot;pUm&middot;xUm&middot;Um&middot;Um&middot;Um&middot=
;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;Um&middot;&=
Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrave=
;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></=
p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
0Um&middot;8Um&middot;@Um&middot;HUm&middot;PUm&middot;XUm&middot;`Um&middo=
t;hUm&middot;pUm&middot;xUm&middot;Um&middot;Um&middot;Um&middot;Um&middot;=
&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&m=
iddot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;=
&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
8Um&middot;@Um&middot;HUm&middot;PUm&middot;XUm&middot;`Um&middot;hUm&middo=
t;pUm&middot;xUm&middot;Um&middot;Um&middot;Um&middot;Um&middot;&nbsp;Um&mi=
ddot;&uml;Um&middot;&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&middot;&Egra=
ve;Um&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&=
middot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
@Um&middot;HUm&middot;PUm&middot;XUm&middot;`Um&middot;hUm&middot;pUm&middo=
t;xUm&middot;Um&middot;Um&middot;Um&middot;Um&middot;&nbsp;Um&middot;&uml;U=
m&middot;&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um&middo=
t;&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth=
;Um&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
HUm&middot;PUm&middot;XUm&middot;`Um&middot;hUm&middot;pUm&middot;xUm&middo=
t;Um&middot;Um&middot;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&d=
eg;Um&middot;&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&m=
iddot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;=
&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
PUm&middot;XUm&middot;`Um&middot;hUm&middot;pUm&middot;xUm&middot;Um&middot=
;Um&middot;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middo=
t;&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Osla=
sh;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&=
middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
XUm&middot;`Um&middot;hUm&middot;pUm&middot;xUm&middot;Um&middot;Um&middot;=
Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;Um=
&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&middo=
t;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p=
></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address `Um&middot;hUm&middot;pUm&middot;xUm&m=
iddot;Um&middot;Um&middot;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middo=
t;&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;=
Um&middot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&mid=
dot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
hUm&middot;pUm&middot;xUm&middot;Um&middot;Um&middot;Um&middot;Um&middot;&n=
bsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&mid=
dot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;&e=
grave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]: add_host_ad=
drs:901:
add host address
pUm&middot;xUm&middot;Um&middot;Um&middot;Um&middot;Um&middot;&nbsp;Um&midd=
ot;&uml;Um&middot;&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&middot;&Egrave=
;Um&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&mi=
ddot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
xUm&middot;Um&middot;Um&middot;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&=
middot;&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um&middot;=
&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;U=
m&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
Um&middot;Um&middot;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg=
;Um&middot;&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&mid=
dot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&o=
slash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
Um&middot;Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot=
;&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslas=
h;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&m=
iddot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
Um&middot;Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;Um=
&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&middo=
t;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p=
></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
Um&middot;&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;Um&middot;&A=
grave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrave;=
Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></p=
>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&nbsp;Um&middot;&uml;Um&middot;&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&m=
iddot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;=
&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&uml;Um&middot;&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um=
&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&middo=
t;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&deg;Um&middot;&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um=
&middot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middo=
t;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&cedil;Um&middot;&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash=
;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&mi=
ddot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&Agrave;Um&middot;&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrav=
e;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p><=
/p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&Egrave;Um&middot;&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;&egrav=
e;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&ETH;Um&middot;&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;U=
m&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&Oslash;Um&middot;&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslas=
h;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:02 myhost automount[3060]:
add_host_addrs:901: add host address
&agrave;Um&middot;&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p><=
/o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host address
&egrave;Um&middot;&eth;Um&middot;&oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host address &eth;Um&middot;&oslash;Um&middot;<o:p>=
</o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host address &oslash;Um&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host address<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host addressVm&middot;Vm&middot;Vm&middot;
Vm&middot;(Vm&middot;0Vm&middot;8Vm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host address Vm&middot;Vm&middot;
Vm&middot;(Vm&middot;0Vm&middot;8Vm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host address Vm&middot;
Vm&middot;(Vm&middot;0Vm&middot;8Vm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host address&nbsp;
Vm&middot;(Vm&middot;0Vm&middot;8Vm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host address (Vm&middot;0Vm&middot;8Vm&middot;<o:p>=
</o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
add_host_addrs:901: add host address 0Vm&middot;8Vm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]: add_host_ad=
drs:901:
add host address 8Vm&middot;<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]: create_tcp_=
client:308:
gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]: create_tcp_=
client:308:
gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:03 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]: create_tcp_=
client:308:
gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]: create_tcp_=
client:308:
gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:04 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]: create_tcp_=
client:308:
gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]: create_tcp_=
client:308:
gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:05 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]: create_tcp_=
client:308:
gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]:
create_udp_client:96: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]:
create_tcp_client:308: gethostbyname_r large-rr<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost last message repeated 2 time=
s<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]: mount_mount=
:
mount(nfs): calling mkdir_path /home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]: mount_mount=
:
mount(nfs): calling mount -t nfs -s -o
nosuid,retry=3D10,rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3 large-rr:/=
home/brian
/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]: mount(nfs):
mounted large-rr:/home/brian on /home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]: send_ready:=
 token
=3D 1<o:p></o:p></p>

<p class=3DMsoPlainText>Dec 26 16:00:06 myhost automount[3060]: mounted
/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><br>
<br>
<o:p></o:p></p>

<p class=3DMsoPlainText>---<o:p></o:p></p>

<p class=3DMsoPlainText>James T. Richardson, Jr.<o:p></o:p></p>

<p class=3DMsoPlainText>jrichardson@x-iss.com<o:p></o:p></p>

<p class=3DMsoPlainText>eXcellence in IS Solutions, Inc.<o:p></o:p></p>

<p class=3DMsoPlainText>713-862-9200 x226<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Making IT Work for You<o:p></o:p></p>

<p class=3DMsoPlainText>HPC &amp; Enterprise IT Solutions<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; HPC Application Acceleration<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Cluster Design, Deploy, Manage, Train<o:p><=
/o:p></p>

<p class=3DMsoPlainText>&#8226; Linux/Windows Integration<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Remote Management, Backup, Anti-Spam/Virus<=
o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Network Assessments, Design<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Security Audits, Design<o:p></o:p></p>

<p class=3DMsoPlainText>&#8226; Datacenter Design, Relocation<o:p></o:p></p=
>

<p class=3DMsoPlainText>&#8226; Messaging and Collaboration<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>-----Original Message-----<br>
From: Ian Kent [mailto:raven@themaw.net] <br>
Sent: Saturday, December 22, 2007 1:12 AM<br>
To: James Richardson<br>
Cc: Jeff Moyer; autofs@linux.kernel.org<br>
Subject: RE: [autofs] Slow mounts when using large round robin sets<o:p></o=
:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>On Sat, 2007-12-22 at 15:24 +0900, Ian Kent wrote:<=
o:p></o:p></p>

<p class=3DMsoPlainText>&gt; On Fri, 2007-12-21 at 16:56 -0600, James Richa=
rdson
wrote:<o:p></o:p></p>

<p class=3DMsoPlainText>&gt; &gt; Jeff,<o:p></o:p></p>

<p class=3DMsoPlainText>&gt; &gt; <o:p></o:p></p>

<p class=3DMsoPlainText>&gt; &gt;&nbsp; <o:p></o:p></p>

<p class=3DMsoPlainText>&gt; &gt; <o:p></o:p></p>

<p class=3DMsoPlainText>&gt; &gt; I applied the patch and here is what was
recorded. <o:p></o:p></p>

<p class=3DMsoPlainText>&gt; <o:p></o:p></p>

<p class=3DMsoPlainText>&gt; What were the actions carried out from the sta=
rt to
the finish of this<o:p></o:p></p>

<p class=3DMsoPlainText>&gt; logging?<o:p></o:p></p>

<p class=3DMsoPlainText>&gt; <o:p></o:p></p>

<p class=3DMsoPlainText>&gt; I think we'll also need to add the hostname to=
 the
logging.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Actually it looks like we're adding an entry for ev=
ery
host ip address<o:p></o:p></p>

<p class=3DMsoPlainText>and but not using the address to probe availability=
.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>So having multiple IPs associated with a host ends =
up
being the same as<o:p></o:p></p>

<p class=3DMsoPlainText>specifying several host names in a mount. autofs th=
en
checks to see<o:p></o:p></p>

<p class=3DMsoPlainText>which is closest and calculates a load metric based=
 on a
ping to the NFS<o:p></o:p></p>

<p class=3DMsoPlainText>NULL proc and chooses one.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>I don't think we should be doing a name lookup for =
every
address though<o:p></o:p></p>

<p class=3DMsoPlainText>and that may be the source of the problem.<o:p></o:=
p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>How about trying this patch.<o:p></o:p></p>

<p class=3DMsoPlainText>I've added the host name and an extra report when a=
n
address is added.<o:p></o:p></p>

<p class=3DMsoPlainText>I've also attempted to use the addresses from the
original lookup.<o:p></o:p></p>

<p class=3DMsoPlainText>It replaces Jeffs patch.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>---<o:p></o:p></p>

<p class=3DMsoPlainText>diff --git a/include/rpc_subs.h b/include/rpc_subs.=
h<o:p></o:p></p>

<p class=3DMsoPlainText>index 3292e01..3f15ef5 100644<o:p></o:p></p>

<p class=3DMsoPlainText>--- a/include/rpc_subs.h<o:p></o:p></p>

<p class=3DMsoPlainText>+++ b/include/rpc_subs.h<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -46,6 +46,7 @@<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;struct conn_info {<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *host;<o:=
p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; const char *addr;<o:p></o=
:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned short port;=
<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long progra=
m;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long versio=
n;<o:p></o:p></p>

<p class=3DMsoPlainText>diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c<o:p></=
o:p></p>

<p class=3DMsoPlainText>index 5797639..0778558 100644<o:p></o:p></p>

<p class=3DMsoPlainText>--- a/lib/rpc_subs.c<o:p></o:p></p>

<p class=3DMsoPlainText>+++ b/lib/rpc_subs.c<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -66,6 +66,7 @@ static CLIENT *create_udp_client(=
struct
conn_info<o:p></o:p></p>

<p class=3DMsoPlainText>*info)<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hostent *php =
=3D
&amp;hp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hostent *resu=
lt;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char
buf[HOST_ENT_BUF_SIZE];<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; const char *haddr;<o:p></=
o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t len;<o:p></o:=
p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
(info-&gt;proto-&gt;p_proto !=3D IPPROTO_UDP)<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -86,11 +87,13 @@ static CLIENT
*create_udp_client(struct conn_info<o:p></o:p></p>

<p class=3DMsoPlainText>*info)<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;raddr, 0=
,
sizeof(raddr));<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; raddr.sin_family =3D
AF_INET;<o:p></o:p></p>

<p class=3DMsoPlainText>-&nbsp;&nbsp;&nbsp;&nbsp; if (inet_aton(info-&gt;ho=
st,
&amp;raddr.sin_addr))<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; haddr =3D info-&gt;addr ?
info-&gt;addr : info-&gt;host;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; if (inet_aton(haddr,
&amp;raddr.sin_addr))<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto
got_addr;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;hp, 0,
sizeof(struct hostent));<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; logerr(&quot;gethostbynam=
e_r %s&quot;,
info-&gt;host);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D
gethostbyname_r(info-&gt;host, php,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf,
HOST_ENT_BUF_SIZE, &amp;result, &amp;ghn_errno);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || !result) =
{<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -276,6 +279,7 @@ static CLIENT
*create_tcp_client(struct conn_info<o:p></o:p></p>

<p class=3DMsoPlainText>*info)<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hostent *php =
=3D
&amp;hp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hostent *resu=
lt;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char
buf[HOST_ENT_BUF_SIZE];<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; const char *haddr;<o:p></=
o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p><=
/p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
(info-&gt;proto-&gt;p_proto !=3D IPPROTO_TCP)<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -295,11 +299,13 @@ static CLIENT
*create_tcp_client(struct conn_info<o:p></o:p></p>

<p class=3DMsoPlainText>*info)<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;addr, 0,
sizeof(addr));<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr.sin_family =3D =
AF_INET;<o:p></o:p></p>

<p class=3DMsoPlainText>-&nbsp;&nbsp;&nbsp;&nbsp; if (inet_aton(info-&gt;ho=
st,
&amp;addr.sin_addr))<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; haddr =3D info-&gt;addr ?
info-&gt;addr : info-&gt;host;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; if (inet_aton(haddr,
&amp;addr.sin_addr))<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; goto
got_addr;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;hp, 0,
sizeof(struct hostent));<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; logerr(&quot;gethostbynam=
e_r
%s&quot;, info-&gt;host);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D
gethostbyname_r(info-&gt;host, php,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf,
HOST_ENT_BUF_SIZE, &amp;result, &amp;ghn_errno);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || !result) =
{<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -418,6 +424,7 @@ int rpc_portmap_getclient(struc=
t
conn_info *info,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return
0;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;host =3D ho=
st;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;addr =3D NULL;<o=
:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;program =3D
PMAPPROG;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;port =3D PM=
APPORT;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;version =3D
PMAPVERS;<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -462,6 +469,7 @@ unsigned short
rpc_portmap_getport(struct conn_info<o:p></o:p></p>

<p class=3DMsoPlainText>*info, struct pmap *parms)<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; client
=3D info-&gt;client;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else {<o:p></o:p></p=
>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pmap_info.host
=3D info-&gt;host;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pmap_info.addr
=3D NULL;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pmap_info.port
=3D PMAPPORT;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pmap_info.program
=3D PMAPPROG;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pmap_info.version
=3D PMAPVERS;<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -589,6 +597,7 @@ static unsigned int __rpc_ping(=
const
char *host,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pmap parms;<o=
:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.host =3D host;<=
o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; info.addr =3D NULL;<o:p><=
/o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.program =3D
NFS_PROGRAM;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.version =3D ver=
sion;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.send_sz =3D 0;<=
o:p></o:p></p>

<p class=3DMsoPlainText>@@ -769,6 +778,7 @@ exports rpc_get_exports(const c=
har
*host, long<o:p></o:p></p>

<p class=3DMsoPlainText>seconds, long micros, unsigned in<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status;<o:p></o:=
p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.host =3D host;<=
o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; info.addr =3D NULL;<o:p><=
/o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.program =3D MOU=
NTPROG;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.version =3D MOU=
NTVERS;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.send_sz =3D 0;<=
o:p></o:p></p>

<p class=3DMsoPlainText>diff --git a/modules/replicated.c b/modules/replica=
ted.c<o:p></o:p></p>

<p class=3DMsoPlainText>index 90b2925..d64f74a 100644<o:p></o:p></p>

<p class=3DMsoPlainText>--- a/modules/replicated.c<o:p></o:p></p>

<p class=3DMsoPlainText>+++ b/modules/replicated.c<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -551,6 +551,7 @@ static int get_vers_and_cost(un=
signed
logopt, struct<o:p></o:p></p>

<p class=3DMsoPlainText>host *host,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timeout
=3D RPC_TIMEOUT * 8;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.host =3D
host-&gt;name;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.addr =3D host-&g=
t;addr;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.program =3D
NFS_PROGRAM;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.timeout.tv_=
sec =3D
timeout;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.close_optio=
n =3D
RPC_CLOSE_DEFAULT;<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -606,6 +607,7 @@ static int
get_supported_ver_and_cost(unsigned<o:p></o:p></p>

<p class=3DMsoPlainText>logopt, struct host *host,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; timeout
=3D RPC_TIMEOUT * 8;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.host =3D
host-&gt;name;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.addr =3D host-&g=
t;addr;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.program =3D
NFS_PROGRAM;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.timeout.tv_=
sec =3D
timeout;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rpc_info.close_optio=
n =3D
RPC_CLOSE_DEFAULT;<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -880,6 +882,7 @@ static int add_host_addrs(struc=
t host
**list, const<o:p></o:p></p>

<p class=3DMsoPlainText>char *host, unsigned int wei<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(buf, 0,
MAX_IFC_BUF);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;he, 0,
sizeof(struct hostent));<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; logerr(&quot;gethostbynam=
e_r
%s&quot;, host);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D
gethostbyname_r(host, phe,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf,
MAX_IFC_BUF, &amp;result, &amp;ghn_errno);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || !result) =
{<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -895,6 +898,7 @@ static int add_host_addrs(struc=
t host
**list, const<o:p></o:p></p>

<p class=3DMsoPlainText>char *host, unsigned int wei<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if
(prx =3D=3D PROXIMITY_ERROR)<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
0;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; logerr(&quot;add
host address %s&quot;, haddr);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if
(!(new =3D new_host(host, *haddr, prx, weight)))<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
0;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

</div>

<br><pre>NOTICE:
This message may contain privileged or otherwise confidential information.
If you are not the intended recipient, please immediately advise the sender
by reply email and delete the message and any attachments without using,
copying or disclosing the contents.
</pre></body>

</html>


------_=_NextPart_001_01C8480C.D9F79B4F--


--===============7800250309588021401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7800250309588021401==--

