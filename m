From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] autofs4 - fix device ioctl mount lookup
Date: Tue, 3 Sep 2013 19:18:42 -0700
Message-ID: <CA+55aFwF+dqSMyGE+3LamM+qSDymieyReYB+RPb8fHTTmntgqw@mail.gmail.com>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
	<20130904010301.GE13318@ZenIV.linux.org.uk>
	<20130904020013.GF13318@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YzV2GJTSa7+m69ImEWMlKVfJnkrcnP3p4gmK1w/VD+I=;
        b=Wgv9Bpb668kU4mD26d6t4L6MgTKFqkyb7vqzqaXIr9rqrhtMpTOuRjGCb25PW821fm
         NkwGIYU3wt2TReuf6SIX884UCGdMx0yDYVuQdbKKi92v/ZvZ88BWdUslDZVDelG8VQIm
         Gv8cBKlKsFfA73nOAsOPID50IPyI7A+sd+OJr7PmVNkX76tgL1gXBayOZKG3LCN2Dmac
         5z0xgQKm787753NYK2hHTGZ6iYqpWZL+PnSr7yY0ittt/mWLPYWVIdFzdmT/jjoko2o5
         WJTU6EP0W6gW/VKo49tSOv0nd0fJCk53aZBkQzbuCN8TcRWkDj/2Zl60wrL2w6RKD63I
         mWVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=YzV2GJTSa7+m69ImEWMlKVfJnkrcnP3p4gmK1w/VD+I=;
        b=QUvCFObcnRXNiuvYXvQnJAI2R/aaKHE6lzWUHZzBdnTSLXU+OxWteTJ7HZH83pR24O
         PAMwAnpJi0moZtiubQ8qDZU2M7yU8fMkOms5GFNN/AJ1updXsIUPSS7hJppJwxOQb4IR
         bUJMlo/JIlSm0erPh26tpr1WuBocpCZzV+s1s=
In-Reply-To: <20130904020013.GF13318@ZenIV.linux.org.uk>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Sep 3, 2013 at 7:00 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That aside, I'm really not happy with this kind of games; this stuff clearly
> belongs in fs/namei.c where we can simply see the last component.  Doing that
> on the level of "let's scan the pathname for slashes, etc." is just plain
> wrong.  Let's step back for a minute here; what are you trying to do?
> You have a pathname that should resolve to a mountpoint, without triggering
> automount (or crossing into the mountpoint, for that matter) and you want
> struct path for the bottom of that mount stack?  Or is it something
> completely different?

Can we add a LOOKUP_NOAUTOMNT bit or something (not exposed to user
space, only used for this particular kern_path() call). Then, if/when
automount gets called recursively (through autofs4_lookup? Or is it
just the autofs4_d_automount() interface?) it can just decide to not
follow that last path.

Hmm? I don't think we pass in the lookup-flags to d_automount, but
that could be changed. Yes?

             Linus
