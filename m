From: "Ogden, Aaron A." <aogden@unocal.com>
Subject: RE: [RFC] Towards a Modern Autofs
Date: Tue, 6 Jan 2004 16:28:59 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6AB920CC10586340BE1674976E0A991D0C6BE4@slexch2.sugarland.unocal.com>
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
To: thockin@Sun.COM, "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@Sun.COM>, Kernel Mailing List <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: autofs-bounces@linux.kernel.org 
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of Tim Hockin
> Sent: Tuesday, January 06, 2004 3:50 PM
> To: H. Peter Anvin
> Cc: autofs mailing list; Mike Waychison; Kernel Mailing List
> Subject: Re: [autofs] [RFC] Towards a Modern Autofs
> 
<...snip...>
>
> > Pardon me for sounding harsh, but I'm seriously sick of the
oft-repeated
> > idiocy that effectively boils down to "the daemon can die and would
lose
> > its state, so let's put it all in the kernel."  A dead daemon is a
> > painful recovery, admitted.  It is also a THIS SHOULD NOT HAPPEN
> 
> But it *does* happen.
> 
> > condition.  By cramming it into the kernel, you're in fact 
> > making the system less stable, not more, because the kernel being
tainted with
> > faulty code is a total system malfunction; a crashed userspace
daemon is
> 
> I don't think this design crams anything into the kernel.  It 
> doesn't put a whole lot more into the kernel than is currently in
there 
> (expiry and new mount stuff, aside).  All the work still happens in
userland.
> 
> The daemon as it stands does NOT handle namespaces, does NOT handle
expiry
> well, and is a pretty sad copy of an old design.
> 
> > "merely" a messy cleanup.  In practice, the autofs daemon does not
die
> > unless a careless system administrator kills it.  It is a
non-problem.
> 
> I have some customers I'd love to send to you, if you really 
> think that's true.

Speaking as a sysadmin with 300+ machines (some linux, some solaris)
using autofs, I can say that the linux autofs daemon does die on
occasion, or at least some of the children become hung or unresponsive.
This happened to us with autofs3 and autofs4, leading me to contact Ian
Kent and become involved in testing new versions of autofs4.  I don't
have any problems with the newest versions (4.1.0+) but with previous
code, 4.0.0pre10 for example, I found the ability to restart the daemon
invaluable.  On those occasions where the autofs daemon gets confused
(loses track of mountpoints, gets corruption in its internal
representation of NIS maps, etc.) we could shut down the autofs daemon,
kill any remaining processes, and restart it from scratch.  In most
cases restarting the daemon fixes the problem.  It's worth noting that I
have seen this happen on Solaris 2.6 as well but it is extremely rare.
On the solaris machine there was no automount daemon to restart so I was
forced to reboot it to regain access to the 'missing' mountpoint.

If you've read this far, what I'm trying to say is that having userspace
related code remain in userland is a good thing since you can restart
the daemon if something goes wrong.  If you move all of this to
kernel-space you can't do anything about it if there is a problem.  In
Solaris there is a command called 'automount' that tells the kernel to
re-read the automount maps, perhaps it resets the autofs subsystem in
the kernel as well.  If linux autofs had the same capability we might
not need the daemon, but until then, having the daemon in userland is a
good thing.
