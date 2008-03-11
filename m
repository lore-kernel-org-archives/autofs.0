From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: Can't mount shares ending in $
Date: Tue, 11 Mar 2008 16:21:22 +1100
Message-ID: <47D616D2.2070008@edcint.co.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3183768834810601824=="
Return-path: <autofs-bounces@linux.kernel.org>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

This is a multi-part message in MIME format.
--===============3183768834810601824==
Content-Type: multipart/alternative;
	boundary="------------090302070401050204020904"

This is a multi-part message in MIME format.
--------------090302070401050204020904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Before you sent this I installed the original Fedora 8 release of autofs 
(autofs-5.0.2-16).
I had originally yum upgraded to Fedora 8 and so had installed the 
latest version autofs-5.0.2-27.
I have found that autofs-5.0.2-16 works fine, but going to -27 breaks it.

And the answer to your question is:
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

--------------090302070401050204020904
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
Before you sent this I installed the original Fedora 8 release of
autofs (autofs-5.0.2-16).<br>
I had originally yum upgraded to Fedora 8 and so had installed the
latest version autofs-5.0.2-27.<br>
I have found that autofs-5.0.2-16 works fine, but going to -27 breaks
it.<br>
<br>
And the answer to your question is:<br>
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

--------------090302070401050204020904--


--===============3183768834810601824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3183768834810601824==--

