From: "James Richardson" <jrichardson@x-iss.com>
Subject: Re: Slow mounts when using large round robin sets
Date: Fri, 21 Dec 2007 16:56:27 -0600
Message-ID: <98E55D6E1B3CFD43BDA59EEB56DD7D724438CB@sbs01.xiss.private>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private><98E55D6E1B3CFD43BDA59EEB56DD7D724431C0@sbs01.xiss.private><1196921804.3089.28.camel@raven.themaw.net><98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private><x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com><98E55D6E1B3CFD43BDA59EEB56DD7D7244386E@sbs01.xiss.private><1198241367.3488.26.camel@raven.themaw.net><x49odck175r.fsf@segfault.boston.devel.redhat.com><98E55D6E1B3CFD43BDA59EEB56DD7D724438C2@sbs01.xiss.private>
	<x49fxxvzpp5.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4902962447093812658=="
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

This is a multi-part message in MIME format.

--===============4902962447093812658==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C84424.B735B19F"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C84424.B735B19F
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Jeff,

=20

I applied the patch and here is what was recorded.=20

=20

Dec 21 16:52:13 myhost autofs: automount startup succeeded

Dec 21 16:52:42 myhost automount[3909]: add_host_addrs:883:
gethostbyname_r

Dec 21 16:52:42 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:42 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:42 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:43 myhost last message repeated 2 times

Dec 21 16:52:43 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:44 myhost last message repeated 2 times

Dec 21 16:52:44 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_udp_client:94:
gethostbyname_r

Dec 21 16:52:45 myhost last message repeated 2 times

Dec 21 16:52:45 myhost automount[3909]: create_tcp_client:304:
gethostbyname_r

=20

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
From: Jeff Moyer [mailto:jmoyer@redhat.com]=20
Sent: Friday, December 21, 2007 3:46 PM
To: James Richardson
Cc: Ian Kent; autofs@linux.kernel.org
Subject: Re: [autofs] Slow mounts when using large round robin sets

=20

"James Richardson" <jrichardson@x-iss.com> writes:

=20

> Jeff,

>=20

> Using the latest Autofs source code from I received the following

> results:

>=20

> large-rr.domain.tld contains 49 A records in DNS.

>=20

> small-rr.domain.tld contains 16 A records (a subset of large-rr).

>=20

> Test 1:

>=20

> I configured auto.home with the entry:

>=20

>       brian -rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3

> large-rr:/home/brian

>=20

>=20

> # time ls /home/brian/.bash_history

>=20

> /home/brian/.bash_history

>=20

> real    0m0.734s

>=20

> user    0m0.000s

>=20

> sys     0m0.000s

> =20

>=20

> Test 2:

>=20

> I then rebooted the server to remove any local cached anything and

> updated auto.home to have:

>=20

>       brian -rsize=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3

> small-rr:/home/brian

>=20

>=20

> # time ls -alht /home/brian/.bash_history

>=20

> -rw-------  1 brian support 13K Nov 15 10:39=20

>=20

> real    0m0.126s

>=20

> user    0m0.000s

>=20

> sys     0m0.004s

> =20

>=20

> During Test 1 there were 1,160 DNS packets (580 UDP packets, 580 TCP

> packets). During Test 2 there were 196 packets (all UDP).

=20

Very strange.  I don't have round-robin DNS configured, but in my

testing, autofs only called into the resolver once, but there were 6-8

queries logged by tcpdump.

=20

You can apply this patch and see what it outputs.  Turn off debug

logging, as it will just clutter the logs.  Results should be printed

in /var/log/messages:

=20

Dec 21 16:37:28 sig11 automount[3763]: add_host_addrs:883:
gethostbyname_r

=20

See how many of these print.  If it's not many, then we'll have to

look elsewhere for your problem (or I've missed some resolver queries

from autofs!).

=20

-Jeff

=20

=20

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c

index 5797639..90bf768 100644

--- a/lib/rpc_subs.c

+++ b/lib/rpc_subs.c

@@ -91,6 +91,7 @@ static CLIENT *create_udp_client(struct conn_info
*info)

=20

      memset(&hp, 0, sizeof(struct hostent));

=20

