From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Sun, 25 Jan 2009 01:07:00 +1100
Message-ID: <408431290901240607r3d6555c6u14ae7c1a6c51075e@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
	<408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
	<408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
	<1232701534.3011.35.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5847011821202113265=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232701534.3011.35.camel@zeus.themaw.net>
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

--===============5847011821202113265==
Content-Type: multipart/alternative; boundary=001636459002ef469904613b0416

--001636459002ef469904613b0416
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jan 23, 2009 at 8:05 PM, Ian Kent <raven@themaw.net> wrote:

> Does dmalloc provide similar functionality in the event of memory
> > exhaustion?
>
> No.
>
> Dmalloc is more like valgrind but is linked in as a library.
> I found Dmalloc much better in pointing to trouble spots than valgrind.
> Unfortunately, I have not been able to get it to work for some time now
> and I never got the 64 bit library to function.


What problem(s) were you having?

--001636459002ef469904613b0416
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Jan 23, 2009 at 8:05 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<div><div></div><div class=3D"Wj3C7c">&gt; Does dmalloc provide similar fun=
ctionality in the event of memory<br>
&gt; exhaustion?<br>
<br>
</div></div>No.<br>
<br>
Dmalloc is more like valgrind but is linked in as a library.<br>
I found Dmalloc much better in pointing to trouble spots than valgrind.<br>
Unfortunately, I have not been able to get it to work for some time now<br>
and I never got the 64 bit library to function.</blockquote><br>What proble=
m(s) were you having?<br></div>

--001636459002ef469904613b0416--


--===============5847011821202113265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5847011821202113265==--

