From: Issa <frechdesign@gmail.com>
Subject: Re: Autofs SMBFS no write in files
Date: Wed, 5 Jan 2011 19:53:23 +0100
Message-ID: <AANLkTimPnSqVgjONUOvmXChATYRgR=N-RwHjcbtLw1fQ@mail.gmail.com>
References: <alpine.LNX.2.00.1012182238560.17400@swampdragon.chaosbits.net>
	<4D207520.60200@gmail.Com>
	<7A014DE1422A694A89BA2CE1F5692DF503831E91@niihau.lionsgate.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2391677513835561161=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:received:in-reply-to
	:references:date:message-id:subject:from:to:cc:content-type;
	bh=uuQtoyn8RKOiZmfUEcdRi5pXib2Lc6HLqUhREQMccSk=;
	b=pWg9IO7JIU2Jwiv+GQnFDqBIxRGvvVRA8tqF3AOa08kl2GqM4a0Oo4k3WOw0Nmwil1
	kQhy+PvjmSEy5gh9yopoeR+1oxJDN4mgeEeaaiQMV2PWVsi97ypJL2F5oEtEB0vTniEy
	z24SIx4K85rxPn+gDlSVtbvI4FwChl3yZDxKE=
In-Reply-To: <7A014DE1422A694A89BA2CE1F5692DF503831E91@niihau.lionsgate.ca>
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
To: "Carter, Joel" <JoelC@trailerwizards.com>
Cc: autofs@linux.kernel.org, Jesper Juhl <jj@chaosbits.net>, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

--===============2391677513835561161==
Content-Type: multipart/alternative; boundary=0015174c3d4a483df504991de64d

--0015174c3d4a483df504991de64d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello thanks for u answer,


yes i need to make sudo for write in .





2011/1/5 Carter, Joel <JoelC@trailerwizards.com>

> Hey there.
>
>
>
> Who is the owner and what are the permissions of your /mnt/smb/win1 mount
> point after autofs kicks in? Can you write to it using root (or using sud=
o,
> same thing)?
>
>
>
> Joel.
>
>
>
> *From:* autofs-bounces@linux.kernel.org [mailto:
> autofs-bounces@linux.kernel.org] *On Behalf Of *Issa
> *Sent:* January-02-11 4:53 AM
> *To:* Jesper Juhl
> *Cc:* autofs@linux.kernel.org; linux-kernel@vger.kernel.org; Ian Kent
> *Subject:* [autofs] Autofs SMBFS no write in files
>
>
>
> Hello,
> Autofs acc=E9s smbfs no way to write in smbfs share ?
>
> Autofs smbfs no writing ?
>
> Im usint autofs with ubuntu 10.10
> Im using autofs like this
>
> sudo nano /etc/auto.master
>
> +auto.master
>
> /mnt/smb       /etc/auto.auto   --timeout=3D60 --ghost
>
> et le fichier sudo nano /etc/auto.auto
>
> #directory name         option for mount                                 =
                 device to mount
>
> win1            -fstype=3Dsmbfs,rw,credentials=3D/etc/smb.auth         :/=
/win1/docs/
>
> Authentication files :
> sudo nano /etc/smb.auth
>
> username=3Dusers1
>
> password=3DmotDePasse
>
> domain=3DwindowsDomaine
>
>
>
> now with this i can access only in read
>
> /mnt/smb/win1
>
> My question how add acess to write ?
>
> because i can write for the moment.
>
> thanks
>



--=20
Cordialement
Yassin Chouchane

--0015174c3d4a483df504991de64d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello thanks for u answer, <br><br><br>yes i need to make sudo for write in=
 .<br><br><br><br><br><br><div class=3D"gmail_quote">2011/1/5 Carter, Joel =