+     logerr("gethostbyname_r");

      ret =3D gethostbyname_r(info->host, php,

                  buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);

      if (ret || !result) {

@@ -300,6 +301,7 @@ static CLIENT *create_tcp_client(struct conn_info
*info)

=20

      memset(&hp, 0, sizeof(struct hostent));

=20

+     logerr("gethostbyname_r");

      ret =3D gethostbyname_r(info->host, php,

                  buf, HOST_ENT_BUF_SIZE, &result, &ghn_errno);

      if (ret || !result) {

diff --git a/modules/replicated.c b/modules/replicated.c

index 90b2925..5171beb 100644

--- a/modules/replicated.c

+++ b/modules/replicated.c

@@ -880,6 +880,7 @@ static int add_host_addrs(struct host **list, const
char *host, unsigned int wei

      memset(buf, 0, MAX_IFC_BUF);

      memset(&he, 0, sizeof(struct hostent));

=20

+     logerr("gethostbyname_r");

      ret =3D gethostbyname_r(host, phe,

                  buf, MAX_IFC_BUF, &result, &ghn_errno);

      if (ret || !result) {


NOTICE:
This message may contain privileged or otherwise confidential information.
If you are not the intended recipient, please immediately advise the sender
by reply email and delete the message and any attachments without using,
copying or disclosing the contents.



------_=_NextPart_001_01C84424.B735B19F
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:dt=3D"uuid:C2F4101=
0-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://schemas.microsoft.com/offi=
ce/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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

<p class=3DMsoPlainText>Jeff,<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>I applied the patch and here is what was recorded. =
<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:13 myhost a=
utofs:
automount startup succeeded<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: add_host_addrs:883: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast message
repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:42 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast message
repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast message
repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:43 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost a=
utomount[3909]:
create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast message
repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:44 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost a=
utomount[3909]:
create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast message
repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_udp_client:94: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost l=
ast
message repeated 2 times<o:p></o:p></p>

<p class=3DMsoPlainText style=3D'margin-left:.5in'>Dec 21 16:52:45 myhost
automount[3909]: create_tcp_client:304: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

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
From: Jeff Moyer [mailto:jmoyer@redhat.com] <br>
Sent: Friday, December 21, 2007 3:46 PM<br>
To: James Richardson<br>
Cc: Ian Kent; autofs@linux.kernel.org<br>
Subject: Re: [autofs] Slow mounts when using large round robin sets<o:p></o=
:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&quot;James Richardson&quot;
&lt;jrichardson@x-iss.com&gt; writes:<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; Jeff,<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; Using the latest Autofs source code from I rec=
eived
the following<o:p></o:p></p>

<p class=3DMsoPlainText>&gt; results:<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; large-rr.domain.tld contains 49 A records in D=
NS.<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; small-rr.domain.tld contains 16 A records (a s=
ubset
of large-rr).<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; Test 1:<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; I configured auto.home with the entry:<o:p></o=
:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brian -rsi=
ze=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3<o:p></o:p></p>

<p class=3DMsoPlainText>&gt; large-rr:/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; # time ls /home/brian/.bash_history<o:p></o:p>=
</p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; /home/brian/.bash_history<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; real&nbsp;&nbsp;&nbsp; 0m0.734s<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; user&nbsp;&nbsp;&nbsp; 0m0.000s<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.000s<o:p></o:p=
></p>

<p class=3DMsoPlainText>&gt;&nbsp; <o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; Test 2:<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; I then rebooted the server to remove any local
cached anything and<o:p></o:p></p>

<p class=3DMsoPlainText>&gt; updated auto.home to have:<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; brian -rsi=
ze=3D8192,wsize=3D8192,proto=3Dtcp,vers=3D3<o:p></o:p></p>

<p class=3DMsoPlainText>&gt; small-rr:/home/brian<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; # time ls -alht /home/brian/.bash_history<o:p>=
</o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; -rw-------&nbsp; 1 brian support 13K Nov 15 10=
:39 <o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; real&nbsp;&nbsp;&nbsp; 0m0.126s<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; user&nbsp;&nbsp;&nbsp; 0m0.000s<o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; sys&nbsp;&nbsp;&nbsp;&nbsp; 0m0.004s<o:p></o:p=
></p>

<p class=3DMsoPlainText>&gt;&nbsp; <o:p></o:p></p>

<p class=3DMsoPlainText>&gt;<o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>&gt; During Test 1 there were 1,160 DNS packets (58=
0 UDP
packets, 580 TCP<o:p></o:p></p>

<p class=3DMsoPlainText>&gt; packets). During Test 2 there were 196 packets=
 (all
UDP).<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Very strange.&nbsp; I don't have round-robin DNS co=
nfigured,
but in my<o:p></o:p></p>

<p class=3DMsoPlainText>testing, autofs only called into the resolver once,=
 but
there were 6-8<o:p></o:p></p>

<p class=3DMsoPlainText>queries logged by tcpdump.<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>You can apply this patch and see what it outputs.&n=
bsp; Turn
off debug<o:p></o:p></p>

<p class=3DMsoPlainText>logging, as it will just clutter the logs.&nbsp; Re=
sults
should be printed<o:p></o:p></p>

<p class=3DMsoPlainText>in /var/log/messages:<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>Dec 21 16:37:28 sig11 automount[3763]:
add_host_addrs:883: gethostbyname_r<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>See how many of these print.&nbsp; If it's not many=
, then
we'll have to<o:p></o:p></p>

<p class=3DMsoPlainText>look elsewhere for your problem (or I've missed som=
e
resolver queries<o:p></o:p></p>

<p class=3DMsoPlainText>from autofs!).<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>-Jeff<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c<o:p></=
o:p></p>

<p class=3DMsoPlainText>index 5797639..90bf768 100644<o:p></o:p></p>

<p class=3DMsoPlainText>--- a/lib/rpc_subs.c<o:p></o:p></p>

<p class=3DMsoPlainText>+++ b/lib/rpc_subs.c<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -91,6 +91,7 @@ static CLIENT *create_udp_client(=
struct
conn_info *info)<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;hp, 0, s=
izeof(struct hostent));<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; logerr(&quot;gethostbynam=
e_r&quot;);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D gethostbynam=
e_r(info-&gt;host, php,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf, HOST_ENT_BUF_SIZE,=
 &amp;result,
&amp;ghn_errno);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || !result) =
{<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -300,6 +301,7 @@ static CLIENT
*create_tcp_client(struct conn_info *info)<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;hp, 0, s=
izeof(struct hostent));<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; logerr(&quot;gethostbynam=
e_r&quot;);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D gethostbynam=
e_r(info-&gt;host, php,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf, HOST_ENT_BUF_SIZE,=
 &amp;result,
&amp;ghn_errno);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || !result) =
{<o:p></o:p></p>

<p class=3DMsoPlainText>diff --git a/modules/replicated.c b/modules/replica=
ted.c<o:p></o:p></p>

<p class=3DMsoPlainText>index 90b2925..5171beb 100644<o:p></o:p></p>

<p class=3DMsoPlainText>--- a/modules/replicated.c<o:p></o:p></p>

<p class=3DMsoPlainText>+++ b/modules/replicated.c<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -880,6 +880,7 @@ static int add_host_addrs(struc=
t host
**list, const char *host, unsigned int wei<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(buf, 0, MAX_I=
FC_BUF);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;he, 0, s=
izeof(struct hostent));<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;<o:p></o:p></p>

<p class=3DMsoPlainText>+&nbsp;&nbsp;&nbsp;&nbsp; logerr(&quot;gethostbynam=
e_r&quot;);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D gethostbynam=
e_r(host, phe,<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf, MAX_IFC_BUF, &amp;=
result,
&amp;ghn_errno);<o:p></o:p></p>

<p class=3DMsoPlainText>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret || !result) =
{<o:p></o:p></p>

</div>

<br><pre>NOTICE:
This message may contain privileged or otherwise confidential information.
If you are not the intended recipient, please immediately advise the sender
by reply email and delete the message and any attachments without using,
copying or disclosing the contents.
</pre></body>

</html>


------_=_NextPart_001_01C84424.B735B19F--


--===============4902962447093812658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4902962447093812658==--

