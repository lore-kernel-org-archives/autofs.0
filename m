From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: 4.8-rc4 spews "BUG: sleeping function called from invalid
 context at fs/dcache.c:757"
Date: Mon, 29 Aug 2016 16:18:55 +0100
Message-ID: <20160829151855.GH2356@ZenIV.linux.org.uk>
References: <s5ha8fv4p8d.wl-tiwai@suse.de>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5ha8fv4p8d.wl-tiwai@suse.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Aug 29, 2016 at 04:35:46PM +0200, Takashi Iwai wrote:

>   [<ffffffff81260b26>] dput+0x46/0x400
	... which should not be called in atomic contexts
>   [<ffffffff8124ff67>] follow_down_one+0x27/0x60
	... and neither should this
>   [<ffffffff81344da2>] autofs4_mount_busy+0x32/0x110
	... nor that (for fsck sake, there's full-blown path_put() in it!)
>   [<ffffffff81345081>] should_expire+0x51/0x3d0
	... so that would better not be called in atomic either (incidentally,
it also calls dput() directly)
>   [<ffffffff81345790>] autofs4_expire_indirect+0x190/0x2d0
	... while here it is called under sbi->fs_lock.

> I don't remember of a similar stack trace in the past, so if any, it
> can be a regression in 4.8 kernel.  But I cannot say it in 100%, as
> this looks spontaneous, nor I would be able to reproduce it at the
> next boot...

It's old; the race is narrow, but it's been there for quite a while, by
the look of it.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
