From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH 04/38] autofs4: Save autofs trigger's vfsmount
 in super block info
Date: Wed, 23 Jun 2010 09:23:34 +0800
Message-ID: <1277256214.2848.17.camel@localhost>
References: <1276627208-17242-1-git-send-email-vaurora@redhat.com>
	 <1276627208-17242-5-git-send-email-vaurora@redhat.com>
	 <1276661043.2339.35.camel@localhost> <1277091579.3827.9.camel@localhost>
	 <E1OQghj-0001Bt-RU@pomaz-ex.szeredi.hu> <1277181999.2829.2.camel@localhost>
	 <26799.1277185756@jrobl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=2iJ7xsdThi8TjJWJUCFc4KC1xCQ=; b=tdPRxUJ68NJN9k93LmKRVljFYTvmgmUtUhSISUNTvzLX3h81ATOlQfnhwjPriesEPFetN32vpNWuzVUCDCOMlLAx/IQ5BkcYHn8ManZrNQcr2I+z1AOAfAjKwyj9FfLNXuYWGvuH39I0mWlFZ6FVGN58Is0mdLw8nWtfwALsgmU=
In-Reply-To: <26799.1277185756@jrobl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "J. R. Okajima" <hooanon05@yahoo.co.jp>
Cc: Miklos Szeredi <miklos@szeredi.hu>, viro@zeniv.linux.org.uk, vaurora@redhat.com, autofs@linux.kernel.org, linux-kernel@vger.kernel.org, hch@infradead.org, linux-fsdevel@vger.kernel.org, jblunck@suse.de

On Tue, 2010-06-22 at 14:49 +0900, J. R. Okajima wrote:
> 
> Or how about iterate_mounts() instead of loop over dentries?
> For example (just a example),

I may be missing something about this, but why is it safe to use
iterate_mounts(), since it doesn't take the vfsmount_lock when
traversing the list of mounts?

Ian

