From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Thu, 15 Jan 2009 01:20:01 +1100
Message-ID: <408431290901140620k11a8cf7evb667895a59c7e204@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901121752x3e7c1ab6xa3d1cf711db5e2bb@mail.gmail.com>
	<1231813498.3057.12.camel@zeus.themaw.net>
	<1231820126.3057.14.camel@zeus.themaw.net>
	<408431290901122107q7ef82404gd48a602cd268241a@mail.gmail.com>
	<1231823945.3057.20.camel@zeus.themaw.net>
	<408431290901131943t2c678c8ej10c1829c71b5a557@mail.gmail.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
	<408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
	<1231939076.3168.53.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2947369240071100073=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231939076.3168.53.camel@zeus.themaw.net>
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

--===============2947369240071100073==
Content-Type: multipart/alternative; boundary=0016e652034a14f2be04607209f0

--0016e652034a14f2be04607209f0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jan 15, 2009 at 12:17 AM, Ian Kent <raven@themaw.net> wrote:

> Sorry, I meant the logic that reloads the file map if it's been
> > modified. I know that autofs v4 checked the mtime, but I can't see
> > where autofs v5 does that.
>
> Yeah, I didn't think I got rid of that.
>
> But the check for a mismatch between the cache and a file key lookup
> should be sufficient to only cause a read when the map has actually
> changed. I guess we could get multiple HUP signals, one following just
> after the other has finished, but that would be a system admin error and
> you'd probably want to know about that since we can't make a similar
> check some other map sources. I probably should get around to removing
> the mtime stuff all-together, perhaps you could let me know if things
> work as they should (or not) so I can clean (or fix) that up.


Are you saying that every lookup for an indirect map will hit the file? If
that's the case, then what's the point of the cache? If that's not the case,
but you're not checking the mtime either, then how do you know when the file
has been modified? (Please excuse the silly questions.)

--0016e652034a14f2be04607209f0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2009 at 12:17 AM, Ian Kent <span dir=3D"ltr">&lt;<a href=3D=
"mailto:raven@themaw.net">raven@themaw.net</a>&gt;</span> wrote:<br><br><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">
<div><div></div><div class=3D"Wj3C7c">&gt; Sorry, I meant the logic that re=
loads the file map if it&#39;s been<br>
&gt; modified. I know that autofs v4 checked the mtime, but I can&#39;t see=
<br>
&gt; where autofs v5 does that.<br>
<br>
</div></div>Yeah, I didn&#39;t think I got rid of that.<br>
<br>
But the check for a mismatch between the cache and a file key lookup<br>
should be sufficient to only cause a read when the map has actually<br>
changed. I guess we could get multiple HUP signals, one following just<br>
after the other has finished, but that would be a system admin error and<br=
>
you&#39;d probably want to know about that since we can&#39;t make a simila=
r<br>
check some other map sources. I probably should get around to removing<br>
the mtime stuff all-together, perhaps you could let me know if things<br>
work as they should (or not) so I can clean (or fix) that up.</blockquote><=
br>Are you saying that every lookup for an indirect map will hit the file? =
If that&#39;s the case, then what&#39;s the point of the cache? If that&#39=
;s not the case, but you&#39;re not checking the mtime either, then how do =
you know when the file has been modified? (Please excuse the silly question=
s.)<br>
</div>

--0016e652034a14f2be04607209f0--


--===============2947369240071100073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2947369240071100073==--

