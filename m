From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: autofs problems with RHEL4
Date: Thu, 18 Oct 2007 09:04:31 +0800
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F041EE6CF@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C81122.D6D82B9C"
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81122.D6D82B9C
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C81122.D6D82B9C"


------_=_NextPart_002_01C81122.D6D82B9C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi all

We run 150+ RHEL3 workstations and a handfull of RHEL4 and RHEL5 boxes.
Our automount maps are served from a Sun One Directory Server v5.1, the
main automount map contains 1258 entries.

On RHEL3 (update 9 fully patched) and RHEL5 (fully patched), autofs
behaves just fine, exactly as we need. =20

On RHEL4 autofs behaves very differently.  (kernel-smp-2.6.9-55.0.9.EL,
autofs-4.1.3-199.3).

Symptoms:
1) Weirdness with symlinks
ls -ld /scratch /scratch/memconf
lrwxrwxrwx    1 root     root           20 Sep  4 11:11 /scratch ->
/nfs/perseus/scratch
lrwxrwxrwx    1 root     bin            34 Oct 16 05:05 /scratch/memconf
-> /nfs/wwwproxy/data/mgmtvol/memconf

On EL3/5, 'ls -l /scratch/memconf/' will list the contents of the
directory '/scratch/memconf' points at.
On EL4, the first time you do a 'ls -l /scratch/memconf/' will produce
'ls: /scratch/memconf/: No such file or directory'.  Repeating the
command will sometimes give the same error but eventually it will work
and once working will continue to work until the mounts expire and then
you're back to square one.

2) Different behavior with BASH, <TAB> completions:
On EL3/5, typing /scra<TAB> will complete to '/scratch/'
On EL4, typing /scra<TAB> will complete to '/scratch ' (note the space
at the end).

I know this is minor but the users hate this.

If '/scratch' is already automounted, the <TAB> completion will put a
'/' at the end rather than a space.

I have attached our /etc/auto.master and /etc/sysconfig/autofs files.
 <<auto.master>>  <<autofs>>=20
Thanks in advance

CC

NOTICE: This email and any attachments are confidential.=20
They may contain legally privileged information or=20
copyright material. You must not read, copy, use or=20
disclose them without authorisation. If you are not an=20
intended recipient, please contact us at once by return=20
email and then delete both messages and all attachments.

------_=_NextPart_002_01C81122.D6D82B9C
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7652.24">
<TITLE>autofs problems with RHEL4</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hi all</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">We run 150+ RHEL3 workstations and a handf=
ull of RHEL4 and RHEL5 boxes.&nbsp; Our automount maps are served from a Su=
n One Directory Server v5.1, the main automount map contains 1258 entries.<=
/FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">On RHEL3 (update 9 fully patched) and RHEL=
5 (fully patched), autofs behaves just fine, exactly as we need.&nbsp; </FO=
NT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">On RHEL4 autofs behaves very differently.&=
nbsp; (kernel-smp-2.6.9-55.0.9.EL, autofs-4.1.3-199.3).</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Symptoms:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">1) Weirdness with symlinks</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">ls -ld /scratch /scratch/memconf</F=
ONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">lrwxrwxrwx&nbsp;&nbsp;&nbsp; 1 root=
&nbsp;&nbsp;&nbsp;&nbsp; root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 20 Sep&nbsp; 4 11:11 /scratch -&gt; /nfs/perseus/scratch</FO=
NT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">lrwxrwxrwx&nbsp;&nbsp;&nbsp; 1 root=
&nbsp;&nbsp;&nbsp;&nbsp; bin&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 34 Oct 16 05:05 /scratch/memconf -&gt; /nfs/wwwproxy/da=
ta/mgmtvol/memconf</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">On EL3/5, 'ls -l /scratch/memconf/' will l=
ist the contents of the directory '/scratch/memconf' points at.</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">On EL4, the first time you do a 'ls -l /s=
cratch/memconf/' will produce 'ls: /scratch/memconf/: No such file or direc=
tory'.&nbsp; Repeating the command will sometimes give the same error but e=
ventually it will work and once working will continue to work until the mou=
nts expire and then you're back to square one.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">2) Different behavior with BASH, &lt;TAB&g=
t; completions:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">On EL3/5, typing /scra&lt;TAB&gt; will co=
mplete to '/scratch/'</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">On EL4, typing /scra&lt;TAB&gt; will comp=
lete to '/scratch ' (note the space at the end).</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I know this is minor but the users hate th=
is.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">If '/scratch' is already automounted, the =
&lt;TAB&gt; completion will put a '/' at the end rather than a space.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I have attached our /etc/auto.master and /=
etc/sysconfig/autofs files.</FONT>

