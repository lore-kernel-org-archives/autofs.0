From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: rm hangs on symlinks to down mount points
Date: Tue, 30 Dec 2003 17:37:27 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0312301649150.3865@xena.cft.ca.us>
References: <Pine.LNX.4.44.0312301833520.24097-100000@gate.nmr.mgh.harvard.edu>
	<3FF21106.4000907@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FF21106.4000907@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

On Tue, 30 Dec 2003, H. Peter Anvin wrote:
> People constantly ask for various kinds of NFS support crap in autofs,
> and it's *ALWAYS* wrong.  There is really no excuse for a feature
> working from within autofs and not when mounted normally.

However, automount's job is to have the mount points available when needed,
and to make them go away when not needed.  As part of the latter, it's
important for the client to resist being harmed when a server dies.

> >>>I am often getting automount processes that are hung and don't die
> >>>with a simple kill.  I can "kill -9" them but that leaves things in
> >>>a bad state usually (though sometimes I will just hand edit /etc/mtab
> >>>so I can get something done).
> >>
> >>That's why they don't die with a simple kill.
> >
> > Which is a pain.  Just because some remote server went down I had
> > automounted should not force me into a reboot of the client.
> >
>
> OK... clue call... *AUTOFS ISN'T INVOLVED.*  Autofs *CANNOT* help you
> when an in-use filesystem has its server removed from underneath it.

Well...  At UCLA-Mathnet we have a lot of Solaris and Linux boxes, all
cross-mounted via automount (soft mounts) for various purposes.
Fortunately they're very stable, because when a server crashes, a Solaris
client's automounter is totally horked and you end up rebooting it.  On
Linux I can often do umount -f -l as part of a cleanup campaign and save
the client (though not the process cd'd to the NFS mounted directory or
executing NFS mounted software).  This is important because the majority of
machines, particularly compute nodes, are NFS servers and clients at the
same time, so a reboot messes up even more machines.

It would really be helpful if this cleanup process could be automated.  I
attribute responsibility to automount, because automount mounted it, and
automount eventually will try (and possibly fail) to unmount it.
Automount needs to be agile as the sysop wriggles around NFS limitations;
particularly, if the filesystem is forcibly unmounted manually, automount
needs to be aware, and to exit when the use count of the client's
representation of the filesystem drops to zero.  It should not be
advertising that there is still a useable filesystem on that mount point.

Perhaps MNT_FORCE (umount -f) or MNT_DETACH (-l) could be helpful in
getting rid of a horked mount point.  I have thought about using rename()
to move a horked mount point into a garbage dump directory that the users
can't see, after which automount can behave normally for that path name:
ENOENT if the server is still dead, or remounting the filesystem if
feasible.  I guess that won't work, but kernel 2.5.x/2.6.x has MS_MOVE
which may accomplish the desired result.

While in Sun's original design you could reboot a server and have NFS
clients resume as if nothing had happened, that no longer seems to be
really happening, probably because Solaris automount can't deal with the
loss of the server even if temporary.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
