From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
	servers
Date: Tue, 08 Feb 2011 10:16:31 +0100
Message-ID: <4D5109EF.7040800@s3group.cz>
References: <4D18885D.6010601@s3group.cz> <1293503090.5923.2.camel@perseus>	
	<4D21A19D.3050303@s3group.cz> <1294297764.3010.8.camel@perseus>	
	<4D2581F0.8020607@s3group.cz> <1294322864.2852.3.camel@perseus>	
	<4D27115A.9010805@s3group.cz> <4D496CF9.5040001@s3group.cz>
	<1297137397.10090.4.camel@perseus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4441213863050649588=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1297137397.10090.4.camel@perseus>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============4441213863050649588==
Content-Type: multipart/alternative;
 boundary="------------060308030207000507040407"

This is a multi-part message in MIME format.
--------------060308030207000507040407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Yes, and replied on the 11/01, did you miss it?
>
Ok I must have missed it - now I see you have taken a different approach - you are constructing a single looong string with all ldap uris 
and then you parse them again.
I must say I do not like it too much as:
a) it is wasted effort (merging together and then splitting again)
b) potentially can ldap uri contain spaces I think

But if you like it more, I am fine with it, too.

Regards,
Ondrej


--------------060308030207000507040407
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000066" bgcolor="#ffffff">
    <br>
    <blockquote cite="mid:1297137397.10090.4.camel@perseus" type="cite">
      <pre wrap="">Yes, and replied on the 11/01, did you miss it?

</pre>
    </blockquote>
    Ok I must have missed it - now I see you have taken a different
    approach - you are constructing a single looong string with all ldap
    uris and then you parse them again.<br>
    I must say I do not like it too much as:<br>
    a) it is wasted effort (merging together and then splitting again)<br>
    b) potentially can ldap uri contain spaces I think<br>
    <br>
    But if you like it more, I am fine with it, too.<br>
    <br>
    Regards,<br>
    Ondrej<br>
    <br>
  </body>
</html>

--------------060308030207000507040407--


--===============4441213863050649588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4441213863050649588==--

