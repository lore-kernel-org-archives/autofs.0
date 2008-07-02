From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: Can't mount shares ending in $
Date: Wed, 02 Jul 2008 17:43:11 +1000
Message-ID: <486B318F.6000109@edcint.co.nz>
References: <47D5CD16.5000807@edcint.co.nz>	
	<1205198214.2955.7.camel@raven.themaw.net>
	<47D70295.2000709@edcint.co.nz>	
	<1205291655.2949.22.camel@raven.themaw.net>
	<47D7918A.1060306@edcint.co.nz>
	<1205310575.2949.23.camel@raven.themaw.net>
	<47D87076.70604@edcint.co.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6859490366982697169=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47D87076.70604@edcint.co.nz>
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
--===============6859490366982697169==
Content-Type: multipart/alternative;
 boundary="------------060409040408040005030101"

This is a multi-part message in MIME format.
--------------060409040408040005030101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I inadvertently "upgraded" to v5.0.2-29 and found that it also has the 
same problem - where the debug logs shows a mount command that works 
manually but not when executed by autofs - maybe the mount points are 
not getting created correctly?

Matthew Jurgens wrote:
> debug for successful mount of C$ share for autofs-5.0.2-16 available at http://www.mmcit.co.nz/autofs-5.0.2-16.debug.zip
>
>   
> Ian Kent wrote:
>> On Wed, 2008-03-12 at 19:17 +1100, Matthew Jurgens wrote:
>>   
>>> So, no it handles mounting with the unescaped $
>>> It seems to be something broken when going from 
>>> autofs-5.0.2-16 to autofs-5.0.2-27
>>>     
>>
>> Any chance of getting a debug log from autofs-5.0.2-16?
>>
>> Ian
>>
>>
>>
>>   

--------------060409040408040005030101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
I inadvertently "upgraded" to v5.0.2-29 and found that it also has the
same problem - where the debug logs shows a mount command that works
manually but not when executed by autofs - maybe the mount points are
not getting created correctly?<br>
<br>
Matthew Jurgens wrote:
<blockquote cite="mid:47D87076.70604@edcint.co.nz" type="cite">
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
  <pre wrap="">debug for successful mount of C$ share for autofs-5.0.2-16 available at <a
 moz-do-not-send="true" class="moz-txt-link-freetext"
 href="http://www.mmcit.co.nz/autofs-5.0.2-16.debug.zip">http://www.mmcit.co.nz/autofs-5.0.2-16.debug.zip</a>

  </pre>
Ian Kent wrote:
  <blockquote cite="mid:1205310575.2949.23.camel@raven.themaw.net"
 type="cite">
    <pre wrap="">On Wed, 2008-03-12 at 19:17 +1100, Matthew Jurgens wrote:
  </pre>
    <blockquote type="cite">
      <pre wrap="">So, no it handles mounting with the unescaped $
It seems to be something broken when going from 
autofs-5.0.2-16 to autofs-5.0.2-27
    </pre>
    </blockquote>
    <pre wrap=""><!---->
Any chance of getting a debug log from autofs-5.0.2-16?

Ian



  </pre>
  </blockquote>
</blockquote>
</body>
</html>

--------------060409040408040005030101--


--===============6859490366982697169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6859490366982697169==--

