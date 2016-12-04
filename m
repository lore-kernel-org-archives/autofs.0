From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Sun, 04 Dec 2016 10:07:48 +0800
Message-ID: <1480817268.3157.4.camel@themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
         <20161203051322.GA24765@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=Ov8jlnleuNnGpYW
        v24vgXLUMPLY=; b=x8hvSrdq/FAK5zRhZzEBetvMEyTY08wNf8j0wRNfaTZ4w37
        fdbWsvidZ/uxJWg3G3EmmsLMu/u6ad5XvJvRk43+RSomgHaEtIn7QvswQGx4L2z8
        bm2Vqvpjt4emObNVGeA8yR8wTuT/mm+V0p10MZ+YUJkSio2UEu3eUm7QLM3k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=Ov8jlnleuNnGpYWv24vgXLUMPLY=; b=I9ovvtw8XPLivNVdA/aV
        Zv2MS1aKZ0AmNWGkxshHsfbKI9VEk9luZYRud1Ldh3BjVP3nXNVM+NcGa6PfTD/d
        UHZrBL9N3XdbKMaoAERI2+HbiaIoGRuz/FqZtkOW4D/Ni5IKRGjsmxu5I9fLb4xD
        oVd5M3KYkrC+B5Z4mFX4u7s=
In-Reply-To: <20161203051322.GA24765@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Sat, 2016-12-03 at 05:13 +0000, Al Viro wrote:
> 	FWIW, I've folded that pile into vfs.git#work.autofs.
> 
> Problems:
> 	* (fixed) __path_is_mountpoint() should _not_ treat NULL from
> __lookup_mnt() as "nothing's mounted there" until it has checked
> that mount_lock hadn't been touched - mount --move on something unrelated
> can race with lockless hash lookup and lead to false negatives.

Right, looking at what you've done there the mistake is so obvious now!
Thanks for helping with it.

> 	* linux/mount.h might be the wrong place for path_is_mountpoint().
> Or it shouldn't be inlined.  I don't like the includes you've added there.
> 	* path_has_submounts() is broken.  At the very least, it's
> AB-BA between mount_lock and rename_lock.  I would suggest trying to
> put read_seqlock_excl(&mount_lock) around the call of d_walk() in there,
> and using __lookup_mnt() in the callback (without retries on the mount_lock,
> of course - read_seqlock_excl done on the outside is enough).  I'm not sure
> if it won't cause trouble with contention, though; that needs testing.  As
> it is, that function is broken in #work.autofs, same as it is in -mm and
> -next.

Umm ... that's a much more obvious dumb mistake and what you've done there
didn't occur to me even after you spelled it out, I'll take some time to digest
it. And thanks for that one too.

Ian
