From: Nathan Salwen <salwen.1@gmail.com>
Subject: Autofs check ping before mounting?
Date: Tue, 9 Feb 2010 06:01:26 -0500
Message-ID: <23a3b61002090301q5f7c01a2jb837463d83b71712@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3885765718746637929=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:date:message-id:subject
	:from:to:content-type;
	bh=FtwrfWMTb0t+uVFx56msTBslQgWsl9TIE6/XwOWje+0=;
	b=c5jZbvLcLvr67GSJYdlyTHqNC2YTRmSZXz6Fcz/vJiy1JMFnXHOFoln4Uvq+3wQHAG
	8TWOU+dA4ndZGrMQ7b7erBQExzaWwnS+zBszQgFKnPDR3MUVizl46Jgx+pS975Yoy1Xi
	AbixzTzZQQHgVl7lM+Js0SwZgDy0pJbIDOIjY=
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

--===============3885765718746637929==
Content-Type: multipart/alternative; boundary=0016e65c8844d5621c047f28d65a

--0016e65c8844d5621c047f28d65a
Content-Type: text/plain; charset=ISO-8859-1

Is there any way to make autofs check ping before trying to mount a volume.
The 60 second timeout freezes openoffice (for example).

Alternatively, is there a way to make NFS timeout more quickly than 60
seconds when it is trying to mount a volume.

Thanks,
Nathan

--0016e65c8844d5621c047f28d65a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Is there any way to make autofs check ping before trying to mount a volume.=
=A0 The 60 second timeout freezes openoffice (for example).<br><br>Alternat=
ively, is there a way to make NFS timeout more quickly than 60 seconds when=
 it is trying to mount a volume.<br>
<br>Thanks,<br>Nathan<br>

--0016e65c8844d5621c047f28d65a--


--===============3885765718746637929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3885765718746637929==--

