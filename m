From: David Meleedy <david.meleedy@analog.com>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Mon, 17 Jan 2005 11:19:51 -0500
Message-ID: <200501171619.j0HGJpEC029321@jetcar.spd.analog.com>
References: <Pine.LNX.4.61.0501172156170.1801@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Mon, 17 Jan 2005 22:01:31 +0800."
	<Pine.LNX.4.61.0501172156170.1801@donald.themaw.net> 
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


> Hi David,
> 
> I've found a small problem with the patch.
> Please update your rpms with the extra patch below or get the version I 
> have uploaded to the autofs v4 directory on kernel.org.

The small patch to the patch you sent did not work, however
the updated patch in:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.3-multi-over.patch

worked just fine.  I will get some testing done today and let you
know how it worked out.

Thanks again Ian,

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
