From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: [NFS] Re: multiple servers per automount
Date: Fri, 10 Oct 2003 10:43:41 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D0C6B7D@slexch2.sugarland.unocal.com>
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
To: "Lever, Charles" <Charles.Lever@netapp.com>, Ian Kent <raven@themaw.net>, Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net


Aha! Wisdom from the heavens... :-)
I assume that the RPC code is doing that to comply with reserved-port
restrictions, ie. ports < 1024.  Solaris needs to do the same thing
(with nfssrv:nfs_portmon=1) so it seems that there would be an inherent
limit of 1024 ports or mountpoints to work with.  Actually less, since
some ports will be in use.  How does Sun get 260,000 active mounts if
they can only use ports < 1024?  Do we really need one port for each
mountpoint?

Perhaps this has something to do with the fact that solaris autofs is
multithreaded (ie. one process) whereas linux autofs has many processes,
one for each mountpoint.  Feel free to correct me if I'm wrong...

-A

-----Original Message-----
From: Lever, Charles [mailto:Charles.Lever@netapp.com] 
Sent: Friday, October 10, 2003 10:10 AM
To: Ian Kent; Mike Waychison
Cc: Ogden, Aaron A.; autofs mailing list; nfs@lists.sourceforge.net
Subject: RE: [NFS] Re: [autofs] multiple servers per automount


the problem is likely the algorithm used to allocate
ports for the RPC transport sockets.  it starts at
port 800 and goes down to zero.

> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net]
> Sent: Thursday, October 09, 2003 6:09 PM
> To: Mike Waychison
> Cc: Ogden, Aaron A.; autofs mailing list; nfs@lists.sourceforge.net
> Subject: [NFS] Re: [autofs] multiple servers per automount
> 
> 
> On Thu, 9 Oct 2003, Mike Waychison wrote:
> 
> > Ogden, Aaron A. wrote:
> >
> > >Ouch.  As you may know, the limit is *much* lower in linux.
Something
> > >that I've been struggling with recently...
> > >
> > >Under normal circumstances I would not be concerned with
'limitations'
> > >of a few hundred active NFS mounts, but such limitations certainly
limit
> > >scalability for the extreme cases.
> > >
> > >
> >
> > The maximum number of plain pseudo-block device filesystems on a
given
> > filesystem is limitted to 256. (This includes proc, autofs, nfs..).
> >
> > This is because pseudo-block filesystems all use major 0, and each
have
> > a different minor (thus the 256 limit).
> >
> > There are however patches floating around (look at SuSe's kernels,
I'm
> > not sure about RH) that allow n majors to be used (default 5).  This
> > gives you 1280 mounts, a big step up :)
> >
> 
> But as Aaron and I know things go pear shaped at just shy of 800
mounts
> with RedHat kernels. They have the more-unnamed patch.
> 
> So this would indicate that even if there is a device system that can
> increase the number of unnamed devices that subsystems like NFS cannot
> handle this many mounts.
> 
