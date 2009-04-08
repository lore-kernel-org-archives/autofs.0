From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] unlock_kernel() in autofs
Date: Wed, 08 Apr 2009 14:40:31 +0800
Message-ID: <49DC46DF.4080908@themaw.net>
References: <alpine.DEB.2.00.0904070829180.522@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.DEB.2.00.0904070829180.522@bicker>
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
To: Dan Carpenter <error27@gmail.com>
Cc: autofs@linux.kernel.org, hpa@zytor.com

Dan Carpenter wrote:
> There are a couple missing unlock_kernel() calls on error paths in autofs 
> version 2.6.29.

Hi Dan,

Thanks for your patch.

You may not be aware but the autofs4 kernel module may satisfy your
needs and it is actively maintained whereas I haven't been paying much
attention to the autofs module for some time now.

I plan on submitting patches to retire the autofs module sometime fairly
soon but haven't yet constructed a list of relevant maintainers to start
the awareness and discussion process.

Can you tell me in what environment you use the autofs kernel module?
Do you actually need to use autofs version 2 kernel communication protocol?
Have you checked to see if the autofs4 kernel module will satisfy your
needs?

> 
> Found by smatch (http://repo.or.cz/w/smatch.git).  Compile tested.

Source code analysis?
Is there a home page or download?

> 
> regards,
> dan carpenter
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> --- orig/fs/autofs/root.c	2009-04-07 08:24:53.000000000 +0300
> +++ devel/fs/autofs/root.c	2009-04-07 08:27:35.000000000 +0300
> @@ -334,8 +334,10 @@
>  	autofs_hash_insert(dh,ent);
>  
>  	inode = autofs_iget(dir->i_sb, ent->ino);
> -	if (IS_ERR(inode))
> +	if (IS_ERR(inode)) {
> +		unlock_kernel();
>  		return PTR_ERR(inode);
> +	}
>  
>  	d_instantiate(dentry, inode);
>  	unlock_kernel();
> @@ -480,6 +482,7 @@
>  	inode = autofs_iget(dir->i_sb, ino);
>  	if (IS_ERR(inode)) {
>  		drop_nlink(dir);
> +		unlock_kernel();
>  		return PTR_ERR(inode);
>  	}
>  
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
