From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: multiple servers per automount
Date: Thu, 09 Oct 2003 15:00:14 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F85B03E.2050109@sun.com>
References: <6AB920CC10586340BE1674976E0A991D5955F1@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <6AB920CC10586340BE1674976E0A991D5955F1@slexch2.sugarland.unocal.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; format="flowed"; charset="us-ascii"
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

Ogden, Aaron A. wrote:

>Ouch.  As you may know, the limit is *much* lower in linux.  Something
>that I've been struggling with recently...
>
>Under normal circumstances I would not be concerned with 'limitations'
>of a few hundred active NFS mounts, but such limitations certainly limit
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
