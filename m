From: "Pranay C. Tembhekar" <pranay@icemcfd.co.in>
Subject: Re: automounting other hosts on the network
Date: Wed, 10 Mar 2004 10:07:19 +0530
Sender: autofs-bounces@linux.kernel.org
Message-ID: <404E9B7F.7070606@icemcfd.co.in>
References: <404D8C3D.9000500@icemcfd.co.in>
	<1078853834.16233.18.camel@bad.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============92112585916059997=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1078853834.16233.18.camel@bad.jf.intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============92112585916059997==
Content-Type: multipart/alternative;
 boundary="------------010407090507030507040108"

This is a multi-part message in MIME format.
--------------010407090507030507040108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

thanx Taylor I'll try it today & let u know about the success & or 
errors...!!!

thanx again



Taylor, ForrestX wrote:

>On Tue, 2004-03-09 at 01:19, Pranay C. Tembhekar wrote:
>  
>
>>Hi Everybody,
>>    I want little bit help. I've installed Red Hat Linux 8.0 & 
>>configured it as a NFS & NIS server. I also installed Red Hat Linux 8.0 
>>on other system as a NIS client. Now I want to automount the hosts. E.g. 
>>/hosts/<systemname>/home. I have exported the /home from server. How can 
>>I achieve this in red hat linux. In solaris I can specify "/hosts -hosts 
>><options" in auto_master. But what's the procedure to do this in red hat 
>>linux?
>>    
>>
>
>Use autofs4 (ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/).  Grab
>the latest src.rpm and rebuild it.  You will probably have to make
>autofs start after NIS.  In the spec file, I have:
># chkconfig: 345 61 19
>
>Also, make sure you have 'alias autofs autofs4' in /etc/modules.conf,
>and remove the autofs3 module (service autofs stop;rmmod autofs).  I
>usually put these in the RPM file, but I haven't downloaded the latest
>to see if this is already in it.
>
>Once you rebuild the src.rpm file, install it and start it.  Instead of
>/hosts, you will use /net, and you may want to add nonstrict to the opts
>line in /etc/auto.net (if it isn't already).
>
>If you have problems, return with your errors.
>
>Forrest
>
>
>  
>


-- 
Pranay C. Tembhekar
Systems & Network Administrator
Matrix CFD Solutions (I) Pvt. Ltd./ANSYS India Ltd.
Phone: +91-20-24226160 x 16
Fax:   +91-20-24228081 x 20
Cell:  +91-98-22373121
http://www.icemcfd.co.in
http://www.ansys.com

Disclaimer:
The information transmitted is intended only for the person or  entity to which it is addressed and may contain confidential and/or  privileged material. Any review, retransmission, dissemination or  other use of, or taking of any action in reliance upon, this  information by persons or entities other than the intended recipient  is prohibited. If you received this in error, please contact the  sender and delete the material from any computer.


--------------010407090507030507040108
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
thanx Taylor I'll try it today &amp; let u know about the success &amp;
or errors...!!!<br>
<br>
thanx again<br>
<br>
<br>
<br>
Taylor, ForrestX wrote:<br>
<blockquote type="cite"
 cite="mid1078853834.16233.18.camel@bad.jf.intel.com">
  <pre wrap="">On Tue, 2004-03-09 at 01:19, Pranay C. Tembhekar wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi Everybody,
    I want little bit help. I've installed Red Hat Linux 8.0 &amp; 
configured it as a NFS &amp; NIS server. I also installed Red Hat Linux 8.0 
on other system as a NIS client. Now I want to automount the hosts. E.g. 
/hosts/&lt;systemname&gt;/home. I have exported the /home from server. How can 
I achieve this in red hat linux. In solaris I can specify "/hosts -hosts 
&lt;options" in auto_master. But what's the procedure to do this in red hat 
linux?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Use autofs4 (<a class="moz-txt-link-freetext" href="ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/">ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/</a>).  Grab
the latest src.rpm and rebuild it.  You will probably have to make
autofs start after NIS.  In the spec file, I have:
# chkconfig: 345 61 19

Also, make sure you have 'alias autofs autofs4' in /etc/modules.conf,
and remove the autofs3 module (service autofs stop;rmmod autofs).  I
usually put these in the RPM file, but I haven't downloaded the latest
to see if this is already in it.

Once you rebuild the src.rpm file, install it and start it.  Instead of
/hosts, you will use /net, and you may want to add nonstrict to the opts
line in /etc/auto.net (if it isn't already).

If you have problems, return with your errors.

Forrest


  </pre>
</blockquote>
<br>
<br>
<pre cols="72" class="moz-signature">-- 
Pranay C. Tembhekar
Systems &amp; Network Administrator
Matrix CFD Solutions (I) Pvt. Ltd./ANSYS India Ltd.
Phone: +91-20-24226160 x 16
Fax:   +91-20-24228081 x 20
Cell:  +91-98-22373121
<a class="moz-txt-link-freetext" href="http://www.icemcfd.co.in">http://www.icemcfd.co.in</a>
<a class="moz-txt-link-freetext" href="http://www.ansys.com">http://www.ansys.com</a>

Disclaimer:
The information transmitted is intended only for the person or  entity to which it is addressed and may contain confidential and/or  privileged material. Any review, retransmission, dissemination or  other use of, or taking of any action in reliance upon, this  information by persons or entities other than the intended recipient  is prohibited. If you received this in error, please contact the  sender and delete the material from any computer.
</pre>
</body>
</html>

--------------010407090507030507040108--


--===============92112585916059997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============92112585916059997==--

