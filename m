From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/3] autofs4 - expiring filesystem from under process
Date: Sun, 10 Apr 2005 16:15:20 -0700
Message-ID: <20050410161520.19f67220.akpm@osdl.org>
References: <Pine.LNX.4.62.0504102048370.5212@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504102048370.5212@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: michael@kmaclub.com, linux-fsdevel@vger.kernel.org, jmoyer@redhat.com, autofs@linux.kernel.org

raven@themaw.net wrote:
>
> +	/* Is someone visiting anywhere in the tree ? */
>  +	if (autofs4_may_umount(mnt))

There's no such function in my tree...
