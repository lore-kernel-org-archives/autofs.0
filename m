From: "Gomez, Daniel" <dgomez@tigr.org>
Subject: Issuing custom mount commands within an autofs controlled
	mountpoint
Date: Tue, 20 Jun 2006 19:58:34 -0400
Message-ID: <7F0AA25C9B1706448E8B73DFDD109B31028E5AC1@EXCHANGE.TIGR.ORG>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6689711810222399223=="
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--===============6689711810222399223==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C694C5.707E0587"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C694C5.707E0587
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,
=20
Is it feasible to hijack the automounter and issue your own custom mount
command or must the automount program perform the actual "mount" call?
=20
The reason why I am interested is that we are using the IBRIX parallel
filesystem and we wish to have some clients mount IBRIX exported shares
using it's own special "ibrix_lwmount" client mount command and
non-ibrix clients to use the normal automount process. The catch is we
want to use the same mountpoint under the control of autofs for both
ibrix and non-ibrix clients.
=20
Is this feat feasible? Any insight into how one might even approach this
problem would be helpful to me and maybe to the whole community of ibrix
users using linux.
=20
I will say, I was able to simply double mount seemingly ok, meaning I
allow the automount to mount the directory as it will under normal
circumstances for regular clients, but then I run the ibrix mount
command ontop of the same directory. At first I was also using the
special ibrix umount command before I stopped the autofs daemon, but it
seems if I don't umount the double mounted directory, autofs still
unmounts all directory keys under the parent mountpoint fine.
=20
Does this raise any eyebrows here?
=20
Thanks.
-Daniel

=20


------_=_NextPart_001_01C694C5.707E0587
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Message</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY><SPAN class=3D320252223-20062006>
<DIV><SPAN class=3D320252223-20062006><FONT face=3DArial=20
size=3D2>Hello,</FONT></SPAN></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D320252223-20062006><FONT=20
face=3DArial size=3D2></FONT></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D320252223-20062006><FONT face=3DArial size=3D2>Is it =
feasible to=20
hijack the automounter and issue your own custom mount command or must =
the=20
automount program perform the actual "mount" call?</FONT></SPAN></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D320252223-20062006><FONT=20
face=3DArial size=3D2></FONT></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT><SPAN class=3D320252223-20062006><FONT face=3DArial =
size=3D2>The reason why=20
I am interested is that we are using the IBRIX parallel filesystem and =
we wish=20
to have some clients mount IBRIX exported shares using it's own special=20
"ibrix_lwmount" client mount command and non-ibrix clients to use the =
normal=20
automount process. The catch is we&nbsp;want to use the =
same&nbsp;mountpoint=20
under the control of autofs for both ibrix and non-ibrix=20
clients.</FONT></SPAN></FONT></DIV>
<DIV><FONT><SPAN class=3D320252223-20062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D320252223-20062006>Is this feat=20
feasible?&nbsp;</SPAN><SPAN class=3D320252223-20062006>Any insight into =
how one=20
might even approach this problem would be helpful to me and maybe to the =
whole=20
community of ibrix users using linux.</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D320252223-20062006></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><SPAN class=3D320252223-20062006><FONT face=3DArial size=3D2>I will =
say, I was=20
able to simply double mount seemingly ok, meaning I allow the automount =
to mount=20
the directory as it will under normal circumstances for regular clients, =
but=20
then I run the ibrix mount command ontop of the same directory. At first =
I was=20
also using the special ibrix umount command before I stopped the autofs =
daemon,=20
but it seems if I don't umount the double mounted directory, autofs =
still=20
unmounts all directory keys under the parent mountpoint=20
fine.</FONT></SPAN></DIV>
<DIV><SPAN class=3D320252223-20062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D320252223-20062006><FONT face=3DArial size=3D2>Does =
this raise any=20
eyebrows here?</FONT></SPAN></DIV>
<DIV><SPAN class=3D320252223-20062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D320252223-20062006><FONT face=3DArial=20
size=3D2>Thanks.<BR>-Daniel</FONT></SPAN></DIV>
<P><SPAN class=3D320252223-20062006><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</P></FONT></SPAN></BODY></HTML>

------_=_NextPart_001_01C694C5.707E0587--


--===============6689711810222399223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6689711810222399223==--

