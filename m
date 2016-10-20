From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/8] vfs - change d_manage() to take a struct path
Date: Fri, 21 Oct 2016 07:39:36 +0800
Message-ID: <1477006776.3207.14.camel@themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
         <20161019124031.94a44fbdd0970989f05d1893@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=bf//YLvthLpdBVGJ3weR39jmKl0=; b=Fh1QBP
        dBoIcDiSJzhqqyQnzx7AA43CSobqsil46w1FnmSFHk/5pQnkPyIBh1kN9MZV9UWC
        Lj2fJGSSj1hPNnj9YSK2Ae+zZYbWbDTWESsw9Z0lUw0dlQdz27Lcm31TF/UB81q7
        ZKW8oyWEJ1OX7J5GoHcLQzY+LY59iAPBFu34g=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=bf//YLvthLpdBVG
        J3weR39jmKl0=; b=e/F55jKvc/KRz21dT2LNnjFk04iX6vf7Aa+CyN1SUCNMeIv
        eGmQyNdhxUHA+KHWg7UFjH7yi6OrovSs8D9jQKVZvNh8ndWjlnjaPUkypv8QS8sm
        QDZRMGtPST2R/bYXf/VBz6hM6KLXzjxo/GgSK1RoPfDdbjffQSQYIS9e0Bd8=
In-Reply-To: <20161019124031.94a44fbdd0970989f05d1893@linux-foundation.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

On Wed, 2016-10-19 at 12:40 -0700, Andrew Morton wrote:
> On Tue, 11 Oct 2016 13:33:52 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > For the autofs module to be able to reliably check if a dentry is a
> > mountpoint in a multiple namespace environment the ->d_manage() dentry
> > operation will need to take a path argument instead of a dentry.
> 
> This patchset contains lots of ViroStuff.  I'll queue it up for some
> testing and will go into wait-and-see mode.

Thanks Andrew.

Maybe Al has been too busy to comment, he has been on the Cc from the start.

Hopefully this email will prompt a review, Al?

> 
> Some patches had an explicit From: Ian Kent <ikent@redhat.com> and some
> did not.  I assumed that this was intended for all patches.  So all
> patches now have different From: and Signed-off-by: email addresses. 
> Unclear if this was your intent ;)

Umm ... sorry about that, I didn't pay enough attention to the From of the
patches when I resurrected them from an earlier attempt at this.

Since the time I did this with an earlier patch series I have elected to not
change my git config and set these in the local tree config so it shouldn't
happen for new work. I'll pay special attention to this if I need to resurrect
any other older patches too.

I know this looks confusing and isn't the best but both email addresses have
been present on my gpg key for a long time so it's verifiable the patches are
from me.

Once again sorry about that.
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
