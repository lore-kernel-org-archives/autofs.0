From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: Can't mount shares ending in $
Date: Wed, 12 Mar 2008 19:17:14 +1100
Message-ID: <47D7918A.1060306@edcint.co.nz>
References: <47D5CD16.5000807@edcint.co.nz>	
	<1205198214.2955.7.camel@raven.themaw.net>
	<47D70295.2000709@edcint.co.nz>
	<1205291655.2949.22.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5039526523465517468=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1205291655.2949.22.camel@raven.themaw.net>
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
--===============5039526523465517468==
Content-Type: multipart/alternative;
	boundary="------------030003050502080007010000"

This is a multi-part message in MIME format.
--------------030003050502080007010000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

So, no it handles mounting with the unescaped $
It seems to be something broken when going from

autofs-5.0.2-16 to autofs-5.0.2-27

which I also imagine will be broken in future releases.

Any ideas?

>> And the answer to your question, back on -27 version, is:
>> With autofs running - no
>> With autofs stopped - no
>> With autofs stopped and when I mkdir /smb/matthew/C$ - yes
>>     
>
> What I'm really after here is to find out whether the cifs mount is
> choking on the unescaped $ in /smb/matthew/C$.
>
>   
>

--------------030003050502080007010000
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
So, no it handles mounting with the unescaped $<br>
It seems to be something broken when going from <br>
<pre wrap="">autofs-5.0.2-16 to autofs-5.0.2-27

which I also imagine will be broken in future releases.

Any ideas?
</pre>
<blockquote cite="mid:1205291655.2949.22.camel@raven.themaw.net"
 type="cite">
  <blockquote type="cite">
    <pre wrap="">And the answer to your question, back on -27 version, is:
With autofs running - no
With autofs stopped - no
With autofs stopped and when I mkdir /smb/matthew/C$ - yes
    </pre>
  </blockquote>
  <pre wrap=""><!---->
What I'm really after here is to find out whether the cifs mount is
choking on the unescaped $ in /smb/matthew/C$.

  </pre>
  <br>
</blockquote>
</body>
</html>

--------------030003050502080007010000--


--===============5039526523465517468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5039526523465517468==--

