From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Sat, 10 Jan 2009 12:19:19 +1100
Message-ID: <408431290901091719j58c33f8bj65ce1a47f782bc29@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<x49mye0ffvg.fsf@segfault.boston.devel.redhat.com>
	<20090109195151.GH32333@shell>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4629071931617137666=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090109195151.GH32333@shell>
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
To: Valerie Aurora Henson <vaurora@redhat.com>
Cc: autofs@linux.kernel.org

--===============4629071931617137666==
Content-Type: multipart/alternative; boundary=0016e6538630aebcc8046016a976

--0016e6538630aebcc8046016a976
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sat, Jan 10, 2009 at 6:51 AM, Valerie Aurora Henson
<vaurora@redhat.com>wrote:

> Most patches of this nature come with some description of a performance
> > problem and how the patch solves it.  Which caching algorithm is
> > implemented below?  There are, of course, many hashing algorithms for
> > variable length strings.  Can we get some rationale for the change?  I'm
> > not against it, I'd just like a *little* explanation.
>
> This is where I get to blame my cold for being stupid. :)
>
> Yes, the original author (Paul Wankadia, now cc'd) gave me a little
> information on that front, I just forgot to pass it on.  It's the
> "One-at-a-Time" hash function by Bob Jenkins. See:
>
> http://burtleburtle.net/bob/hash/doobs.html
>
> What I vaguely recall from our conversation is an order of magnitude
> improvement in elapsed time for large (thousands) numbers of maps, but
> I'll let Paul be more specific.  Do we have a test for thousands of
> entries somewhere in our automated tests?


It's just that the additive hash function and the tiny, non-prime hash table
size offended my delicate sensibilities. ;)

Actually, we discovered that reloading a large file map took well over ten
seconds. Profiling revealed that the daemon spent most of its time calling
strcmp(3).

Oh, and I should note that the problem was observed in autofs v4. I'll be
looking more closely at autofs v5 in the near future.

--0016e6538630aebcc8046016a976
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2009 at 6:51 AM, Valerie Aurora Henson <span dir=3D"ltr">&l=
t;<a href=3D"mailto:vaurora@redhat.com">vaurora@redhat.com</a>&gt;</span> w=
rote:<br><br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
&gt; Most patches of this nature come with some description of a performanc=
e<br>
&gt; problem and how the patch solves it. &nbsp;Which caching algorithm is<=
br>
&gt; implemented below? &nbsp;There are, of course, many hashing algorithms=
 for<br>
&gt; variable length strings. &nbsp;Can we get some rationale for the chang=
e? &nbsp;I&#39;m<br>
&gt; not against it, I&#39;d just like a *little* explanation.<br>
<br>
This is where I get to blame my cold for being stupid. :)<br>
<br>
Yes, the original author (Paul Wankadia, now cc&#39;d) gave me a little<br>
information on that front, I just forgot to pass it on. &nbsp;It&#39;s the<=
br>
&quot;One-at-a-Time&quot; hash function by Bob Jenkins. See:<br>
<br>
<a href=3D"http://burtleburtle.net/bob/hash/doobs.html" target=3D"_blank">h=
ttp://burtleburtle.net/bob/hash/doobs.html</a><br>
<br>
What I vaguely recall from our conversation is an order of magnitude<br>
improvement in elapsed time for large (thousands) numbers of maps, but<br>
I&#39;ll let Paul be more specific. &nbsp;Do we have a test for thousands o=
f<br>
entries somewhere in our automated tests?</blockquote><br>It&#39;s just tha=
t the additive hash function and the tiny, non-prime hash table size offend=
ed my delicate sensibilities. ;)<br><br>Actually, we discovered that reload=
ing a large file map took well over ten seconds. Profiling revealed that th=
e daemon spent most of its time calling strcmp(3).<br>
<br>Oh, and I should note that the problem was observed in autofs v4. I&#39=
;ll be looking more closely at autofs v5 in the near future.<br><br></div>

--0016e6538630aebcc8046016a976--


--===============4629071931617137666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4629071931617137666==--

