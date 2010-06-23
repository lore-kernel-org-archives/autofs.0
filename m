From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH 04/38] autofs4: Save autofs trigger's vfsmount
 in super block info
Date: Wed, 23 Jun 2010 10:37:58 +0800
Message-ID: <1277260678.2848.19.camel@localhost>
References: <1276627208-17242-1-git-send-email-vaurora@redhat.com>
	 <1276627208-17242-5-git-send-email-vaurora@redhat.com>
	 <1276661043.2339.35.camel@localhost> <1277091579.3827.9.camel@localhost>
	 <E1OQghj-0001Bt-RU@pomaz-ex.szeredi.hu> <1277181999.2829.2.camel@localhost>
	 <26799.1277185756@jrobl> <1277256214.2848.17.camel@localhost>
	 <9219.1277258833@jrobl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=OObzdq9UcrByK/t2gBn9tgWhxcc=; b=ZJwsriype83SQnvJ7Q6w3S2sbk09om1VJtT3LPBc5EZrS+FRhDuVL9RqiCrjV0eifuNRd5Naluu0IpaoOdiQSP0zrYcIIqWQA3clzqbGW5vaXruGMxX46Jw6oL5u77xPdK76br9VKJ2gSYPtSGJrIZSx5ySJAXFrNhp7O0mEv5k=
In-Reply-To: <9219.1277258833@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
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
> 
> Or it may be better to extract the body of iterate_mounts() and create a
> new function __iterate_mounts() such like that.
> 
> __iterate_mounts()
> {
> 	/* equiv to the current iterate_mounts */
> }
> 
> iterate_mount()
> {
> 	down_read(namespace_sem);
> 	or spin_lock(&vfsmount_lock);
> 
> 	__iterate_mount();
> 
> 	spin_unlock(&vfsmount_lock);
> 	or up_read(namespace_sem);
> }

Yep, thought so.
That's a useful enough function to warrant that IMHO.
I'll continue checking its usages before I do it though.

Ian

