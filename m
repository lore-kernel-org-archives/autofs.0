From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: Re: I have some patches for the autofs-4.x daemon - what
 to do with them?
Date: Mon, 6 Dec 2010 13:34:09 +1300
Message-ID: <AANLkTimUAegMdD0kdAdK4Bb44NOpaNxAUZQcN5t7XpD-@mail.gmail.com>
References: <AANLkTinCncue4d-g_c0fSF1smE3i8cT-GT+w-eDygGPF@mail.gmail.com>
	<1291350420.3062.12.camel@perseus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4939066453946230782=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:mime-version:received:in-reply-to
	:references:from:date:message-id:subject:to:cc:content-type;
	bh=uOvPKMm/2P2tVG9w0iBl46GF3g2dTS8qoGZTTyHEZc8=;
	b=QrxvRc8cmLDFh/uHHjAuB4MoPUbI0vWVqBbw4fRDCTa5jp/KofSHdgNYyIdLBvAdN7
	p54oh3/5DQvwr3AZEFaS2QBLJOo+sIaaXfq1klEx8iiyUu/ff5KP+yzOO5Nx4jxOtRmG
	7FiNJzdmKNlV34/CrnkjYcutYuCQAF6l8btzo=
In-Reply-To: <1291350420.3062.12.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--===============4939066453946230782==
Content-Type: multipart/alternative; boundary=000325575d660fd2550496b30d9a

--000325575d660fd2550496b30d9a
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Dec 3, 2010 at 5:27 PM, Ian Kent <raven@themaw.net> wrote:

> On Wed, 2010-12-01 at 11:07 +1300, Bill Ryder wrote:
> > Where should I submit those?
> >
> >
>
>
> Probably, but it might be good for me to create a directory on
> kernel.org and save them their, but a readme with applicable version and
> usage information would probably make sense.
>

OK. How about if I break out the patches against 4.1.4 against
ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4

I'll try to make the changelog detailed enough in each patch so it's clear
what it does.



>
> > I don't like autofs-5 because I cant' fix automounts individually.
> > It's very convenient to be able to restart individual mounts. Also
> > when a daemon core dumps they don't take out every single map. Also I
> > prefer automount to run the mount command itself - rather than
> > building it into the daemon.
>
> Right, but v5 still uses mount(8) as v4 did.
>

Oh. I thought I saw some mount code in it when I was taking a cursory look.
(looking over the code now I suspect I saw the rpc_get_exports code and
didn't look properly). That's good. I thought it was a bit crazy at the time
but didn't look properly. Sorry about that. (I thought that time was trying
to be saved by not running  mount).



> I understand your need for segregation but it would be good to get v5 to
> a state where this isn't a problem for you any more.
>

Yeah.

When I last looked (which was admittedly last year now) I was looking for a
way to restart the thread responsible for a particular map if it had crashed
or just needed a poke or if I wanted to change the ldap query it was using.
 At that time I couldn't even find a way to easily see which thread owned
which map. Let alone start up one map with a hand rolled ldap string.


> Tell me more about the "take out every single map" problem. With current
> v5 you should be able to just start it up again and your mounts should
> continue to function. The problem of course come when you have a
> non-responsive server, then you end up re-connecting to non-responsive
> mounts. Of course, there is still a time where new mounts cannot be made
> until the startup.
>


As I understand it a core dump will take the autofs-5 daemon and all of it's
threads down.

So existing mounts will continue to function but any request requiring a new
mount will not.

With a process per map  you only lose one map - not all of them - if it
should crash.

We run a lot of checkers that will bring up individual broken maps. This
used to be a constant thing with 4.1.3 but 4.1.4 is much more stable.

Also sometimes when I'm testing things I'll want to start up a map with
special options (ldap filter usually) but leave the other maps alone.

As I see it the problem with the multithreaded automounter is all the
functionality you get for free from linux (starting individual processes for
each map, looking at which process owns which mount points by looking at ps,
and so on) you need to code for explicitly in autofs 5.




>
> >
> >
> > The main work I've done is to build in retrying mounts depending on
> > the errors returned by mount (with our client count we overload our
> > fileservers often which causes retryable errors, and sometimes a
> > client will try to mount 100 or so mount points in a very short amount
> > of time which causes some tcp client port exhaustion - which is also
> > retryable).
>
> So you can't export to allow clients to use insecure ports?
>

I could do this but we have around 30 'normal' fileservers (netapps) and a
lot (> 100) virtual NFS servers on 4 clusters which are more painful to
administer. And of course the way to specify secure vs insecure is
different.

And since I already have retry code in place to handle overloaded
fileservers  this was an easy - if ugly -  workaround (which hopefully we
won't need anymore because we've changed some things which created these
little storms). It was rare but it did happen.

For our work it's better if a mount hangs for a while rather than failing
and returning a path not found to the application.

The big fault with my retry code is I look at a set of compiled in strings
of errors that are retryable. Very painful when you just want to add one
more error message. Ideally I'd read a file with the list of retryable
errors in it when automounter starts up.

Bill

