From: Ian Kent <raven@themaw.net>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Fri, 9 Apr 2004 09:12:20 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404090841260.4861@raven.themaw.net>
References: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Raymond Prach <rprach@us.ibm.com>
Cc: autofs@linux.kernel.org

On Thu, 8 Apr 2004, Raymond Prach wrote:

> 
> Unfortunately the script is not simple, and neither is our environment. ;) 

Expected that. Oh well.

> However, what seems to happen is this:
> 
> 1. The script reads from the home directories of a large number of users
> 2. Users' home directories, by and large, are located on their 
> workstations, which are AIX 5.1

Can I assume that you're sure you're not reaching the anonymous mounts 
limit that exists in the 2.4 kernel?

> 3. Thus, via autofs, the server mounts a whole bunch of home directories 
> using NFS (v2, over UDP, if that matters) from a whole bunch of AIX 
> workstations -- say 20 at a time
> 4. Eventually, the script attempts to mount a home directory from a 
> workstation that is down or has been removed from the network, so it waits 
> around for a long time for the mount attempt to time out
> 5. While it is waiting for this mount attempt to fail, a bunch of mounts 
> that autofs previously mounted time out due to inactivity, so autofs 
> unmounts them
> 6. At this point, the "self destruct" message appears in the syslog
> 7. Lather, rinse, repeat.

OK so I should be able to duplicate this with three machines.
The picture sound fairly clear. I'll have a go at duplicating this.

Certainly, the mount behaviour in the presence of an unavailable server 
is unacceptable. I have some ideas for this but am still (and have been 
for some time) working through bug fix and minor updates. This type of 
change may amount to something a little more than minor.

> 
> I hope that is somewhat helpful, or at least informative.

Yep. very helpfull.

> 
> I can't really do much unless you are willing to duplicate this 
> against, at least autofs-4.1.1 (4.1.2 is latest), together with the kernel 
> 
> patches for autofs4. I haven't tested 2.4.25 but the 2.4.22 patch applies 
> OK against 2.4.24.
> 
> Ehhh. Unfortunately these are at least nominally production systems, and 
> I'm loath to start applying bleeding-edge patches to them when it doesn't 
> look like it will make the problem go away. Are there other advantages to 
> switching to autofs4? (Also, off-topic, but my 2.4.25 kernel has an 
> autofs4 module. What is the difference between that autofs4 and the 
> autofs4 you are talking about?)

Yes. I have trouble testing also, as my work systems are in production use 
as well.

I've been eorking on autofs v4 for quite a while now and a number of 
people have taken advantage of this. My focus is on improving stability 
and adding features that people in enterprise ebvironments need.

I've made some progress but have to carry some annoying limitations due 
largely to limitations in the kernel.

Essentailly what I have added is the ability for autofs to understand 
direct mount maps for file, NIS and LDAP maps. I'm about to start on NIS+. 
There remains a significant limitation so see README.direct if you are 
going to use this.

The kernel module update allows the daemon to provide a browsable autofs 
mount tree (aka ghosting in autofs v4).

You could call them bleeding edge, I suppose. I have been making 
corrections and enhancements for the couple of years that myself and 
others have been using.

> 
> What patch was this? I must have missed it.

Yep. Above.

They are in the 2.6.5-mm2 tree at the moment and I hope they will make it 
through to a 2.6 release soonish (fingers crossed).

> 
> >From kernel.org: o A patch by Greg Banks to help fix the "VFS: Busy inodes 
> after unmount." problem that occurs if autofs expires the mountpoint while 
> an NFS sillydelete is still pending. Now didn't have high hopes for this 
> patch, as I don't think that what we're seeing has anything to do with 
> sillydeletes (or indeed that any are being performed), but I was running 
> out of ideas here.

Yes, that is the patch I refered to but haven't tested. So it sounds like 
you have saved me some time.

Ian
