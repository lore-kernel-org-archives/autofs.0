From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: multiple servers per automount
Date: Fri, 10 Oct 2003 10:16:01 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D5955FC@slexch2.sugarland.unocal.com>
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
To: Ian Kent <raven@themaw.net>, Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net



-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: Thursday, October 09, 2003 8:09 PM
To: Mike Waychison
Cc: Ogden, Aaron A.; autofs mailing list; nfs@lists.sourceforge.net
Subject: Re: [autofs] multiple servers per automount

>> The maximum number of plain pseudo-block device filesystems on a
given
>> filesystem is limitted to 256. (This includes proc, autofs, nfs..).
>>
>> This is because pseudo-block filesystems all use major 0, and each
have
>> a different minor (thus the 256 limit).
>>
>> There are however patches floating around (look at SuSe's kernels,
I'm
>> not sure about RH) that allow n majors to be used (default 5).  This
>> gives you 1280 mounts, a big step up :)
>>
>
> But as Aaron and I know things go pear shaped at just shy of 800
mounts
> with RedHat kernels. They have the more-unnamed patch.
>
> So this would indicate that even if there is a device system that can
> increase the number of unnamed devices that subsystems like NFS cannot
> handle this many mounts.

Maybe.  I'm not 100% certain though.  Currently I am holding steady at
710 active mounts, I am going to write a little script to mount more in
small increments, ie. read a list of ~1000 mountpoints from /home, mount
a few of them, check the filesystems, and repeat... this way I will know
exactly where things break down.
