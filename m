From: Dana Wellen <dana.wellen@onsemi.com>
Subject: Re: SOLVED?? Pls help on configuring autofs on NFS for
 home dir
Date: Tue, 26 Sep 2006 10:50:51 -0400
Message-ID: <45193E4B.20402@onsemi.com>
References: <200609261119.47084.fajarpri@cbn.net.id>	<200609261143.12477.fajarpri@cbn.net.id>	<45192426.3040108@onsemi.com>
	<200609262047.22505.fajarpri@cbn.net.id>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4239756126779797941=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200609262047.22505.fajarpri@cbn.net.id>
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
To: autofs@linux.kernel.org

--===============4239756126779797941==
Content-Type: text/html; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id k922vZ99012554

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DISO-8859-15"
 http-equiv=3D"Content-Type">
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Fajar,<br>
=A0 Is your /home a mounted partition?=A0 Or /home exists before hand.=A0
Automounts will create<br>
the directory as needed when autofs is started.=A0 In other words /home
can't exist on ether <br>
the root partition or have any other partitions mounted to /home.<br>
<br>
<br>
<br>
Fajar Priyanto wrote:
<blockquote cite=3D"mid200609262047.22505.fajarpri@cbn.net.id" type=3D"ci=
te">
  <pre wrap=3D"">On Tuesday 26 September 2006 19:59, Dana Wellen wrote:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D""> Fajar,
 =A0 I assume you want your nfstest user to mount their home directory in
/home.=A0 Your autofs files should be:
 auto.master
 /home=A0=A0 =A0=A0 /etc/auto.home --timeout=3D60
 auto.home
*       -rw,soft,intr   192.168.1.247:/home/&amp;
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
Hi Dana,
Thank you very much for replying.
Actually, that was one of the first configurations I tried, but, when I t=
ried=20
it, autofs couldn't be started with error:
"Cannot start automount.=20
/home already mounted"

I don't know, maybe it's because I have done some mistakes before. But, I=
=20
couldn't restart the machine since it's my running mail server (shame on =
me=20
by experimenting on a production server).

I'll setup some boxes at home to try it again.
I'll post the result.
  </pre>
</blockquote>
<br>
<div class=3D"moz-signature">-- <br>
<br>
</div>
</body>
</html>


--===============4239756126779797941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4239756126779797941==--
