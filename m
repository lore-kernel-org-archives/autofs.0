From: Ian Kent <raven@themaw.net>
Subject: Re: 5.0.5 non-expiring mounts
Date: Mon, 28 Mar 2011 11:17:35 +0800
Message-ID: <1301282255.2934.9.camel@perseus>
References: <4D510D53.7010507@gmail.com>
	<AANLkTim6qQCGZiDkoRrG7AXHpexrYy74dG9z1cFbmHew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=tTy0UVed6ZP2yC7WJcj0IFYsqac=;
	b=gEkxNBiuygp2MxaTRCgr7aZ6BdoR5B5JiULOVXABEMrLwbGqhWCWH/WeJNC/bFMHT5kLOSl26GMLwFoOOLsvoTMklR2cTxVGV+sWIb3SK2cFStW4YPcqFE1kPlvcFdh5KB8pJamL3tE3W5EYnwZfaAK9AU63p1jQrN3EhZtf6kw=
In-Reply-To: <AANLkTim6qQCGZiDkoRrG7AXHpexrYy74dG9z1cFbmHew@mail.gmail.com>
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
Cc: autofs@linux.kernel.org, "Philip Ong Jr." <pongjr@gmail.com>

On Thu, 2011-03-24 at 19:03 -0300, Leonardo Chiquitto wrote:
> 
> I finally had time to return to this issue. To avoid the confusion caused by old
> kernels, I reproduced the problem on openSUSE Factory (kernel 2.6.38 and
> autofs 5.0.5 with all kernel.org patches applied). Here's the
> configuration used:
> 
> # cat /etc/auto.master
> /data	/etc/auto.data
> 
> # cat /etc/auto.data
> isos	-fstype=nfs,ro,rsize=8192,wsize=8192,intr,nolock,nosuid libre:/isos
> 
> # cat /etc/sysconfig/autofs | grep -v '^#'
> AUTOFS_OPTIONS=""
> LOCAL_OPTIONS=""
> APPEND_OPTIONS="yes"
> USE_MISC_DEVICE="yes"
> DEFAULT_MASTER_MAP_NAME="auto.master"
> DEFAULT_TIMEOUT=600
> DEFAULT_BROWSE_MODE="yes"
> DEFAULT_LOGGING="debug"
> DEFAULT_MAP_OBJECT_CLASS="nisMap"
> DEFAULT_ENTRY_OBJECT_CLASS="nisObject"
> DEFAULT_MAP_ATTRIBUTE="nisMapName"
> DEFAULT_ENTRY_ATTRIBUTE="cn"
> DEFAULT_VALUE_ATTRIBUTE="nisMapEntry"
> DEFAULT_AUTH_CONF_FILE="etc/autofs_ldap_auth.conf"
> MAP_HASH_TABLE_SIZE=1024
> 
> I'm attaching the automount debug logs showing the following sequence:
> 
> - automount startup
> - mount of an NFS volume (/data/isos)
> - failed attempt to trigger the expiration of the mounted volume (sending
>   SIGUSR1)
> - successful attempt to trigger the expiration of the mounted volume
>   (sending SIGUSR1 again)
> 
> I also confirmed that the problem no longer happens if I revert the
> following commit:
> 
> commit 08aafab4c1d0ab6227c80f8cd1086ae78556a370
> Author: Ian Kent <raven@themaw.net>
> Date:   Thu Sep 9 11:10:47 2010 +0800
> 
>     autofs-5.0.5 - fix direct map not updating on reread
> 
> Philip, do you think you could try to revert it in your setup/package just
> to confirm this "works"?

The problem was actually introduced by
autofs-5.0.5-remove-state-machine-timed-wait.patch.

There had been a long standing bug in the state queue handling which I
thought was a pthreads problem. When I added the above patch everything
appeared to work OK.

But the change you mentioned above exposed the bug and the log you
provided allowed me to work out what was broken and fix it.

But the stale map processing has also been broken somewhere along the
way and I'm also working on fixing that.

Once that's done there's not much more needed for 5.0.6, at last.

Ian
