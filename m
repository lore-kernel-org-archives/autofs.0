From: Jonathan Loran <jonathan@loran.name>
Subject: Re: statfs() and autofs
Date: Sun, 20 Jul 2008 22:08:27 -0700
Message-ID: <488419CB.6090108@loran.name>
References: <20080715204839.GU5858@pixar.com>	<1216179794.22783.46.camel@raven.themaw.net>	<487D855B.8000405@loran.name>	<Pine.LNX.4.64.0807201441330.3491@simba.math.ucla.edu>	<20080721034112.GU5858@pixar.com>
	<1216615194.3093.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1989262481602767571=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1216615194.3093.8.camel@raven.themaw.net>
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
--===============1989262481602767571==
Content-Type: multipart/alternative;
 boundary="------------030706080609090100070100"

This is a multi-part message in MIME format.
--------------030706080609090100070100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Ian Kent wrote:
> On Sun, 2008-07-20 at 20:41 -0700, Chris Walker wrote:
>   
>> From jimc [07/20 15:31]:
>>     
>>> Actually, only the sysop knows which is more important: doing the mount 
>>> storm to respond to stat() or statfs(), or avoiding the storm.
>>>       
>> Agreed. In our case, we have 'heavily discouraged' use of /net on our
>> big servers and we would prefer that statfs()/stat() waited for the
>> automount to complete.
>>     
>
> Just to be absolutely clear.
>
> The "browse" or "--ghost option isn't being used, in oder to avoid mount
> storms, but we still see stat(2) and statfs(2) (et. al.) not wait for a
> mount to complete.
>
> Is that right?
> Is anyone in a position to test a kernel patch?
>
>   
I may be willing to try the patch, but first I need to see if I can 
recreate the problem reliably.  If not, there isn't much use.  I just 
know that on our "faster" servers, the programmers I work with have 
demonstrated the issue.  I will need their help.  I'll let know if I 
make head way.  Thanks,

Jon

P.S. Chris, can you reliably demonstrate the not waiting for the mount 
problem?


--------------030706080609090100070100
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
<br>
Ian Kent wrote:
<blockquote cite="mid:1216615194.3093.8.camel@raven.themaw.net"
 type="cite">
  <pre wrap="">On Sun, 2008-07-20 at 20:41 -0700, Chris Walker wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">From jimc [07/20 15:31]:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Actually, only the sysop knows which is more important: doing the mount 
storm to respond to stat() or statfs(), or avoiding the storm.
      </pre>
    </blockquote>
    <pre wrap="">Agreed. In our case, we have 'heavily discouraged' use of /net on our
big servers and we would prefer that statfs()/stat() waited for the
automount to complete.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Just to be absolutely clear.

The "browse" or "--ghost option isn't being used, in oder to avoid mount
storms, but we still see stat(2) and statfs(2) (et. al.) not wait for a
mount to complete.

Is that right?
Is anyone in a position to test a kernel patch?

  </pre>
</blockquote>
I may be willing to try the patch, but first I need to see if I can
recreate the problem reliably.&nbsp; If not, there isn't much use.&nbsp; I just
know that on our "faster" servers, the programmers I work with have
demonstrated the issue.&nbsp; I will need their help.&nbsp; I'll let know if I
make head way.&nbsp; Thanks,<br>
<br>
Jon<br>
<br>
P.S. Chris, can you reliably demonstrate the not waiting for the mount
problem?<br>
<br>
</body>
</html>

--------------030706080609090100070100--


--===============1989262481602767571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1989262481602767571==--

