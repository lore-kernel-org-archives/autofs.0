From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Mon, 26 Jan 2009 15:06:14 +1100
Message-ID: <408431290901252006u190ef6aega8d3276172b98b92@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
	<408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
	<1232701534.3011.35.camel@zeus.themaw.net>
	<408431290901240607r3d6555c6u14ae7c1a6c51075e@mail.gmail.com>
	<1232853798.3019.5.camel@zeus.themaw.net>
	<408431290901242306t1ad6fbacg69d8b785158a1666@mail.gmail.com>
	<1232872567.3019.20.camel@zeus.themaw.net>
	<408431290901250340l68b48f8btba212c7451d711d4@mail.gmail.com>
	<1232934896.3009.3.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3500084875771858066=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232934896.3009.3.camel@zeus.themaw.net>
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

--===============3500084875771858066==
Content-Type: multipart/alternative; boundary=0016e652fe7e1d7dc204615adc03

--0016e652fe7e1d7dc204615adc03
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jan 26, 2009 at 12:54 PM, Ian Kent <raven@themaw.net> wrote:

> Aren't there any Red Hat packages for dmalloc? I just installed the
> > Ubuntu packages and then rebuilt autofs without any trouble.
>
> Nope.
> I have a spec file I can use but the tarball from the download site
> still doesn't compile. I'll get back to that some time but not just now.


I suspect that Red Hat packages could be useful for a lot of users. If you
don't have time to maintain them, then perhaps one of your colleagues does?

What version was installed?


Dapper and Feisty have version 5.4.2.
Gutsy, Hardy, Intrepid and Jaunty have version 5.5.1.

> BTW, perhaps you could check dmalloc's log file as part of the
> > automated testing?
>
> If I could easily build an rpm each time I updated Fedora then I would
> script something and run it regularly. Maybe looking at the patches
> applied by the deb would be useful.


FWIW, SourceForge seems to offer i386 and src .rpm downloads for version
5.4.2.

--0016e652fe7e1d7dc204615adc03
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Jan 26, 2009 at 12:54 PM, Ian Kent <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&g=
t;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">
<div class=3D"Ih2E3d">&gt; Aren&#39;t there any Red Hat packages for dmallo=
c? I just installed the<br>
&gt; Ubuntu packages and then rebuilt autofs without any trouble.<br>
<br>
</div>Nope.<br>
I have a spec file I can use but the tarball from the download site<br>
still doesn&#39;t compile. I&#39;ll get back to that some time but not just=
 now.</blockquote><div><br>I suspect that Red Hat packages could be useful =
for a lot of users. If you don&#39;t have time to maintain them, then perha=
ps one of your colleagues does?<br>
<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">What ve=
rsion was installed?</blockquote><div><br>Dapper and Feisty have version 5.=
4.2.<br>
Gutsy, Hardy, Intrepid and Jaunty have version 5.5.1.<br><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; BTW, perhaps you cou=
ld check dmalloc&#39;s log file as part of the<br>
<div class=3D"Ih2E3d">
&gt; automated testing?<br>
<br>
</div>If I could easily build an rpm each time I updated Fedora then I woul=
d<br>
script something and run it regularly. Maybe looking at the patches<br>
applied by the deb would be useful.</blockquote><br>FWIW, SourceForge seems=
 to offer i386 and src .rpm downloads for version 5.4.2.<br></div>

--0016e652fe7e1d7dc204615adc03--


--===============3500084875771858066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3500084875771858066==--

