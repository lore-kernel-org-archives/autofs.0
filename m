From: Cove Schneider <cove_s@yahoo.com>
Subject: Re: Resolved autofs + AD DIGEST-MD5 integration issue
Date: Fri, 27 Nov 2009 12:26:15 -0800 (PST)
Message-ID: <806389.37406.qm@web110611.mail.gq1.yahoo.com>
References: <660637.19535.qm@web110601.mail.gq1.yahoo.com>
	<4B0A5EAF.5090609@s3group.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1441398776831059318=="
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1259353575; bh=JowrP1xXEL//DYpWOxmx4Zhg9jw+RBOfuaPALf8FDu4=;
	h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
	b=p0Qrp+C76zbezfF/j/Aqhahywnm1yjcsu/5/9uTAU6TMjJwDf+/4Q4dMsdWtwCYKNKM2FunVzhJ6PRa6olA8DCptqneBCTntT+xg7VY3dqG+oEcdLL+IjX36HAJFB3+T9vg57M8HEV54yrRthgwYCKF3foAmP1AeYj4AwhUc+jo=
In-Reply-To: <4B0A5EAF.5090609@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

--===============1441398776831059318==
Content-Type: multipart/alternative; boundary="0-1631527407-1259353575=:37406"

--0-1631527407-1259353575=:37406
Content-Type: text/plain; charset=us-ascii

The patch will be rolled into the mainline at the next hotfix cycle, which I'm told is Dec 2009.

Yeah, GSSAPI is good, we just happen to have some situations where DIGEST-MD5 turned out to be a better fit.

Cove


________________________________
From: Ondrej Valousek <webserv@s3group.cz>
To: Cove Schneider <cove_s@yahoo.com>
Cc: autofs@linux.kernel.org
Sent: Mon, November 23, 2009 2:06:39 AM
Subject: Re: [autofs] Resolved autofs + AD DIGEST-MD5 integration issue

Note:
Maybe it works in Win2008 R2 but it is definitely not working in
Win2008 - the patch below is needed.
Anyway autofs binding to AD using GSSAPI works fine with all Win
servers I know about (and it is better than DIGEST-MD5, I believe).
Ondrej

Cove Schneider wrote: 
> 
>Autofs not being able to bind to AD using DIGEST-MD5
>will be resolved in Windows 2008 onward. This was due to AD
>accidentally indicating it supported subsequent authentication when it
>didn't.
>
>>Hot fix:
>http://support.microsoft.com/kb/975697
>
>Original issue:
>http://linux.kernel.org/pipermail/autofs/2009-January/005527.html
>
>>Cove
>
>
>
________________________________

>_______________________________________________
>autofs mailing list
>autofs@linux.kernel.org http://linux.kernel.org/mailman/listinfo/autofs 



      
--0-1631527407-1259353575=:37406
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:'times new roman', 'new york', times, serif;font-size:12pt"><div>The patch will be rolled into the mainline at the next hotfix cycle, which I'm told is Dec 2009.</div><div><br></div><div>Yeah, GSSAPI is good, we just happen to have some situations where DIGEST-MD5&nbsp;turned out to be a better fit.</div><div><br></div><div>Cove</div><div><br></div><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><font size="2" face="Tahoma"><hr size="1"><b><span style="font-weight: bold;">From:</span></b> Ondrej Valousek &lt;webserv@s3group.cz&gt;<br><b><span style="font-weight: bold;">To:</s
 pan></b> Cove Schneider &lt;cove_s@yahoo.com&gt;<br><b><span style="font-weight: bold;">Cc:</span></b> autofs@linux.kernel.org<br><b><span style="font-weight:
 bold;">Sent:</span></b> Mon, November 23, 2009 2:06:39 AM<br><b><span style="font-weight: bold;">Subject:</span></b> Re: [autofs] Resolved autofs + AD DIGEST-MD5 integration issue<br></font><br>



  


Note:<br>
Maybe it works in Win2008 R2 but it is definitely not working in
Win2008 - the patch below is needed.<br>
Anyway autofs binding to AD using GSSAPI works fine with all Win
servers I know about (and it is better than DIGEST-MD5, I believe).<br>
Ondrej<br>
<br>
Cove Schneider wrote:
<blockquote type="cite">
  
  <div style="font-family:times new roman, new york, times, serif;font-size:12pt;">
  <div>
  <div style="">Autofs not being able to bind to AD using DIGEST-MD5
will be resolved in Windows 2008 onward. This was due to AD
accidentally indicating it supported subsequent authentication when it
didn't.<br>
  <span style="background-color:white;" lang="en-US"><font color="black" face="Tahoma" size="1"><span style="font-size:13px;" dir="ltr"><br>
Hot fix:<br>
  <span><span><a target="_blank" href="http://support.microsoft.com/kb/975697">http://support.microsoft.com/kb/975697</a></span></span><br>
  <br>
  </span></font></span>Original issue:<br>
  <span><span><a target="_blank" href="http://linux.kernel.org/pipermail/autofs/2009-January/005527.html">http://linux.kernel.org/pipermail/autofs/2009-January/005527.html</a></span></span><br>
  <br>
Cove<br>
  </div>
  </div>

  </div>
  <br>
  <pre><hr size="4" width="90%">
_______________________________________________
autofs mailing list
<a rel="nofollow" class="moz-txt-link-abbreviated" ymailto="mailto:autofs@linux.kernel.org" target="_blank" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a><span>
<a target="_blank" href="http://linux.kernel.org/mailman/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>
  </span></pre>
</blockquote>
<br>


</div></div><div style="position:fixed"></div>


<!-- cg6.c4.mail.gq1.yahoo.com compressed/chunked Thu Nov 26 22:56:59 PST 2009 -->
</div><br>

      </body></html>
--0-1631527407-1259353575=:37406--


--===============1441398776831059318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1441398776831059318==--

