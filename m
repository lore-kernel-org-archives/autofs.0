From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: multiple servers per automount
Date: Thu, 9 Oct 2003 16:20:01 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D0C6B77@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>


Yes, we are using the RH kernels as a base, the limit is supposed to be
1200+ but my experiments have shown it to be just shy of 800.  Or maybe
that results is due to a bug in the autofs code.  I think the real
solution to this problem is Richard Gooch's devfs and kernel 2.6.  It's
anyone's guess when there will be a distribution using both of those but
I think Fedora might be the first.

-----Original Message-----
From: Mike Waychison [mailto:Michael.Waychison@Sun.COM] 
Sent: Thursday, October 09, 2003 2:00 PM
To: Ogden, Aaron A.
Cc: autofs mailing list; Ian Kent
Subject: Re: [autofs] multiple servers per automount


Ogden, Aaron A. wrote:

>Ouch.  As you may know, the limit is *much* lower in linux.  Something
>that I've been struggling with recently...
>
>Under normal circumstances I would not be concerned with 'limitations'
>of a few hundred active NFS mounts, but such limitations certainly
limit
>scalability for the extreme cases.
>  
>

The maximum number of plain pseudo-block device filesystems on a given 
filesystem is limitted to 256. (This includes proc, autofs, nfs..).

This is because pseudo-block filesystems all use major 0, and each have 
a different minor (thus the 256 limit). 

There are however patches floating around (look at SuSe's kernels, I'm 
not sure about RH) that allow n majors to be used (default 5).  This 
gives you 1280 mounts, a big step up :)

Mike Waychison
