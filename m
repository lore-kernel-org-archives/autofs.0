From: Ian Kent <raven@themaw.net>
Subject: Re: autofs breaking nfs4 protocol by sending udp probes ?
Date: Thu, 24 Jan 2008 14:33:24 +0900
Message-ID: <1201152804.3061.28.camel@raven.themaw.net>
References: <478F7969.4080209@inria.fr>
	<1200967695.3078.1.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1200967695.3078.1.camel@raven.themaw.net>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org


On Tue, 2008-01-22 at 11:08 +0900, Ian Kent wrote:
> On Thu, 2008-01-17 at 16:51 +0100, Guillaume Rousse wrote:
> > According to nfs4 developpers, autofs is suspect there:
> > http://linux-nfs.org/pipermail/nfsv4/2007-December/007332.html
> 
> Please try this patch and let me know how it goes.

This one isn't right.
Can you try this one instead please.
http://www.kernel.org/pub/linux/daemons/autofs/v5/autofs-5.0.3-nfs4-tcp-only.patch

> Ian
> 
> ---
> diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
> index 0e7aebe..df01fd6 100644
> --- a/modules/mount_nfs.c
> +++ b/modules/mount_nfs.c
> @@ -129,7 +129,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
>  	}
>  
>  	if (strcmp(fstype, "nfs4") == 0)
> -		vers = NFS4_VERS_MASK | NFS_PROTO_MASK;
> +		vers = NFS4_VERS_MASK | NFS_TCP_SUPPORTED;
>  	else
>  		vers = NFS_VERS_MASK | NFS_PROTO_MASK;
>  
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
