From: Ian Kent <raven@themaw.net>
Subject: Re: stat -L triggering mount (behavior change starting
 with 2.6.38-rc1)
Date: Fri, 01 Apr 2011 12:27:18 +0800
Message-ID: <1301632038.2880.11.camel@perseus>
References: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=S/5xRPEizPeveyrTpX9Dyb1lYrs=;
	b=MZCdzIXmbjxPnvsMBrJGEZM242TMvF07AfTLJ/XVbSGorQxLoASlFx+1TaS0dNA9bA+OzaNpIWAUvtl+VbcQaF1/444sHRrkdnkq2lpasgc/745HydKIGjNK4mopPbRk7fkanbAl9l1B9eEgX4nPgQN6n7Nnkc3h6aQy/rHVCDA=
In-Reply-To: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
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
Cc: autofs@linux.kernel.org, David Howells <dhowells@redhat.com>

On Mon, 2011-03-28 at 19:53 -0300, Leonardo Chiquitto wrote:
> Hello,
> 
> After the update to 2.6.38, I noticed that AutoFS started to mount volumes
> at times it normally wouldn't. More specifically, "ls -la" inside an AutoFS
> mount point will trigger the mount of all available maps.
> 
> This can be reproduced with a simple indirect mount setup:
> 
> # cat /etc/auto.master
> /data	/etc/auto.data
> 
> # cat /etc/auto.data
> isos	-fstype=nfs4,ro,rsize=8192,wsize=8192,intr,nolock,nosuid libre:/isos
> 
> # egrep '(autofs|nfs4)' /proc/mounts
> /etc/auto.data /data autofs rw,relatime,fd=7,pgrp=4300,timeout=600,minproto=5,\
>   maxproto=5,indirect 0 0
> 
> # stat -L /data/isos > /dev/null

How about an strace of this please?

> 
> # egrep '(autofs|nfs4)' /proc/mounts
> /etc/auto.data /data autofs rw,relatime,fd=7,pgrp=4300,timeout=600,minproto=5,\
>   maxproto=5,indirect 0 0
> libre:/isos /data/isos nfs4 ro,nosuid,relatime,vers=4,(.. more mount
> options ..) 0 0
> 
> Bisecting the changes between 2.6.37 and 2.6.38, I found that 2.6.38-rc1
> exhibits the new behavior already. I went as near 2.6.37 as I could and verified
> that commit b650c858c2 (autofs4: Merge the remaining dentry ops tables) also
> shows the new behavior. I tried to bisect the remaining ~18 commits
> but everything
> I tested/built ended up unbootable.
> 
> I also tested mainline and verified that the problem is still there.

There where two significant patch series merged in 2.6.38 which were to
similar parts of the VFS. One was the vfs-scale series and the other was
the vfs-automount series. So 2.6.38 had significant autofs changes.

I think the mount storm your seeing would be due to this check not
catching lstat(2) calls, but AFAICS it should catch this case:

        if (!(flags & LOOKUP_FOLLOW) &&
            !(flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY |
                       LOOKUP_OPEN | LOOKUP_CREATE)))
                return -EISDIR;

What do you think David?
Ian
