From: Ian Kent <raven@themaw.net>
Subject: Re: Newbie Question
Date: Fri, 13 Aug 2004 07:51:31 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0408130745170.30055@wombat.indigo.net.au>
References: <411BAE2F.8040309@analog.com>
	<16667.46801.458839.821849@segfault.boston.redhat.com>
	<16667.49462.344049.857207@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16667.49462.344049.857207@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Thu, 12 Aug 2004, Jeff Moyer wrote:

> 
> Okay, get the source rpm for your kernel and install it.  Note that this is
> not the kernel-source-x.y.z rpm, but rather the kernel-x.y.z.src.rpm.  It
> will install to /usr/src/redhat/ by default.
> 
> Now, here's the tricky part.  I'm not sure if any of Ian's patch sets will
> apply cleanly to your Red Hat 8 kernel.  :(  You can try the patch against
> rh9, which can be found here:
> 
>      http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs4-2.4.20-redhat9-20040508.patch

This should apply over RH kernel source.

So, no need to re-build the rpms, just install the kernel-source rpm,
apply the above patch and build a custom kernel as normal.

Let me know if the patch does not apply.

> 
> In addition to this patch, you will want to install Ian's mount expiry
> patch for 2.4, which I've attached to this mail.

Will be needed if you use Jeffs testing rpms. This work is in progress so 
don't expect much. It should be largely finished soon.

Ian
