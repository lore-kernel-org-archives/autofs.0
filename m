From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: unable to automount windows C$
Date: Tue, 09 Jun 2009 18:03:07 +1000
Message-ID: <4A2E173B.8030606@edcint.co.nz>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz> <4A0B808C.2030705@themaw.net>
	<4A0CC262.7020105@edcint.co.nz> <4A0D1630.3040407@themaw.net>
	<4A0FC156.10108@edcint.co.nz> <4A10BC5B.7010402@themaw.net>
	<4A24BC60.1020404@edcint.co.nz> <4A250A66.4070206@themaw.net>
	<4A271218.3030300@edcint.co.nz> <4A274C69.4090202@themaw.net>
	<4A2DADEA.3010406@edcint.co.nz> <4A2DD535.3060709@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8828118801540605064=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A2DD535.3060709@themaw.net>
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

This is a multi-part message in MIME format.
--===============8828118801540605064==
Content-Type: multipart/alternative;
 boundary="------------030100020700070200040408"

This is a multi-part message in MIME format.
--------------030100020700070200040408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> What does the master map entry for this look like?
> If you have "file:" in front of the map path that will force autofs to
> treat it as a file map.
>
> Ian
>
>   
I found that the auto.master had a file: in front of the /smb entry - 
then I read this (would have saved me some time!)
Now lets stop this part of the thread and I will resume from an earlier 
point

-- 
Smartmon System Monitoring <http://www.smartmon.com.au>
www.smartmon.com.au

--------------030100020700070200040408
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid:4A2DD535.3060709@themaw.net" type="cite">
  <pre wrap="">What does the master map entry for this look like?
If you have "file:" in front of the map path that will force autofs to
treat it as a file map.

Ian

  </pre>
</blockquote>
I found that the auto.master had a file: in front of the /smb entry -
then I read this (would have saved me some time!)<br>
Now lets stop this part of the thread and I will resume from an earlier
point<br>
<br>
<div class="moz-signature">-- <br>
<font size="2"><font face="Verdana">
<a href="http://www.smartmon.com.au">Smartmon System Monitoring</a><br>
<a class="moz-txt-link-abbreviated" href="http://www.smartmon.com.au">www.smartmon.com.au</a>
</font></font></div>
</body>
</html>

--------------030100020700070200040408--


--===============8828118801540605064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8828118801540605064==--

