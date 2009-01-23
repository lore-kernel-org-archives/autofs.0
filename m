From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Fri, 23 Jan 2009 16:27:27 +1100
Message-ID: <408431290901222127n3d8a759eka7151cb60f6a8e13@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
	<408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
	<408431290901212055v28a781caka0126cfb8db16e7c@mail.gmail.com>
	<1232604292.3239.17.camel@zeus.themaw.net>
	<408431290901221800y3c008d5dib66b2786e832c086@mail.gmail.com>
	<1232683724.3011.6.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1623615129640965326=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232683724.3011.6.camel@zeus.themaw.net>
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

--===============1623615129640965326==
Content-Type: multipart/alternative; boundary=0016e652fe7e0e4e1504611fa55f

--0016e652fe7e0e4e1504611fa55f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jan 23, 2009 at 3:08 PM, Ian Kent <raven@themaw.net> wrote:

at this point either list == ent or ent is linked into list.

...

> So in all these cases it looks to me like free_mnt_list() handles the
> dealloc.


Oh, I see. Thanks.

> Also, strdup(3) is useful. :P
>
> Sure, but not this time around, ;)


Hmm?

--0016e652fe7e0e4e1504611fa55f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Jan 23, 2009 at 3:08 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
at this point either list =3D=3D ent or ent is linked into list.</blockquot=
e><div>...<br></div><blockquote class=3D"gmail_quote" style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;">So in all these cases it looks to me like free_mnt_list() handles the<br=
>

dealloc.</blockquote><div><br>Oh, I see. Thanks.<br><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); ma=
rgin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"Ih2E3d">&gt; Als=
o, strdup(3) is useful. :P<br>

<br>
</div>Sure, but not this time around, ;)</blockquote></div><br>Hmm?

--0016e652fe7e0e4e1504611fa55f--


--===============1623615129640965326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1623615129640965326==--

