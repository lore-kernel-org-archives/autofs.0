From: Ian Kent <raven@themaw.net>
Subject: Re: "simultaneous" mounts causing weird behavior
Date: Thu, 6 Nov 2003 11:53:59 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311061108300.32640-100000@wombat.indigo.net.au>
References: <1068051462.2640.181.camel@aluminum>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1068051462.2640.181.camel@aluminum>
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
To: Matthew Mitchell <matthew@geodev.com>
Cc: autofs@linux.kernel.org

On Wed, 5 Nov 2003, Matthew Mitchell wrote:

> On Tue, 2003-11-04 at 18:46, Ian Kent wrote:
>
> > The /tmp entry is caused by mount failing to handle overlapping requests.
> > Aaron Ogden and I have been there recently with autofs v4.
> >
> > The overlapping mount problem is likely causing the other problem as well.
> > I put some altogether ugly code, which shouldn't work at all, but seems
> > to, into autofs v4 to deal with this. In fact I hated it so much, I
> > removed it at one point and Aaron was horrified to find everything broken
> > again.
>
> Looking at the 4.1.0-beta2 code, I don't see any mutex-looking code in
> handle_packet_missing.  Isn't that where it should be?  Or are you
> taking care of it elsewhere?  (Or are you allowing the bind mounts to go
> through in the odd case where you get past the lstat() test while still
> waiting on the lookup_mount to finish?)

Huh?.

You know of a user space semaphore implementation other than SysV IPC.
Tell me and I'll use it.

There is no MUTEX type code and the code that is there is not around the
lookup.

First I believe one of the problems is caused by contention for the mtab
file within mount. This can cause mount to return a fail even though the
mount has happened. Similar things happen at umount time when there are
many master map entries. Hence using a -n switch on the bind mount test
helps when there are many entries in the master map. This problem can also
occur when mount requests occur in rapid succession. The other possiblity
is that the kernel module incorrectly fires multiple mounts requests. If
this is the case (as it was at one point) then that needs to be fixed in
the kernel module not the daemon.

I can't remember whether you gave details of your senario.

All I do is use a lock file around mount calls and a timed delay once
the lock file is aquired. I'm not giving any guarentee that this will
always work or that it will even work at all. However it does seem to work
better than I expected. It is a temporary work around until a better
solution is implemented.

Perhaps you can help here with a patch. But first try it and see if it
works. If it aint broke then I don't have the time to fix it.

You should be using the latest autofs4 kernel module with this. It is
available form the same place you got the beta autofs-4.


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
