From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/9] Use %pd in AutoFS
Date: Thu, 12 Dec 2013 10:43:59 +0800
Message-ID: <1386816239.4312.39.camel@perseus.fritz.box>
References: <1386727713.2478.0.camel@perseus.fritz.box>
	 <20131210152612.4916.80435.stgit@warthog.procyon.org.uk>
	 <20131210152626.4916.67655.stgit@warthog.procyon.org.uk>
	 <1177.1386763766@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=Dt9p8NmP8HUxJzSKMpyhvSBRxiU=; b=WGwOVzoZGAZSl3EhBwGtbDXs9Io3
	NDbZ24Jfmoq4ZQSOKjj1wlugTXa1EG9ppJrD9uXYRcXdc6ypRPOSBQpGWF+Lptdq
	wWe2BtsCiBpBaPSoZAM6nDVcidGEznMMgHecSjSMveLb8lglLGuWYxRpyc8mLZhH
	xOTByuIwnW4kfQc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=Dt9p8NmP8HUxJzSKMpyhvS
	BRxiU=; b=sPm9yfr/yCQH/hnGYWFpETYYIN/nZ8TRDs6KyMjAp3KL0yrxFnMizf
	V+vwtmgCpPQiBILKi0W3eYpCL1q2LODYCnN+b+1FyxvDH8Eq3KsBdDw/2NmSDwap
	1tUCwuJhSM4tiQAil0ORH0b6wKTVFC2SwFNdOAiBaZkjPMlGlGx0A=
In-Reply-To: <1177.1386763766@warthog.procyon.org.uk>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Howells <dhowells@redhat.com>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org

On Wed, 2013-12-11 at 12:09 +0000, David Howells wrote:
> Ian Kent <raven@themaw.net> wrote:
> 
> > > Use the new %pd printk() specifier in AutoFS to replace passing of dentry name
> > > or dentry name and name length * 2 with just passing the dentry.
> > > 
> > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > cc: Ian Kent <raven@themaw.net>
> > > cc: autofs@vger.kernel.org
> > 
> > Looks sensible.
> > 
> > Acked-by: Ian Kent <raven@themaw.net>
> 
> Can you take the autofs bit through your tree?

Because there have been so few changes to autofs I don't maintain a
development tree.

I can take it if you wish but if I do it will need to be passed on to
akpm for inclusion in linux-next .... which will probably take a while.

Might be quicker if you include it in your patch set.
Your call though.

> 
> David


