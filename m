From: Greg Bradner <gregb@rhythm.com>
Subject: Re: nfs optimization settings in the automounter
Date: Tue, 18 Nov 2003 11:11:34 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FBA6EE6.9010205@rhythm.com>
References: <3FBA5C63.9080402@scout.wisc.edu> <3FBA67F7.1050505@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============69509215323673335=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FBA67F7.1050505@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============69509215323673335==
Content-Type: multipart/alternative;
 boundary="------------000001060503070900000805"

This is a multi-part message in MIME format.
--------------000001060503070900000805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

It's an nfs limitation. Reconfig your server and change this option: 

"include/linux/nfsd/const.h" in the kernel source shows the following
definition

/*
 * Maximum blocksize supported by daemon currently at 8K
 */
#define NFSSVC_MAXBLKSIZE       8192




H. Peter Anvin wrote:

>Justin Rush wrote:
>  
>
>>I am having a hard time telling the automounter to use the options
>>rsize=32768,wsize=32768 when automounting home directories.  I have
>>tried specifying these options in the auto.home file on my nis master
>>server ( -rw,soft,rsize=32768,wsize=32768 nismaster:/export/home/jrush )
>>I have also tried to put them in the localoptions setting in the autofs
>>init file ( localoptions='rsize=32768,wsize=32768' ) on both the nis
>>master and on the client machines.
>>I also tried to specify these options in the auto.master file on the nis
>>master (the client machines don't have auto.master files because they
>>read the nis master's file ) ( /etc/auto.home 
>>--timeout=43200,rsize=32768,wsize=32768 )
>>I have also tried to use lower settings such as 16384
>>
>>however when I look in /proc/mounts on the client machine it is either
>>mounted with 4096 or 8192
>>
>>    
>>
>
>Are you using NFSv3?  As far as I know I think 8192 is max for NFSv2, at
>least for most of the NFSv2 servers I know.
>
>Try doing the mounting without using autofs.  If the same thing happens,
>it's an NFS issue, not an autofs issue.
>
>	-hpa
>
>_______________________________________________
>autofs mailing list
>autofs@linux.kernel.org
>http://linux.kernel.org/mailman/listinfo/autofs
>  
>

-- 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm & Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
gregb@rhythm.com


--------------000001060503070900000805
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<pre wrap="">It's an nfs limitation. Reconfig your server and change this option: 

"include/linux/nfsd/const.h" in the kernel source shows the following
definition

/*
 * Maximum blocksize supported by daemon currently at 8K
 */
#define NFSSVC_MAXBLKSIZE       8192


</pre>
<br>
H. Peter Anvin wrote:<br>
<blockquote type="cite" cite="mid3FBA67F7.1050505@zytor.com">
  <pre wrap="">Justin Rush wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am having a hard time telling the automounter to use the options
rsize=32768,wsize=32768 when automounting home directories.  I have
tried specifying these options in the auto.home file on my nis master
server ( -rw,soft,rsize=32768,wsize=32768 nismaster:/export/home/jrush )
I have also tried to put them in the localoptions setting in the autofs
init file ( localoptions='rsize=32768,wsize=32768' ) on both the nis
master and on the client machines.
I also tried to specify these options in the auto.master file on the nis
master (the client machines don't have auto.master files because they
read the nis master's file ) ( /etc/auto.home 
--timeout=43200,rsize=32768,wsize=32768 )
I have also tried to use lower settings such as 16384

however when I look in /proc/mounts on the client machine it is either
mounted with 4096 or 8192

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Are you using NFSv3?  As far as I know I think 8192 is max for NFSv2, at
least for most of the NFSv2 servers I know.

Try doing the mounting without using autofs.  If the same thing happens,
it's an NFS issue, not an autofs issue.

	-hpa

_______________________________________________
autofs mailing list
<a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
<a class="moz-txt-link-freetext" href="http://linux.kernel.org/mailman/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>
  </pre>
</blockquote>
<br>
<pre class="moz-signature" cols="72">-- 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rhythm &amp; Hues
5404 Jandy Place
Los Angeles, CA 90066
Voice: 310 448-7763
Fax:   310 448-7600
<a class="moz-txt-link-abbreviated" href="mailto:gregb@rhythm.com">gregb@rhythm.com</a>
</pre>
</body>
</html>

--------------000001060503070900000805--


--===============69509215323673335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============69509215323673335==--

