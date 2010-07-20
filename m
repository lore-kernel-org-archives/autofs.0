From: marina cacciagrano <mcacciagrano@gmail.com>
Subject: help: rm_unwanted and disappearing symbolink links from
	nfs servers
Date: Tue, 20 Jul 2010 17:24:34 +0100
Message-ID: <AANLkTilfvoSFLvRZCm4kf4NYi6YdrkYhluz4_8WPCAij@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9025749291255317370=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:received:date:message-id
	:subject:from:to:content-type;
	bh=DPBHpWyrF0f5rPSEWic7XHTVJhySxZUgQQ2A5bwi/A8=;
	b=TN7ynJQWVNYXKGZmyw1xbVNw78tGexzmkByw4fFiCC4FtKiuWPzGCuxKwYraDNEMf8
	yDt+EZwDmQHjy6rQhW7qy1uCujdVVDZAFf6iBdHYYupDpMB6vpHGFy+ZiatHiPO6/Uve
	fLZNUOghJ6zNgks0H0efb/IYv+IMB3D8d+o/0=
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

--===============9025749291255317370==
Content-Type: multipart/alternative; boundary=0015174989f6de5a30048bd41e9d

--0015174989f6de5a30048bd41e9d
Content-Type: text/plain; charset=ISO-8859-1

Hello,
I am experiencing some annoying (if not scary) issue with automount
(autofs-4.1.3-187).
I am runnung Linux kernel 2.6.9-34 (RedHat RHEL4 update3).

Files (mainly symbolic links) disappear from nfs mounted volumes.
This happens randomly.
I support several machines running the above mentioned kernel version and
autofs version.
The kernel on these cannot be updated, as any change in the kernel name will
prevent the main application from running.
I noticed that the file disappearance time concide with messages on some of
the nfs client machines similar to the following:

Jul 19 00:20:05 flame-b automount[14400]: rm_unwanted: attempting to remove
files from a mounted directory

'googling' for the error message, I found a cuple of interesting messages.
Two from IBM:

http://www-01.ibm.com/support/docview.wss?rs=984&uid=swg21260655
http://www-01.ibm.com/support/docview.wss?ratlid=cctocbody&rs=984&uid=swg21279055

which describe the problem so closely to what I am experiencing, that I
thought I would send them in this mail, even if they seem to describe an
issue specific to an IBM system.

A better match to my problem was found in some autofs forum answers. In
example the following:

http://www.mail-archive.com/autofs@linux.kernel.org/msg05120.html

There are other with very similar messages, they all suggest a patch which
forces autofs to do a check of some sort.
I do not know how to implement the mentioned patch. I would like to know
whether there is a version of autofs which implements the patch and that can
be installed on the 2.6.9-34 kernel. I really need to know, as I have seen
instances of whole directories desappearing as well as symbolic links.

In the forum I have seen the recurring names of Jeff Moyer, Ian Kent and
Chris Feist. Is there any chance I can get in touch with any of them, and
get some help?

Best regards,
marina cacciagrano

--0015174989f6de5a30048bd41e9d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br>
I am experiencing some annoying (if not scary) issue with automount (autofs=
-4.1.3-187).<br>
I am runnung Linux kernel 2.6.9-34 (RedHat RHEL4 update3).<br>
<br>
Files (mainly symbolic links) disappear from nfs mounted volumes.<br>
This happens randomly.<br>
I support several machines running the above mentioned kernel version and a=
utofs version.<br>
The kernel on these cannot be updated, as any change in the kernel name wil=
l prevent the main application from running.<br>
I noticed that the file disappearance time concide with messages on some of=
 the nfs client machines similar to the following:<br>
<br><span style=3D"font-family: courier new,monospace;">Jul 19 00:20:05 fla=
me-b automount[14400]: rm_unwanted: attempting to remove files from a mount=
ed directory</span><br style=3D"font-family: courier new,monospace;"><br>&#=
39;googling&#39; for the error message, I found a cuple of interesting mess=
ages. Two from IBM:<br>


<br><a href=3D"http://www-01.ibm.com/support/docview.wss?rs=3D984&amp;uid=
=3Dswg21260655" target=3D"_blank">http://www-01.ibm.com/support/docview.wss=
?rs=3D984&amp;uid=3Dswg21260655</a><br><a href=3D"http://www-01.ibm.com/sup=
port/docview.wss?ratlid=3Dcctocbody&amp;rs=3D984&amp;uid=3Dswg21279055" tar=
get=3D"_blank">http://www-01.ibm.com/support/docview.wss?ratlid=3Dcctocbody=
&amp;rs=3D984&amp;uid=3Dswg21279055</a><br>


<br>which describe the problem so closely to what I am experiencing,
that I thought I would send them in this mail, even if they seem to
describe an issue specific to an IBM system.<br><br>A better match to my pr=
oblem was found in some autofs forum answers. In example the following:<br>
<br><a href=3D"http://www.mail-archive.com/autofs@linux.kernel.org/msg05120=
.html" target=3D"_blank">http://www.mail-archive.com/autofs@linux.kernel.or=
g/msg05120.html</a><br><br>There are other with very similar messages, they=
 all suggest a patch which forces autofs to do a check of some sort.<br>


I do not know how to implement the mentioned patch. I would like to
know whether there is a version of autofs which implements the patch
and that can be installed on the 2.6.9-34 kernel. I really need to
know, as I have seen instances of whole directories desappearing as
well as symbolic links.<br>
<br>In the forum I have seen the recurring names of Jeff Moyer, Ian
Kent and Chris Feist. Is there any chance I can get in touch with any
of them, and get some help?<br><br>Best regards,<br>marina cacciagrano<br>

--0015174989f6de5a30048bd41e9d--


--===============9025749291255317370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============9025749291255317370==--

