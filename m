From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Fri, 23 Jan 2009 17:42:40 +1100
Message-ID: <408431290901222242y5a254e84i91db363d934b2382@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232509747.3931.5.camel@zeus.themaw.net>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<1232604004.3239.15.camel@zeus.themaw.net>
	<408431290901220028h3fd5cbd1y317b1142ac6b043a@mail.gmail.com>
	<1232617153.3239.36.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4581693537447111501=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232617153.3239.36.camel@zeus.themaw.net>
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

--===============4581693537447111501==
Content-Type: multipart/alternative; boundary=001485f3e8be0190f6046120b2a1

--001485f3e8be0190f6046120b2a1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jan 22, 2009 at 8:39 PM, Ian Kent <raven@themaw.net> wrote:

> I wanted to understand your position...
> >
> > Oh, and I've just noticed that there's a `fatal' macro that calls
> > abort(3). It seems to be used widely, but solely for unexpected
> > Pthreads errors?
>
> So, now it looks like I'm contradicting myself, well called, ;)
>
> The fatal() function was added much later than the times we got
> complains about autofs exiting upon errors, which lead to the common
> approach of continue if at all possible. The call is used almost
> exclusively for checking pthreads call returns that should "never" fail.
> The idea is that, rather than not bother checking them, abort so we can
> see where the fail occurred and get a backtrace from the core.


Does dmalloc provide similar functionality in the event of memory
exhaustion?

--001485f3e8be0190f6046120b2a1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Jan 22, 2009 at 8:39 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
&gt; I wanted to understand your position...<br>
&gt;<br>
&gt; Oh, and I&#39;ve just noticed that there&#39;s a `fatal&#39; macro tha=
t calls<br>
&gt; abort(3). It seems to be used widely, but solely for unexpected<br>
&gt; Pthreads errors?<br>
<br>
So, now it looks like I&#39;m contradicting myself, well called, ;)<br>
<br>
The fatal() function was added much later than the times we got<br>
complains about autofs exiting upon errors, which lead to the common<br>
approach of continue if at all possible. The call is used almost<br>
exclusively for checking pthreads call returns that should &quot;never&quot=
; fail.<br>
The idea is that, rather than not bother checking them, abort so we can<br>
see where the fail occurred and get a backtrace from the core.</blockquote>=
</div><br>Does dmalloc provide similar functionality in the event of memory=
 exhaustion?<br>

--001485f3e8be0190f6046120b2a1--


--===============4581693537447111501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4581693537447111501==--

