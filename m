From: "Murata, Dennis W (SAIC)" <muratadw@bp.com>
Subject: RE: Server IP address change screws up active mounts
Date: Mon, 17 May 2004 11:17:46 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <134FC8D9C1F126488E3D123A9B2607370105E0F9@bp1houex002.bp1.ad.bp.com>
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
To: Ian Kent <raven@themaw.net>, David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org

We experienced similar problems using autofs-3.x with both RedHat(7.3,
8.0, 2.1, 9.0) and Slackware(9.0).  This seems to be fixed with
autofs-4.x.  We have used 4.0.0-pre10 for a couple of years without
problem and are now trying 4.1.2.
The problems we were seeing dealt with and automounted nfs server not
responding, the mount would hang, autofs would not timeout and would
hang, only a hard reset would reboot the computer.

Wayne

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org]On Behalf Of Ian Kent
Sent: Thursday, May 13, 2004 9:13 PM
To: David Meleedy
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Server IP address change screws up active mounts


On Thu, 13 May 2004, David Meleedy wrote:

> 
> One question I had for you guys happened to us when we were moving
> our subnets to an internal 10. net.  We were using autofs version 3
> on redhat 8, and I haven't had a chance to test this with version 4
> yet, but the problem might still exist.
> 
> If the redhat client using automounter had mounted a directory from
some
> server (so the mount was active), and then we changed the IP address
of 
> the server, the automounter would hang on that mount forever after.
In fact
> we couldn't even do "init 6", we had to do "reboot -f" to get
> the client working again.  To compare, with our Solaris machines,
> we didn't have this problem.  The new IP address was discovered and
> the mount continued to work.

You must post this to the nfs list.

> 
> So I'm not really sure if this is an automount issue, or a mount
command issue,
> but I figured you guys would be the right ones to ask.  I definitely
> think this issue should be fixed, it's not that uncommon to move
> servers to new IP addresses.

Sounds like an issue with NFS or mount.

It sounds a bit strange though. It's been my impression that these types

of behaviour have improved greatly in later kernel versions.

What are the versions of:

kernel
util-linux
autofs

Ian


_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
