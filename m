From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [NFS] RE: multiple servers per automount
Date: Tue, 14 Oct 2003 11:52:22 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F8C1BB6.9010202@sun.com>
References: <Pine.LNX.4.44.0310142131090.3044-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.44.0310142131090.3044-100000@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net, Kernel Mailing List <linux-kernel@vger.kernel.org>, Joseph V Moss <jmoss@ichips.intel.com>

Ian Kent wrote:

>On Tue, 14 Oct 2003, Joseph V Moss wrote:
>
>  
>
>>The limit is 800 as others have stated.  Although, it can be less than that
>>if something else is already using up some of the reserved UDP ports.
>>
>>I wrote a patch long ago against a 2.2.x kernel to enable it to use
>>multiple majors for NFS mounts (like the patches now common in several
>>distros).  I then ran into the 800 limit in the RPC layer.  After changing
>>the RPC layer to count up from 0, instead of down from 800, with no real
>>upper limit, I was able to mount more than 2000 NFS filesystems simultaneously.
>>I'm sure I could have done many thousand if I had had that many filesystems
>>around to mount.  Obviously, after 1024, it wasn't using reserved ports
>>anymore, but it didn't seem to matter.
>>
>>Unfortunately, while the changes to NFS were easy to port to the 2.4 kernel,
>>the RPC layer is different enough between 2.2 and 2.4 that it didn't work
>>right off.  Bumping it up to somewhere around 1024 should work, but using
>>non-reserved ports didn't seem to work when I made a simple attempt.
>>
>>Of course, the real fix for the NFS layer is the expansion of the minor
>>numbers that's already occurred in 2.6 and the RPC layer problems should
>>be fixed by multiplexing multiple mounts on the same port.
>>
>>
>>    
>>
>
>I don't see that expansion in 2.6 (test6). It looks to me like the 
>allocation is done in set_anon_super (in fs/super.c) and that looks like 
>it is restricted to 256. Please correct this for me. I can't see how there 
>is any change to the number of unnmaed devices.
>
>  
>

Here is the quick fix for this in RH 2.1AS kernels:

http://www.kernelnewbies.org/kernels/rh21as/SOURCES/linux-2.4.9-moreunnamed.patch

It makes unnamed block devices use majors 12, 14, 38, 39, as well as 0. 

I don't know if anyone is working out a better scheme for 
get_unnamed_dev in 2.6 yet.  It does need to be done though.  A simple 
patch for 2.6 would maybe see the unnamed_dev_in_use bitmap grow to 
PAGE_SIZE, automatically allowing for 32768 unnamed devices.

Mike Waychison
