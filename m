From: Scott Leerssen <scott@leerssen.com>
Subject: automount deletes and fails to recreate mount points
Date: Mon, 5 Nov 2007 12:43:49 -0500
Message-ID: <0E22C564-0BD1-4930-889E-CBB4EBF05C52@leerssen.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary="===============6225298204628957972=="
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


--===============6225298204628957972==
Content-Type: multipart/alternative; boundary=Apple-Mail-9--918419107


--Apple-Mail-9--918419107
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hi,

A google search and scan of the archives didn't reveal an answer, so  
I apologize in advance if this subject has been beaten to death  
already.  Here are a few version numbers for reference:

CentOS 5
kernel:  2.6.18-8.1.15.el5
autofs: autofs-5.0.1-0.rc2.43.0.2
SElinux: disabled

I have a stock, yum updated CentOS 5 installation on which autofs  
works fine as long as the mount points are pre-existing.  However, if  
I stop the automounter with 'service autofs stop' (or by rebooting),  
the automounter deletes my /net and /misc mount points and then fails  
to recreate them on 'service autofs start'.

One caveat to the "normal" CentOS 5 install, is that I'm running off  
of an NFS root.  Is there anything in particular about having a mount  
point inside another NFS mounted directory that would make automount  
want to remove my mount points and fail to recreate them?


Scott Leerssen
scott@leerssen.com

A.S.K. c2fdaa4f-3a4b-4bee-9335-945dabdce5cd


--Apple-Mail-9--918419107
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">
<div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Hi,=A0</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><br =
class=3D"webkit-block-placeholder"></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica">A google =
search and scan of the archives didn't reveal an answer, so I apologize =
in advance if this subject has been beaten to death already. =A0Here are =
a few version numbers for reference:</font></div><div style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><br =
class=3D"webkit-block-placeholder"></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica">CentOS =
5</font></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">kernel: =
=A02.6.18-8.1.15.el5</font></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica">autofs: =
autofs-5.0.1-0.rc2.43.0.2</font></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica">SElinux: =
disabled</font></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><font face=3D"Helvetica" size=3D"3" style=3D"font: =
12.0px Helvetica">I have a stock, yum updated CentOS 5 installation on =
which autofs works fine as long as the mount points are pre-existing. =
=A0However, if I stop the automounter with 'service autofs stop' (or by =
rebooting), the automounter deletes my /net and /misc mount points and =
then fails to recreate them on 'service autofs start'.</font></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><br></div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><font =
face=3D"Helvetica" size=3D"3" style=3D"font: 12.0px Helvetica">One =
caveat to the "normal" CentOS 5 install, is that I'm running off of an =
NFS root. =A0Is there anything in particular about having a mount point =
inside another NFS mounted directory that would make automount want to =
remove my mount points and fail to recreate them? =
=A0</font></div><br><div> <span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><div><br =
class=3D"Apple-interchange-newline">Scott Leerssen</div><div><a =
href=3D"mailto:scott@leerssen.com">scott@leerssen.com</a></div><div><br></=
div></span>A.S.K. c2fdaa4f-3a4b-4bee-9335-945dabdce5cd</span> =
</div><br></body></html>=

--Apple-Mail-9--918419107--


--===============6225298204628957972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6225298204628957972==--

