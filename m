From: "Newman, Edward \(GTI\)" <edward_newman@ml.com>
Subject: AutoFS / SASL support
Date: Mon, 29 Oct 2007 18:30:53 -0400
Message-ID: <E5F741E838FC2043A0B843E48181813806AB71D6@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4663923259855490356=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-Class: urn:content-classes:message
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

--===============4663923259855490356==
Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C81A7B.5DF04D46"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81A7B.5DF04D46
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Just wanted to confirm whether SASL support is currently broken in 5.0.2
with all outstanding patches applied.=20

Debug of code suggests following issues:

- Makefile has invalid test for HAVE_SASL in configure.in and thus
doesn't include correct libraries (-z instead of -n in test step)
- patched code in connect_to_server in lookup_ldap.c does not call
auth_init prior to testing for auth_required and thus fails SASL in all
cases
- order of code sequence currently fails to enable SASL correctly.

I am also trying to use an existing keytab for Kerberos GSSAPI
authentication to directory and currently sasl_kinit code appears to
fail. Haven't worked out exact cause yet but appears to not passing a
keytab name and environment is not picking up location from krb5.conf.

Please confirm above and whether this is being actively worked on at
this time.

Thanks

Edward
--------------------------------------------------------

This message w/attachments (message) may be privileged, confidential or =
proprietary, and if you are not an intended recipient, please notify the =
sender, do not use or share it and delete it. Unless specifically =
indicated, this message is not an offer to sell or a solicitation of any =
investment products or other financial product or service, an official =
confirmation of any transaction, or an official statement of Merrill =
Lynch. Subject to applicable law, Merrill Lynch may monitor, review and =
retain e-communications (EC) traveling through its networks/systems. The =
laws of the country of each sender/recipient may impact the handling of =
EC, and EC may be archived, supervised and produced in countries other =
than the country in which you are located. This message cannot be =
guaranteed to be secure or error-free. This message is subject to terms =
available at the following link: =
http://www.ml.com/e-communications_terms/. By messaging with Merrill =
Lynch you consent to the foregoing.
--------------------------------------------------------

------_=_NextPart_001_01C81A7B.5DF04D46
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<HTML xmlns:eXclaimer=3D"http://www.exclaimer.co.uk" =
xmlns:msxsl=3D"urn:schemas-microsoft-com:xslt" =
xmlns:exc=3D"http://www.exclaimer.co.uk/rtf">
<HEAD>
<META http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3DUTF-16">


<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6619.12">
<TITLE>AutoFS / SASL support</TITLE>
</HEAD>
<BODY >
<DIV>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Arial">Just wanted to confirm whether SASL =
support is currently broken in 5.0.2 with all outstanding patches =
applied. </FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Debug of code suggests following =
issues:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- Makefile has invalid test for =
HAVE_SASL in configure.in and thus doesn&#8217;t include correct =
libraries (-z instead of -n in test step)</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- patched code in connect_to_server in =
lookup_ldap.c does not call auth_init prior to testing for auth_required =
and thus fails SASL in all cases</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">- order of code sequence currently =
fails to enable SASL correctly.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I am also trying to use an existing =
keytab for Kerberos GSSAPI authentication to directory and currently =
sasl_kinit code appears to fail. Haven't worked out exact cause yet but =
appears to not passing a keytab name and environment is not picking up =
location from krb5.conf.</FONT></P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Please confirm above and whether this =
is being actively worked on at this time.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Edward</FONT>
</P>
<BR>

</DIV>
<DIV>
<HR COLOR=3D"gray">
</DIV>
<DIV><BODY >This message w/attachments (message) may be privileged, =
confidential or proprietary, and if you are not an intended recipient, =
please notify the sender, do not use or share it and delete it. Unless =
specifically indicated, this message is not an offer to sell or a =
solicitation of any investment products or other financial product or =
service, an official confirmation of any transaction, or an official =
statement of Merrill Lynch. Subject to applicable law, Merrill Lynch may =
monitor, review and retain e-communications (EC) traveling through its =
networks/systems. The laws of the country of each sender/recipient may =
impact the handling of EC, and EC may be archived, supervised and =
produced in countries other than the country in which you are located. =
This message cannot be guaranteed to be secure or error-free. This =
message is subject to terms available at the following link: <A =
HREF=3D"http://www.ml.com/e-communications_terms/">http://www.ml.com/e-co=
mmunications_terms/</A>. By messaging with Merrill Lynch you consent to =
the foregoing.</BODY></DIV>
<DIV>
<HR COLOR=3D"gray">
</DIV>
<DIV>
<FONT COLOR=3D"#008000">
</FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<P>
<FONT COLOR=3D"#008000">
</FONT>&nbsp;</P></BODY></HTML>

------_=_NextPart_001_01C81A7B.5DF04D46--


--===============4663923259855490356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4663923259855490356==--

