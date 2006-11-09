From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs4 patch] fix e2fsck error checking
Date: Thu, 09 Nov 2006 11:26:44 +0800
Message-ID: <1163042804.4475.3.camel@localhost>
References: <x49irhpnw8z.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49irhpnw8z.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Wed, 2006-11-08 at 22:18 -0500, Jeff Moyer wrote:
> Hi, Ian, list,
> 
> The patch is pretty self-explanatory.  Comments are welcome, as always.
> I sent this a while back, too.  I have not re-tested it since then.
> 
> -Jeff
> 
> 
> diff --git a/modules/mount_ext2.c b/modules/mount_ext2.c
> index b2efb96..a7f008f 100644
> --- a/modules/mount_ext2.c
> +++ b/modules/mount_ext2.c
> @@ -99,7 +99,13 @@ #endif
>  		err = spawnl(LOG_DEBUG, fsck_prog, fsck_prog, "-p", what, NULL);
>  	}
>  
> -	if (err & ~6) {
> +	/*
> +	 * spawnl returns the error code, left shifted by 8 bits.  We are

I thought I checked this and concluded it wasn't actually the case.
I'll check it again.

> +	 * interested in the following error bits from the fsck program:
> +	 *    2 - File system errors corrected, system should be rebooted
> +	 *    4 - File system errors left uncorrected
> +	 */
> +	if ((err >> 8) & 6) {
>  		error(MODPREFIX "%s: filesystem needs repair, won't mount",
>  		      what);
>  		return 1;