<BR><FONT FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"> &lt;&lt;auto.master&gt=
;&gt; </FONT><FONT FACE=3D"Arial" SIZE=3D2 COLOR=3D"#000000"> &lt;&lt;autof=
s&gt;&gt; </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Arial">Thanks in advance</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">CC</FONT>
</P>

<pre>
NOTICE: This email and any attachments are confidential.=20
They may contain legally privileged information or=20
copyright material. You must not read, copy, use or=20
disclose them without authorisation. If you are not an=20
intended recipient, please contact us at once by return=20
email and then delete both messages and all attachments.
</pre></BODY>
</HTML>
------_=_NextPart_002_01C81122.D6D82B9C--

------_=_NextPart_001_01C81122.D6D82B9C
Content-Type: application/octet-stream;
	name="auto.master"
Content-Transfer-Encoding: base64
Content-Description: auto.master
Content-Disposition: attachment;
	filename="auto.master"

IwojICRJZDogYXV0by5tYXN0ZXIsdiAxLjMgMjAwMy8wOS8yOSAwODoyMjozNSByYXZlbiBFeHAg
JAojCiMgU2FtcGxlIGF1dG8ubWFzdGVyIGZpbGUKIyBUaGlzIGlzIGFuIGF1dG9tb3VudGVyIG1h
cCBhbmQgaXQgaGFzIHRoZSBmb2xsb3dpbmcgZm9ybWF0CiMga2V5IFsgLW1vdW50LW9wdGlvbnMt
c2VwYXJhdGVkLWJ5LWNvbW1hIF0gbG9jYXRpb24KIyBGb3IgZGV0YWlscyBvZiB0aGUgZm9ybWF0
IGxvb2sgYXQgYXV0b2ZzKDUpLgojL21pc2MJL2V0Yy9hdXRvLm1pc2MgLS10aW1lb3V0PTYwCiMv
bWlzYwkvZXRjL2F1dG8ubWlzYwojL25ldAkvZXRjL2F1dG8ubmV0Ci8tICAgICAgYXV0b19nbG9i
YWwgLS1naG9zdCBuZnN2ZXJzPTMsdGNwLHJzaXplPTMyNzY4LHdzaXplPTMyNzY4Ci9ob21lICAg
YXV0b19ob21lICAgLS1naG9zdCBuZnN2ZXJzPTMsdGNwLHJzaXplPTMyNzY4LHdzaXplPTMyNzY4
Cg==

------_=_NextPart_001_01C81122.D6D82B9C
Content-Type: application/octet-stream;
	name="autofs"
Content-Transfer-Encoding: base64
Content-Description: autofs
Content-Disposition: attachment;
	filename="autofs"

