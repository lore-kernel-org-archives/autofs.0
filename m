From: Issa <frechdesign@gmail.com>
Subject: Autofs SMBFS no write in files
Date: Sun, 02 Jan 2011 13:52:48 +0100
Message-ID: <4D207520.60200@gmail.Com>
References: <alpine.LNX.2.00.1012182238560.17400@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6474995512047325843=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:message-id:date:from
	:user-agent:mime-version:to:cc:subject:references:in-reply-to
	:content-type; bh=/DtXVchGgdhdrDaWSqnHrLV7cFGot2bJp1WE6rHF0FE=;
	b=kwazl9/EUErQRLn3SkiHtqz6PwfSSOocxiD+x6sy1w6bmoNVimE11CB+CuDYU/cqBR
	Aw4bB5OYXSRj3oG1lDkNZo+wrSKZYJs/jpatwIbqTcCOsC7RwRMsSAitlDIb0Yo79CnB
	6dOQs5WZkkOWrSmF0zi6Ir4o0q+vS+DBAPml0=
In-Reply-To: <alpine.LNX.2.00.1012182238560.17400@swampdragon.chaosbits.net>
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
To: Jesper Juhl <jj@chaosbits.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

This is a multi-part message in MIME format.
--===============6474995512047325843==
Content-Type: multipart/alternative;
 boundary="------------030805030802090201070203"

This is a multi-part message in MIME format.
--------------030805030802090201070203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id p0574LiB003686

Hello,


      Autofs acc=E9s smbfs no way to write in smbfs share ?

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


--------------030805030802090201070203
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <div class="moz-text-html" lang="x-western"> Hello,<br>
      <br>
      <h3>Autofs acc&eacute;s smbfs no way to write in smbfs share ?</h3>
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
    </div>
  </body>
</html>

--------------030805030802090201070203--


--===============6474995512047325843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6474995512047325843==--

