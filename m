From: "Murata, Dennis W (SAIC)" <muratadw@bp.com>
Subject: RE: Server IP address change screws up active mounts
Date: Wed, 19 May 2004 15:05:23 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <134FC8D9C1F126488E3D123A9B2607370105E0FC@bp1houex002.bp1.ad.bp.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org, David Meleedy <david.meleedy@analog.com>, Ian Kent <raven@themaw.net>

The nfs server not responding is indeed an NFS problem, however, using
autofs 3.x, if you tried to stop and restart the automounter or reboot
the workstation it would hang trying to kill automount.  Only a power
cycle would reboot the workstation.  When we switched to
autofs-4.0.0pre10, you will getting messages about trying to unmount
directories, but eventually (~30 seconds) autofs would timeout(?) then
continue the reboot, or allow you to start the service back up again.
The only change was the upgrade to autofs-4.0.0pre10.

Wayne

-----Original Message-----
From: H. Peter Anvin [mailto:hpa@zytor.com]
Sent: Tuesday, May 18, 2004 7:15 PM
To: Murata, Dennis W (SAIC)
Cc: Ian Kent; David Meleedy; autofs@linux.kernel.org
Subject: Re: [autofs] Server IP address change screws up active mounts


Murata, Dennis W (SAIC) wrote:
> We experienced similar problems using autofs-3.x with both RedHat(7.3,
> 8.0, 2.1, 9.0) and Slackware(9.0).  This seems to be fixed with
> autofs-4.x.  We have used 4.0.0-pre10 for a couple of years without
> problem and are now trying 4.1.2.
> The problems we were seeing dealt with and automounted nfs server not
> responding, the mount would hang, autofs would not timeout and would
> hang, only a hard reset would reboot the computer.
> 

It wouldn't have anything to do with autofs, though.  Rather, it's an 
NFS problem.

	-hpa
