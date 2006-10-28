From: Timo Wendt <twendt@online.de>
Subject: autofs 5 not recognizing manual umounts properly
Date: Sat, 28 Oct 2006 18:41:13 +0200
Message-ID: <B2E30F3E-200F-4D99-8813-732B62601D43@online.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/mixed; boundary="===============8769823635489907005=="
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


--===============8769823635489907005==
Content-Type: multipart/alternative; boundary=Apple-Mail-14--937120087


--Apple-Mail-14--937120087
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hi,

I have just installed FC6 to do some tests with autofs 5 as I need to  
use direct mounts. The new version works really great. The only thing  
I figured out so far that does not work fine is, when I umount one of  
the automounted fs manually.
If I then try to list the contents of that directory it says, that it  
is empty. As soon as I try to create a file in that directory, it  
fails and seems to realize, that the directory should be mounted and  
remounts it, without creating the file though.

Now I have 2 questions:

1. Why is it not remounting the FS when trying an ls on it?

2. Why is it not creating the file after remounting the FS instead of  
failing first and then doing the mount?

Timo




--Apple-Mail-14--937120087
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=US-ASCII

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; "><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Hi,</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">I have just =
installed FC6 to do some tests with autofs 5 as I need to use direct =
mounts. The new version works really great. The only thing I figured out =
so far that does not work fine is, when I umount one of the automounted =
fs manually.</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">If I then try to list the =
contents of that directory it says, that it is empty. As soon as I try =
to create a file in that directory, it fails and seems to realize, that =
the directory should be mounted and remounts it, without creating the =
file though.</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; font: normal normal normal =
12px/normal Helvetica; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Now I have 2 questions:</DIV><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: =
normal normal normal 12px/normal Helvetica; min-height: 14px; =
"><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">1. Why is it not remounting the =
FS when trying an ls on it?</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font: normal =
normal normal 12px/normal Helvetica; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">2. Why is it not creating the file after remounting =
the FS instead of failing first and then doing the mount?</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; font: normal normal normal 12px/normal Helvetica; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">Timo</DIV><DIV><SPAN class=3D"Apple-style-span" =
style=3D"border-collapse: separate; border-spacing: 0px 0px; color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; text-align: auto; =
-khtml-text-decorations-in-effect: none; text-indent: 0px; =
-apple-text-size-adjust: auto; text-transform: none; orphans: 2; =
white-space: normal; widows: 2; word-spacing: 0px; "><P style=3D"margin: =
0.0px 0.0px 0.0px 0.0px"><BR class=3D"khtml-block-placeholder"></P><BR =
class=3D"Apple-interchange-newline"></SPAN> </DIV><BR></BODY></HTML>=

--Apple-Mail-14--937120087--


--===============8769823635489907005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8769823635489907005==--

