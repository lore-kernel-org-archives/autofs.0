From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: unable to automount windows C$
Date: Thu, 04 Jun 2009 10:15:20 +1000
Message-ID: <4A271218.3030300@edcint.co.nz>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2139885692096462334=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A250A66.4070206@themaw.net>
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
--===============2139885692096462334==
Content-Type: multipart/alternative;
 boundary="------------060508010906010705030402"

This is a multi-part message in MIME format.
--------------060508010906010705030402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>> Sorry I must be missing something.
>> You say autofs is now treating the script as a file since it is not
>> executable but it is executable.
>> I don't quite understand the "if (st.st_mode & __S_IEXEC)" part of the
>> code above.
>>     
>
> All I'm saying is that, for whatever reason, autofs is treating your
> program map as a file map. Why I don't know.
>
> The check (st.st_mode & __S_IEXEC) checks if the mode returned by the
> stat(2) of the path in ap->argv[0] is executable by the owner of the file.
>
> Ian
>
>   
Can you please then just explain what

"if (st.st_mode & __S_IEXEC)" is testing for?


-- 
Smartmon System Monitoring <http://www.smartmon.com.au>
www.smartmon.com.au

--------------060508010906010705030402
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid:4A250A66.4070206@themaw.net" type="cite">
  <blockquote type="cite">
    <pre wrap="">Sorry I must be missing something.
You say autofs is now treating the script as a file since it is not
executable but it is executable.
I don't quite understand the "if (st.st_mode &amp; __S_IEXEC)" part of the
code above.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
All I'm saying is that, for whatever reason, autofs is treating your
program map as a file map. Why I don't know.

The check (st.st_mode &amp; __S_IEXEC) checks if the mode returned by the
stat(2) of the path in ap-&gt;argv[0] is executable by the owner of the file.

Ian

  </pre>
</blockquote>
Can you please then just explain what <br>
<pre wrap="">"if (st.st_mode &amp; __S_IEXEC)" is testing for?</pre>
<br>
<div class="moz-signature">-- <br>
<font size="2"><font face="Verdana">
<a href="http://www.smartmon.com.au">Smartmon System Monitoring</a><br>
<a class="moz-txt-link-abbreviated" href="http://www.smartmon.com.au">www.smartmon.com.au</a>
</font></font></div>
</body>
</html>

--------------060508010906010705030402--


--===============2139885692096462334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2139885692096462334==--

