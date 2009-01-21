From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Wed, 21 Jan 2009 16:15:10 +1100
Message-ID: <408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
	<1232509747.3931.5.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1174159292954980160=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232509747.3931.5.camel@zeus.themaw.net>
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

--===============1174159292954980160==
Content-Type: multipart/alternative; boundary=0016e652060264e8fd0460f73dec

--0016e652060264e8fd0460f73dec
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jan 21, 2009 at 2:49 PM, Ian Kent <raven@themaw.net> wrote:

Fortunately, these cases usually don't happen so we haven't seen a
> problem with it already.
>
> Anyway, i think this is all we need although continuing after an malloc
> fail is a bit questionable. Suggestions?


In this case, make_fullpath() is called from only one place and its return
value is checked, but I was asking in general, yes.

--0016e652060264e8fd0460f73dec
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Jan 21, 2009 at 2:49 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
Fortunately, these cases usually don&#39;t happen so we haven&#39;t seen a<=
br>
problem with it already.<br>
<br>
Anyway, i think this is all we need although continuing after an malloc<br>
fail is a bit questionable. Suggestions?</blockquote><div><br>In this case,=
 make_fullpath() is called from only one place and its return value is chec=
ked, but I was asking in general, yes.</div></div>

--0016e652060264e8fd0460f73dec--


--===============1174159292954980160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1174159292954980160==--

