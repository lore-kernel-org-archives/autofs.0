From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] autofs4 - add mount option to display mount device
Date: Wed, 27 Feb 2008 21:17:56 -0800
Message-ID: <20080227211756.9e57e8a6.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
	<Pine.LNX.4.64.0802261219500.8490@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802261219500.8490@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Tue, 26 Feb 2008 13:29:07 +0900 (WST) Ian Kent <raven@themaw.net> wrote:

> --- linux-2.6.25-rc2-mm1/fs/autofs4/inode.c.add-mount-device-display-option	2008-02-20 13:01:06.000000000 +0900
> +++ linux-2.6.25-rc2-mm1/fs/autofs4/inode.c	2008-02-20 13:03:45.000000000 +0900
> @@ -190,6 +190,7 @@ static int autofs4_show_options(struct s
>  	seq_printf(m, ",timeout=%lu", sbi->exp_timeout/HZ);
>  	seq_printf(m, ",minproto=%d", sbi->min_proto);
>  	seq_printf(m, ",maxproto=%d", sbi->max_proto);
> +	seq_printf(m, ",dev=%d", autofs4_get_dev(sbi));

%u would be more appropriate here.
