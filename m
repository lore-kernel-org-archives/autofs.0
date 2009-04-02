From: q q <andukundu@yahoo.com>
Subject: NFS unmount notification
Date: Wed, 1 Apr 2009 21:11:39 -0700 (PDT)
Message-ID: <888706.70098.qm@web45203.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7064213223012561914=="
Return-path: <autofs-bounces@linux.kernel.org>
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


--===============7064213223012561914==
Content-Type: multipart/alternative; boundary="0-520915647-1238645499=:70098"


--0-520915647-1238645499=:70098
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable







Hi,
=A0
Is there any way I can get a notification when a NFS directory mounted thro=
ugh autofs is unmounted. I tried using inotify, but did not succeed. The ma=
sk was never set to IN_UNMOUNT. I tried keeping watch on parent/destination=
/child directory, but was of no use.
=A0
Any suggestions?
=A0
Thanks,
Gang=0A=0A=0A      
--0-520915647-1238645499=:70098
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><DIV>
<TABLE border=3D0 cellSpacing=3D0 cellPadding=3D0>
<TBODY>
<TR>
<TD vAlign=3Dtop>
<BLOCKQUOTE style=3D"BORDER-LEFT: rgb(16,16,255) 2px solid; PADDING-LEFT: 5=
px; MARGIN-LEFT: 5px">
<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>Is there any way I can get a notification when a NFS directory mounted=
 through autofs is unmounted. I tried using inotify, but did not succeed. T=
he mask was never set to IN_UNMOUNT. I tried keeping watch on parent/destin=
ation/child directory, but was of no use.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Any suggestions?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks,</DIV>
<DIV>Gang</DIV></BLOCKQUOTE></TD></TR></TBODY></TABLE></DIV></td></tr></tab=
le><br>=0A=0A=0A=0A      
--0-520915647-1238645499=:70098--


--===============7064213223012561914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7064213223012561914==--

