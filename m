From: Colin Walters <walters@verbum.org>
Subject: Re: [PATCH 1/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Tue, 08 Aug 2017 09:11:14 -0400
Message-ID: <1502197874.3935465.1066793424.598228B6@webmail.messagingengine.com>
References: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=P1tWhR
        SwWzQAX37xs9ehN1UBXC8KGW5K+zjQfEfO/oM=; b=ktXJqLUokHUdZzhkPolJB6
        3MqagMdwq+YVYJD7Np3U9zACt7zqxP+nCaMquDQEK+t1DZWRCQR49Q77xHZVcfTS
        lVVGIutm4jhK3UtOCD4LGeIt5YcaKBPyK5H/35mrrzSuP4XG+HyGv5nWy/YgQfgQ
        fKpGn/z40JMk+DD1koI14+WfsJA7s7caZRWw3kzhfbaM2zRPGQcdPbER5gl0+4T4
        uGKD4JY6eqGDfwU5Kd5w6txT+ZofPxb6PNrOEk7jWTjPDOSAozycXAwxHnxd/3mB
        rjI5w25eH9it4YQTAFvvF3lwbBEbpLPuEdoQ/X4mLK4Gw4/cDfNKliwPl50k838Q
        ==
In-Reply-To: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Ondrej Holy <oholy@redhat.com>, Colin Walters <walters@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Tue, Aug 8, 2017, at 12:26 AM, Ian Kent wrote:

> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3022,8 +3022,7 @@ static inline int vfs_lstat(const char __user *name, struct kstat *stat)
>  static inline int vfs_fstatat(int dfd, const char __user *filename,
>  			      struct kstat *stat, int flags)
>  {
> -	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
> -			 stat, STATX_BASIC_STATS);
> +	return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
>  }
>  static inline int vfs_fstat(int fd, struct kstat *stat)
>  {

This is reverting the fstatat() prat of
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=deccf497d804a4c5fca2dbfad2f104675a6f9102
Which itself seems weird to me - it looks like we were unconditionally
forcing on AT_NO_AUTOMOUNT regardless of what userspace passed?
So perhaps a
Fixes: deccf497d804a4c5fca2dbfad2f104675a6f9102
is appropriate here?

I understand that for stat()/lstat() we didn't expose the option to userspace,
so the behavior was...ah, there's this note in man-pages (man-pages-4.09-3.fc26.noarch):

> On Linux, lstat() will generally not trigger automounter action, whereas stat() will (but see fstatat(2)).

I have no idea of the history here, but maybe it makes sense to drop
the AT_NO_AUTOMOUNT from the vfs_stat() too?
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
