From: Joseph V Moss <jmoss@ichips.intel.com>
Subject: Re: [NFS] RE: multiple servers per automount
Date: Tue, 14 Oct 2003 00:05:07 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <10324.1066115107@ichips.intel.com>
References: <Pine.LNX.4.33.0310131108160.3433-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Mon, 13 Oct 2003 11:23:51 +0800."
             <Pine.LNX.4.33.0310131108160.3433-100000@wombat.indigo.net.au> 
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
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net, Mike Waychison <Michael.Waychison@Sun.COM>

> On Fri, 10 Oct 2003, Ogden, Aaron A. wrote:
> 
> >
> >
> > > So this would indicate that even if there is a device system that can
> > > increase the number of unnamed devices that subsystems like NFS cannot
> > > handle this many mounts.
> >
> > Maybe.  I'm not 100% certain though.  Currently I am holding steady at
> > 710 active mounts, I am going to write a little script to mount more in
> > small increments, ie. read a list of ~1000 mountpoints from /home, mount
> > a few of them, check the filesystems, and repeat... this way I will know
> > exactly where things break down.
> 
> Interesting.
> 
> If you can edge it up then it's probably not an available port
> restriction.
> 
> There may be more than one issue at work here.
> 

The limit is 800 as others have stated.  Although, it can be less than that
if something else is already using up some of the reserved UDP ports.

I wrote a patch long ago against a 2.2.x kernel to enable it to use
multiple majors for NFS mounts (like the patches now common in several
distros).  I then ran into the 800 limit in the RPC layer.  After changing
the RPC layer to count up from 0, instead of down from 800, with no real
upper limit, I was able to mount more than 2000 NFS filesystems simultaneously.
I'm sure I could have done many thousand if I had had that many filesystems
around to mount.  Obviously, after 1024, it wasn't using reserved ports
anymore, but it didn't seem to matter.

Unfortunately, while the changes to NFS were easy to port to the 2.4 kernel,
the RPC layer is different enough between 2.2 and 2.4 that it didn't work
right off.  Bumping it up to somewhere around 1024 should work, but using
non-reserved ports didn't seem to work when I made a simple attempt.

Of course, the real fix for the NFS layer is the expansion of the minor
numbers that's already occurred in 2.6 and the RPC layer problems should
be fixed by multiplexing multiple mounts on the same port.
