From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] Possible buffer overflow
Date: Thu, 30 Nov 2006 14:35:37 -0500
Message-ID: <x49mz68u3qu.fsf@segfault.boston.devel.redhat.com>
References: <n7xhcwghnj0.fsf@giuliani.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <n7xhcwghnj0.fsf@giuliani.suse.de> (Matthias Koenig's message of
	"Thu, 30 Nov 2006 18:06:43 +0100")
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
To: Matthias Koenig <mkoenig@suse.de>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> On Thu, 30 Nov 2006 18:06:43 +0100, Matthias Koenig <mkoenig@suse.de> said:

Matthias> Hi,
Matthias> There seems to be a possible buffer overflow in modules/mount_afs.c.
Matthias> strncat(dest, src, n) uses at most n chars from src. n is not the
Matthias> size of dest. Patch below.

The fix seems correct to me.  Have you actually seen a problem in the
wild?  I wonder why the dest string is twice the maximum path length;
that doesn't make a whole lot of sense.  Perhaps we should fix that
while we're in here.

-Jeff

> --- modules/mount_afs.c
> +++ modules/mount_afs.c
> @@ -36,8 +36,8 @@
>  	char dest[PATH_MAX * 2];

>  	strcpy(dest, root);	/* Convert the name to a mount point. */
> -	strncat(dest, "/", sizeof(dest));
> -	strncat(dest, name, sizeof(dest));
> +	strncat(dest, "/", sizeof(dest)-strlen(dest)-1);
> +	strncat(dest, name, sizeof(dest)-strlen(dest)-1);

>  	/* remove trailing slash (http://bugs.debian.org/141775) */
>  	if (dest[strlen(dest)-1] == '/')
