From: devnull@adc.idt.com
Subject: Re: autofs and 2.6.x
Date: Mon, 10 May 2004 13:41:34 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0405101332190.27883-100000@who.adc.idt.com>
References: <Pine.LNX.4.58.0405102251560.28439@donald.themaw.net>
Reply-To: devnull@adc.idt.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405102251560.28439@donald.themaw.net>
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
To: raven@themaw.net
Cc: AutoFS on Linux Kernel <autofs@linux.kernel.org>

> Use the patches for your kernel at 
> http://www.kernel.org/pub/linux/kernel/people/raven
> 
> and add this patch for the ioctls. It applies with a small offset but 
> achieves the desired result. This fixes the problem for me on sparc64 but 
> I'm not sure avout x86_64. Let me know.

Doesnt seem to fix the problem. 

autofs seems to work fine, but ghosting doesnt. 

Is there anything else i can do on the machine to help debug the problem ?

> 
> --- linux-2.6.6-rc3-mm2/include/linux/compat_ioctl.h.orig	2004-05-09 23:06:04.000000000 +0800
> +++ linux-2.6.6-rc3-mm2/include/linux/compat_ioctl.h	2004-05-09 23:04:19.000000000 +0800
> @@ -546,6 +546,10 @@
>  COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER)
>  COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE)
>  COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI)
> +COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOSUBVER)
> +COMPATIBLE_IOCTL(AUTOFS_IOC_ASKREGHOST)
> +COMPATIBLE_IOCTL(AUTOFS_IOC_TOGGLEREGHOST)
> +COMPATIBLE_IOCTL(AUTOFS_IOC_ASKUMOUNT)
>  /* DEVFS */
>  COMPATIBLE_IOCTL(DEVFSDIOC_GET_PROTO_REV)
>  COMPATIBLE_IOCTL(DEVFSDIOC_SET_EVENT_MASK)

I am applying all the patches(the ones from /people/raven and this one) to 
the 2.6.4 tree. 

Should i be trying 2.6.6 instead ?
