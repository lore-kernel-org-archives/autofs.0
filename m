From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Wed, 14 Jan 2009 21:52:14 +1100
Message-ID: <408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231732946.3073.44.camel@zeus.themaw.net>
	<1231736307.3073.68.camel@zeus.themaw.net>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
	<1231813498.3057.12.camel@zeus.themaw.net>
	<1231820126.3057.14.camel@zeus.themaw.net>
	<408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
	<1231823945.3057.20.camel@zeus.themaw.net>
	<408431290901131943t2c678c8ej10c1829c71b5a557@mail.gmail.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1998718275486672841=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231922825.3168.37.camel@zeus.themaw.net>
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

--===============1998718275486672841==
Content-Type: multipart/alternative; boundary=0016e651fa9af7d83504606f2166

--0016e651fa9af7d83504606f2166
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Jan 14, 2009 at 7:47 PM, Ian Kent <raven@themaw.net> wrote:

> It seems that autofs v5 doesn't read an indirect map into the cache
> > unless ghosting is enabled, so I'm thinking about adding a map option
> > to force the read. Has the file map reloading logic changed
> > significantly since autofs v4?
>
> It's a bit hard to give a good answer to that as there have been so many
> changes but, having said that, it shouldn't have changed much except for
> the obvious one that it tries not to read the entire map unless it has
> to. Adding the "--ghost" or "browse" option will cause it to read the
> entire map. Also, the internal default, which is "browse" enabled by
> default, is overridden by the default installed configuration with
> BROWSE_MODE="no" so v5 behaves the same as v4.


Sorry, I meant the logic that reloads the file map if it's been modified. I
know that autofs v4 checked the mtime, but I can't see where autofs v5 does
that.

--0016e651fa9af7d83504606f2166
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2009 at 7:47 PM, Ian Kent <span dir=3D"ltr">&lt;<a href=3D"=
mailto:raven@themaw.net">raven@themaw.net</a>&gt;</span> wrote:<br><br><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
<div class=3D"Ih2E3d">&gt; It seems that autofs v5 doesn&#39;t read an indi=
rect map into the cache<br>
&gt; unless ghosting is enabled, so I&#39;m thinking about adding a map opt=
ion<br>
&gt; to force the read. Has the file map reloading logic changed<br>
&gt; significantly since autofs v4?<br>
<br>
</div>It&#39;s a bit hard to give a good answer to that as there have been =
so many<br>
changes but, having said that, it shouldn&#39;t have changed much except fo=
r<br>
the obvious one that it tries not to read the entire map unless it has<br>
to. Adding the &quot;--ghost&quot; or &quot;browse&quot; option will cause =
it to read the<br>
entire map. Also, the internal default, which is &quot;browse&quot; enabled=
 by<br>
default, is overridden by the default installed configuration with<br>
BROWSE_MODE=3D&quot;no&quot; so v5 behaves the same as v4.</blockquote><br>=
Sorry, I meant the logic that reloads the file map if it&#39;s been modifie=
d. I know that autofs v4 checked the mtime, but I can&#39;t see where autof=
s v5 does that.<br>
</div>

--0016e651fa9af7d83504606f2166--


--===============1998718275486672841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1998718275486672841==--

