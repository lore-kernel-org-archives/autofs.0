From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 0/2] struct pid-ify autofs4
Date: Fri, 21 Sep 2012 17:44:48 +0200
Message-ID: <87haqrwfbj.fsf@tucsk.pomaz.szeredi.hu>
References: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xh5WRYcWd9NcnsgC8Kasvm+A9xNE/zMZp9Zrt5nc8TE=;
        b=iBfCxcM0SxUTnDA/XFUmhTR57WJLsY9AVXVPwFNHPa1q+C/ek+0ylKovmoyhk4wnG6
         l90zRsNxUMn2v6VDzWp8eVy/sRqUaxM90bM3Y2TikbmEG5wMxwpYJi0fkkb92XpdB5N9
         0aP/c9L9IKra7fSoF5e7UCl+65QLpbsLK+MWw=
In-Reply-To: <1348068576-21363-1-git-send-email-miklos@szeredi.hu> (Miklos
	Szeredi's message of "Wed, 19 Sep 2012 17:29:34 +0200")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, ebiederm@xmission.com

Miklos Szeredi <miklos@szeredi.hu> writes:

> These two patches change autofs4 to store struct pid pointers instead of pid_t
> values.
>
> Fixed various issues with the previous post.  Not tested, handle with
> care!

Customer gave positive test results.

Thanks,
Miklos

>
> Thanks,
> Miklos
> ---
>
>
> Serge Hallyn (1):
>       autofs4: store struct pids in autofs_waitqs
>
> Sukadev Bhattiprolu (1):
>       Replace pid_t in autofs4 with struct pid reference.
>
> ---
>  fs/autofs4/autofs_i.h  |    8 ++++----
>  fs/autofs4/dev-ioctl.c |    3 ++-
>  fs/autofs4/inode.c     |   22 +++++++++++++++-------
>  fs/autofs4/waitq.c     |   19 +++++++++++++------
>  4 files changed, 34 insertions(+), 18 deletions(-)
