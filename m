From: Rajouri Jammu <rajouri.jammu@gmail.com>
Subject: Re: wait_for_lock() in mount
Date: Fri, 20 Feb 2009 16:03:44 -0800
Message-ID: <3307cdf90902201603y2434a0dbvfcd987770d31c41a@mail.gmail.com>
References: <3307cdf90804180939t42fed2d7k8fc96304f8d01455@mail.gmail.com>
	<1208576146.3090.5.camel@raven.themaw.net>
	<3307cdf90804191052v194cc2bctb25b6aab612e903d@mail.gmail.com>
	<1208703048.3632.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2433622751166059714=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1208703048.3632.8.camel@raven.themaw.net>
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

--===============2433622751166059714==
Content-Type: multipart/alternative; boundary=001485f0a01ebbc2dd046362800b

--001485f0a01ebbc2dd046362800b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I'm again running into problem with cascaded automounts.

This time I'm using the autofs as part of CentOS 5.0
rpm -qa | grep autofs
autofs-5.0.1-0.rc2.43.0.2

>Using the patch requires a configure option to be specified.
>I'm not sure if this patch has been added to the RHEL-4 package, you'll
>need to check. In RHEL-5 the configure option is used when the package
>is built so CentOS 5 will have this already

Does autofs-5.0.. version have "--disable-mount-locking" configured by
default?

Any suggestions would be of great help.

Thanks!

Ranjit


On Sun, Apr 20, 2008 at 6:50 AM, Ian Kent <raven@themaw.net> wrote:

>
> On Sat, 2008-04-19 at 10:52 -0700, Rajouri Jammu wrote:
> > Thank you for the prompt response.
> >
> >
> > Yes, I'm using autofs4 which came with CentOS release 4.6
>
> RHEL-4 U6 should be OK.
> But I don't think any of the versions of mount are 100%.
>
> >
> >
> > mount -V
> > mount: mount-2.12a
> >
> >
> >
> > Is that version of mount OK or do I need a newer version to work with
> > the locking path?
> > If I need a newer version can you please let me know approximately
> > which one?
> >
> >
> > Lastly, does autofs5 not have this issue?
>
> This is a problem with mount and any version of autofs that
> uses /etc/mtab will have this problem.
>
> The later revisions of autofs v4 and autofs v5 use /etc/mtab somewhat
> less and so are less vulnerable.
>
> Using the patch requires a configure option to be specified.
> I'm not sure if this patch has been added to the RHEL-4 package, you'll
> need to check. In RHEL-5 the configure option is used when the package
> is built so CentOS 5 will have this already.
>
> Ian
>
>
>
>

--001485f0a01ebbc2dd046362800b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I&#39;m again running into problem with cascaded automounts.<br>=
<br>This time I&#39;m using the autofs as part of CentOS 5.0 <br>rpm -qa | =
grep autofs<br>autofs-5.0.1-0.rc2.43.0.2<br><br>&gt;Using the patch require=
s a configure option to be specified.<br>

&gt;I&#39;m not sure if this patch has been added to the RHEL-4 package, yo=
u&#39;ll<br>
&gt;need to check. In RHEL-5 the configure option is used when the package<=
br>
&gt;is built so CentOS 5 will have this already<br><br>Does autofs-5.0.. ve=
rsion have &quot;--disable-mount-locking&quot; configured by default?<br><b=
r>Any suggestions would be of great help.<br><br>Thanks!<br><br>Ranjit<br>
<br><br><div class=3D"gmail_quote">On Sun, Apr 20, 2008 at 6:50 AM, Ian Ken=
t <span dir=3D"ltr">&lt;<a href=3D"mailto:raven@themaw.net">raven@themaw.ne=
t</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">
<div class=3D"Ih2E3d"><br>
On Sat, 2008-04-19 at 10:52 -0700, Rajouri Jammu wrote:<br>
&gt; Thank you for the prompt response.<br>
&gt;<br>
&gt;<br>
&gt; Yes, I&#39;m using autofs4 which came with CentOS release 4.6<br>
<br>
</div>RHEL-4 U6 should be OK.<br>
But I don&#39;t think any of the versions of mount are 100%.<br>
<div class=3D"Ih2E3d"><br>
&gt;<br>
&gt;<br>
&gt; mount -V<br>
&gt; mount: mount-2.12a<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Is that version of mount OK or do I need a newer version to work with<=
br>
&gt; the locking path?<br>
&gt; If I need a newer version can you please let me know approximately<br>
&gt; which one?<br>
&gt;<br>
&gt;<br>
&gt; Lastly, does autofs5 not have this issue?<br>
<br>
</div>This is a problem with mount and any version of autofs that<br>
uses /etc/mtab will have this problem.<br>
<br>
The later revisions of autofs v4 and autofs v5 use /etc/mtab somewhat<br>
less and so are less vulnerable.<br>
<br>
Using the patch requires a configure option to be specified.<br>
I&#39;m not sure if this patch has been added to the RHEL-4 package, you&#3=
9;ll<br>
need to check. In RHEL-5 the configure option is used when the package<br>
is built so CentOS 5 will have this already.<br>
<font color=3D"#888888"><br>
Ian<br>
<br>
<br>
<br>
</font></blockquote></div><br>

--001485f0a01ebbc2dd046362800b--


--===============2433622751166059714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2433622751166059714==--

