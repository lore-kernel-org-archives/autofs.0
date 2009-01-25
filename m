From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Sun, 25 Jan 2009 22:40:50 +1100
Message-ID: <408431290901250340l68b48f8btba212c7451d711d4@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
	<408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
	<408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
	<1232701534.3011.35.camel@zeus.themaw.net>
	<408431290901240607r3d6555c6u14ae7c1a6c51075e@mail.gmail.com>
	<1232853798.3019.5.camel@zeus.themaw.net>
	<408431290901242306t1ad6fbacg69d8b785158a1666@mail.gmail.com>
	<1232872567.3019.20.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6437406446018080627=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232872567.3019.20.camel@zeus.themaw.net>
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

--===============6437406446018080627==
Content-Type: multipart/alternative; boundary=0016e652f7140f65bb04614d18cd

--0016e652f7140f65bb04614d18cd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Jan 25, 2009 at 7:36 PM, Ian Kent <raven@themaw.net> wrote:

> What problem(s) were you having with dmalloc?
>
> Can't remember now but I think, compilation problems, link problems and
> then not being able to find the shared libraries mostly. Mostly it I
> just ended up spending too much time on it. I probably should spend some
> time on it again.


Aren't there any Red Hat packages for dmalloc? I just installed the Ubuntu
packages and then rebuilt autofs without any trouble.

BTW, perhaps you could check dmalloc's log file as part of the automated
testing?

--0016e652f7140f65bb04614d18cd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sun, Jan 25, 2009 at 7:36 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<div><div></div><div class=3D"Wj3C7c">&gt; What problem(s) were you having =
with dmalloc?<br>
<br>
</div></div>Can&#39;t remember now but I think, compilation problems, link =
problems and<br>
then not being able to find the shared libraries mostly. Mostly it I<br>
just ended up spending too much time on it. I probably should spend some<br=
>
time on it again.</blockquote><br>Aren&#39;t there any Red Hat packages for=
 dmalloc? I just installed the Ubuntu packages and then rebuilt autofs with=
out any trouble.<br><br>BTW, perhaps you could check dmalloc&#39;s log file=
 as part of the automated testing?<br>
</div>

--0016e652f7140f65bb04614d18cd--


--===============6437406446018080627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6437406446018080627==--