IyBEZWZpbmUgY3VzdG9tIG9wdGlvbnMgaW4gL2V0Yy9zeXNjb25maWcvYXV0b2ZzCiMgVXNlIExP
Q0FMT1BUSU9OUyBmb3IgZGVmaW5pbmcgdmFyaWFibGVzLCBlLmcuIE9TUkVMCiMgVXNlIERBRU1P
Tk9QVElPTlMgdG8gZGVmaW5lIHRoZSB1bm1vdW50IHRpbWVvdXQKIyBEZWZpbmUgVU5ERVJTQ09S
RVRPRE9UIGFzIDEgdG8gY29udmVydCAKIyAgICAgYXV0b19ob21lIHRvIGF1dG8uaG9tZSBhbmQg
YXV0b19tbnQgdG8gYXV0by5tbnQKIyBNb3VudCBvcHRpb25zLCBlLmcuIHJzaXplPTgxOTIsIHNo
b3VsZCBnbyBpbiBhdXRvLm1hc3RlciBvcgojICAgICB0aGUgYXV0b18qIG1hcCBlbnRyeSBmb3Ig
YSBzcGVjaWZpYyBtb3VudCBwb2ludAojCkxPQ0FMT1BUSU9OUz0iIgpEQUVNT05PUFRJT05TPSIt
LXRpbWVvdXQ9NjAgLS1kZWJ1ZyIKTERBUEFVVE9NQVNURVI9IiIKIyAgVU5ERVJTQ09SRVRPRE9U
IGNoYW5nZXMgYXV0b19ob21lIHRvIGF1dG8uaG9tZSBhbmQgYXV0b19tbnQgdG8gYXV0by5tbnQK
VU5ERVJTQ09SRVRPRE9UPTEKRElTQUJMRV9ESVJFQ1Q9MAojIE9ubHkgc291cmNlIG9uZSBtYXN0
ZXIgbWFwIGlmIHNldCB0byAxLiAgVGhpcyB3b3VsZCBtaW1pYyBTdW4gYmVoYXZpb3VyLgojIFRo
ZSBkZWZhdWx0IGlzIDAgdG8gbWFpbnRhaW4gYmFja3dhcmRzIGNvbXBhdGliaWxpdHkuCk9ORV9B
VVRPX01BU1RFUj0wCiMgTGlzdCBvZiBkaXJlY3RvcmllcyB0byBiZSBnaG9zdGVkLCBzZXBhcmF0
ZWQgYnkgd2hpdGUgc3BhY2UuCkdIT1NURElSUz0iIgojIEJhc2UgRE4gdG8gdXNlIHdoZW4gc2Vh
cmNoaW5nIGZvciB0aGUgbWFzdGVyIG1hcApCQVNFRE49CiMgVGhlIGxkYXAgbW9kdWxlIHdhcyB1
cGRhdGVkIHRvIG9ubHkgdHJ5IHRoZSBmaXJzdCBzY2hlbWEgdGhhdCB3b3JrcwojIChpbnN0ZWFk
IG9mIHRyeWluZyBhbGwgMyBhdXRvZnMgc2NoZW1hcyBmb3IgZWFjaCBsb29rdXApLiAgSXQgaXMK
IyBwb3NzaWJsZSwgdGhvdWdoIHVubGlrZWx5LCB0aGF0IHRoaXMgY291bGQgY2F1c2UgcHJvYmxl
bXMuICBJZiB5b3UgdXBkYXRlCiMgdGhlIGF1dG9tb3VudGVyIGFuZCBmaW5kIHRoYXQgeW91ciBs
ZGFwIHNjaGVtYXMgZG9lc24ndCB3b3JrIGFzIGl0IGRpZAojIHByZXZpb3VzbHksIHRyeSBzZXR0
aW5nIHRoaXMgb3B0aW9uIHRvIDEuICBQbGVhc2UgYWxzbyByZXBvcnQgdGhlIHByb2JsZW0sCiMg
YXMgaXQgaXMgbGlrZWx5IHRoYXQgeW91ciBzY2hlbWEgaXMgaW5jb21wYXRpYmxlIHdpdGggYXV0
b2ZzIHY1LgpPTERfTERBUF9MT09LVVA9MAo=

------_=_NextPart_001_01C81122.D6D82B9C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

------_=_NextPart_001_01C81122.D6D82B9C--

