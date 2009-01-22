From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Thu, 22 Jan 2009 19:28:00 +1100
Message-ID: <408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
	<1232509747.3931.5.camel@zeus.themaw.net>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6766203643928929828=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232604004.3239.15.camel@zeus.themaw.net>
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

--===============6766203643928929828==
Content-Type: multipart/alternative; boundary=0016e652f714e5539e04610e0c4f

--0016e652f714e5539e04610e0c4f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jan 22, 2009 at 5:00 PM, Ian Kent <raven@themaw.net> wrote:

> Sorry, I just don't understand why that's the right thing to do. If a
> > daemon can't allocate memory in order to perform the operations that
> > it needs to perform, then how can it provide the functionality that
> > it's expected to provide? Why should it continue indefinitely instead
> > of aborting and being restarted automatically?
>
> Yeah, your entitled to your option but this has been discussed in the
> past and some people say just the opposite. I'm going to leave things
> the way they are for now.


I wanted to understand your position...

Oh, and I've just noticed that there's a `fatal' macro that calls abort(3).
It seems to be used widely, but solely for unexpected Pthreads errors?

--0016e652f714e5539e04610e0c4f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Jan 22, 2009 at 5:00 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<div><div></div><div class=3D"Wj3C7c">&gt; Sorry, I just don&#39;t understa=
nd why that&#39;s the right thing to do. If a<br>
&gt; daemon can&#39;t allocate memory in order to perform the operations th=
at<br>
&gt; it needs to perform, then how can it provide the functionality that<br=
>
&gt; it&#39;s expected to provide? Why should it continue indefinitely inst=
ead<br>
&gt; of aborting and being restarted automatically?<br>
<br>
</div></div>Yeah, your entitled to your option but this has been discussed =
in the<br>
past and some people say just the opposite. I&#39;m going to leave things<b=
r>
the way they are for now.</blockquote></div><br>I wanted to understand your=
 position...<br><br>Oh, and I&#39;ve just noticed that there&#39;s a `fatal=
&#39; macro that calls abort(3). It seems to be used widely, but solely for=
 unexpected Pthreads errors?

--0016e652f714e5539e04610e0c4f--


--===============6766203643928929828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6766203643928929828==--

