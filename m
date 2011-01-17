From: Frank Hall <frank.f.hall@gmail.com>
Subject: mount dependencies in autofs
Date: Mon, 17 Jan 2011 17:43:37 +0000
Message-ID: <AANLkTimCzAZ0dg3Xv2hvAJGf5-5VU64eTgKqQbP7egcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5760626673663376961=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:date:message-id:subject:from:to
	:content-type; bh=Sw4qYirCKaPx4t9TkH8YaafDHpceZT2kKZW2GlYezFA=;
	b=UZsrRPwFk+gG5mw1neZZk/VC4PX1Y51q1JUaglYLErzdh93aqBTR7onbitU6fwM/kX
	q5jI7hKbfSEqxk7nSsmJhLmTFLaLHUP98709+Tr3rdgAcwc2qjWDg6D4XvLXF+wl+nsi
	+Uot1BstQ0OfRpeZsY7SPHSKBYhQGAzjvH0lc=
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
To: autofs@linux.kernel.org

--===============5760626673663376961==
Content-Type: multipart/alternative; boundary=20cf3054a87de2db70049a0e527a

--20cf3054a87de2db70049a0e527a
Content-Type: text/plain; charset=ISO-8859-1

Hello,

Is there a way to use autofs to manage two filesystems, where the second
filesystem is dependent on the first?

An example is where the first filesystem holds an ISO image, and the second
filesystem is a loop mounting of that image.  Another example is where the
second filesystem is a bind mount from within the first filesystem.

I have tried with a direct map like this:

    /svfs/stuff -fstype=bind :/srv/topmnts/fs0/stuff
    /srv/topmnts/fs0 -fstype=auto :-Lfs0

If I try and access /srv/topmnts/fs0 first, and then try to access
/svfs/stuff, this works just fine.  However, if I try to access /svfs/stuff
first, I get "No such file or directory", and the log gets ">> mount:
special device /srv/topmnts/fs0/stuff does not exist".

So it looks like autofs's filesystem access is not itself subject to autofs
intervention?

The strange thing is, I'm sure I have had a similar configuration working in
the past.  But unfortunately I no longer have access to those systems and
configuration data.

I'm using autofs 5.0.4 as packaged by Debian squeeze.

Finally, what would you call such a feature?  Recursive automounts?  Chained
automounts?  Dependent automounts?

  Regards, Frank.

--20cf3054a87de2db70049a0e527a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<div><br></div><div>Is there a way to use autofs to manage two filesy=
stems, where the second filesystem is dependent on the first?</div><div><br=
></div><div>An example is where the first filesystem holds an ISO image, an=
d the second filesystem is a loop mounting of that image. =A0Another exampl=
e is where the second filesystem is a bind mount from within the first file=
system.</div>
<div><br></div><div>I have tried with a direct map like this:</div><div><br=
></div><div>=A0=A0 =A0/svfs/stuff -fstype=3Dbind :/srv/topmnts/fs0/stuff</d=
iv><div>=A0=A0 =A0/srv/topmnts/fs0 -fstype=3Dauto :-Lfs0</div><div><br></di=
v><div>If I try and access /srv/topmnts/fs0 first, and then try to access /=
svfs/stuff, this works just fine. =A0However, if I try to access=A0/svfs/st=
uff first, I get &quot;No such file or directory&quot;, and the log gets &q=
uot;&gt;&gt; mount: special device /srv/topmnts/fs0/stuff does not exist&qu=
ot;.</div>
<div><br></div><div>So it looks like autofs&#39;s filesystem access is not =
itself subject to autofs intervention?</div><div><br></div><div>The strange=
 thing is, I&#39;m sure I have had a similar configuration working in the p=
ast. =A0But unfortunately I no longer have access to those systems and conf=
iguration data.</div>
<div><br></div><div>I&#39;m using autofs 5.0.4 as packaged by Debian squeez=
e.</div><div><br></div><div>Finally, what would you call such a feature? =
=A0Recursive automounts? =A0Chained automounts? =A0Dependent automounts?</d=
iv><div>
<br></div><div>=A0=A0Regards, Frank.</div>

--20cf3054a87de2db70049a0e527a--


--===============5760626673663376961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5760626673663376961==--

