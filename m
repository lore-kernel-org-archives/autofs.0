From: Greg Bradner <gregb@rhythm.com>
Subject: Re: auotfs v4
Date: Fri, 14 Nov 2003 06:29:51 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FB4E6DF.9020907@rhythm.com>
References: <Pine.LNX.4.44.0311070711380.2959-100000@raven.themaw.net>
	<3FABB076.5080702@rhythm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============19026586840762727=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FABB076.5080702@rhythm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============19026586840762727==
Content-Type: multipart/alternative;
 boundary="------------070804030801050209080403"

This is a multi-part message in MIME format.
--------------070804030801050209080403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This remains a major problem for me. I have changed the exports file on 
the NetApp, but am still having the same problem.
Why would /nfs/hosts3/fs7/vol/vo0 get umount but not exported 
directories under that mount point?  Why does /etc/mtab reflect an 
umount but /proc/mounts show them mounted?

Any ideas?

Greg Bradner wrote:

> I am using RH 7.3 with the 2.4.20 kernel. It doen't have the patch. 
> But I don't need it at the moment. I need to figure out why my 
> /proc/mounts file is filling up with the same mount points.
>
> My problem is a NetApp. Not because it's a NetApp, rather I believe 
> it's the way volumes are exported.
> > showmount -e fs7
> Export list for fs7:
> /vol/vol0/systems   (everyone)
> /vol/vol0/muse      (everyone)
> /vol/vol0/avidcache (everyone)
> /vol/vol0           (everyone)
>
> What I see in /proc/mounts:
> fs7:/vol/vol0/muse /nfs/hosts3/fs7/vol/vol0/muse nfs 
> rw,v2,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=fs7 0 0
> fs7:/vol/vol0/avidcache /nfs/hosts3/fs7/vol/vol0/avidcache nfs 
> rw,v2,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=fs7 0 0
> fs7:/vol/vol0/systems /nfs/hosts3/fs7/vol/vol0/systems nfs 
> rw,v2,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=fs7 0 0
>
> But I don't see:
> /vol/vol0
>
> I believe autofs is expiring and unmounting fs7:/vol/vol0 and getting 
> confused as what to do with the directories under that root vol.
>
>
> Ian Kent wrote:
>
>>On Thu, 6 Nov 2003, Mike Waychison wrote:
>>
>>  
>>
>>>Greg Bradner wrote:
>>>
>>>    
>>>
>>>>Any ideas what 'mount table full' means?
>>>>Nov  6 10:08:44 linn automount[27555]: >> NFSv3 not supported!
>>>>Nov  6 10:08:44 linn automount[27555]: >> mount table full
>>>>Nov  6 10:08:44 linn automount[27555]: mount(nfs): nfs: mount failure 
>>>>fs7:/vol/vol0/systems/celia/utils on /celia/utils/
>>>>Nov  6 10:09:15 linn automount[1899]: attempting to mount entry 
>>>>/misc/hsm_cache
>>>>Nov  6 10:09:15 linn automount[27589]: >> NFSv3 not supported!
>>>>Nov  6 10:09:15 linn automount[27589]: >> mount table full
>>>>Nov  6 10:09:15 linn automount[27589]: mount(nfs): nfs: mount failure 
>>>>fs8:/vol/vol0/hsm_cache on /misc/hsm_cache/
>>>>
>>>>Everything works fine after a reboot.
>>>>
>>>>      
>>>>
>>>It means that you have more than 256 mounts that don't have a 
>>>block-device back-end.  These include NFS, autofs, procfs, sysfs...
>>>
>>>This is a known limitation in linux 2.4.  You may want to try a patch 
>>>like the following:
>>>
>>>http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-unmaj.diff
>>>
>>>
>>>    
>>>
>>
>>Most of the RedHat packaged kernels have this patch.
>>
>>What distro are you using?
>>What version of autofs?
>> 
>>  
>>
>
>-- 
>
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>Rhythm & Hues
>5404 Jandy Place
>Los Angeles, CA 90066
>Voice: 310 448-7763
>Fax:   310 448-7600
>gregb@rhythm.com
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


