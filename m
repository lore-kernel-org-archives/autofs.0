From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs - use dentry flags to block walks during expire
Date: Mon, 12 Sep 2016 14:07:15 -0700
Message-ID: <20160912140715.a56f7d696dec7acc19180025@linux-foundation.org>
References: <20160912014017.1773.73060.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20160912014017.1773.73060.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, autofs mailing list <autofs@vger.kernel.org>, NeilBrown <neilb@suse.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Mon, 12 Sep 2016 09:40:17 +0800 Ian Kent <raven@themaw.net> wrote:

> Somewhere along the way the autofs expire operation has changed to
> hold a spin lock over expired dentry selection. The autofs indirect
> mount expired dentry selection is complicated and quite lengthy so
> it isn't appropriate to hold a spin lock over the operation.
> 
> Commit 47be6184 added a might_sleep() to dput() causing a BUG()
> about this usage to be issued.

It's a WARN_ONCE(), not a BUG()?

> But the spin lock doesn't need to be held over this check, the
> autofs dentry info. flags are enough to block walks into dentrys
> during the expire.
> 
> I've left the direct mount expire as it is (for now) becuase it
> is much simpler and quicker than the indirect mount expire and
> adding spin lock release and re-aquires would do nothing more
> than add overhead.
> 
> Fixes: 47be61845c77 ("fs/dcache.c: avoid soft-lockup in dput()")
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: NeilBrown <neilb@suse.com>

47be61845c77 is cc:stable, so this should be likewise.

I've made those two changes to my copy of this changelog.

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
