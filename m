From: Peter Schmidt <schmidt@pasemi.com>
Subject: Re: Map file search list question
Date: Mon, 17 Nov 2008 09:16:58 -0800
Message-ID: <4921A70A.3000701@pasemi.com>
References: <46171233.15261226615003069.JavaMail.root@postoffice>
	<1226627640.2906.10.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8899010926462334043=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1226627640.2906.10.camel@zeus.themaw.net>
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
To: autofs mailing list <autofs@linux.kernel.org>

--===============8899010926462334043==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Ian Kent wrote:
<blockquote cite="mid:1226627640.2906.10.camel@zeus.themaw.net"
 type="cite">
  <pre wrap="">On Thu, 2008-11-13 at 14:23 -0800, Peter Schmidt wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">(Sorry if this turns up as a double post as I first tried to post from a non list account)

I think what I want is provided by the replicated server feature but I can't get it to work.

I want to search multiple map files that refer to the same mount point.
e.g  in the auto.master file can I do something like:

/home   yp:auto.home1,<a class="moz-txt-link-freetext" href="ldap:nisMapName=auto.home2,ou=mygroup,o=mycompany">ldap:nisMapName=auto.home2,ou=mygroup,o=mycompany</a>

If it can't find the entry in auto.home1 then query auto.home2
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Maybe something like (the old method):
/home   multi: yp:auto.home1 -- <a class="moz-txt-link-freetext" href="ldap:nisMapName=auto.home2,ou=mygroup,o=mycompany">ldap:nisMapName=auto.home2,ou=mygroup,o=mycompany</a>

should do it.

But you should also be able to use:
In /etc/nsswitch.conf
automount: files nis ldap

and in /etc/auto.master:
/home /etc/auto.home

and in /etc/auto.home
+auto.home1
+auto.home2

If entries in your maps are all fully qualified you should be able to
set "automount: files" in /etc/nsswitch and in /etc/auto.home do:
+yp:auto.home1
+ldap:nisMapName=auto.home2,ou=mygroup,o=mycompany

Ian


  </pre>
</blockquote>
Ian, neither of these work.&nbsp;&nbsp; Looks like the first suggestion is
supposed to work with autofs 4 &amp; the second is supported in autofs
5?&nbsp;&nbsp;&nbsp; I'm running rhel4 update 7 which has both autofs 4.1.3-234 &amp;&nbsp;
5.0.1-0.rc2.88 installed.<br>
<br>
Any other suggestions that I could try?<br>
</body>
</html>


--===============8899010926462334043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8899010926462334043==--
