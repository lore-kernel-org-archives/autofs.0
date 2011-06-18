From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] AUTOFS4: Fix the return from
 autofs4_d_automount() and simplify autofs4_d_manage()
Date: Sat, 18 Jun 2011 18:06:19 +0800
Message-ID: <1308391579.12881.12.camel@perseus.themaw.net>
References: <20110618001104.29347.67602.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=usPNkjZ2MQfWw7XKRSQA5shT8LI=;
	b=ZJMdf/JR45cr2Ys44Bcc7wNmznvjcLT4OqqtaB9WG2l9o1BwJmrhWMRFBVyQw8yI9wNBp2PAQFRRAweetad5nZ+JZxuMVAXSw+lhwj7F9qb+whuk3RTxW8AnLGyHCHSNnc8NNmq3+VSBgPsDRUFkIEVT1ibWjq7UR5/wr0cG0AY=
In-Reply-To: <20110618001104.29347.67602.stgit@warthog.procyon.org.uk>
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
To: David Howells <dhowells@redhat.com>
Cc: autofs@linux.kernel.org, viro@ZenIV.linux.org.uk

On Sat, 2011-06-18 at 01:11 +0100, David Howells wrote:
> autofs4_d_automount() returns 0 if it detects that the calling process is in Oz
> mode (ie. it's the autofs userspace daemon).  This return, however, is meant to
> indicate to follow_automount() that the caller should retry the check on the
> the current path point.  In the Oz mode case, this is a bad idea because
> nothing has changed on the path, and follow_managed() will just repeat until
> follow_automount() hits the total_link_count limit and returns -ELOOP.
> 
> What it should do is return -EISDIR to indicate to the callers that actually it
> wants the daemon to see this directory as an ordinary directory.

No, not unless the check below can be changed to somehow not trigger
when LOOKUP_CONTINUE is set for autofs automount dentrys that don't
actually end up with a mount on them, but are automount triggers never
the less:

               if (PTR_ERR(mnt) == -EISDIR && (flags & LOOKUP_CONTINUE))
                        return -EREMOTE;
                return PTR_ERR(mnt);

Fact is in our discussions on this we could never reach agreement so I
worked around it by breaking out of the follow_managed() loop using
->d_managed() instead, thinking that the above check must remain to
satisfy the needs of other kernel users.

> 
> 
> Now, given that change outlined above, it is then unnecessary for
> autofs4_d_manage() to return -EISDIR if the current path point is not a
> mountpoint.  If it returns 0 instead, and the path point isn't a mountpoint,
> then follow_managed() will skip the attempt to transit to the mounted
> filesystem and proceed to call autofs4_d_automount(), which will return
> -EISDIR.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/autofs4/root.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index f55ae23..a6dc11c 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -334,7 +334,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
>  
>  	/* The daemon never triggers a mount. */
>  	if (autofs4_oz_mode(sbi))
> -		return NULL;
> +		return ERR_PTR(-EISDIR);
>  
>  	/*
>  	 * If an expire request is pending everyone must wait.
> @@ -435,13 +435,8 @@ int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
>  		dentry, dentry->d_name.len, dentry->d_name.name);
>  
>  	/* The daemon never waits. */
> -	if (autofs4_oz_mode(sbi)) {
> -		if (rcu_walk)
> -			return 0;
> -		if (!d_mountpoint(dentry))
> -			return -EISDIR;
> +	if (autofs4_oz_mode(sbi))
>  		return 0;
> -	}
>  
>  	/* We need to sleep, so we need pathwalk to be in ref-mode */
>  	if (rcu_walk)
> 
