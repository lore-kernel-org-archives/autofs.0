From: Ian Kent <raven@themaw.net>
Subject: Re: "simultaneous" mounts causing weird behavior
Date: Wed, 5 Nov 2003 08:49:07 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311050848130.8092-100000@wombat.indigo.net.au>
References: <1067979370.2630.110.camel@aluminum>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1067979370.2630.110.camel@aluminum>
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
Cc: autofs@linux.kernel.org, "H. Peter Anvin" <hpa@zytor.com>

On Tue, 4 Nov 2003, Matthew Mitchell wrote:

> On Tue, 2003-11-04 at 11:02, H. Peter Anvin wrote:
> > Matthew Mitchell wrote:
> > > Hello,
> > >
> > > On some SMP processing nodes we have in our cluster we are noticing the
> > > following odd behavior.  It seems like there might be a race condition
> > > somewhere in automount that results in the same (in this case NFS)
> > > device mounted twice on the same mountpoint.
> > >
> > > In our case we have a (closed-source, vendor provided) data processing
> > > app that runs 2-4 processes at a time on each of these nodes.  The
> > > processes communicate via MPI.  What ends up happening is that each of
> > > them tries to read data from these NFS-mounted volumes at exactly the
> > > same time, and sometimes (about one node out of every 10) we get unlucky
> > > and the disk gets double-mounted.
> > >
> > > Here is the entry from the messages file where the disks are getting
> > > mounted:
> > > Nov  2 16:52:53 fir32 automount[674]: attempting to mount entry
> > > /etvf/data0
> > > Nov  2 16:52:53 fir32 automount[674]: attempting to mount entry
> > > /etvf/data0
> > >
> > > (Yes, there are two of them.)
> > >
> >
> > This happens because mount silently changed behaviour -- autofs relies
> > on mount only allowing one thing to be mounted on each mount point, but
> > that was suddenly changed without warning.
>
> Yes, I know that mount can do that now.  But automount is spawning the
> second mount before the first one completes, no?  Still seems like there
> should be some sort of mutual exclusion around the lookup_mount call.  I
> realize our workload is kind of funny in that the processes effectively
> _try_ to synchronize their automount request.
>
> Has any of this changed in the 4.0-pre autofs?  I haven't read through
> its source yet.

Yep. If you are willing, try the latest autofs-4.1.0-beta.


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
