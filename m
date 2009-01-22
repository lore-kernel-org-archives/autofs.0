From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Thu, 22 Jan 2009 12:21:49 +1100
Message-ID: <408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
	<1232509747.3931.5.camel@zeus.themaw.net>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7165078500854788688=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232515783.3931.28.camel@zeus.themaw.net>
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

--===============7165078500854788688==
Content-Type: multipart/alternative; boundary=0016e652f56ab7f2c6046108188c

--0016e652f56ab7f2c6046108188c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jan 21, 2009 at 4:29 PM, Ian Kent <raven@themaw.net> wrote:

> In this case, make_fullpath() is called from only one place and its
> > return value is checked, but I was asking in general, yes.
>
> Not sure I understand the question.
>
> Functions like make_fullpath() need to return a NULL in such a case
> because it has to be up to the caller to decide on how to handle the
> fail.
>
> In the case above it is questionable whether we continue the prune but
> then another thread could free() heap memory so we might still be able
> to make some useful progress.


A daemon shouldn't run out of memory. Generally speaking, it's an
exceptional condition that justifies abnormal termination.

--0016e652f56ab7f2c6046108188c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Jan 21, 2009 at 4:29 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<div><div></div><div class=3D"Wj3C7c">&gt; In this case, make_fullpath() is=
 called from only one place and its<br>
&gt; return value is checked, but I was asking in general, yes.<br>
<br>
</div></div>Not sure I understand the question.<br>
<br>
Functions like make_fullpath() need to return a NULL in such a case<br>
because it has to be up to the caller to decide on how to handle the<br>
fail.<br>
<br>
In the case above it is questionable whether we continue the prune but<br>
then another thread could free() heap memory so we might still be able<br>
to make some useful progress.</blockquote></div><br>A daemon shouldn&#39;t =
run out of memory. Generally speaking, it&#39;s an exceptional condition th=
at justifies abnormal termination.

--0016e652f56ab7f2c6046108188c--


--===============7165078500854788688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7165078500854788688==--