--------------070804030801050209080403
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
This remains a major problem for me. I have changed the exports file on
the NetApp, but am still having the same problem.<br>
Why would /nfs/hosts3/fs7/vol/vo0 get umount but not exported
directories under that mount point?&nbsp; Why does /etc/mtab reflect an
umount but /proc/mounts show them mounted?<br>
<br>
Any ideas?<br>
<br>
Greg Bradner wrote:<br>
<blockquote type="cite" cite="mid3FABB076.5080702@rhythm.com">
  <meta http-equiv="Content-Type" content="text/html;">
  <title></title>
I am using RH 7.3 with the 2.4.20 kernel. It doen't have the patch. But
I don't need it at the moment. I need to figure out why my /proc/mounts
file is filling up with the same mount points.<br>
  <br>
My problem is a NetApp. Not because it's a NetApp, rather I believe
it's the way volumes are exported.<br>
&gt; showmount -e fs7<br>
Export list for fs7:<br>
/vol/vol0/systems&nbsp;&nbsp; (everyone)<br>
/vol/vol0/muse&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (everyone)<br>
/vol/vol0/avidcache (everyone)<br>
/vol/vol0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (everyone)<br>
  <br>
What I see in /proc/mounts:<br>
fs7:/vol/vol0/muse /nfs/hosts3/fs7/vol/vol0/muse nfs
rw,v2,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=fs7 0 0<br>
fs7:/vol/vol0/avidcache /nfs/hosts3/fs7/vol/vol0/avidcache nfs
rw,v2,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=fs7 0 0<br>
fs7:/vol/vol0/systems /nfs/hosts3/fs7/vol/vol0/systems nfs
rw,v2,rsize=8192,wsize=8192,hard,intr,udp,lock,addr=fs7 0 0<br>
  <br>
But I don't see:<br>
/vol/vol0<br>
  <br>
I believe autofs is expiring and unmounting fs7:/vol/vol0 and getting
confused as what to do with the directories under that root vol.<br>
  <br>
  <br>
Ian Kent wrote:<br>
  <blockquote type="cite"
 cite="midPine.LNX.4.44.0311070711380.2959-100000@raven.themaw.net">
    <pre wrap="">On Thu, 6 Nov 2003, Mike Waychison wrote:

  </pre>
    <blockquote type="cite">
      <pre wrap="">Greg Bradner wrote:

    </pre>
      <blockquote type="cite">
        <pre wrap="">Any ideas what 'mount table full' means?
Nov  6 10:08:44 linn automount[27555]: &gt;&gt; NFSv3 not supported!
Nov  6 10:08:44 linn automount[27555]: &gt;&gt; mount table full
Nov  6 10:08:44 linn automount[27555]: mount(nfs): nfs: mount failure 
fs7:/vol/vol0/systems/celia/utils on /celia/utils/
Nov  6 10:09:15 linn automount[1899]: attempting to mount entry 
/misc/hsm_cache
Nov  6 10:09:15 linn automount[27589]: &gt;&gt; NFSv3 not supported!
Nov  6 10:09:15 linn automount[27589]: &gt;&gt; mount table full
Nov  6 10:09:15 linn automount[27589]: mount(nfs): nfs: mount failure 
fs8:/vol/vol0/hsm_cache on /misc/hsm_cache/

Everything works fine after a reboot.

      </pre>
      </blockquote>
      <pre wrap="">It means that you have more than 256 mounts that don't have a 
block-device back-end.  These include NFS, autofs, procfs, sysfs...

This is a known limitation in linux 2.4.  You may want to try a patch 
like the following:

<a class="moz-txt-link-freetext"
 href="http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-unmaj.diff">http://people.redhat.com/zaitcev/linux/linux-2.4.19-pre7-unmaj.diff</a>


    </pre>
    </blockquote>
    <pre wrap=""><!---->
Most of the RedHat packaged kernels have this patch.

What distro are you using?
What version of autofs?
 
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

--------------070804030801050209080403--


--===============19026586840762727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============19026586840762727==--

