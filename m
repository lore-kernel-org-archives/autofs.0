From: marty <martyleisner@yahoo.com>
Subject: Re: automount core's on strdup(NULL)
Date: Sun, 12 Apr 2009 18:09:38 -0700 (PDT)
Message-ID: <996924.92996.qm@web50610.mail.re2.yahoo.com>
References: <49E15F7D.4060300@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2762149883192464403=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49E15F7D.4060300@themaw.net>
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
To: Marty Leisner <leisner@rochester.rr.com>, Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


--===============2762149883192464403==
Content-Type: multipart/alternative; boundary="0-260884250-1239584978=:92996"


--0-260884250-1239584978=:92996
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Before I dig into the code, this causes a definite problem with my patch an=
d the unpatched
git version:

At the end of the file, this works:
/net=A0=A0=A0 /etc/auto.net
#

/-=A0 /etc/auto.direct


This doesn't work
net=A0=A0 /etc/auto.net

/- /etc/auto.direct

Note the "success" depended on whether the "bad line" was at the end of the=
 file or not...

marty

--- On Sat, 4/11/09, Ian Kent <raven@themaw.net> wrote:
From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] automount core's on strdup(NULL)
To: "Marty Leisner" <leisner@rochester.rr.com>
Cc: autofs@linux.kernel.org, martyleisner@yahoo.com
Date: Saturday, April 11, 2009, 11:26 PM

Marty Leisner wrote:
> I just installed opensuse 11.1 -- couldn't get autofs to work...
>=20
> I scratched my head - its using 5.03 --so I got 5.04 -- also core (but=20
> I could build it -g).
>=20
> So I got the head of the git tree....same problem...
>=20
> (gdb) bt
>  #0  0xb7f37743 in strlen () from /lib/libc.so.6
>  #1  0xb7f37465 in strdup () from /lib/libc.so.6
>  #2  0xb80abaf5 in master_new_mapent (master=3D0xb80c4368, path=3D0x0,
>      age=3D1239478044) at master.c:666
>  #3  0xb80b18ab in master_parse_entry (buffer=3D0xb80e0aa0 "/net
/etc/auto.net",
>      default_timeout=3D600, logging=3D0, age=3D1239478044) at master_pars=
e.y:771

But buffer is a valid map entry in this case.

If path ends up as NULL after parsing a valid map entry then we would be
seeing a lot more problems.

So what exactly were the circumstances that lead to this?

>  #4  0xb7eab462 in lookup_read_master (master=3D0xb80c4368, age=3D1239478=
044,
>      context=3D0xb80c5430) at lookup_file.c:469
>  #5  0xb809b744 in do_read_master (master=3D0xb80c4368, type=3D0xb80c4458
"files",
>      age=3D1239478044) at lookup.c:96
>  #6  0xb809b8a9 in read_master_map (master=3D0xb80c4368, type=3D0xb80c445=
8
"files",
>      age=3D1239478044) at lookup.c:135
>  #7  0xb809bc80 in lookup_nss_read_master (master=3D0xb80c4368,
age=3D1239478044)
>      at lookup.c:223
>  #8  0xb80ac1cb in master_read_master (master=3D0xb80c4368, age=3D1239478=
044,
>      readall=3D0) at master.c:814
>  #9  0xb8091e2c in main (argc=3D0, argv=3D0xbfcbde40) at automount.c:2094
>=20
> I ended up doing this:
> : leisner@gateway 03:42:23;rcsdiff -u master.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: master.c,v
> retrieving revision 1.1
> diff -u -r1.1 master.c
> --- master.c    2009/04/11 19:35:35     1.1
> +++ master.c    2009/04/11 19:36:20
> @@ -657,6 +657,9 @@
>         int status;
>         char *tmp;
>=20
> +       if(!path)
> +               return NULL;
> +
>         entry =3D malloc(sizeof(struct master_mapent));
>         if (!entry)
>                 return NULL;
>=20
> I think I ended up with a parse error at the end (not sure that was valid
> when I started -- I had
> misc  /etc/auto.misc

If that was the case the master map parser should have caught this as it
requires a "/" to even get started otherwise it returns a parse
error.

We haven't got to the bottom of what caused the problem you saw and
putting in the check you have above is just going to hide the actual
problem so it can return to haunt us later.

Ian


Ian

=0A=0A=0A      
--0-260884250-1239584978=:92996
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Before I dig into the code, this causes a def=
inite problem with my patch and the unpatched<br>git version:<br><br>At the=
 end of the file, this works:<br>/net&nbsp;&nbsp;&nbsp; /etc/auto.net<br>#<=
br><br>/-&nbsp; /etc/auto.direct<br><br><br>This doesn't work<br>net&nbsp;&=
nbsp; /etc/auto.net<br><br>/- /etc/auto.direct<br><br>Note the "success" de=
pended on whether the "bad line" was at the end of the file or not...<br><b=
r>marty<br><br>--- On <b>Sat, 4/11/09, Ian Kent <i>&lt;raven@themaw.net&gt;=
</i></b> wrote:<br><blockquote style=3D"border-left: 2px solid rgb(16, 16, =
255); margin-left: 5px; padding-left: 5px;">From: Ian Kent &lt;raven@themaw=
.net&gt;<br>Subject: Re: [autofs] automount core's on strdup(NULL)<br>To: "=
Marty Leisner" &lt;leisner@rochester.rr.com&gt;<br>Cc: autofs@linux.kernel.=
org, martyleisner@yahoo.com<br>Date: Saturday, April 11, 2009, 11:26
 PM<br><br><pre>Marty Leisner wrote:<br>&gt; I just installed opensuse 11.1=
 -- couldn't get autofs to work...<br>&gt; <br>&gt; I scratched my head - i=
