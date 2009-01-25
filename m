From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Sun, 25 Jan 2009 18:06:27 +1100
Message-ID: <408431290901242306t1ad6fbacg69d8b785158a1666@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
	<408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
	<408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
	<1232701534.3011.35.camel@zeus.themaw.net>
	<408431290901240607r3d6555c6u14ae7c1a6c51075e@mail.gmail.com>
	<1232853798.3019.5.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8413170728240394621=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232853798.3019.5.camel@zeus.themaw.net>
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

--===============8413170728240394621==
Content-Type: multipart/alternative; boundary=0016e651fa9ac300fa046149429c

--0016e651fa9ac300fa046149429c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Jan 25, 2009 at 2:23 PM, Ian Kent <raven@themaw.net> wrote:

> What problem(s) were you having?
>
> This was added during the development of version 5 when I did memory
> management (leak) checking. The idea was that as time passed and changes
> were made I could simply enable DMALLOC and run checks from time to time
> but it didn't work out. The code analysis seems quite good at detecting
> those mistakes that seem to be inevitable or mistakes in code that
> hasn't been looked since taking over maintenance of a product.


What problem(s) were you having with dmalloc?

--0016e651fa9ac300fa046149429c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sun, Jan 25, 2009 at 2:23 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<div><div></div><div class=3D"Wj3C7c">&gt; What problem(s) were you having?=
<br>
<br>
</div></div>This was added during the development of version 5 when I did m=
emory<br>
management (leak) checking. The idea was that as time passed and changes<br=
>
were made I could simply enable DMALLOC and run checks from time to time<br=
>
but it didn&#39;t work out. The code analysis seems quite good at detecting=
<br>
those mistakes that seem to be inevitable or mistakes in code that<br>
hasn&#39;t been looked since taking over maintenance of a product.</blockqu=
ote><br>What problem(s) were you having with dmalloc?<br></div>

--0016e651fa9ac300fa046149429c--


--===============8413170728240394621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8413170728240394621==--

