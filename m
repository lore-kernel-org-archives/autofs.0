From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] VFS / autofs4: remove kern_path_mountpoint()
Date: Thu, 9 Nov 2017 12:06:41 -0800
Message-ID: <CA+55aFx=-BeJbptHctGF1TrDYV9q7Oc2a_7ALsJ6dAHpWffT9A@mail.gmail.com>
References: <151021179901.22743.15252956909042161062.stgit@noble> <151021202428.22743.11071460838655377498.stgit@noble>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=alOvTlNSbbSnvtrpSDiGlnfYHVrilPcZWx6jx3Nr378=;
        b=CKMaYrjK/mLIuzW9X9G+33k8z3GJyOByTocvq4czqXY42etAOVZD7ba22uR5euh2Hm
         NLKFeOrIRt6Og/YgiDTF3n4hgEnalqMjkicGG7jyT9H15DwUPK0kBiXfpbV+kOaWi9Kv
         +2u41Khm1EmhsYeEmL/d2UfZXx3fCTXsW4awU/4WjDWNDk+CmNsGxxhsyhGS/bH7Gj0K
         ieCpMqzYZn8RJ/lEygyYZ+bnahnL6q/MRc+yKnOAOcvqV3ZSgN6kXOP4zpbss9RnRQ0u
         NathQjHiCOLZ82rcVgNyFv+xZwG8J2e+8y5YNZ2E6offdeqiJB9L5GN8D/li5GWCxzBY
         i6rQ==
In-Reply-To: <151021202428.22743.11071460838655377498.stgit@noble>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: NeilBrown <neilb@suse.com>
Cc: Ian Kent <ikent@redhat.com>, Latchesar Ionkov <lucho@ionkov.net>, Jeff Layton <jlayton@redhat.com>, Eric Van Hensbergen <ericvh@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Ron Minnich <rminnich@sandia.gov>, Trond Myklebust <trondmy@primarydata.com>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, V9FS Developers <v9fs-developer@lists.sourceforge.net>

On Wed, Nov 8, 2017 at 11:20 PM, NeilBrown <neilb@suse.com> wrote:
> ---
>  fs/autofs4/dev-ioctl.c |    5 +-
>  fs/namei.c             |  129 ------------------------------------------------
>  include/linux/namei.h  |    1
>  3 files changed, 2 insertions(+), 133 deletions(-)

This one certainly looks lovely, and the rationale all looks solid.

Al, mind taking a look?

             Linus
