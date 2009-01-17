From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Sun, 18 Jan 2009 04:11:34 +1100
Message-ID: <408431290901170911q1af268b1o5576f46e0bee2129@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901151257i70400351yc3ab9360136c8e9c@mail.gmail.com>
	<1232065653.3166.19.camel@zeus.themaw.net>
	<1232066406.3166.28.camel@zeus.themaw.net>
	<1232070195.3166.36.camel@zeus.themaw.net>
	<408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
	<1232079714.3166.56.camel@zeus.themaw.net>
	<408431290901152204i8d2da71vbf8ee5f2e2f84fa@mail.gmail.com>
	<1232087057.3166.88.camel@zeus.themaw.net>
	<1232087952.3166.98.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0445102683086409291=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232087952.3166.98.camel@zeus.themaw.net>
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

--===============0445102683086409291==
Content-Type: multipart/alternative; boundary=001485f3e8be20308b0460b0c84b

--001485f3e8be20308b0460b0c84b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jan 16, 2009 at 5:39 PM, Ian Kent <raven@themaw.net> wrote:

> > Sorry, I don't understand how that condition will evaluate to false.
> > > You won't read the map until ctxt->mtime changes, but it won't change
> > > until you read the map.
> >
> > Mmmm .. before that last change I was assuming the code which sets the
> > stale flag would cause the read but then I removed that bit and ...
> > oops!
>
> Because, after a mount lookup we check the stale status and queue a map
> read if the map is stale. But then I went and removed the bit that sets
> the map stale because it's lazy in identifying if the map has changed so
> we could get quite a few mount lookups before a map read gets queued.
> I'll add back the stat(2) I originally had their before I posted the
> patch.


Thanks!

I'm also thinking of checking if a map read task is in progress when a
> mount lookup comes in and waiting for it to complete before continuing
> with the lookup (to reduce the number of file scans a bit). But I'll
> need to have a look around to see if that will be a problem.


Is there a design document for autofs v5 that you're permitted to share?

--001485f3e8be20308b0460b0c84b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Fri, Jan 16, 2009 at 5:39 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net</a>&gt=
;</span> wrote:<br><br><blockquote class=3D"gmail_quote" style=3D"border-le=
ft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: =
1ex;">
&gt; &gt; Sorry, I don&#39;t understand how that condition will evaluate to=
 false.<br>
&gt; &gt; You won&#39;t read the map until ctxt-&gt;mtime changes, but it w=
on&#39;t change<br>
&gt; &gt; until you read the map.<br>
&gt;<br>
&gt; Mmmm .. before that last change I was assuming the code which sets the=
<br>
&gt; stale flag would cause the read but then I removed that bit and ...<br=
>
&gt; oops!<br>
<br>
Because, after a mount lookup we check the stale status and queue a map<br>
read if the map is stale. But then I went and removed the bit that sets<br>
the map stale because it&#39;s lazy in identifying if the map has changed s=
o<br>
we could get quite a few mount lookups before a map read gets queued.<br>
I&#39;ll add back the stat(2) I originally had their before I posted the<br=
>
patch.</blockquote><div><br>Thanks!<br><br></div><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">I&#39;m also thinking of checking if a map =
read task is in progress when a<br>

mount lookup comes in and waiting for it to complete before continuing<br>
with the lookup (to reduce the number of file scans a bit). But I&#39;ll<br=
>
need to have a look around to see if that will be a problem.</blockquote><b=
r>Is there a design document for autofs v5 that you&#39;re permitted to sha=
re?<br><br></div>

--001485f3e8be20308b0460b0c84b--


--===============0445102683086409291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0445102683086409291==--

