From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: Re: [PATCH 3/4] Easy alloca() replacements
Date: Fri, 9 Jan 2009 15:48:51 -0500
Message-ID: <20090109204851.GJ32333@shell>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<1231526823-18595-3-git-send-email-vaurora@redhat.com>
	<1231526823-18595-4-git-send-email-vaurora@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1231526823-18595-4-git-send-email-vaurora@redhat.com>
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
To: autofs@linux.kernel.org

On Fri, Jan 09, 2009 at 01:47:02PM -0500, Valerie Aurora Henson wrote:
> 
> --- a/daemon/direct.c
> +++ b/daemon/direct.c
> @@ -742,11 +742,9 @@ int mount_autofs_offset(struct autofs_point *ap, struct mapent *me, const char *
>  
>  	type = ap->entry->maps->type;
>  	if (type && !strcmp(ap->entry->maps->type, "hosts")) {
> -		char *tmp = alloca(7);
> -		if (tmp) {
> -			strcpy(tmp, "-hosts");
> -			map_name = (const char *) tmp;
> -		}
> +		char tmp[7];
> +		strcpy(tmp, "-hosts");
> +		map_name = (const char *) tmp;
>  	} else
>  		map_name = me->mc->map->argv[0];
>  

tmp is being accessed outside of the scope it is declared in, I'll fix
that too.

-VAL
