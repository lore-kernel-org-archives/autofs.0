From: Paul Wankadia <junyer@google.com>
Subject: Re: problems in daemon/lookup.c
Date: Thu, 22 Jan 2009 14:46:53 +1100
Message-ID: <408431290901211946p1b6b6236n249cffada9534b7a@mail.gmail.com>
References: <408431290901192148idf9499xe12e58fb2b36a975@mail.gmail.com>
	<1232504588.3931.0.camel@zeus.themaw.net>
	<1232509747.3931.5.camel@zeus.themaw.net>
	<408431290901202115i1709c46s5bf1252f0a72b2c4@mail.gmail.com>
	<1232515783.3931.28.camel@zeus.themaw.net>
	<408431290901211721q162fb146vf071bff40727aa7b@mail.gmail.com>
	<1232590002.3069.14.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5386985083075202086=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232590002.3069.14.camel@zeus.themaw.net>
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

--===============5386985083075202086==
Content-Type: multipart/alternative; boundary=0016e65385c28dae1704610a1fab

--0016e65385c28dae1704610a1fab
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jan 22, 2009 at 1:06 PM, Ian Kent <raven@themaw.net> wrote:

> A daemon shouldn't run out of memory. Generally speaking, it's an
> > exceptional condition that justifies abnormal termination.
>
> Don't think it being a daemon makes any difference?
>
> I'm not entirely sure how this works but I thought that modified pages
> are written to swap. If swap fills up I think alocs can fail even though
> heap is available. If that is then fixed by external intervention the
> alocs could then succeed. So, maybe termination isn't the right chioce
> here. In any case it should be evident from the log that the situation
> exists and the admin can decide what action to take. OTOH if heap is
> really exhausted then termination probably is the right choice.
>
> In any case I prefer to try and continue.


Sorry, I just don't understand why that's the right thing to do. If a daemon
can't allocate memory in order to perform the operations that it needs to
perform, then how can it provide the functionality that it's expected to
provide? Why should it continue indefinitely instead of aborting and being
restarted automatically?

--0016e65385c28dae1704610a1fab
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Jan 22, 2009 at 1:06 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net" target=3D"_blank">raven=
@themaw.net</a>&gt;</span> wrote:<br><br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">

<div><div></div><div>&gt; A daemon shouldn&#39;t run out of memory. General=
ly speaking, it&#39;s an<br>
&gt; exceptional condition that justifies abnormal termination.<br>
<br>
</div></div>Don&#39;t think it being a daemon makes any difference?<br>
<br>
I&#39;m not entirely sure how this works but I thought that modified pages<=
br>
are written to swap. If swap fills up I think alocs can fail even though<br=
>
heap is available. If that is then fixed by external intervention the<br>
alocs could then succeed. So, maybe termination isn&#39;t the right chioce<=
br>
here. In any case it should be evident from the log that the situation<br>
exists and the admin can decide what action to take. OTOH if heap is<br>
really exhausted then termination probably is the right choice.<br>
<br>
In any case I prefer to try and continue.</blockquote></div><br>Sorry, I ju=
st don&#39;t understand why that&#39;s the right thing to do. If a daemon c=
an&#39;t allocate memory in order to perform the operations that it needs t=
o perform, then how can it provide the functionality that it&#39;s expected=
 to provide? Why should it continue indefinitely instead of aborting and be=
ing restarted automatically?

--0016e65385c28dae1704610a1fab--


--===============5386985083075202086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5386985083075202086==--