--000325575d660fd2550496b30d9a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Dec 3, 2010 at 5:27 PM, Ian Kent=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.net=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"im">On Wed, 2010-12-01 at 11:07 +1300, Bill Ryder wrote:<br>
&gt; Where should I submit those?<br>
&gt;<br>
&gt;<br><br>
<br>
</div>Probably, but it might be good for me to create a directory on<br>
<a href=3D"http://kernel.org" target=3D"_blank">kernel.org</a> and save the=
m their, but a readme with applicable version and<br>
usage information would probably make sense.<br></blockquote><div><br></div=
><div>OK. How about if I break out the patches against 4.1.4 against=A0<a h=
ref=3D"ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4">ftp:/=
/ftp.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4</a></div>

<div><br></div><div>I&#39;ll try to make the changelog detailed enough in e=
ach patch so it&#39;s clear what it does.</div><div><br></div><div>=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex;">


<div class=3D"im"><br>
&gt; I don&#39;t like autofs-5 because I cant&#39; fix automounts individua=
lly.<br>
&gt; It&#39;s very convenient to be able to restart individual mounts. Also=
<br>
&gt; when a daemon core dumps they don&#39;t take out every single map. Als=
o I<br>
&gt; prefer automount to run the mount command itself - rather than<br>
&gt; building it into the daemon.<br>
<br>
</div>Right, but v5 still uses mount(8) as v4 did.<br></blockquote><div><br=
></div><div>Oh. I thought I saw some mount code in it when I was taking a c=
ursory look. (looking over the code now I suspect I saw the rpc_get_exports=
 code and didn&#39;t look properly). That&#39;s good. I thought it was a bi=
t crazy at the time but didn&#39;t look properly. Sorry about that. (I thou=
ght that time was trying to be saved by not running =A0mount).</div>

<div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<br>
I understand your need for segregation but it would be good to get v5 to<br=
>
a state where this isn&#39;t a problem for you any more.<br></blockquote><d=
iv><br></div><div>Yeah.=A0</div><div><br></div><div>When I last looked (whi=
ch was admittedly last year now) I was looking for a way to restart the thr=
ead responsible for a particular map if it had crashed or just needed a pok=
e or if I wanted to change the ldap query it was using. =A0At that time I c=
ouldn&#39;t even find a way to easily see which thread owned which map. Let=
 alone start up one map with a hand rolled ldap string.</div>

<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex;">
<br>
Tell me more about the &quot;take out every single map&quot; problem. With =
current<br>
v5 you should be able to just start it up again and your mounts should<br>
continue to function. The problem of course come when you have a<br>
non-responsive server, then you end up re-connecting to non-responsive<br>
mounts. Of course, there is still a time where new mounts cannot be made<br=
>
until the startup.<br></blockquote><div><br></div><div><br></div><div>As I =
understand it a core dump will take the autofs-5 daemon and all of it&#39;s=
 threads down.=A0</div><div><br></div><div>So existing mounts will continue=
 to function but any request requiring a new mount will not.</div>

<div><br></div><div>With a process per map =A0you only lose one map - not a=
ll of them - if it should crash.</div><div><br></div><div>We run a lot of c=
heckers that will bring up individual broken maps. This used to be a consta=
nt thing with 4.1.3 but 4.1.4 is much more stable.</div>

<div><br></div><div>Also sometimes when I&#39;m testing things I&#39;ll wan=
t to start up a map with special options (ldap filter usually) but leave th=
e other maps alone.</div><div><br></div><div>As I see it the problem with t=
he multithreaded automounter is all the functionality you get for free from=
 linux (starting individual processes for each map, looking at which proces=
s owns which mount points by looking at ps, and so on) you need to code for=
 explicitly in autofs 5.=A0</div>

<div><br></div><div><br></div><div>=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"=
>
<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt; The main work I&#39;ve done is to build in retrying mounts depending o=
n<br>
&gt; the errors returned by mount (with our client count we overload our<br=
>
&gt; fileservers often which causes retryable errors, and sometimes a<br>
&gt; client will try to mount 100 or so mount points in a very short amount=
<br>
&gt; of time which causes some tcp client port exhaustion - which is also<b=
r>
&gt; retryable).<br>
<br>
</div>So you can&#39;t export to allow clients to use insecure ports?<br></=
blockquote><div><br></div><div>I could do this but we have around 30 &#39;n=
ormal&#39; fileservers (netapps) and a lot (&gt; 100) virtual NFS servers o=
n 4 clusters which are more painful to administer. And of course the way to=
 specify secure vs insecure is different.</div>

<div><br></div><div>And since I already have retry code in place to handle =
overloaded fileservers =A0this was an easy - if ugly - =A0workaround (which=
 hopefully we won&#39;t need anymore because we&#39;ve changed some things =
which created these little storms). It was rare but it did happen.=A0</div>

<div><br></div><div>For our work it&#39;s better if a mount hangs for a whi=
le rather than failing and returning a path not found to the application.</=
div><div><br></div><div>The big fault with my retry code is I look at a set=
 of compiled in strings of errors that are retryable. Very painful when you=
 just want to add one more error message. Ideally I&#39;d read a file with =
the list of retryable errors in it when automounter starts up.</div>

<div><br></div><div>Bill</div><div><br></div><div><br></div></div>

--000325575d660fd2550496b30d9a--


--===============4939066453946230782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4939066453946230782==--

