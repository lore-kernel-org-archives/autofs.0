From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Remove master_mutex_unlock() leftover
Date: Tue, 14 Jun 2011 10:06:56 +0800
Message-ID: <1308017216.3268.0.camel@perseus.themaw.net>
References: <20110613213940.GA4908@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=BNaHX53mU2kkFLjg8oIkYBkUyZ4=;
	b=DYVuk+Av+bXt3dZiTzDDSvVwcxE9YSnVSOPiobBfQaMQxzKyDZHGoVZC0L2OrlXzUufuCvAQ4ldKIxiEfe4sikcaGFTXOteRvppk2W4CVjigycVTNku/Vb8IcNE2EdNjTtLUieI2q62dZhy3n9pGnKnqjFa3wPkho+WEqM4i6eM=
In-Reply-To: <20110613213940.GA4908@libre.l.ngdn.org>
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

On Mon, 2011-06-13 at 18:39 -0300, Leonardo Chiquitto wrote:
> Hello Ian, list
> 
> While trying to make some progress on the AB/BA locking issue, I
> think I've found a bug introduced by commit dc0c3734.

Committed, pushed and posted on kernel.org.
Thanks Leonard.

> 
> Thanks,
> Leonardo
> 
> 
> Remove master_mutex_unlock() leftover
> 
> Commit dc0c3734 ("fix out of order locking in readmap") removes
> the calls to master_mutex_lock() and master_mutex_unlock() from
> master_find_mapent(), but leaves an unlock behind.
> 
> Signed-off-by: Leonardo Chiquitto <lchiquitto@novell.com>
> 
> ---
>  lib/master.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> Index: autofs/lib/master.c
> ===================================================================
> --- autofs.orig/lib/master.c
> +++ autofs/lib/master.c
> @@ -643,10 +643,8 @@ struct master_mapent *master_find_mapent
>  
>  		entry = list_entry(p, struct master_mapent, list);
>  
> -		if (!strcmp(entry->path, path)) {
> -			master_mutex_unlock();
> +		if (!strcmp(entry->path, path))
>  			return entry;
> -		}
>  	}
>  
>  	return NULL;
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
