From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: Can't mount shares ending in $
Date: Wed, 12 Mar 2008 09:07:17 +1100
Message-ID: <47D70295.2000709@edcint.co.nz>
References: <47D5CD16.5000807@edcint.co.nz>
	<1205198214.2955.7.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6178210580659723631=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1205198214.2955.7.camel@raven.themaw.net>
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
--===============6178210580659723631==
Content-Type: multipart/alternative;
	boundary="------------020804020503010101050902"

This is a multi-part message in MIME format.
--------------020804020503010101050902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ian

For some reason, most of the messages I post to the list never show up - 
no idea why - so this time I am putting you on the receipt list as well 
- my reply is below. Thanks for you work on this product.



Before you sent this I installed the original Fedora 8 release of autofs 
(autofs-5.0.2-16).
I had originally yum upgraded to Fedora 8 and so had been running on the 
latest version autofs-5.0.2-27.
I have found that autofs-5.0.2-16 works fine, but going to -27 breaks it.

And the answer to your question, back on -27 version, is:
With autofs running - no
With autofs stopped - no
With autofs stopped and when I mkdir /smb/matthew/C$ - yes

Ian Kent wrote:
> On Tue, 2008-03-11 at 11:06 +1100, Matthew Jurgens wrote:
>   
>>  From the debug info, the mount command that fails is:
>> mount -t cifs -s -o username=USER,password=PASSWORD //matthew/C\$ /smb/matthew/C$
>>     
>
> Does this command work if you run it manually?
>
> Ian
>
>
>
>   

--------------020804020503010101050902
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Ian<br>
<br>
For some reason, most of the messages I post to the list never show up
- no idea why - so this time I am putting you on the receipt list as
well - my reply is below. Thanks for you work on this product.<br>
<br>
<br>
<br>
Before you sent this I installed the original Fedora 8 release of
autofs (autofs-5.0.2-16).<br>
I had originally yum upgraded to Fedora 8 and so had been running on
the latest version autofs-5.0.2-27.<br>
I have found that autofs-5.0.2-16 works fine, but going to -27 breaks
it.<br>
<br>
And the answer to your question, back on -27 version, is:<br>
With autofs running - no<br>
With autofs stopped - no<br>
With autofs stopped and when I mkdir /smb/matthew/C$ - yes<br>
<br>
Ian Kent wrote:
<blockquote cite="mid:1205198214.2955.7.camel@raven.themaw.net"
 type="cite">
  <pre wrap="">On Tue, 2008-03-11 at 11:06 +1100, Matthew Jurgens wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap=""> From the debug info, the mount command that fails is:
mount -t cifs -s -o username=USER,password=PASSWORD //matthew/C\$ /smb/matthew/C$
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Does this command work if you run it manually?

Ian



  </pre>
</blockquote>
</body>
</html>

--------------020804020503010101050902--


--===============6178210580659723631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6178210580659723631==--