ts using 5.03 --so I got 5.04 -- also core (but <br>&gt; I could build it -=
g).<br>&gt; <br>&gt; So I got the head of the git tree....same problem...<b=
r>&gt; <br>&gt; (gdb) bt<br>&gt;  #0  0xb7f37743 in strlen () from /lib/lib=
c.so.6<br>&gt;  #1  0xb7f37465 in strdup () from /lib/libc.so.6<br>&gt;  #2=
  0xb80abaf5 in master_new_mapent (master=3D0xb80c4368, path=3D0x0,<br>&gt;=
      age=3D1239478044) at master.c:666<br>&gt;  #3  0xb80b18ab in master_p=
arse_entry (buffer=3D0xb80e0aa0 "/net<br>/etc/auto.net",<br>&gt;      defau=
lt_timeout=3D600, logging=3D0, age=3D1239478044) at master_parse.y:771<br><=
br>But buffer is a valid map entry in this case.<br><br>If path ends up as =
NULL after parsing a valid map entry then we would be<br>seeing a lot more =
problems.<br><br>So what exactly were the circumstances that lead to
 this?<br><br>&gt;  #4  0xb7eab462 in lookup_read_master (master=3D0xb80c43=
68, age=3D1239478044,<br>&gt;      context=3D0xb80c5430) at lookup_file.c:4=
69<br>&gt;  #5  0xb809b744 in do_read_master (master=3D0xb80c4368, type=3D0=
xb80c4458<br>"files",<br>&gt;      age=3D1239478044) at lookup.c:96<br>&gt;=
  #6  0xb809b8a9 in read_master_map (master=3D0xb80c4368, type=3D0xb80c4458=
<br>"files",<br>&gt;      age=3D1239478044) at lookup.c:135<br>&gt;  #7  0x=
b809bc80 in lookup_nss_read_master (master=3D0xb80c4368,<br>age=3D123947804=
4)<br>&gt;      at lookup.c:223<br>&gt;  #8  0xb80ac1cb in master_read_mast=
er (master=3D0xb80c4368, age=3D1239478044,<br>&gt;      readall=3D0) at mas=
ter.c:814<br>&gt;  #9  0xb8091e2c in main (argc=3D0, argv=3D0xbfcbde40) at =
automount.c:2094<br>&gt; <br>&gt; I ended up doing this:<br>&gt; : leisner@=
gateway 03:42:23;rcsdiff -u master.c<br>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>&gt; RCS file: master.c,v<br>&gt; retrieving revis=
ion
 1.1<br>&gt; diff -u -r1.1 master.c<br>&gt; --- master.c    2009/04/11 19:3=
5:35     1.1<br>&gt; +++ master.c    2009/04/11 19:36:20<br>&gt; @@ -657,6 =
+657,9 @@<br>&gt;         int status;<br>&gt;         char *tmp;<br>&gt; <b=
r>&gt; +       if(!path)<br>&gt; +               return NULL;<br>&gt; +<br>=
&gt;         entry =3D malloc(sizeof(struct master_mapent));<br>&gt;       =
  if (!entry)<br>&gt;                 return NULL;<br>&gt; <br>&gt; I think=
 I ended up with a parse error at the end (not sure that was valid<br>&gt; =
when I started -- I had<br>&gt; misc  /etc/auto.misc<br><br>If that was the=
 case the master map parser should have caught this as it<br>requires a "/"=
 to even get started otherwise it returns a parse<br>error.<br><br>We haven=
't got to the bottom of what caused the problem you saw and<br>putting in t=
he check you have above is just going to hide the actual<br>problem so it c=
an return to haunt us
 later.<br><br>Ian<br><br><br>Ian<br><br></pre></blockquote></td></tr></tab=
le><br>=0A=0A=0A=0A      
--0-260884250-1239584978=:92996--


--===============2762149883192464403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2762149883192464403==--

