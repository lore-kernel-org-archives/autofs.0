From: Aaron Ogden <aogden@gxt.com>
Subject: autofs 4.1.2 on kernel 2.4.26
Date: Tue, 11 May 2004 07:51:03 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40A0CC37.3080003@gxt.com>
References: <200405101900.i4AJ09pH031586@hera.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76254997271424796=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200405101900.i4AJ09pH031586@hera.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org, raven@themaw.net

This is a multi-part message in MIME format.
--===============76254997271424796==
Content-Type: multipart/alternative;
 boundary="------------020707090602000107010909"

This is a multi-part message in MIME format.
--------------020707090602000107010909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


>------------------------------
>
>Message: 2
>Date: Mon, 10 May 2004 23:02:58 +0800 (WST)
>From: raven@themaw.net
>Subject: Re: [autofs]  automount doesn't expire nested nfs mounts for
>	certain kernel configs
>To: Joseph Mack NA3T <jmack@wm7d.net>
>Cc: autofs@linux.kernel.org
>Message-ID: <Pine.LNX.4.58.0405102301540.28439@donald.themaw.net>
>Content-Type: TEXT/PLAIN; charset=US-ASCII
>
>On Mon, 10 May 2004, Joseph Mack NA3T wrote:
>
>  
>
>>On Mon, 10 May 2004 raven@themaw.net wrote:
>>
>>    
>>
>>>You might like to apply the 4.1.2 patches at the same location you got the
>>>tar.
>>>      
>>>
>>are the 2.4.22 patches OK if I'm using 2.4.26?
>>    
>>
>
>Haven't checked 2.4.26.
>Would like to hear if it applies cleanly.
>
>Ian
>  
>
Yes it is working great over here.  I am running 2.4.26 + trond's 
NFS_ALL + autofs4-20040417.
When I applied the patches there were no offsets or errors.


--------------020707090602000107010909
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid200405101900.i4AJ09pH031586@hera.kernel.org"
 type="cite">
  <pre wrap="">------------------------------

Message: 2
Date: Mon, 10 May 2004 23:02:58 +0800 (WST)
From: <a class="moz-txt-link-abbreviated" href="mailto:raven@themaw.net">raven@themaw.net</a>
Subject: Re: [autofs]  automount doesn't expire nested nfs mounts for
	certain kernel configs
To: Joseph Mack NA3T &lt;<a class="moz-txt-link-abbreviated" href="mailto:jmack@wm7d.net">jmack@wm7d.net</a>&gt;
Cc: <a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
Message-ID: &lt;<a class="moz-txt-link-abbreviated" href="mailto:Pine.LNX.4.58.0405102301540.28439@donald.themaw.net">Pine.LNX.4.58.0405102301540.28439@donald.themaw.net</a>&gt;
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 10 May 2004, Joseph Mack NA3T wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">On Mon, 10 May 2004 <a class="moz-txt-link-abbreviated" href="mailto:raven@themaw.net">raven@themaw.net</a> wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">You might like to apply the 4.1.2 patches at the same location you got the
tar.
      </pre>
    </blockquote>
    <pre wrap="">are the 2.4.22 patches OK if I'm using 2.4.26?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Haven't checked 2.4.26.
Would like to hear if it applies cleanly.

Ian
  </pre>
</blockquote>
Yes it is working great over here.&nbsp; I am running 2.4.26 + trond's
NFS_ALL + autofs4-20040417.<br>
When I applied the patches there were no offsets or errors.<br>
<br>
</body>
</html>

--------------020707090602000107010909--


--===============76254997271424796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============76254997271424796==--

