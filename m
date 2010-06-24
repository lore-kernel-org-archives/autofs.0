From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH 04/38] autofs4: Save autofs trigger's vfsmount
 in super block info
Date: Thu, 24 Jun 2010 09:35:50 +0800
Message-ID: <1277343350.2841.33.camel@localhost>
References: <1276627208-17242-1-git-send-email-vaurora@redhat.com>
	 <1276627208-17242-5-git-send-email-vaurora@redhat.com>
	 <1276661043.2339.35.camel@localhost> <1277091579.3827.9.camel@localhost>
	 <E1OQghj-0001Bt-RU@pomaz-ex.szeredi.hu> <1277181999.2829.2.camel@localhost>
	 <26799.1277185756@jrobl> <1277256214.2848.17.camel@localhost>
	 <9219.1277258833@jrobl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=eODs25Jnv9qkany5cm7gtSmoZzU=; b=ql+87GaQu+38r9A8Wq0QEDq+xhttdWmnXUg1SYudz3o90izsjsYoFt9kqSyh3JZhcvO6BXpuIRY3RiR2YPx7pb1Y3tLCIZ7Rddft3H9+A+ZrgAFl1MCatISPhemb3st/hNqHcfg28ijJeXmQYz1om2/UPMRfj/e0H8b2E6OsQ0I=
In-Reply-To: <9219.1277258833@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "J. R. Okajima" <hooanon05@yahoo.co.jp>
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@zeniv.linux.org.uk, vaurora@redhat.com, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, linux-fsdevel@vger.kernel.org, jblunck@suse.de

On Wed, 2010-06-23 at 11:07 +0900, J. R. Okajima wrote:
> Ian Kent:
> > I may be missing something about this, but why is it safe to use
> > iterate_mounts(), since it doesn't take the vfsmount_lock when
> > traversing the list of mounts?
> 
> The sample code was not correct.
> We need to acquire vfsmount_lock or down_read(namespace_sem).

This is looking more and more suspect the more I dig.

The only place iterate_mounts() is called is within the audit subsystem
AFAICS, and I don't see where vfsmount_lock is taken in that code. OTOH,
in fs/namespace.c it is pretty clear that vfsmount->mnt_list is
protected by the vfsmount_lock.

Ummm ... that's gota be broken but maybe someone can give a reason why
it isn't?

Ian


