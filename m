From: Ian Kent <raven@themaw.net>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port
	usage problems
Date: Thu, 13 Jan 2005 16:13:27 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0501131611410.6063@wombat.indigo.net.au>
References: <200501112122.j0BLMmET002446@jetcar.spd.analog.com>
	<Pine.LNX.4.58.0501121334440.1641@wombat.indigo.net.au>
	<41E55688.9070107@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41E55688.9070107@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org, David Meleedy <david.meleedy@analog.com>

On Wed, 12 Jan 2005, Mike Waychison wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Ian Kent wrote:
> > Just a quick note before we get deep into this.
> > 
> > Can you check something for me.
> > Get the source rpm for util-linux.
> > Check if there is a patch applied to it to probe for services during 
> > mount (it was a patch in FC). If it is rebuild the rpm without it and test 
> > again.
> > 
> > On Tue, 11 Jan 2005, David Meleedy wrote:
> > 
> > 
> >>Hi Ian & Jeff,
> >>	I am trying to track down an autofs issue that has been
> >>plaguing us.  It seems to be caused by the interaction of autofs version
> >>4 with a Network Appliance server, and cd'ing to /net directories
> >>on the Netapp server.
> >>
> >>A similar issue was seen in Analog Devices in Redhat 8, and apparently
> >>the problem was worked around by Dwight Marzolf working with Ian Kent's
> >>help.  So following what Dwight did I have been trying to recreate the fix
> >>for Redhat Enterprise 3 update 3, and so far have not met with success.
> >>
> >>THE PROBLEM DESCRIPTION:
> >>
> >>Autofs hangs and refuses to mount any directories for a period of time
> >>after cd'ing to /net/<Netapp>/vol/vol[0-3] and waiting a while.
> >>The only way to clear this is to reboot the client.
> >>
> >>Initially we started using the following software (Redhat Enterprise 3 update 
> >>3)
> >>autofs 4.1.3-12
> >>kernel 2.4.21-20
> >>nfs-utils 1.0.6-31EL
> >>
> >>WHAT HAS BEEN TRIED SO FAR:
> >>
> >>Mike Waychison, after seeing the messages from our log file said,
> >>
> >>"These messages are due to starvation for reserved ports (< 1024).
> >>Specifically, the kernel will only use ports < 800.  Currently, the
> >>kernel uses one port per nfs filesystem.  If you mount filesystems very
> >>fast, then you can also run out of reserved ports as the local (mountd
> >>iirc?) will close tcp sessions and each must wait 2 minutes before being
> >>released.
> >>
> >>One solution is to try out the patch I posted last week that allows nfs
> >>mounts to share tcp/udp connections:
> >>
> >>http://marc.theaimsgroup.com/?l=linux-nfs&m=110261671705396&w=2
> >>"
> >>
> >>The problem is we are using a different version of the kernel 2.4,
> >>and his patch was for the 2.6 kernel.  Also, although his patch
> >>might make the number of ports available increase, I think it does
> >>not really solve the problem, it just gives more breathing room.
> 
> Well, it will pretty much guarantee only one port is used for any given
> filer for talking to the nfs program.  Other ports are still used
> temporarily to talk to mountd and the portmapper.

Both of these are a significant problem as well from what I've seen in 
the netstat output.

> 
> I've attached patch that applies cleanly to 2.4.21-20.EL, though I
> haven't had the chance to test it other than by compiling it.
> 
> >>
> >>After talking with Jeff Moyer about the issue, I updated autofs to 
> >>autofs-4.1.3-67.  This was supposed to incorporate a patch that fixes
> >>the port leak problem.
> >>
> >>This did not solve the problem, but it did seem to improve things a bit.
> >>
> >>After looking at Dwight Marzolf's document on his workaround I found
> >>the following information (this is exactly the same sort of thing we
> >>are seeing too):
> >>
> >>"
> >>we quickly found that if you did a cd via /net to one of our Network
> >>Appliance filers (all our other netapp filers worked correctly when
> >>unmounting /net mounts), the port release issue still existed.  In
> >>fact, the mountpoints actively took more ports.  This meant that if you
> >>mounted this filer with /net, your workstation could be rendered
> >>useless in less than 24 hours.  It also became evident that this active
> >>taking of ports by this filer was not limited to just autofs-4.1.3-28
> >>but also earlier versions of autofs  ...  Further
> >>research revealed the ports were being taken at the point of automount
> >>timeout.  When the automounter had declared these mountpoints to be
> >>timed out and ready to be unmounted and attempted to umount them, in
> >>fact, it ended up remounting them, using new ports for the remount ...
> >>"
> >>
> 
> Out of curiosity, can we see the output of showmount -e against your filer?
> 
> - --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NOTICE:  The opinions expressed in this email are held by me,
> and may not represent the views of Sun Microsystems, Inc.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFB5VaHdQs4kOxk3/MRAvvhAJ4uOaMXMTE4rjZ6ivLrbyeowcZkuACfdshX
> yBzl0PSwvsMaQZgKelhmrd4=
> =vjuL
> -----END PGP SIGNATURE-----
> 
