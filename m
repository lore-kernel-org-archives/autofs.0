From: Ian Kent <raven@themaw.net>
Subject: Re: Server IP address change screws up active mounts
Date: Fri, 14 May 2004 10:12:43 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405141006140.29527@wombat.indigo.net.au>
References: <200405132140.i4DLeg1s019737@jetcar.spd.analog.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200405132140.i4DLeg1s019737@jetcar.spd.analog.com>
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org

On Thu, 13 May 2004, David Meleedy wrote:

> 
> One question I had for you guys happened to us when we were moving
> our subnets to an internal 10. net.  We were using autofs version 3
> on redhat 8, and I haven't had a chance to test this with version 4
> yet, but the problem might still exist.
> 
> If the redhat client using automounter had mounted a directory from some
> server (so the mount was active), and then we changed the IP address of 
> the server, the automounter would hang on that mount forever after.  In fact
> we couldn't even do "init 6", we had to do "reboot -f" to get
> the client working again.  To compare, with our Solaris machines,
> we didn't have this problem.  The new IP address was discovered and
> the mount continued to work.

You must post this to the nfs list.

> 
> So I'm not really sure if this is an automount issue, or a mount command issue,
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
