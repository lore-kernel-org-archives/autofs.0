From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Fri, 16 Jan 2009 17:04:41 +1100
Message-ID: <408431290901152204i8d2da71vbf8ee5f2e2f84fa@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1232032573.3100.53.camel@zeus.themaw.net>
	<408431290901151233q33699529r6119788c998866ed@mail.gmail.com>
	<x49d4eouwt6.fsf@segfault.boston.devel.redhat.com>
	<408431290901151257i70400351yc3ab9360136c8e9c@mail.gmail.com>
	<1232065653.3166.19.camel@zeus.themaw.net>
	<1232066406.3166.28.camel@zeus.themaw.net>
	<1232070195.3166.36.camel@zeus.themaw.net>
	<408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
	<1232079714.3166.56.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3794520295534817756=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232079714.3166.56.camel@zeus.themaw.net>
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

--===============3794520295534817756==
Content-Type: multipart/alternative; boundary=001485f01e5250b70c04609359a9

--001485f01e5250b70c04609359a9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jan 16, 2009 at 3:21 PM, Ian Kent <raven@themaw.net> wrote:

>         +               if (me && ctxt->mtime <= me->age)
> >
> > You have to call stat(2) or fstat(2) at some point or else ctxt->mtime
> > will never change.
>
> We set the mtime when we read the entire map, see
> modules/lookup_file.c:lookup_read_map(). This is totally taking
> advantage of the existing code to read a map that is marked as stale. It
> doesn't however attempt to simplify the code which works out if we need
> to mark the map stale but we probably don't want to anyway as we need to
> ensure we use up to date entries for lookups done while waiting for the
> map update to be done.


Sorry, I don't understand how that condition will evaluate to false. You
won't read the map until ctxt->mtime changes, but it won't change until you
read the map.

--001485f01e5250b70c04609359a9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Jan 16, 2009 at 3:21 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<div><div class=3D"Wj3C7c">&gt; &nbsp; &nbsp; &nbsp; &nbsp; + &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (me &amp;&amp; ctxt-&gt;mtime &lt;=
=3D me-&gt;age)<br>
&gt;<br>
&gt; You have to call stat(2) or fstat(2) at some point or else ctxt-&gt;mt=
ime<br>
&gt; will never change.<br>
<br>
</div></div>We set the mtime when we read the entire map, see<br>
modules/lookup_file.c:lookup_read_map(). This is totally taking<br>
advantage of the existing code to read a map that is marked as stale. It<br=
>
doesn&#39;t however attempt to simplify the code which works out if we need=
<br>
to mark the map stale but we probably don&#39;t want to anyway as we need t=
o<br>
ensure we use up to date entries for lookups done while waiting for the<br>
map update to be done.</blockquote></div><br>Sorry, I don&#39;t understand =
how that condition will evaluate to false. You won&#39;t read the map until=
 ctxt-&gt;mtime changes, but it won&#39;t change until you read the map.<br=
>

--001485f01e5250b70c04609359a9--


--===============3794520295534817756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3794520295534817756==--

