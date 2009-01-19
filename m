From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Mon, 19 Jan 2009 12:28:00 +1100
Message-ID: <408431290901181728u5b01c262u1b2640595deaac95@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1232066406.3166.28.camel@zeus.themaw.net>
	<1232070195.3166.36.camel@zeus.themaw.net>
	<408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
	<1232079714.3166.56.camel@zeus.themaw.net>
	<408431290901152204i8d2da71vbf8ee5f2e2f84fa@mail.gmail.com>
	<1232087057.3166.88.camel@zeus.themaw.net>
	<1232087952.3166.98.camel@zeus.themaw.net>
	<408431290901170911q1af268b1o5576f46e0bee2129@mail.gmail.com>
	<1232249174.3106.5.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2472559184413480714=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232249174.3106.5.camel@zeus.themaw.net>
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

--===============2472559184413480714==
Content-Type: multipart/alternative; boundary=001485f4225e5953b40460cbd526

--001485f4225e5953b40460cbd526
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Jan 18, 2009 at 2:26 PM, Ian Kent <raven@themaw.net> wrote:

> Is there a design document for autofs v5 that you're permitted to
> > share?
>
> There isn't, but even of there were it wouldn't have a level of detail
> that would be useful in cases like this and if it did it would have
> become hopelessly out of date as time has passed.
>
> However, the attached pdf, written by Jeff and myself, has a high level
> overview of v5 and what it seeks to achieve.


Cool, thanks.

It's just that your earlier comment regarding a concurrency issue led me to
wonder about the use of Pthreads. In particular, I'm not sure what the
rationale was, but I'd also like to understand the control flow, so that's
why I was interested in a design document of some sort.

--001485f4225e5953b40460cbd526
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sun, Jan 18, 2009 at 2:26 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<div><div></div><div class=3D"Wj3C7c">&gt; Is there a design document for a=
utofs v5 that you&#39;re permitted to<br>
&gt; share?<br>
<br>
</div></div>There isn&#39;t, but even of there were it wouldn&#39;t have a =
level of detail<br>
that would be useful in cases like this and if it did it would have<br>
become hopelessly out of date as time has passed.<br>
<br>
However, the attached pdf, written by Jeff and myself, has a high level<br>
overview of v5 and what it seeks to achieve.</blockquote></div><br>Cool, th=
anks.<br><br>It&#39;s just that your earlier comment regarding a concurrenc=
y issue led me to wonder about the use of Pthreads. In particular, I&#39;m =
not sure what the rationale was, but I&#39;d also like to understand the co=
ntrol flow, so that&#39;s why I was interested in a design document of some=
 sort.<br>
<br>

--001485f4225e5953b40460cbd526--


--===============2472559184413480714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2472559184413480714==--

