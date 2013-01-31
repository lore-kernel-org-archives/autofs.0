From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] parisc: unbreak automounter support on 64-bit kernel
 with 32-bit userspace
Date: Fri, 01 Feb 2013 07:26:48 +1100
Message-ID: <1359664008.2468.5.camel@dabdike>
References: <20130131200110.GA6032@p100.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20130131200110.GA6032@p100.box>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

[adding autofs list and maintainer for their perusal and ack, although
this is an obvious fix to me

James]
On Thu, 2013-01-31 at 21:01 +0100, Helge Deller wrote:
> Similiar to other 64 bit Linux targets autofs_wqt_t needs to be of type int
> which has a size of 32 bits on 32- and 64-bit parisc kernels.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
> index 77cdba9..d551754 100644
> --- a/include/uapi/linux/auto_fs.h
> +++ b/include/uapi/linux/auto_fs.h
> @@ -43,7 +43,7 @@
>   */
>  
>  #if defined(__sparc__) || defined(__mips__) || defined(__x86_64__) \
> - || defined(__powerpc__) || defined(__s390__)
> + || defined(__powerpc__) || defined(__s390__) || defined(__hppa__)
>  typedef unsigned int autofs_wqt_t;
>  #else
>  typedef unsigned long autofs_wqt_t;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-parisc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


