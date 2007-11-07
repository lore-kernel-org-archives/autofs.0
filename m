From: Scott Leerssen <scott@leerssen.com>
Subject: Re: automount deletes and fails to recreate mount points
Date: Wed, 7 Nov 2007 12:46:54 -0500
Message-ID: <2E7073E0-D5EC-42C9-96AF-D4373C3BB89C@leerssen.com>
References: <0E22C564-0BD1-4930-889E-CBB4EBF05C52@leerssen.com>
	<1194405020.3113.8.camel@raven.themaw.net>
	<3CE53FD7-F085-4313-AB14-8A733742BF4B@leerssen.com>
	<1194450752.13416.29.camel@raven.themaw.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary="===============7281913816357367178=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1194450752.13416.29.camel@raven.themaw.net>
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


--===============7281913816357367178==
Content-Type: multipart/alternative; boundary=Apple-Mail-18--745433838


--Apple-Mail-18--745433838
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Nov 7, 2007, at 10:52 AM, Ian Kent wrote:

>
>
> The problem is that, for various reasons, autofs won't create mount
> point directories on what it thinks is a remote file system. But,  
> if the
> directory already exists, then it shouldn't be removed at shutdown.
>
> I think that was fixed in revision 0.rc2.44.
>
> Ian
>

Excellent, thanks. 
--Apple-Mail-18--745433838
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">
<br><div><div>On Nov 7, 2007, at 10:52 AM, Ian Kent wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><br></div><blockquote type=3D"cite"> =
</blockquote><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><br></div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">The problem is that, for various reasons, autofs =
won't create mount</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">point directories on what =
it thinks is a remote file system. But, if the</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">directory already exists, then it shouldn't be =
removed at shutdown.</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; min-height: 14px; =
"><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">I think that was fixed in =
revision 0.rc2.44.</div><div style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; min-height: 14px; =
"><br></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Ian</div><div style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><br></div> </blockquote></div><br><div> <span =
class=3D"Apple-style-span" style=3D"border-collapse: separate; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; orphans: 2; text-align: auto; text-indent: =
0px; text-transform: none; white-space: normal; widows: 2; word-spacing: =
0px; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><span class=3D"Apple-style-span" =
style=3D"border-collapse: separate; color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: 2; text-align: auto; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-border-horizontal-spacing: 0px; -webkit-border-vertical-spacing: =
0px; -webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0; "><div>Excellent, =
thanks.=A0</div></span></span></div></body></html>=

--Apple-Mail-18--745433838--


--===============7281913816357367178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7281913816357367178==--

