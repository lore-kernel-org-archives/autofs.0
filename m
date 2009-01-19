From: Paul Wankadia <junyer@google.com>
Subject: Re: [PATCH 1/4] Make hash table scale to thousands of
	entries
Date: Mon, 19 Jan 2009 16:23:05 +1100
Message-ID: <408431290901182123w63b5ef4aw676fdc1bb60a93bd@mail.gmail.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<408431290901151959o7c504c79k88681dddb468359f@mail.gmail.com>
	<1232079714.3166.56.camel@zeus.themaw.net>
	<408431290901152204i8d2da71vbf8ee5f2e2f84fa@mail.gmail.com>
	<1232087057.3166.88.camel@zeus.themaw.net>
	<1232087952.3166.98.camel@zeus.themaw.net>
	<408431290901170911q1af268b1o5576f46e0bee2129@mail.gmail.com>
	<1232249174.3106.5.camel@zeus.themaw.net>
	<408431290901181728u5b01c262u1b2640595deaac95@mail.gmail.com>
	<1232330605.3136.7.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0393694594855282632=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232330605.3136.7.camel@zeus.themaw.net>
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

--===============0393694594855282632==
Content-Type: multipart/alternative; boundary=0016e65206020ab40d0460cf1ec8

--0016e65206020ab40d0460cf1ec8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

 On Mon, Jan 19, 2009 at 1:03 PM, Ian Kent <raven@themaw.net> wrote:

> It's just that your earlier comment regarding a concurrency issue led
> > me to wonder about the use of Pthreads. In particular, I'm not sure
> > what the rationale was, but I'd also like to understand the control
> > flow, so that's why I was interested in a design document of some
> > sort.
>
> Right.
>
> One of the things that v5 does is to move the master map parsing out of
> the init script and into the daemon itself. That means that the daemon
> then has to manage each of the master map mounts as well. Using
> individual sub-processes has a whole set of problems related to the
> supervising process communicating with and knowing the state of those
> sub-processes so v5 changed to a threaded model which of course has it's
> own set of difficulties.


Does the daemon need multiple processes/threads because of the ioctl(2)
calls that block?

On a related note, is the autofs device a step towards a completely revised
kernel interface? I've started to contemplate the use of socket pairs
instead of pipes and ioctl(2) calls. (NBD seems to be a simple example of
this style.)

--0016e65206020ab40d0460cf1ec8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


<div class=3D"gmail_quote">On Mon, Jan 19, 2009 at 1:03 PM, Ian Kent <span =
dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net" target=3D"_blank">raven=
@themaw.net</a>&gt;</span> wrote:<br><br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">




<div><div></div><div>&gt; It&#39;s just that your earlier comment regarding=
 a concurrency issue led<br>
&gt; me to wonder about the use of Pthreads. In particular, I&#39;m not sur=
e<br>
&gt; what the rationale was, but I&#39;d also like to understand the contro=
l<br>
&gt; flow, so that&#39;s why I was interested in a design document of some<=
br>
&gt; sort.<br>
<br>
</div></div>Right.<br>
<br>
One of the things that v5 does is to move the master map parsing out of<br>
the init script and into the daemon itself. That means that the daemon<br>
then has to manage each of the master map mounts as well. Using<br>
individual sub-processes has a whole set of problems related to the<br>
supervising process communicating with and knowing the state of those<br>
sub-processes so v5 changed to a threaded model which of course has it&#39;=
s<br>
own set of difficulties.</blockquote></div><br>Does the daemon need multipl=
e processes/threads because of the ioctl(2) calls that block?<br><br>On a r=
elated note, is the autofs device a step towards a completely revised kerne=
l interface? I&#39;ve started to contemplate the use of socket pairs instea=
d of pipes and ioctl(2) calls. (NBD seems to be a simple example of this st=
yle.)<br>

--0016e65206020ab40d0460cf1ec8--


--===============0393694594855282632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0393694594855282632==--

