From: raven@themaw.net
Subject: Re: autofs and 2.6.x
Date: Mon, 10 May 2004 22:55:55 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405102251560.28439@donald.themaw.net>
References: <Pine.LNX.4.44.0405100948310.23174-100000@who.adc.idt.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0405100948310.23174-100000@who.adc.idt.com>
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
To: devnull@adc.idt.com
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

On Mon, 10 May 2004 devnull@adc.idt.com wrote:

> > Had a look at this. This is due to the ioctl 32 bit emulation layer not 
> > being told yet about the added ioctls in the latest autofs4.
> > 
> > This is also true on 2.4 and 64 bit archs.
> > 
> > If I make a patch can you test it for me on your arch. I can only test on 
> Most definitely. 
> 
> Thanks for your help!!

Use the patches for your kernel at 
http://www.kernel.org/pub/linux/kernel/people/raven

and add this patch for the ioctls. It applies with a small offset but 
achieves the desired result. This fixes the problem for me on sparc64 but 
I'm not sure avout x86_64. Let me know.

--- linux-2.6.6-rc3-mm2/include/linux/compat_ioctl.h.orig	2004-05-09 23:06:04.000000000 +0800
+++ linux-2.6.6-rc3-mm2/include/linux/compat_ioctl.h	2004-05-09 23:04:19.000000000 +0800
@@ -546,6 +546,10 @@
 COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER)
 COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE)
 COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI)
+COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOSUBVER)
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKREGHOST)
+COMPATIBLE_IOCTL(AUTOFS_IOC_TOGGLEREGHOST)
+COMPATIBLE_IOCTL(AUTOFS_IOC_ASKUMOUNT)
 /* DEVFS */
 COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV)
 COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)
