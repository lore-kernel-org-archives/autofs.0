From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 04/13] autofs4 - change printks AUTOFS defined prints
Date: Mon, 03 Nov 2014 00:25:36 -0800
Message-ID: <1415003136.17743.9.camel@perches.com>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
	 <20141103081234.6215.82821.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20141103081234.6215.82821.stgit@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2014-11-03 at 16:12 +0800, Ian Kent wrote:
> Use the AUTOFS_*() print defines instead of raw printks.

Please check the output of these conversions.

For instance:

> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
[]
> @@ -162,7 +162,7 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
>  		break;
>  	}
>  	default:
> -		printk("autofs4_notify_daemon: bad type %d!\n", type);
> +		AUTOFS_WARN("autofs4_notify_daemon: bad type %d!", type);
>  		mutex_unlock(&sbi->wq_mutex);
>  		return;
>  	}

The current #define is:

#define AUTOFS_WARN(fmt, ...)                          \
	pr_warn("pid %d: %s: " fmt "\n",        \
		current->pid, __func__, ##__VA_ARGS__)
 
So this duplicates the function name in the output.

It's probably better to simply use
	#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
or
	#define pr_fmt(fmt) KBUILD_MODNAME ":%d:%s" fmt, current->pid, __func__
if you _really_ want pid/func in the output

and just use pr_<level> instead of AUTOFS_<LEVEL> macros.

And it's better to use a consistent style for
these logging functions ideally with terminating
newlines so there isn't a mix of code with
and without those newlines.  That inconsistency
leads to unintended defects.


