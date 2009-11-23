From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Resolved autofs + AD DIGEST-MD5 integration issue
Date: Mon, 23 Nov 2009 11:06:39 +0100
Message-ID: <4B0A5EAF.5090609@s3group.cz>
References: <660637.19535.qm@web110601.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3222505829273593746=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <660637.19535.qm@web110601.mail.gq1.yahoo.com>
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
To: Cove Schneider <cove_s@yahoo.com>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============3222505829273593746==
Content-Type: multipart/alternative;
 boundary="------------050507020105050209080603"

This is a multi-part message in MIME format.
--------------050507020105050209080603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Note:
Maybe it works in Win2008 R2 but it is definitely not working in Win2008 
- the patch below is needed.
Anyway autofs binding to AD using GSSAPI works fine with all Win servers 
I know about (and it is better than DIGEST-MD5, I believe).
Ondrej

Cove Schneider wrote:
> Autofs not being able to bind to AD using DIGEST-MD5 will be resolved 
> in Windows 2008 onward. This was due to AD accidentally indicating it 
> supported subsequent authentication when it didn't.
>
> Hot fix:
> http://support.microsoft.com/kb/975697
>
> Original issue:
> http://linux.kernel.org/pipermail/autofs/2009-January/005527.html
>
> Cove
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>   


--------------050507020105050209080603
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000066">
Note:<br>
Maybe it works in Win2008 R2 but it is definitely not working in
Win2008 - the patch below is needed.<br>
Anyway autofs binding to AD using GSSAPI works fine with all Win
servers I know about (and it is better than DIGEST-MD5, I believe).<br>
Ondrej<br>
<br>
Cove Schneider wrote:
<blockquote cite="mid:660637.19535.qm@web110601.mail.gq1.yahoo.com"
 type="cite">
  <style type="text/css"><!-- DIV {margin:0px;} --></style>
  <div
 style="font-family: times new roman,new york,times,serif; font-size: 12pt;">
  <div>
  <div style="">Autofs not being able to bind to AD using DIGEST-MD5
will be resolved in Windows 2008 onward. This was due to AD
accidentally indicating it supported subsequent authentication when it
didn't.<br>
  <span style="background-color: white;" lang="en-US"><font
 color="black" face="Tahoma" size="1"><span style="font-size: 13px;"
 dir="ltr"><br>
Hot fix:<br>
  <span><a moz-do-not-send="true" target="_blank"
 href="http://support.microsoft.com/kb/975697">http://support.microsoft.com/kb/975697</a></span><br>
  <br>
  </span></font></span>Original issue:<br>
  <span><a moz-do-not-send="true" target="_blank"
 href="http://linux.kernel.org/pipermail/autofs/2009-January/005527.html">http://linux.kernel.org/pipermail/autofs/2009-January/005527.html</a></span><br>
  <br>
Cove<br>
  </div>
  </div>
<!-- cg39.c4.mail.gq1.yahoo.com compressed/chunked Fri Nov 20 12:47:52 PST 2009 -->
  </div>
  <br>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
autofs mailing list
<a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
<a class="moz-txt-link-freetext" href="http://linux.kernel.org/mailman/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------050507020105050209080603--


--===============3222505829273593746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3222505829273593746==--

