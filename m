From: Jonathan Loran <jonathan@loran.name>
Subject: Re: statfs() and autofs
Date: Tue, 15 Jul 2008 22:21:31 -0700
Message-ID: <487D855B.8000405@loran.name>
References: <20080715204839.GU5858@pixar.com>
	<1216179794.22783.46.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5564912433753830772=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1216179794.22783.46.camel@raven.themaw.net>
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
--===============5564912433753830772==
Content-Type: multipart/alternative;
 boundary="------------070304010803090202070509"

This is a multi-part message in MIME format.
--------------070304010803090202070509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Ian Kent wrote:
> On Tue, 2008-07-15 at 13:48 -0700, Chris Walker wrote:
>   
>> autofs 5.0.3
>> linux 2.6.18
>>
>> When statfs() is called on an automounted directory, it returns before
>> the automount occurs. This results in output like this initially:
>>     
>
> That may be because there are a group of system calls that don't trigger
> a mount because we have to avoid mount storms for map entries that use
> the browse option. In particular stat(2) and calls that use the same
> kernel path lookup flags, such as statfs(2).
>
> Basically, if the mount point directory exists in the autofs file system
> but doesn't currently have a mount for some reason (perhaps it wasn't
> removed at expire or the entry uses the browse option), these calls will
> return the attributes of the autofs directory without performing a
> mount.
>
>   
Hi Ian,

I need to say that this basically has to be declared a bug.  I have been 
silent on this until now because I am so over committed with other 
tasks, and haven't had time to test it so cleanly as Chris has.

At my lab we find that on machines that do large batch processing, 
automounted directories often aren't there at the time that they are 
stat-ed.  The workaround has been to put in some nanosleeps to give the 
mount point a chance to mount, but that is very much a hack, since now 
the code authors need to know the point where an automount is joined, or 
they at least have to find it out empirically.  The code they write has 
become unportable and for all we know, incompatible on other systems if 
the autofs mount points are different. 

To throw this in the mix, somehow, our Solaris systems, which share 
identical automount maps, simply never have this issue.  Is there an 
architectural reason for this?  And if so, can we learn how this is so, 
and apply similar logic to the Linux autofs/mount path?

Thanks,

Jon

--------------070304010803090202070509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
Ian Kent wrote:
<blockquote cite="mid:1216179794.22783.46.camel@raven.themaw.net"
 type="cite">
  <pre wrap="">On Tue, 2008-07-15 at 13:48 -0700, Chris Walker wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">autofs 5.0.3
linux 2.6.18

When statfs() is called on an automounted directory, it returns before
the automount occurs. This results in output like this initially:
    </pre>
  </blockquote>
  <pre wrap=""><!---->
That may be because there are a group of system calls that don't trigger
a mount because we have to avoid mount storms for map entries that use
the browse option. In particular stat(2) and calls that use the same
kernel path lookup flags, such as statfs(2).

Basically, if the mount point directory exists in the autofs file system
but doesn't currently have a mount for some reason (perhaps it wasn't
removed at expire or the entry uses the browse option), these calls will
return the attributes of the autofs directory without performing a
mount.

  </pre>
</blockquote>
Hi Ian,<br>
<br>
I need to say that this basically has to be declared a bug.&nbsp; I have
been silent on this until now because I am so over committed with other
tasks, and haven't had time to test it so cleanly as Chris has.<br>
<br>
At my lab we find that on machines that do large batch processing,
automounted directories often aren't there at the time that they are
stat-ed.&nbsp; The workaround has been to put in some nanosleeps to give the
mount point a chance to mount, but that is very much a hack, since now
the code authors need to know the point where an automount is joined,
or they at least have to find it out empirically.&nbsp; The code they write
has become unportable and for all we know, incompatible on other
systems if the autofs mount points are different.&nbsp; <br>
<br>
To throw this in the mix, somehow, our Solaris systems, which share
identical automount maps, simply never have this issue.&nbsp; Is there an
architectural reason for this?&nbsp; And if so, can we learn how this is so,
and apply similar logic to the Linux autofs/mount path?<br>
<br>
Thanks,<br>
<br>
Jon<br>
</body>
</html>

--------------070304010803090202070509--


--===============5564912433753830772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5564912433753830772==--

