From: Ian Kent <raven@themaw.net>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Tue, 18 Jan 2005 09:33:16 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0501180931470.32570@wombat.indigo.net.au>
References: <200501171619.j0HGJpEC029321@jetcar.spd.analog.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200501171619.j0HGJpEC029321@jetcar.spd.analog.com>
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@sun.com>

On Mon, 17 Jan 2005, David Meleedy wrote:

> 
> > Hi David,
> > 
> > I've found a small problem with the patch.
> > Please update your rpms with the extra patch below or get the version I 
> > have uploaded to the autofs v4 directory on kernel.org.
> 
> The small patch to the patch you sent did not work, however
> the updated patch in:
> 
> ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.3-multi-over.patch
> 
> worked just fine.  I will get some testing done today and let you
> know how it worked out.

Oops.

Alls well that ends well!

Ian
