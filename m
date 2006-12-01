From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Possible buffer overflow
Date: Fri, 01 Dec 2006 10:01:50 +0800
Message-ID: <1164938510.3404.6.camel@localhost>
References: <n7xhcwghnj0.fsf@giuliani.suse.de>
	<x49mz68u3qu.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49mz68u3qu.fsf@segfault.boston.devel.redhat.com>
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

On Thu, 2006-11-30 at 14:35 -0500, Jeff Moyer wrote:
> ==> On Thu, 30 Nov 2006 18:06:43 +0100, Matthias Koenig <mkoenig@suse.de> said:
> 
> Matthias> Hi,
> Matthias> There seems to be a possible buffer overflow in modules/mount_afs.c.
> Matthias> strncat(dest, src, n) uses at most n chars from src. n is not the
> Matthias> size of dest. Patch below.
> 
> The fix seems correct to me.  Have you actually seen a problem in the
> wild?  I wonder why the dest string is twice the maximum path length;
> that doesn't make a whole lot of sense.  Perhaps we should fix that
> while we're in here.

Yes, that array does seem to be excessive.
I was thinking that it would be better to calculate the length, check it
and then do the copy.

> 
> -Jeff
> 
> > --- modules/mount_afs.c
> > +++ modules/mount_afs.c
> > @@ -36,8 +36,8 @@
> >  	char dest[PATH_MAX * 2];
> 
> >  	strcpy(dest, root);	/* Convert the name to a mount point. */
> > -	strncat(dest, "/", sizeof(dest));
> > -	strncat(dest, name, sizeof(dest));
> > +	strncat(dest, "/", sizeof(dest)-strlen(dest)-1);
> > +	strncat(dest, name, sizeof(dest)-strlen(dest)-1);
> 
> >  	/* remove trailing slash (http://bugs.debian.org/141775) */
> >  	if (dest[strlen(dest)-1] == '/')
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
