From: Ian Kent <raven@themaw.net>
Subject: RE: [NFS] Re: multiple servers per automount
Date: Mon, 13 Oct 2003 11:05:29 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0310131044500.3433-100000@wombat.indigo.net.au>
References: <482A3FA0050D21419C269D13989C6113020AC4E3@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <482A3FA0050D21419C269D13989C6113020AC4E3@lavender-fe.eng.netapp.com>
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
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@Sun.COM>, nfs@lists.sourceforge.net

On Fri, 10 Oct 2003, Lever, Charles wrote:

> the problem is likely the algorithm used to allocate
> ports for the RPC transport sockets.  it starts at
> port 800 and goes down to zero.

Don't think so.

I appears that a single connection is maintained for nfs comms for both
udp and tcp.

However, if a rapid number of mount requests are fired then multiple
portmap connections are made. They end up in a TIME_WAIT state which is
probably causing the port allocation starvation.

This doesn't appear to happen under Solaris.

>
> > -----Original Message-----
> > From: Ian Kent [mailto:raven@themaw.net]
> > Sent: Thursday, October 09, 2003 6:09 PM
> > To: Mike Waychison
> > Cc: Ogden, Aaron A.; autofs mailing list; nfs@lists.sourceforge.net
> > Subject: [NFS] Re: [autofs] multiple servers per automount
> >
> >
> > On Thu, 9 Oct 2003, Mike Waychison wrote:
> >
> > > Ogden, Aaron A. wrote:
> > >
> > > >Ouch.  As you may know, the limit is *much* lower in
> > linux.  Something
> > > >that I've been struggling with recently...
> > > >
> > > >Under normal circumstances I would not be concerned with
> > 'limitations'
> > > >of a few hundred active NFS mounts, but such limitations
> > certainly limit
> > > >scalability for the extreme cases.
> > > >
> > > >
> > >
> > > The maximum number of plain pseudo-block device filesystems
> > on a given
> > > filesystem is limitted to 256. (This includes proc, autofs, nfs..).
> > >
> > > This is because pseudo-block filesystems all use major 0,
> > and each have
> > > a different minor (thus the 256 limit).
> > >
> > > There are however patches floating around (look at SuSe's
> > kernels, I'm
> > > not sure about RH) that allow n majors to be used (default 5).  This
> > > gives you 1280 mounts, a big step up :)
> > >
> >
> > But as Aaron and I know things go pear shaped at just shy of
> > 800 mounts
> > with RedHat kernels. They have the more-unnamed patch.
> >
> > So this would indicate that even if there is a device system that can
> > increase the number of unnamed devices that subsystems like NFS cannot
> > handle this many mounts.
> >
> > --
> >
> >    ,-._|\    Ian Kent
> >   /      \   Perth, Western Australia
> >   *_.--._/   E-mail: raven@themaw.net
> >         v    Web: http://themaw.net/
> >
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: SF.net Giveback Program.
> > SourceForge.net hosts over 70,000 Open Source Projects.
> > See the people who have HELPED US provide better services:
> > Click here: http://sourceforge.net/supporters.php
> > _______________________________________________
> > NFS maillist  -  NFS@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/nfs
> >
>

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
