From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS creates unmountable directories when ghosting
 is enabled
Date: Wed, 15 Dec 2010 10:49:04 +0800
Message-ID: <1292381344.2979.6.camel@perseus>
References: <20101210191042.GA4396@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=X66CTq5DZIBTaGu0XiZ4l3PsB+4=;
	b=Lj/gG8slTw5YtHvpC9D617iuioAJxZZlxDxy+V/wURX54CSOgzgXw6Kdt/SMAhCnhoFbLN1qmJfXQSnhSFv2sXFvD6aDnyCNo7m07pWdabHycgMULBrWNNi72LCNvDIjmxE7P1q0kl5dPJyq4NmdWUC1zaTLY5pa+5cMtzgT3IM=
In-Reply-To: <20101210191042.GA4396@libre.l.ngdn.org>
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

On Fri, 2010-12-10 at 17:10 -0200, Leonardo Chiquitto wrote:
> Hello Ian and list,
> 
> I'd like to forward a bug report we received on openSUSE's Bugzilla [1].
> Please consider the following setup to reproduce the problem:
> 
> host:~ # grep automount /etc/nsswitch.conf
> automount:	files
> 
> host:~ # cat /etc/auto.master
> /vol	/etc/auto.vol
> 
> host:~ # cat /etc/auto.vol
> data1	-fstype=nfs,ro,rsize=8192,wsize=8192,intr,nolock,nosuid	srv:/data1
> data2	-fstype=nfs,ro,rsize=8192,wsize=8192,intr,nolock,nosuid srv:/data2
> data3	-fstype=nfs,ro,rsize=8192,wsize=8192,intr,nolock,nosuid srv:/data3
> 
> host:~ # cat /etc/sysconfig/autofs
> AUTOFS_OPTIONS=""
> LOCAL_OPTIONS=""
> APPEND_OPTIONS="yes"
> DEFAULT_MASTER_MAP_NAME="auto.master"
> DEFAULT_TIMEOUT=600
> DEFAULT_BROWSE_MODE="yes"
> DEFAULT_LOGGING="debug"
> USE_MISC_DEVICE="yes"
> 
> host:~ # ls -F /vol
> data1/  data2/  data3/
> 
> The problem depends on ghosting being enabled (ie, BROWSE_MODE=yes).
> When we try to access a non-existent key/entry, AutoFS will fail to mount
> it but will still create the mount point:
> 
> host:~ # ls -d /vol/invalid; sleep 10; ls -d /vol/invalid
> ls: cannot access /vol/invalid: No such file or directory
> /vol/invalid
> 
> host:~ # ls -F /vol
> data1/  data2/  data3/  invalid/
> 
> The problem happens because lookup_ghost() iterates over all cached
> mapents and creates directories for each entry in the cache. Since
> the cache also stores entries for failed mounts (negative entries), it
> ends up creating directories for mount points that don't exist in the
> map.

Yes, an obvious problem.

> 
> I tested the patch below and it resolves the problem for me, but I'm not
> sure if this is the best (or even the correct) way to fix the bug. I'd
> appreciate if you could review and comment.

Yeah, at first I thought there were a few other cases.
There still might be so let me think about it further.

> 
> Thanks,
> Leonardo
> 
> [1] https://bugzilla.novell.com/show_bug.cgi?id=658734
> 
> When ghosting is enabled, don't create mount points for cached entries
> that don't have a valid mapent.
> 
> Index: autofs-5.0.5/daemon/lookup.c
> ===================================================================
> --- autofs-5.0.5.orig/daemon/lookup.c
> +++ autofs-5.0.5/daemon/lookup.c
> @@ -604,6 +604,9 @@ int lookup_ghost(struct autofs_point *ap
>  			if (!strcmp(me->key, "*"))
>  				goto next;
>  
> +			if (!me->mapent)
> +				goto next;
> +
>  			if (*me->key == '/') {
>  				/* It's a busy multi-mount - leave till next time */
>  				if (list_empty(&me->multi_list))
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
