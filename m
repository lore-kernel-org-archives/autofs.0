From: David Meleedy <david.meleedy@analog.com>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Fri, 14 Jan 2005 17:38:37 -0500
Message-ID: <200501142238.j0EMcbOT002214@jetcar.spd.analog.com>
References: <Pine.LNX.4.61.0501142225200.2519@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Fri, 14 Jan 2005 22:35:08 +0800."
	<Pine.LNX.4.61.0501142225200.2519@donald.themaw.net> 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@sun.com>


Ian,
	I have installed the multi-over patch into our version
of the automounter 4.1.3-67 (with updated large-program-map patch)
and so far everything looks great!  I am going to test our machines
for a longer period of time and make sure everything looks stable,
but so far, so good!

It seems to have eliminated the "BUG" message in the messages file,
and it seems as though the automounter can unmount /net/aflac
which it was not able to do in the past during a reboot.  I suspect
that this means it will use a lot less ports, and I might not
even need the kernel patch (given the small amount of mounts we actually
use) -- I am testing this as well.

Thanks!

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
