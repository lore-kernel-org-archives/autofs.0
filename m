From: Greg Bradner <gregb@rhythm.com>
Subject: Re: autofs v4
Date: Fri, 24 Oct 2003 13:48:12 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F99900C.7080702@rhythm.com>
References: <Pine.LNX.4.44.0310242114250.2980-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============043566449823244202=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310242114250.2980-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============043566449823244202==
Content-Type: multipart/alternative;
 boundary="------------080903040200060800020508"

This is a multi-part message in MIME format.
--------------080903040200060800020508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I noticed what was going on after I sent the message. My program is 
outputing the wrong information.
Thanks.

Ian Kent wrote:

>On Thu, 23 Oct 2003, Greg Bradner wrote:
>
>Can you post the script or the output of it along with the imputs used 
>please.
>
>  
>
>>It is not making the mount  points for program mounts. Any ideas?
>>
>>This is from /etc/auto_maps/autofs_host_mount.pl, my program for program 
>>mounts.
>>PARGS /usr/sbin/automount --timeout 60 /n program 
>>/etc/auto_maps/autofs_host_mount.pl vers=2,mountvers=2 
>>rsize=32768,wsize=32768
>>TEST = --timeout
>>TEST = 60
>>TEST = /n
>>BASEDIR = /n (2)
>>MOUNT OPTS: -o  vers=2,mountvers=2,rsize=32768,wsize=32768
>>am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/etc 
>>/n/linn/etc
>>am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/usr 
>>/n/linn/usr
>>am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/local/b 
>>/n/linn/local/b
>>am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/local/a 
>>/n/linn/local/a
>>/n/linn
>>
>>[34] lid2:/# tail /var/log/messages
>>Oct 23 08:55:50 lid2 am_mount[11720]: am_mount /n/linn/usr
>>Oct 23 08:55:50 lid2 automount[2281]: attempting to mount entry /n/linn
>>Oct 23 08:55:50 lid2 am_mount[11725]: am_mount /n/linn/etc
>>Oct 23 08:55:50 lid2 am_mount[11726]: am_mount /n/linn/usr
>>Oct 23 08:55:50 lid2 am_mount[11727]: am_mount /n/linn/local/b
>>Oct 23 08:55:50 lid2 am_mount[11728]: am_mount /n/linn/local/a
>>Oct 23 08:55:50 lid2 automount[11722]: >> mount: wrong fs type, bad 
>>option, bad superblock on ,
>>Oct 23 08:55:50 lid2 automount[11722]: >>        or too many mounted 
>>file systems
>>
>>
>>
>>
>>_______________________________________________
>>autofs mailing list
>>autofs@linux.kernel.org
>>http://linux.kernel.org/mailman/listinfo/autofs
>>
>>    
>>
>
>  
>

--------------080903040200060800020508
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
I noticed what was going on after I sent the message. My program is
outputing the wrong information.<br>
Thanks.<br>
<br>
Ian Kent wrote:<br>
<blockquote type="cite"
 cite="midPine.LNX.4.44.0310242114250.2980-100000@raven.themaw.net">
  <pre wrap="">On Thu, 23 Oct 2003, Greg Bradner wrote:

Can you post the script or the output of it along with the imputs used 
please.

  </pre>
  <blockquote type="cite">
    <pre wrap="">It is not making the mount  points for program mounts. Any ideas?

This is from /etc/auto_maps/autofs_host_mount.pl, my program for program 
mounts.
PARGS /usr/sbin/automount --timeout 60 /n program 
/etc/auto_maps/autofs_host_mount.pl vers=2,mountvers=2 
rsize=32768,wsize=32768
TEST = --timeout
TEST = 60
TEST = /n
BASEDIR = /n (2)
MOUNT OPTS: -o  vers=2,mountvers=2,rsize=32768,wsize=32768
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/etc 
/n/linn/etc
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/usr 
/n/linn/usr
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/local/b 
/n/linn/local/b
am_mount -o  vers=2,mountvers=2,rsize=32768,wsize=32768 linn:/local/a 
/n/linn/local/a
/n/linn

[34] lid2:/# tail /var/log/messages
Oct 23 08:55:50 lid2 am_mount[11720]: am_mount /n/linn/usr
Oct 23 08:55:50 lid2 automount[2281]: attempting to mount entry /n/linn
Oct 23 08:55:50 lid2 am_mount[11725]: am_mount /n/linn/etc
Oct 23 08:55:50 lid2 am_mount[11726]: am_mount /n/linn/usr
Oct 23 08:55:50 lid2 am_mount[11727]: am_mount /n/linn/local/b
Oct 23 08:55:50 lid2 am_mount[11728]: am_mount /n/linn/local/a
Oct 23 08:55:50 lid2 automount[11722]: &gt;&gt; mount: wrong fs type, bad 
option, bad superblock on ,
Oct 23 08:55:50 lid2 automount[11722]: &gt;&gt;        or too many mounted 
file systems




_______________________________________________
autofs mailing list
<a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
<a class="moz-txt-link-freetext" href="http://linux.kernel.org/mailman/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>

    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
</body>
</html>

--------------080903040200060800020508--


--===============043566449823244202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============043566449823244202==--

