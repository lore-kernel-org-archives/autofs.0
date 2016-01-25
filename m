From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] autofs: show pipe inode in mount options
Date: Tue, 26 Jan 2016 10:19:07 +1100
Message-ID: <20160126101907.388686e7@canb.auug.org.au>
References: <20151216120222.19097.54512.stgit@localhost.localdomain>
	<568E8840.3010801@odin.com>
	<1452237640.2973.19.camel@themaw.net>
	<568F9D85.6070601@odin.com>
	<1452257913.7030.25.camel@themaw.net>
	<568FD028.5090207@odin.com>
	<1452303110.3067.29.camel@themaw.net>
	<5693931F.9070101@odin.com>
	<56A213CA.5090704@odin.com>
	<1453509017.3042.7.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
	s=201601; t=1453763948;
	bh=/Lr/hSgSpmNr6MF9zo2I0X6oANFd7gPbwby+tngz+xQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b4MIV0nsltDaUpVa6FS8TiLRYdEWFSJ+s3kH0edH/hN5VomJukhzToK5wRSsSh+jR
	 n+Y2fa0Baj1tpwAon5H0xFMhd02uhfkvFTwVC/pYK1CVB3NI684YGoPbrnJx9YnTr8
	 y5omRN1XAdSy1cb5OLYeZrlwCOyjE/8xfCofB8h4=
In-Reply-To: <1453509017.3042.7.camel@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: skinsbursky@virtuozzo.com, criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>

Hi Ian,

On Sat, 23 Jan 2016 08:30:17 +0800 Ian Kent <raven@themaw.net> wrote:
>
> I haven't had anything significant enough for autofs to warrant
> maintaining a tree and sending push requests so I'll need to ask
> Stephen what I need to do (perhaps you could offer some advise on that
> now Stephen, please).

I guess if its just a few patches every now and then, then Andrew
Morton may be the best person to shepherd them upstream.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
