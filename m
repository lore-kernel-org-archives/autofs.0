From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs - fix slab out of bounds read in getname_kernel()
Date: Fri, 06 Jul 2018 09:08:36 +0800
Message-ID: <1530839316.2940.5.camel@themaw.net>
References: <153060031527.26631.18306637892746301555.stgit@pluto.themaw.net>
         <20180705165842.856d66594bf695f4f688ccfa@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=osgjEHQIkXfjfeLid5BeMiyRD1Xm/
        RRhQgZ4ngn9hsQ=; b=OUpGL5s1vbnL1FECaTJ3qkVNbA77zwRdjA0nEv8CEwyrm
        Ir3g6zfO1X3KPst0PIxZolMNCLo3aKjDcBC2HL1BVIhV2mjCUczCDyVXLq7sNtf5
        8sSkVPfrd0atmQJ69t07Elk6NEDN7wogqSfSXC7m07GqidUYq1pNiWiGjeNGTP1v
        /n1YwL+9SWlCvQxKxevxFnIL3QN+I/NI20iwiUCJO3QkT2XVNgk3Cq3tajAjVLHw
        lrf8vcQZRGNaAqCm9DrvU1EtiT/375YilvYHhslKXcZKhHjmR67ELFzgqSb6u1zq
        gN9BpqRFlh/8bqWz6eb091AHlGDXXvm33pQSVbUqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=osgjEH
        QIkXfjfeLid5BeMiyRD1Xm/RRhQgZ4ngn9hsQ=; b=JGVdCdgELUNnYzyPF/jBKj
        9YKLkw//O7u5lt46sogDNYe4eg86Xzgjt+vE+Q8T1GGEV3Noxf/LFqp/0wOhyi3I
        zdPtrJlbPKynOYyptCvBWxi1RjTIGJeauD3HVOaTCtipiJdftx+qicn9xdjd/vV2
        ZzLpZN581ikt2DaTQ2sulfFllu2NdBuN1cpKULHdrl3UOicQvfP7FWTXjHQkD7FA
        wJsD0Pc/HLPdL+ljf3S4uII+001vj6KvDDzsL5c/7Z9rqKCyXMkUAs1A+ahWKn1H
        rxeEAIl41PYMmDTgKpPv16rw3rnD5KYdmKbLeVNoyP3upugVMYa7wP5zN1V8FQZQ
        ==
In-Reply-To: <20180705165842.856d66594bf695f4f688ccfa@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomas Bortoli <tomasbortoli@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>

On Thu, 2018-07-05 at 16:58 -0700, Andrew Morton wrote:
> On Tue, 03 Jul 2018 14:45:15 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > Initial patch contributed by Tomas Bortoli.
> > 
> > The autofs subsystem does not check that the "path" parameter is
> > present for all cases where it is required when it is passed in
> > via the "param" struct.
> > 
> > In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
> > ioctl command.
> > 
> > To solve it, modify validate_dev_ioctl() function to check that a
> > path has been provided for ioctl commands that require it.
> > 
> > Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com
> 
> So who is the primary author of this?  I'm assuming "Tomas" from the
> signoff order?

Yes, Tomas was the originator but I did change it somewhat so added
my Signed-off-by as well.

> 
> The way of signifying this is to put the other author's From: line right
> at the top of changelog.

Oh, ok, will do in future, although my changes were fairly significant.

IMHO it was a joint effort more or less equal by both of us.
Nevertheless I would have been happy to list Tomas as the From author.

> 
> I assume this is a root-only bug, so we don't need to backport the fix?

It is, so yes that's right, unless Tomas has other recommendations.

Ian
