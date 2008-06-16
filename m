From: Ian Kent <raven@themaw.net>
Subject: Re: autofs mountopints on NFS mounted filesystems
Date: Mon, 16 Jun 2008 21:37:25 +0800
Message-ID: <1213623445.18072.29.camel@raven.themaw.net>
References: <n7xiqwdslwk.fsf@sor.suse.de>
	<1213360565.18072.3.camel@raven.themaw.net>
	<n7xabhlsmrk.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <n7xabhlsmrk.fsf@sor.suse.de>
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


On Mon, 2008-06-16 at 12:21 +0200, Matthias Koenig wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Fri, 2008-06-13 at 11:51 +0200, Matthias Koenig wrote:
> >> Hi,
> >> 
> >> autofs will not create the autofs mountpoint path
> >> if the filesystem is not a locally mounted filesystem
> >> (e.g. a NFS mounted filesystem).
> >> contained_in_local_fs() returns false in this case.
> >> This might be intentional in most cases.
> >> 
> >> But how about if the root filesystem mounted via NFS?
> >> Do you see any problems adding an exceptional rule for this
> >> case?
> >
> > Yeah, sounds sensible.
> 
> Ok, how about the following patch?

Yeah, I'll commit it and post the patch to kernel.org as usual.

> 
> Thanks,
> Matthias
> 
> Index: autofs-5.0.3/lib/mounts.c
> ===================================================================
> --- autofs-5.0.3.orig/lib/mounts.c      2008-06-13 14:30:01.000000000 +0200
> +++ autofs-5.0.3/lib/mounts.c   2008-06-16 11:38:16.000000000 +0200
> @@ -363,6 +363,10 @@ int contained_in_local_fs(const char *pa
>                 if (!strncmp(path, this->path, len)) {
>                         if (len > 1 && pathlen > len && path[len] != '/')
>                                 continue;
> +                       else if (len == 1 && this->path[0] == '/')
> +                               /* alway return true on rootfs, we don't care
> +                                * here if it is local */
> +                               ret = 1;
>                         else if (this->fs_name[0] == '/') {
>                                 if (strlen(this->fs_name) > 1) {
>                                         if (this->fs_name[1] != '/')
