From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: unable to automount windows C$
Date: Thu, 11 Jun 2009 22:13:37 +1000
Message-ID: <4A30F4F1.9000909@edcint.co.nz>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz> <4A0B808C.2030705@themaw.net>
	<4A2E2CD7.20905@edcint.co.nz> <4A30A2FB.5050005@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2411721542915564360=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A30A2FB.5050005@themaw.net>
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
--===============2411721542915564360==
Content-Type: multipart/alternative;
 boundary="------------000105050303060503000809"

This is a multi-part message in MIME format.
--------------000105050303060503000809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>> # optional authentication information
>> # either set it here or pass it in via the environment
>> # SMB_USER=
>> # SMB_PASSWORD
>>     
>
> I don't think that embedding password information in a distributed
> example program map is the right thing to do. People need to work out
> how they will access authentication information for themselves and
> modify the example program map to suite.
>
> Also, I don't understand how this can be set in the environment. If it
> is set in the daemon environment, typically root, and used for every
> mount then I don't think that is a good example of usage to distribute
> either.
>   
This is just how I do it and thought it might help others who are 
perhaps wondering how to do it
I did miss out one line - which is what you are puzzling over.
I include another script which contains SMB_USER and SMB_PASSWORD into 
the environment
I have the line
. /etc/my_user_info
in my version of the script
-- 
Smartmon System Monitoring <http://www.smartmon.com.au>
www.smartmon.com.au

--------------000105050303060503000809
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid:4A30A2FB.5050005@themaw.net" type="cite">
  <blockquote type="cite">
    <pre wrap="">
# optional authentication information
# either set it here or pass it in via the environment
# SMB_USER=
# SMB_PASSWORD
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I don't think that embedding password information in a distributed
example program map is the right thing to do. People need to work out
how they will access authentication information for themselves and
modify the example program map to suite.

Also, I don't understand how this can be set in the environment. If it
is set in the daemon environment, typically root, and used for every
mount then I don't think that is a good example of usage to distribute
either.
  </pre>
</blockquote>
This is just how I do it and thought it might help others who are
perhaps wondering how to do it<br>
I did miss out one line - which is what you are puzzling over.<br>
I include another script which contains SMB_USER and SMB_PASSWORD into
the environment<br>
I have the line<br>
. /etc/my_user_info<br>
in my version of the script<br>
<div class="moz-signature">-- <br>
<font size="2"><font face="Verdana">
<a href="http://www.smartmon.com.au">Smartmon System Monitoring</a><br>
<a class="moz-txt-link-abbreviated" href="http://www.smartmon.com.au">www.smartmon.com.au</a>
</font></font></div>
</body>
</html>

--------------000105050303060503000809--


--===============2411721542915564360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2411721542915564360==--

