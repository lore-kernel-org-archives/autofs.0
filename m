From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Tue, 13 Jan 2009 16:07:27 +1100
Message-ID: <408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
	<1231692176.10063.10.camel@zeus.themaw.net>
	<408431290901111525y578a5ba4n634ee8b071718790@mail.gmail.com>
	<1231723189.3073.7.camel@zeus.themaw.net>
	<1231732946.3073.44.camel@zeus.themaw.net>
	<1231736307.3073.68.camel@zeus.themaw.net>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
	<1231813498.3057.12.camel@zeus.themaw.net>
	<1231820126.3057.14.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0106737511823470336=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231820126.3057.14.camel@zeus.themaw.net>
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

--===============0106737511823470336==
Content-Type: multipart/alternative; boundary=0016e652f4e812721404605633ac

--0016e652f4e812721404605633ac
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Jan 13, 2009 at 1:24 PM, Ian Kent <raven@themaw.net> wrote:

> Why do you think that you've miscalculated the minimum?
>
> Well, maybe I haven't but I thought min should be > 0.
> But, it's not worth worrying about as I think we've managed to show a
> clear improvement.


The minimum was zero because there were empty buckets.

> I plotted the number of elements in each bucket.
> >
> > As you now see, the additive hash function doesn't scale.
>
> Sure and now we can say why it doesn't scale in the patch description.


More importantly, who's the scapegoat? :P

> Perhaps you could make it configurable?
>
> Perhaps, but I don't think this is the sort of thing that should be
> configurable so I'd prefer to make it a compile time option rather than
> a run time configuration setting.


On Tue, Jan 13, 2009 at 3:15 PM, Ian Kent <raven@themaw.net> wrote:

I've changed my mind, ;), configurable it is with a default of 977.


The hash function is good now, so the size of the hash table can be a power
of two.

--0016e652f4e812721404605633ac
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2009 at 1:24 PM, Ian Kent <span dir=3D"ltr">&lt;<a href=3D"=
mailto:raven@themaw.net">raven@themaw.net</a>&gt;</span> wrote:<br><br><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
&gt; Why do you think that you&#39;ve miscalculated the minimum?<br>
<br>
Well, maybe I haven&#39;t but I thought min should be &gt; 0.<br>
But, it&#39;s not worth worrying about as I think we&#39;ve managed to show=
 a<br>
clear improvement.</blockquote><div><br>The minimum was zero because there =
were empty buckets.<br><br></div><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
&gt; I plotted the number of elements in each bucket.<br>
&gt;<br>
&gt; As you now see, the additive hash function doesn&#39;t scale.<br>
<br>
Sure and now we can say why it doesn&#39;t scale in the patch description.<=
/blockquote><div><br>More importantly, who&#39;s the scapegoat? :P<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Perhap=
s you could make it configurable?<br>
<br>
Perhaps, but I don&#39;t think this is the sort of thing that should be<br>
configurable so I&#39;d prefer to make it a compile time option rather than=
<br>
a run time configuration setting.</blockquote></div><br>On Tue, Jan 13, 200=
9 at 3:15 PM, Ian Kent <span dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw=
.net">raven@themaw.net</a>&gt;</span> wrote:<br><br><div class=3D"gmail_quo=
te">
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I&#39;ve changed =
my mind, ;), configurable it is with a default of 977.</blockquote></div><b=
r>
The hash function is good now, so the size of the hash table can be a power=
 of two.<br><br>

--0016e652f4e812721404605633ac--


--===============0106737511823470336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0106737511823470336==--