<span dir=3D"ltr">&lt;<a href=3D"mailto:JoelC@trailerwizards.com">JoelC@tra=
ilerwizards.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div bgcolor=3D"white" link=3D"blue" vlink=3D"purple" lang=3D"EN-CA"><div><=
p class=3D"MsoNormal"><span style=3D"font-size: 10pt; color: windowtext;">H=
ey there.</span></p><p class=3D"MsoNormal"><span style=3D"font-size: 10pt; =
color: windowtext;">=A0</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; color: windowtext;">=
Who is the owner and what are the permissions of your /mnt/smb/win1 mount p=
oint after autofs kicks in? Can you write to it using root (or using sudo, =
same thing)?</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; color: windowtext;">=
=A0</span></p><p class=3D"MsoNormal"><span style=3D"font-size: 10pt; color:=
 windowtext;">Joel.</span></p><p class=3D"MsoNormal"><span style=3D"font-si=
ze: 10pt; color: windowtext;">=A0</span></p>
<div><div style=3D"border-width: 1pt medium medium; border-style: solid non=
e none; border-color: rgb(181, 196, 223) -moz-use-text-color -moz-use-text-=
color; padding: 3pt 0cm 0cm;"><p class=3D"MsoNormal"><b><span style=3D"font=
-size: 10pt; color: windowtext;" lang=3D"EN-US">From:</span></b><span style=
=3D"font-size: 10pt; color: windowtext;" lang=3D"EN-US"> <a href=3D"mailto:=
autofs-bounces@linux.kernel.org" target=3D"_blank">autofs-bounces@linux.ker=
nel.org</a> [mailto:<a href=3D"mailto:autofs-bounces@linux.kernel.org" targ=
et=3D"_blank">autofs-bounces@linux.kernel.org</a>] <b>On Behalf Of </b>Issa=
<br>
<b>Sent:</b> January-02-11 4:53 AM<br><b>To:</b> Jesper Juhl<br><b>Cc:</b> =
<a href=3D"mailto:autofs@linux.kernel.org" target=3D"_blank">autofs@linux.k=
ernel.org</a>; <a href=3D"mailto:linux-kernel@vger.kernel.org" target=3D"_b=
lank">linux-kernel@vger.kernel.org</a>; Ian Kent<br>
<b>Subject:</b> [autofs] Autofs SMBFS no write in files</span></p></div></d=
iv><div><div></div><div class=3D"h5"><p class=3D"MsoNormal">=A0</p><div><p =
class=3D"MsoNormal" style=3D"margin-bottom: 12pt;">Hello,</p><h3>Autofs acc=
=E9s smbfs no way to write in smbfs share ?</h3>
<p class=3D"MsoNormal">Autofs smbfs no writing ?<br><br>Im usint autofs wit=
h ubuntu 10.10<br>Im using autofs like this</p><p>sudo nano /etc/auto.maste=
r</p><div><pre><code>+auto.master</code></pre><pre><code>/mnt/smb=A0=A0=A0=
=A0=A0=A0 /etc/auto.auto=A0=A0 --timeout=3D60 --ghost</code></pre>
</div><p>et le fichier sudo nano /etc/auto.auto</p><div><pre><code>#directo=
ry name=A0=A0=A0=A0=A0=A0=A0=A0 option for mount=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device to mount</code></pre><=
pre><code>win1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -fstype=3Dsmbfs,rw,credenti=
als=3D/etc/smb.auth=A0=A0=A0=A0=A0=A0=A0=A0 ://win1/docs/</code></pre>
</div><p>Authentication files :<br>sudo nano /etc/smb.auth</p><div><pre><co=
de>username=3Dusers1</code></pre><pre><code>password=3DmotDePasse</code></p=
re><pre><code>domain=3DwindowsDomaine</code></pre></div><pre><code>=A0</cod=
e></pre>
<pre><code>now with this i can access only in read</code></pre><pre><code>/=
mnt/smb/win1</code></pre><p>My question how add acess to write ?</p><p>beca=
use i can write for the moment.</p><p>thanks</p></div></div></div></div>
</div></blockquote></div><br><br clear=3D"all"><br>-- <br>Cordialement<br>Y=
assin Chouchane<br>

--0015174c3d4a483df504991de64d--


--===============2391677513835561161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2391677513835561161==--

