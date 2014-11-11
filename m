From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/3] autofs - fix log print messages
Date: Mon, 10 Nov 2014 19:25:41 -0800
Message-ID: <1415676341.16070.0.camel@perches.com>
References: <20141111012954.25773.4002.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20141111012954.25773.4002.stgit@perseus.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 2014-11-11 at 09:29 +0800, Ian Kent wrote:
> Fix some inconsistencies in log print output and ensure that
> the module name is included in all log prints.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: Joe Perches <joe@perches.com>
> ---
>  fs/autofs/autofs_i.h  |    6 +++---
>  fs/autofs/dev-ioctl.c |    2 +-
>  fs/autofs/inode.c     |   10 +++++-----
>  fs/autofs/waitq.c     |    4 ++--
>  4 files changed, 11 insertions(+), 11 deletions(-)

What tree are these patches made against?


