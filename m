From: Jonathan Loran <jonathan@loran.name>
Subject: Re: autofs and terminal networks woes.
Date: Thu, 17 Feb 2005 08:09:55 -0800
Message-ID: <4214C1D3.8080107@loran.name>
References: <215ff441050217023378003e72@mail.gmail.com>	<Pine.LNX.4.61.0502172136030.1683@donald.themaw.net>	<215ff441050217060647db41dc@mail.gmail.com>	<Pine.LNX.4.61.0502172203440.1683@donald.themaw.net>
	<215ff441050217071517292c1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0868536618=="
In-Reply-To: <215ff441050217071517292c1a@mail.gmail.com>
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============0868536618==
Content-Type: multipart/alternative;
	boundary="------------070005010400000507050909"

This is a multi-part message in MIME format.
--------------070005010400000507050909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Chris, Ian,

I don't chime in here very often, and I know this is now more or less 
working, but the obvious question to me is, since both the thin client 
and server are running Linux/Unix, why not use the more native NFS?  
Perhaps I'm missing something obvious.

Jon

Chris Fanning wrote:

>ok. downloaded, compiled and installed.
>This works great!
>
>Thankyou.
>Chris.
>
>
>
>On Thu, 17 Feb 2005 22:10:58 +0800 (WST), raven@themaw.net
><raven@themaw.net> wrote:
>  
>
>>On Thu, 17 Feb 2005, Chris Fanning wrote:
>>
>>    
>>
>>>Hi Ian,
>>>
>>>      
>>>
>>>>Versions?
>>>>
>>>>        
>>>>
>>>4.1.3-9
>>>
>>>      
>>>
>>>>Perhaps you need to use ://thinclient_ip/fd
>>>>        
>>>>
>>>So, do you suggest I upgrade?
>>>      
>>>
>>Only if you can solve the problems you face. Certainly not without plenty
>>of testing.
>>
>>    
>>
>>>When might 4.1.4 be available for debian testing?
>>>      
>>>
>>I guess that will depend on the Debian folks.
>>I'm hoping they will push 4.1.4 into the Debian tree fairly soon after it
>>is released. I've tried to get as many fixes into the new version as I could.
>>
>>    
>>
>>>Should I download the source instead?
>>>      
>>>
>>If you wish to test this out you can download
>>autofs-4.1.4_beta2-deb.tar.gz which basically contains the files of a
>>source deb.
>>
>>As i've said before, this is for testing only as I'm not the maintainer of
>>the Debian package.
>>
>>If you do try this make sure you stop autofs before installing the deb.
>>
>>Ian
>>
>>
>>    
>>
>
>_______________________________________________
>autofs mailing list
>autofs@linux.kernel.org
>http://linux.kernel.org/mailman/listinfo/autofs
>  
>

--------------070005010400000507050909
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
Chris, Ian,<br>
<br>
I don't chime in here very often, and I know this is now more or less
working, but the obvious question to me is, since both the thin client
and server are running Linux/Unix, why not use the more native NFS?&nbsp;
Perhaps I'm missing something obvious.<br>
<br>
Jon<br>
<br>
Chris Fanning wrote:
<blockquote cite="mid215ff441050217071517292c1a@mail.gmail.com"
 type="cite">
  <pre wrap="">ok. downloaded, compiled and installed.
This works great!

Thankyou.
Chris.



On Thu, 17 Feb 2005 22:10:58 +0800 (WST), <a class="moz-txt-link-abbreviated" href="mailto:raven@themaw.net">raven@themaw.net</a>
<a class="moz-txt-link-rfc2396E" href="mailto:raven@themaw.net">&lt;raven@themaw.net&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Thu, 17 Feb 2005, Chris Fanning wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">Hi Ian,

      </pre>
      <blockquote type="cite">
        <pre wrap="">Versions?

        </pre>
      </blockquote>
      <pre wrap="">4.1.3-9

      </pre>
      <blockquote type="cite">
        <pre wrap="">Perhaps you need to use ://thinclient_ip/fd
        </pre>
      </blockquote>
      <pre wrap="">So, do you suggest I upgrade?
      </pre>
    </blockquote>
    <pre wrap="">Only if you can solve the problems you face. Certainly not without plenty
of testing.

    </pre>
    <blockquote type="cite">
      <pre wrap="">When might 4.1.4 be available for debian testing?
      </pre>
    </blockquote>
    <pre wrap="">I guess that will depend on the Debian folks.
I'm hoping they will push 4.1.4 into the Debian tree fairly soon after it
is released. I've tried to get as many fixes into the new version as I could.

    </pre>
    <blockquote type="cite">
      <pre wrap="">Should I download the source instead?
      </pre>
    </blockquote>
    <pre wrap="">If you wish to test this out you can download
autofs-4.1.4_beta2-deb.tar.gz which basically contains the files of a
source deb.

As i've said before, this is for testing only as I'm not the maintainer of
the Debian package.

If you do try this make sure you stop autofs before installing the deb.

Ian


    </pre>
  </blockquote>
  <pre wrap=""><!---->
_______________________________________________
autofs mailing list
<a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
<a class="moz-txt-link-freetext" href="http://linux.kernel.org/mailman/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>
  </pre>
</blockquote>
</body>
</html>

--------------070005010400000507050909--


--===============0868536618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0868536618==--

