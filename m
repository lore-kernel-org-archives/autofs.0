From: Ian Kent <raven@themaw.net>
Subject: Re: When ghosting is enabled, failed mounts by AutoFS leave broken
 directories
Date: Tue, 25 Sep 2012 10:13:49 +0800
Message-ID: <1348539229.2307.26.camel@perseus.themaw.net>
References: <CAEySpB59DaMnK2Ge4r-kzZhA_mG-88Nz_sVpMv-tJDUM3CJ9-w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=ouI6XpFnptGxdf4ZHbP5ZtDUqAc=; b=Cvm8gmAGNpG/HWiwQpz/xIANgizl
	XbPZWK72BbXR2IkgYVOZTN6nyumFIWtvU6JA0iFu7RJQQePWJgoDw3P3i/tbrZK3
	VqTNgIN8TYWtGSopGGawDspQQGOphcIHVG8KTVWO2aUQ5L+CclbZ1OQbkyj2cn54
	bSZ3HNq6MZaJ6IE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=ouI6XpFnptGxdf4ZHbP5ZtDUqAc=; b=lbd
	CBHiRNlgh+YkDTVwKKEypi7tTKunAb9t5htsfVomIHK/MGs0vBy0S0Pofyqy4H86
	J2AR5exTlHo3LqOidvc/uve5d+0G9D5gTfLfLl9BLXr1aean3X6Z00V1S5E/lAIf
	XsdUr0wvhFoPL8wdAbv2pzzGkQtgaCakouqKOnZY=
In-Reply-To: <CAEySpB59DaMnK2Ge4r-kzZhA_mG-88Nz_sVpMv-tJDUM3CJ9-w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu

On Mon, 2012-09-24 at 17:14 -0300, Leonardo Chiquitto wrote:
> Hi,
> 
> If you try to access an automounted directory and the mount operation fails,
> the attributes of the directory (owner, group, mode, access time) are lost.
> This happens only when AutoFS' browse mode (ghosting) is enabled.
> 
> How to reproduce the problem:
> 
> Make sure you have BROWSE_MODE="yes" in /etc/sysconfig/autofs.
> 
> 1. Add a simple indirect mount map (it's required that the server does NOT
>    export the /notexported directory):
> 
> # cat /etc/auto.master
> /nfs    /etc/auto.nfs
> 
> # cat /etc/auto.nfs
> v2      server:/notexported
> 
> 2. Restart AutoFS and try to access the directory:
> 
> # cd /nfs/v2
> -bash: cd: /nfs/v2: No such file or directory
> 
> # ls -la /nfs
> ls: cannot access /nfs/v2: No such file or directory
> total 4
> drwxr-xr-x  3 root root    0 Sep 24 21:43 .
> drwxr-xr-x 28 root root 4096 Sep 24 21:25 ..
> d?????????  ? ?    ?       ?            ? v2
> 
> This problem is reproducible on recent upstream kernels such as 3.6.0-rc6.
> I found out that the last kernel version that does not exhibit the bug is
> 2.6.37. Between 2.6.37 and 2.6.38 there were quite some changes in
> AutoFS/VFS and my attempts to bisect the problem were frustrated by
> early crashes.
> 
> Any ideas?

Not really.

It would be best to start with an full autofs debug log so we can see
what is happening within automount and work back from there. We'll
probably need to look at the dentry itself as well to see if we can get
any info about where it came from possibly, with a kernel dump.

Ian


