From: Issa <frechdesign@gmail.com>
Subject: Autofs SMBFS no write in files
Date: Tue, 28 Dec 2010 19:51:30 +0100
Message-ID: <4D1A31B2.4000103@gmail.Com>
References: <alpine.LNX.2.00.1012122357570.9206@swampdragon.chaosbits.net>	<1292382195.2979.17.camel@perseus>
	<alpine.LNX.2.00.1012171306310.4638@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3017885952585749916=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from
	:user-agent:mime-version:cc:subject:references:in-reply-to
	:content-type; bh=4w57jOFgITeloCXJ2BL3TruLpnL4dfyCNWR1/hRS1x0=;
	b=Mq4ITBVLWpKeApb9vElE2egO8XE02xjAx4F9DXj0w7UuhJYaQnJlQXoTwZ8H+BhNkL
	am6yLCQMbt5bDwL0AC3M9dU2fTRDZWkQmtoYP8DETqBMvUOceXQI0st2A6ounkFqr3ge
	XteoPMwC6VYkAysGMlunBWPdeJ1hqe4Aw28wo=
In-Reply-To: <alpine.LNX.2.00.1012171306310.4638@swampdragon.chaosbits.net>
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
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--===============3017885952585749916==
Content-Type: multipart/alternative;
 boundary="------------050606070405040604080409"

This is a multi-part message in MIME format.
--------------050606070405040604080409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id p0573A2C003370

Hello,


      Autofs acc=E9s smbfs impossible d'=E9crire sur le disque ?

Autofs smbfs no writing ?

Im usint autofs with ubuntu 10.10
Im using autofs like this

sudo nano /etc/auto.master

|+auto.master
/mnt/smb       /etc/auto.auto   --timeout=3D60 --ghost|

et le fichier sudo nano /etc/auto.auto

|#directory name         option for mount                                =
                  device to mount
win1            -fstype=3Dsmbfs,rw,credentials=3D/etc/smb.auth         :/=
/win1/docs/|

Authentication files :
sudo nano /etc/smb.auth

|username=3Dusers1
password=3DmotDePasse
domain=3DwindowsDomaine|

|
now with this i can access only in read
/mnt/smb/win1|

My question how add acess to write ?

because i can write for the moment.

thanks


--------------050606070405040604080409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    Hello,<br>
    <br>
    <h3>Autofs acc&eacute;s smbfs impossible d'&eacute;crire sur le disque ?</h3>
    Autofs smbfs no writing ?<br>
    <br>
    Im usint autofs with ubuntu 10.10<br>
    Im using autofs like this<br>
    <p>sudo nano /etc/auto.master<br>
    </p>
    <div class="codebox">
      <pre><code>+auto.master
/mnt/smb       /etc/auto.auto   --timeout=60 --ghost</code></pre>
    </div>
    <p>et le fichier sudo nano /etc/auto.auto<br>
    </p>
    <div class="codebox">
      <pre><code>#directory name         option for mount                                                  device to mount
win1            -fstype=smbfs,rw,credentials=/etc/smb.auth         ://win1/docs/</code></pre>
    </div>
    <p>Authentication files :<br>
      sudo nano /etc/smb.auth<br>
    </p>
    <div class="codebox">
      <pre><code>username=users1
password=motDePasse
domain=windowsDomaine</code></pre>
    </div>
    <pre><code>
now with this i can access only in read
/mnt/smb/win1</code></pre>
    <p>My question how add acess to write ?<br>
    </p>
    <p>because i can write for the moment.<br>
    </p>
    <p>thanks<br>
    </p>
  </body>
</html>

--------------050606070405040604080409--


--===============3017885952585749916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3017885952585749916==--

