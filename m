From: Ian Kent <raven@themaw.net>
Subject: Re: Special map type "-hosts" no longer works
Date: Mon, 24 Mar 2014 12:53:47 +0800
Message-ID: <1395636827.2466.3.camel@perseus.fritz.box>
References: <CAEySpB4QciPfW4Cck=jrtZ0ht1neig8re9DG0i1BZ7NOQsfU4w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=yAmhD7nEl8qVC14F70tKzbw/KDk=; b=s10lzegQcNn2rJX6wR6A0zdfgERQ
	+9UmQy1M6hK9n5DPv+anfHnXfYaXakAouucTxNLsBLmuAbAmgFhfmupx6wbREr9w
	lDZPvllKGwOIc0d4b9Lj4HvXI/Yno1G1nau9XrsfeEBEGox9Fwgii+kSmVtmpwUC
	9ZoqYPZ7U8TdlKc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=yAmhD7nEl8qVC14F70tKzb
	w/KDk=; b=b9Te2bagjp1gDZy+AHFcV2NuVXU8j/T8F1f6UdwMfLOpIH1iS8pQbs
	VW/K8kyin5q1a1f+ZH8x95aNYAx7jrJGHAG4gFEJeZCV8xEAaNqFXsAiHb84GTHg
	yhN53W6JhqNa0WloREysg1gqmMSaqEYEODNIvS6QDRmNe02pLAMNc=
In-Reply-To: <CAEySpB4QciPfW4Cck=jrtZ0ht1neig8re9DG0i1BZ7NOQsfU4w@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs <autofs@vger.kernel.org>

On Fri, 2014-03-21 at 10:17 -0300, Leonardo Chiquitto wrote:
> Hi,
> 
> The last patches pushed to the git repository break the special -hosts
> map:

Indeed it does, thanks for catching this.

> 
> automount[29770]: ghosting enabled
> automount[29770]: master_do_mount: mounting /net
> automount[29770]: automount_path_to_fifo: fifo name /run/autofs.fifo-net
> automount[29770]: lookup_nss_read_map: reading map hosts (null)
> automount[29770]: mount_autofs_indirect: failed to read map for /net
> automount[29770]: handle_mounts: mount of /net failed!
> automount[29770]: master_do_mount: failed to startup mount
> systemd[1]: Started Automounts filesystems on demand.

Yep, got that.

snip ...

> 
> The culprit is probably commit e40bff4fb ("fix map source with type lookup").

Indeed it is, will fix immediately.

Ian


