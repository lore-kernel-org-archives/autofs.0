From: David Meleedy <david.meleedy@analog.com>
Subject: Server IP address change screws up active mounts
Date: Thu, 13 May 2004 17:40:42 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200405132140.i4DLeg1s019737@jetcar.spd.analog.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org


One question I had for you guys happened to us when we were moving
our subnets to an internal 10. net.  We were using autofs version 3
on redhat 8, and I haven't had a chance to test this with version 4
yet, but the problem might still exist.

If the redhat client using automounter had mounted a directory from some
server (so the mount was active), and then we changed the IP address of 
the server, the automounter would hang on that mount forever after.  In fact
we couldn't even do "init 6", we had to do "reboot -f" to get
the client working again.  To compare, with our Solaris machines,
we didn't have this problem.  The new IP address was discovered and
the mount continued to work.

So I'm not really sure if this is an automount issue, or a mount command issue,
but I figured you guys would be the right ones to ask.  I definitely
think this issue should be fixed, it's not that uncommon to move
servers to new IP addresses.

Thanks!

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
