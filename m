From: Matthew Mitchell <matthew@geodev.com>
Subject: Re: "simultaneous" mounts causing weird behavior
Date: Mon, 10 Nov 2003 10:57:03 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1068483422.2640.458.camel@aluminum>
References: <Pine.LNX.4.33.0311061108300.32640-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0311061108300.32640-100000@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Wed, 2003-11-05 at 21:53, Ian Kent wrote:
> On Wed, 5 Nov 2003, Matthew Mitchell wrote:
> 
> > Looking at the 4.1.0-beta2 code, I don't see any mutex-looking code in
> > handle_packet_missing.  Isn't that where it should be?  Or are you
> > taking care of it elsewhere?  (Or are you allowing the bind mounts to go
> > through in the odd case where you get past the lstat() test while still
> > waiting on the lookup_mount to finish?)
> 
> Huh?.
> 
> You know of a user space semaphore implementation other than SysV IPC.
> Tell me and I'll use it.
> 
> There is no MUTEX type code and the code that is there is not around the
> lookup.

Sorry, what I wrote was a bit unclear.  You don't need a real mutex
because there is only one automount process per mount point.  The
problem (it seems to me) is that the automount process runs mount
asychronously (fork && exec without wait()) which can lead to
unnecessary bind() mounts.   I would think that you either need to
wait() on the mount or put in a manual exclusion check around the fork
&& exec.  Of course I am only thinking about a simple NFS mount
situation; there may be other automount uses that preclude this.  If so
please educate me before I take the naive path. :)

> First I believe one of the problems is caused by contention for the mtab
> file within mount. This can cause mount to return a fail even though the
> mount has happened. Similar things happen at umount time when there are
> many master map entries. Hence using a -n switch on the bind mount test
> helps when there are many entries in the master map. This problem can also
> occur when mount requests occur in rapid succession. The other possiblity
> is that the kernel module incorrectly fires multiple mounts requests. If
> this is the case (as it was at one point) then that needs to be fixed in
> the kernel module not the daemon.

Contention for mtab might explain the weird /tmp/mount-foobar garbage
that df complains about.  I don't have any idea what was in mtab when
this happened, though.  Have to check it the next time the problem shows
up.

> I can't remember whether you gave details of your senario.
> 
> All I do is use a lock file around mount calls and a timed delay once
> the lock file is aquired. I'm not giving any guarentee that this will
> always work or that it will even work at all. However it does seem to work
> better than I expected. It is a temporary work around until a better
> solution is implemented.
> 
> Perhaps you can help here with a patch. But first try it and see if it
> works. If it aint broke then I don't have the time to fix it.

Understood.

> You should be using the latest autofs4 kernel module with this. It is
> available form the same place you got the beta autofs-4.

OK.  Looks like a big change to the kernel setup (from a quick browse of
the patch).  In the interest of isolating the change to userspace, can
you point me to a version of autofs4 that works with the stock 2.4.20
kernel module?  I'd be happy to forward-port anything that works and
test it again with the newer code.  (I can test the new stuff pretty
easily on one machine but I don't want to undertake the week-long
process of updating the kernel on the whole cluster just for this
problem.)

-m
