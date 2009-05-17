From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: unable to automount windows C$
Date: Sun, 17 May 2009 17:48:38 +1000
Message-ID: <4A0FC156.10108@edcint.co.nz>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz> <4A0B808C.2030705@themaw.net>
	<4A0CC262.7020105@edcint.co.nz> <4A0D1630.3040407@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6085400582586321094=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0D1630.3040407@themaw.net>
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
To: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============6085400582586321094==
Content-Type: multipart/alternative;
 boundary="------------030604050604000204040304"

This is a multi-part message in MIME format.
--------------030604050604000204040304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>
>> Script updated and gsub commented out (like a message earlier in the
>> thread):
>> -fstype=cifs,username=USER,password=PASS \
>>         "/C" "://xp0/C" \
>>         "/ADMIN$" "://xp0/ADMIN$" \
>>         "/C$" "://xp0/C$"
>>
>> cd /smb/xp0/C$  gives
>> cd: no such file or directory: /smb/xp0/C$
>>
>> something is really busted now since I can't even cd /smb/xp0/C either.
>> I don't understand why the debug log contains what looks like parts of
>> the script as the output since running the script manually seems to have
>> perfectly clean output
>>     
>
> Because the script file is not executable now it is treating it as a
> file map not a program map.

Not sure how you come to that conclusion since I ran it above to get the 
output and it is
-rwxr-xr-x



-- 
Smartmon System Monitoring <http://www.smartmon.com.au>
www.smartmon.com.au

--------------030604050604000204040304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<blockquote cite="mid:4A0D1630.3040407@themaw.net" type="cite">
  <blockquote type="cite">
    <pre wrap="">Script updated and gsub commented out (like a message earlier in the
thread):
-fstype=cifs,username=USER,password=PASS \
        "/C" "://xp0/C" \
        "/ADMIN$" "://xp0/ADMIN$" \
        "/C$" "://xp0/C$"

cd /smb/xp0/C$  gives
cd: no such file or directory: /smb/xp0/C$

something is really busted now since I can't even cd /smb/xp0/C either.
I don't understand why the debug log contains what looks like parts of
the script as the output since running the script manually seems to have
perfectly clean output
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Because the script file is not executable now it is treating it as a
file map not a program map.</pre>
</blockquote>
<br>
Not sure how you come to that conclusion since I ran it above to get
the output and it is <br>
-rwxr-xr-x<br>
<br>
<br>
<br>
<div class="moz-signature">-- <br>
<font size="2"><font face="Verdana">
<a href="http://www.smartmon.com.au">Smartmon System Monitoring</a><br>
<a class="moz-txt-link-abbreviated" href="http://www.smartmon.com.au">www.smartmon.com.au</a>
</font></font></div>
</body>
</html>

--------------030604050604000204040304--


--===============6085400582586321094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6085400582586321094==--

