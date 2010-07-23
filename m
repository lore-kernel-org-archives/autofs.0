From: Ian Kent <raven@themaw.net>
Subject: Re: Making "verbose" mode a little less verbose
Date: Fri, 23 Jul 2010 13:36:33 +0800
Message-ID: <1279863393.2969.11.camel@localhost>
References: <20100706181115.GA23693@libre.l.ngdn.org>
	<1279686981.2936.20.camel@localhost>
	<20100722195544.GA13097@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=rNv061iZv6fb8Ld6ULwZymsm/Cg=;
	b=H4CGl6aeV5S9DOwBKo95IKMszehRsX0CnkDfNWTDA5fwY/Co/NYd7t+BqD8ExgUMXCC7JnkIRq7WFRLya5VD53X6SYSPeqwcNnGLH3xR8VnnyQsfC6LSrfdNB4TbBvS3CQ/N5cT5mvIFyDXZjWtDJvkpatsgWiCNcZaOyQJv+pQ=
In-Reply-To: <20100722195544.GA13097@libre.l.ngdn.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 2010-07-22 at 16:55 -0300, Leonardo Chiquitto wrote:
> On Wed, Jul 21, 2010 at 12:36:21PM +0800, Ian Kent wrote:
> > On Tue, 2010-07-06 at 15:11 -0300, Leonardo Chiquitto wrote:
> > > Hello AutoFS developers,
> > > 
> > > I'm trying to improve the usefulness of "verbose" logs for a customer.
> > > The problem they currently face can be summarized as: they need some
> > > messages that are only logged with DEFAULT_LOGGING="verbose" (or debug),
> > > but enabling the verbose mode on busy servers (hundreds of users and
> > > AutoFS mount points) causes a significant traffic increase on their
> > > syslog infrastructure.
> > > 
> > > My first idea was to introduce a new log level ("normal") and move the
> > > most important messages from "verbose" to "normal", but I realized later
> > > that this would require some redesign to allow some info() messages to
> > > be printed only on "verbose" mode. Since this would be more intrusive,
> > > I decided to go with a simpler proposal: move some "verbose" messages
> > > to "debug" level. Here are some examples of messages that would be
> > > demoted to debug (prefixed with -):
> > 
> > Leonardo and Michael, as you've probably guessed, I've been avoiding
> > replying to this for a while now.
> > 
> > The problem is that there are two different views on this, one saying
> > there isn't enough logging and others saying there is too much, *sigh*.
> > 
> > > 
> > > Successful mount:
> > > 
> > >   14:49:13 n1 automount[1013]: attempting to mount entry /v/temp
> > >  -14:49:13 n1 automount[1013]: mount(nfs): mounted libre:/temp on /v/temp
> > >   14:49:13 n1 automount[1013]: mounted /v/temp
> > 
> > This is a good opportunity to eliminate some extra logging, good.
> > 
> > > 
> > > Invalid map:
> > > 
> > >   14:51:15 n1 automount[1013]: attempting to mount entry /v/no
> > >  -14:51:15 n1 automount[1013]: key "no" not found in map source(s).
> > >   14:51:15 n1 automount[1013]: failed to mount /v/no
> > 
> > This is the problem for me.
> > 
> > This annoying constant key not found logging was the result of a
> > customer complaining that they couldn't work out if a problem was due to
> > a non-existent key or some other issue, so I'd rather not remove it. It
> > should only be logged once on the first lookup of a non-existent key and
> > once again after the negative cache entry times out. There was however a
> > bug with the negative caching of non-existent keys, so we would need to
> > check that the source in use is up to date wrt. this issue, and that it
> > is working the way it is supposed to and then see how the logging goes.
> 
> Ian,
> 
> I believe the customer's complain makes sense. I missed this use case.
> Here's an updated patch without the "key not found" chunk.

Sure, I've had a quick look and it looks fine.
I'll get to it as soon as I can.

> 
> Thanks,
> Leonardo
> 
> 
> Move some informational logs to debug level to avoid redundancy.
> 
> ---
>  daemon/lookup.c         |    2 +-
>  daemon/automount.c      |    2 +-
>  modules/mount_changer.c |    2 +-
>  modules/mount_ext2.c    |    2 +-
>  modules/mount_generic.c |    2 +-
>  modules/mount_nfs.c     |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> Index: autofs/daemon/lookup.c
> ===================================================================
> --- autofs.orig/daemon/lookup.c
> +++ autofs/daemon/lookup.c
> @@ -688,7 +688,7 @@ static int lookup_name_file_source_insta
>  	char *type, *format;
>  
>  	if (stat(map->argv[0], &st) == -1) {
> -		warn(ap->logopt, "file map not found");
> +		debug(ap->logopt, "file map not found");
>  		return NSS_STATUS_NOTFOUND;
>  	}
>  
> Index: autofs/daemon/automount.c
> ===================================================================
> --- autofs.orig/daemon/automount.c
> +++ autofs/daemon/automount.c
> @@ -512,7 +512,7 @@ static int umount_subtree_mounts(struct
>  	 * it already to ensure it's ok to remove any offset triggers.
>  	 */
>  	if (!is_mm_root && is_mounted(_PATH_MOUNTED, path, MNTS_REAL)) {
> -		info(ap->logopt, "unmounting dir = %s", path);
> +		debug(ap->logopt, "unmounting dir = %s", path);
>  		if (umount_ent(ap, path)) {
>  			warn(ap->logopt, "could not umount dir %s", path);
>  			left++;
> Index: autofs/modules/mount_changer.c
> ===================================================================
> --- autofs.orig/modules/mount_changer.c
> +++ autofs/modules/mount_changer.c
> @@ -129,7 +129,7 @@ int mount_mount(struct autofs_point *ap,
>  
>  		return 1;
>  	} else {
> -		info(ap->logopt, MODPREFIX "mounted %s type %s on %s",
> +		debug(ap->logopt, MODPREFIX "mounted %s type %s on %s",
>  		    what, fstype, fullpath);
>  		return 0;
>  	}
> Index: autofs/modules/mount_ext2.c
> ===================================================================
> --- autofs.orig/modules/mount_ext2.c
> +++ autofs/modules/mount_ext2.c
> @@ -140,7 +140,7 @@ int mount_mount(struct autofs_point *ap,
>  
>  		return 1;
>  	} else {
> -		info(ap->logopt,
> +		debug(ap->logopt,
>  		      MODPREFIX "mounted %s type %s on %s",
>  		      what, fstype, fullpath);
>  		return 0;
> Index: autofs/modules/mount_generic.c
> ===================================================================
> --- autofs.orig/modules/mount_generic.c
> +++ autofs/modules/mount_generic.c
> @@ -122,7 +122,7 @@ int mount_mount(struct autofs_point *ap,
>  
>  		return 1;
>  	} else {
> -		info(ap->logopt, MODPREFIX "mounted %s type %s on %s",
> +		debug(ap->logopt, MODPREFIX "mounted %s type %s on %s",
>  		     loc, fstype, fullpath);
>  		free(loc);
>  		return 0;
> Index: autofs/modules/mount_nfs.c
> ===================================================================
> --- autofs.orig/modules/mount_nfs.c
> +++ autofs/modules/mount_nfs.c
> @@ -251,7 +251,7 @@ int mount_mount(struct autofs_point *ap,
>  		}
>  
>  		if (!err) {
> -			info(ap->logopt, MODPREFIX "mounted %s on %s", loc, fullpath);
> +			debug(ap->logopt, MODPREFIX "mounted %s on %s", loc, fullpath);
>  			free(loc);
>  			free_host_list(&hosts);
>  			return 0;
