From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Mon, 12 Jan 2009 10:25:52 +1100
Message-ID: <408431290901111525y578a5ba4n634ee8b071718790@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<x49mye0ffvg.fsf@segfault.boston.devel.redhat.com>
	<20090109195151.GH32333@shell>
	<408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
	<1231692176.10063.10.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1728771113808536452=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231692176.10063.10.camel@zeus.themaw.net>
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

--===============1728771113808536452==
Content-Type: multipart/alternative; boundary=0016e64ed5eaa5c8c104603d4fde

--0016e64ed5eaa5c8c104603d4fde
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jan 12, 2009 at 3:42 AM, Ian Kent <raven@themaw.net> wrote:

> It's just that the additive hash function and the tiny, non-prime hash
> > table size offended my delicate sensibilities. ;)
>
> Oh .. right, looks like v4 uses a prime to me but I did mean to use a
> prime in v5, oops!


$ factor 27 77
27: 3 3 3
77: 7 11
$

> Actually, we discovered that reloading a large file map took well over
> > ten seconds. Profiling revealed that the daemon spent most of its time
> > calling strcmp(3).
> >
> > Oh, and I should note that the problem was observed in autofs v4. I'll
> > be looking more closely at autofs v5 in the near future.
>
> It's much the same, the hash size is not much bigger and it can well do
> with a healthy increase. I don't know what sort of distribution the
> simple additive hash gives and if we are going to change it then we
> should do some checking with representative strings to ensure that what
> we use is in fact better.


How could it be worse? :P

I'll check our large file map just to satisfy my curiosity.

--0016e64ed5eaa5c8c104603d4fde
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2009 at 3:42 AM, Ian Kent <span dir=3D"ltr">&lt;<a href=3D"=
mailto:raven@themaw.net">raven@themaw.net</a>&gt;</span> wrote:<br><br><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
&gt; It&#39;s just that the additive hash function and the tiny, non-prime =
hash<br>
&gt; table size offended my delicate sensibilities. ;)<br>
<br>
Oh .. right, looks like v4 uses a prime to me but I did mean to use a<br>
prime in v5, oops!</blockquote><div><br>$ factor 27 77<br>27: 3 3 3<br>77: =
7 11<br>$ <br><br></div><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">
&gt; Actually, we discovered that reloading a large file map took well over=
<br>
&gt; ten seconds. Profiling revealed that the daemon spent most of its time=
<br>
&gt; calling strcmp(3).<br>
&gt;<br>
&gt; Oh, and I should note that the problem was observed in autofs v4. I&#3=
9;ll<br>
&gt; be looking more closely at autofs v5 in the near future.<br>
<br>
It&#39;s much the same, the hash size is not much bigger and it can well do=
<br>
with a healthy increase. I don&#39;t know what sort of distribution the<br>
simple additive hash gives and if we are going to change it then we<br>
should do some checking with representative strings to ensure that what<br>
we use is in fact better.</blockquote></div><br>How could it be worse? :P<b=
r><br>I&#39;ll check our large file map just to satisfy my curiosity.<br><b=
r>

--0016e64ed5eaa5c8c104603d4fde--


--===============1728771113808536452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1728771113808536452==--

