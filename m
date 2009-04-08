From: "Mazzocchi, Stefano" <stefano.mazzocchi@eds.com>
Subject: autofs double mount when key in mapfile is a relative
	path...
Date: Wed, 8 Apr 2009 13:03:41 +0200
Message-ID: <2BA9322EE5F80A4B8E7B40593937D5A301825AE6@defrm203.emea.corp.eds.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0805640124571237204=="
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
To: autofs@linux.kernel.org
Cc: TS-AS-UNIX-ICT@sict.eni.it

This is a multi-part message in MIME format.

--===============0805640124571237204==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9B839.AD05D46A"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9B839.AD05D46A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



Hi there,=20

I hope this is the right place to post a issue we experience with autofs
on Linux Redhat 4.6. =20
We are using indirect mount to mount different directories from the same
host at different depth level.=20
Each directory is a separate file system on the file server.  File
server is a Sun Solaris 8.=20
Here  my auto.master entry:=20

cat auto.master:=20
/data/gqssan1   /etc/auto.gqssan1 --ghost --timeout=3D60

I assume that I can specify a relative path name as "key" within my
mapfile:=20

   key
       For indirect mounts this is the part of the pathname between the
mount-
       point  and the path into the filesystem mounted. Usually you can
think
       about the key as a subdirectory name below the mountpoint.

here is my mapfile entry:=20

cat auto.gqssan1

1       	-rw,soft,intr   stargeo:/data/gqssan1/1
...
30       	-rw,soft,intr   stargeo:/data/gqssan1/30
GEOS/1       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/1
GEOS/2       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/2
GEOS/3       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/3
GEOS/4       -rw,soft,intr   stargeo:/data/gqssan1/GEOS/4

At the very beginning everything seems to be fine. After about 10
minutes time,  I see another mount point=20
with the same name within the very first one:=20

[root@ensv16im gqssan1]# cd /data/gqssan1/GEOS/
[root@ensv16im GEOS]# ls -tlr
total 0
dr-xr-xr-x    6 root     root            0 Apr  8 00:03 GEOS
dr-xr-xr-x    2 root     root            0 Apr  8 00:03 4
dr-xr-xr-x    2 root     root            0 Apr  8 00:03 3
dr-xr-xr-x    2 root     root            0 Apr  8 00:03 2
dr-xr-xr-x    2 root     root            0 Apr  8 00:03 1

I cd to both mount points and I see my file system mounte twice.=20

[root@ensv16im GEOS]# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/vg00/rootvol     7.8G  3.3G  4.2G  44% /
/dev/sda1              99M   33M   61M  36% /boot
none                  989M     0  989M   0% /dev/shm
siful4:/vol/siful4_base/3RD
                      170G  166G  5.0G  98% /sw/3rd
/dev/vg01/owdata       72G   33M   69G   1% /data
stargeo:/data/gqssan1/1
                      172G  131G   41G  77% /data/gqssan1/GEOS/1
stargeo:/data/gqssan1/GEOS/1
                      506G  149G  355G  30% /data/gqssan1/GEOS/GEOS/1


Am I correctly assuming that the "key" value may be a relative path as
well as a simple directory?=20

Please help.=20

Best regards,=20

Stefano Mazzocchi=20
tel 02.99964140
ts-as-unix
EDS - via Medici del vascello=20
mailto:stefano.mazzocchit@eds.com



------_=_NextPart_001_01C9B839.AD05D46A
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
<TITLE>autofs double mount when key in mapfile is a relative path... =
</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi there, </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I hope this is the right place to post =
a issue we experience with autofs on Linux Redhat 4.6.&nbsp; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">We are using indirect mount to mount =
different directories from the same host at different depth level. =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Each directory is a separate file =
system on the file server.&nbsp; File server is a Sun Solaris 8. </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Here&nbsp; my auto.master entry: =
</FONT>
</P>

<P><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier New">cat =
auto.master: </FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">/data/gqssan1&nbsp;&nbsp; /etc/auto.gqssan1 --ghost =
--timeout=3D60</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I assume that I can specify a relative =
path name as &quot;key&quot; within my mapfile: </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp; key</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
For indirect mounts<I> this is the part of the pathname between the =
mount-</I></FONT>

<BR><I><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; point&nbsp; and the =
path into the filesystem mounted.</FONT></I><FONT SIZE=3D2 =
FACE=3D"Arial"> Usually you can think</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
about the key as a subdirectory name below the mountpoint.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">here is my mapfile entry:</FONT>=20
</P>

<P><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier New">cat =
auto.gqssan1</FONT>
</P>

