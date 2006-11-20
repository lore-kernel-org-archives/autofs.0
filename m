From: "Shawn Starr" <sstarr@platform.com>
Subject: Re: Automount with a local NFS export and a remote NFS
	export using the same mount path name over LDAP
Date: Mon, 20 Nov 2006 15:03:18 -0500
Message-ID: <E2AC825D4FC7764DA86D9C8ECA27A2DE065AEA@catoexm05.noam.corp.platform.com>
References: <E2AC825D4FC7764DA86D9C8ECA27A2DEAF7B34@catoexm05.noam.corp.platform.com>
	<x49k61quoif.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1395968908417933818=="
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--===============1395968908417933818==
content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C70CDE.EBBD848C"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70CDE.EBBD848C
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

=3D=3D> On Mon, 20 Nov 2006 10:27 AM, "Jeff Moyer" said:

>For some reason, I can't find your original post in my mailbox...
>
>For the RHEL variants, add this to your /etc/sysconfig/autofs
>
>ONE_AUTO_MASTER=3D1
>
>Shawn> > If Automount 4 can't do this does version 5? :)
>
>Yes, but in the v5 case no special settings are necessary.
>
>-Jeff

Yes, I am using RHEL4 at present. I just found the errata page this =
should solve the issue.

Thank you!
Shawn.

------_=_NextPart_001_01C70CDE.EBBD848C
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DWindows-1252">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.0.6618.4">
<TITLE>RE: [autofs] Automount with a local NFS export and a remote NFS =
export using the same mount path name over LDAP</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>=3D=3D&gt; On Mon, 20 Nov 2006 10:27 AM, &quot;Jeff =
Moyer&quot; said:<BR>
<BR>
&gt;For some reason, I can't find your original post in my =
mailbox...<BR>
&gt;<BR>
&gt;For the RHEL variants, add this to your /etc/sysconfig/autofs<BR>
&gt;<BR>
&gt;ONE_AUTO_MASTER=3D1<BR>
&gt;<BR>
&gt;Shawn&gt; &gt; If Automount 4 can't do this does version 5? :)<BR>
&gt;<BR>
&gt;Yes, but in the v5 case no special settings are necessary.<BR>
&gt;<BR>
&gt;-Jeff<BR>
<BR>
Yes, I am using RHEL4 at present. I just found the errata page this =
should solve the issue.<BR>
<BR>
Thank you!<BR>
Shawn.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C70CDE.EBBD848C--


--===============1395968908417933818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1395968908417933818==--

