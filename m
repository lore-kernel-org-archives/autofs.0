From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Wed, 14 Jan 2009 14:43:42 +1100
Message-ID: <408431290901131943t2c678c8ej10c1829c71b5a557@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901111525y578a5ba4n634ee8b071718790@mail.gmail.com>
	<1231723189.3073.7.camel@zeus.themaw.net>
	<1231732946.3073.44.camel@zeus.themaw.net>
	<1231736307.3073.68.camel@zeus.themaw.net>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
	<1231813498.3057.12.camel@zeus.themaw.net>
	<1231820126.3057.14.camel@zeus.themaw.net>
	<408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
	<1231823945.3057.20.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7539477713205431475=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231823945.3057.20.camel@zeus.themaw.net>
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

--===============7539477713205431475==
Content-Type: multipart/alternative; boundary=0016e651fac26fc8eb046069257a

--0016e651fac26fc8eb046069257a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Jan 13, 2009 at 4:19 PM, Ian Kent <raven@themaw.net> wrote:

> More importantly, who's the scapegoat? :P
>
> That would be me, ;)


It seems that autofs v5 doesn't read an indirect map into the cache unless
ghosting is enabled, so I'm thinking about adding a map option to force the
read. Has the file map reloading logic changed significantly since autofs
v4?

> The hash function is good now, so the size of the hash table can be a
> > power of two.
>
> So your suggesting 1024 then, does it matter?


%1024 should become &1023 due to strength reduction, but it's not overly
important.

--0016e651fac26fc8eb046069257a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2009 at 4:19 PM, Ian Kent <span dir=3D"ltr">&lt;<a href=3D"=
mailto:raven@themaw.net">raven@themaw.net</a>&gt;</span> wrote:<br><br><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
&gt; More importantly, who&#39;s the scapegoat? :P<br>
<br>
That would be me, ;)</blockquote><div><br>It seems that autofs v5 doesn&#39=
;t read an indirect map into the cache unless ghosting is enabled, so I&#39=
;m thinking about adding a map option to force the read. Has the file map r=
eloading logic changed significantly since autofs v4?<br>
<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Th=
e hash function is good now, so the size of the hash table can be a<br>
&gt; power of two.<br>
<br>
So your suggesting 1024 then, does it matter?</blockquote></div><br>%1024 s=
hould become &amp;1023 due to strength reduction, but it&#39;s not overly i=
mportant.<br><br>

--0016e651fac26fc8eb046069257a--


--===============7539477713205431475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7539477713205431475==--