<P><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -rw,soft,intr&nbsp;&nbsp; =
stargeo:/data/gqssan1/1</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier New">...</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">30&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -rw,soft,intr&nbsp;&nbsp; =
stargeo:/data/gqssan1/30</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">GEOS/1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-rw,soft,intr&nbsp;&nbsp; stargeo:/data/gqssan1/GEOS/1</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">GEOS/2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-rw,soft,intr&nbsp;&nbsp; stargeo:/data/gqssan1/GEOS/2</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">GEOS/3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-rw,soft,intr&nbsp;&nbsp; stargeo:/data/gqssan1/GEOS/3</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">GEOS/4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-rw,soft,intr&nbsp;&nbsp; stargeo:/data/gqssan1/GEOS/4</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">At the very beginning everything seems =
to be fine. After about 10 minutes time,&nbsp; I see another mount point =
</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">with the same name within the very =
first one: </FONT>
</P>

<P><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier New">[root@ensv16im =
gqssan1]# cd /data/gqssan1/GEOS/</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier New">[root@ensv16im =
GEOS]# ls -tlr</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier New">total 0</FONT>

<BR><FONT COLOR=3D"#FF0000" SIZE=3D2 FACE=3D"Courier =
New">dr-xr-xr-x&nbsp;&nbsp;&nbsp; 6 root&nbsp;&nbsp;&nbsp;&nbsp; =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
Apr&nbsp; 8 00:03 GEOS</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">dr-xr-xr-x&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp; =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
Apr&nbsp; 8 00:03 4</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">dr-xr-xr-x&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp; =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
Apr&nbsp; 8 00:03 3</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">dr-xr-xr-x&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp; =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
Apr&nbsp; 8 00:03 2</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">dr-xr-xr-x&nbsp;&nbsp;&nbsp; 2 root&nbsp;&nbsp;&nbsp;&nbsp; =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 =
Apr&nbsp; 8 00:03 1</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I cd to both mount points and I see my =
file system mounte twice. </FONT>
</P>

<P><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier New">[root@ensv16im =
GEOS]# df -h</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">Filesystem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Size&nbsp; Used Avail Use% Mounted on</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">/dev/vg00/rootvol&nbsp;&nbsp;&nbsp;&nbsp; 7.8G&nbsp; 3.3G&nbsp; =
4.2G&nbsp; 44% /</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">/dev/sda1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 99M&nbsp;&nbsp; 33M&nbsp;&nbsp; 61M&nbsp; 36% =
/boot</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">none&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 989M&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp; 989M&nbsp;&nbsp; 0% /dev/shm</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">siful4:/vol/siful4_base/3RD</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 170G&nbsp; =
166G&nbsp; 5.0G&nbsp; 98% /sw/3rd</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Courier =
New">/dev/vg01/owdata&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
72G&nbsp;&nbsp; 33M&nbsp;&nbsp; 69G&nbsp;&nbsp; 1% /data</FONT>

<BR><FONT COLOR=3D"#FF0000" SIZE=3D2 FACE=3D"Courier =
New">stargeo:/data/gqssan1/1</FONT>

<BR><FONT COLOR=3D"#FF0000" SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 172G&nbsp; =
131G&nbsp;&nbsp; 41G&nbsp; 77% /data/gqssan1/GEOS/1</FONT>

<BR><FONT COLOR=3D"#FF0000" SIZE=3D2 FACE=3D"Courier =
New">stargeo:/data/gqssan1/GEOS/1</FONT>

<BR><FONT COLOR=3D"#FF0000" SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 506G&nbsp; =
149G&nbsp; 355G&nbsp; 30% /data/gqssan1/GEOS/GEOS/1</FONT>
</P>
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Am I correctly assuming that the =
&quot;key&quot; value may be a relative path as well as a simple =
directory? </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Please help. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Best regards, </FONT>
</P>

<P><B><FONT COLOR=3D"#000080" FACE=3D"Arial">Stefano =
Mazzocchi</FONT></B>=20

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">tel =
02.99964140</FONT>

<BR><FONT COLOR=3D"#000080" FACE=3D"Arial">ts-as-unix</FONT>

<BR><FONT COLOR=3D"#000080" SIZE=3D2 FACE=3D"Arial">EDS - via Medici del =
vascello</FONT>=20

<BR><A HREF=3D"mailto:stefano.mazzocchit@eds.com"><U></U><U><FONT =
COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">mailto:stefano.mazzocchit@eds.com</FONT></U></A>
</P>
<BR>

</BODY>
</HTML>
------_=_NextPart_001_01C9B839.AD05D46A--


--===============0805640124571237204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0805640124571237204==--

