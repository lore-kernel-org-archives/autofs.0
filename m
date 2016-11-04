From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 00/37] Current patch queue for review
Date: Fri, 04 Nov 2016 16:53:18 +0800
Message-ID: <1478249598.2869.3.camel@themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=Czq+L6JKrwgejgz
        sbav6Lp+TBho=; b=I+BeoDtxC9lN/abNXR/PYmYgiuGqvRHRH9nmymxxcXSQCAk
        rE9syj4aSl2nvi/ec404UmUyGUpbkZkbl8t/eX9vb9tta8ypmWTxAQoivn7Dm6sM
        3WyGeJhtw3D9PjHWaHKACHPa9qxE3F9nUp7RYv7GTZaKfKzcHXfYasuoxxDE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=Czq+L6JKrwgejgzsbav6Lp+TBho=; b=JcsDSdM5WYdlXeddJj1T
        jB5OgmZ0h3+PAKC5de7ZP0lG+Dl+ixPmm9AgbhAjoSne09Y+dRdcNg94LNozXZyi
        mSNbfl1JB9W2YuGikofkXQoJCVDgWZv16il7N6fURJQ1YCByUIt0SA4aJemWaxTE
        Hu2nRL5iO0lEFffzpz8DXvc=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: autofs mailing list <autofs@vger.kernel.org>

On Tue, 2016-10-25 at 09:17 +0800, Ian Kent wrote:
> Hi all,
> 
> The patch queue is well overdue for a commit but since there's
> been increased contributions for others recently I thought it
> would be useful to post the patches for review and give a brief
> description of what's in the queue and what still needs work. 
> 
> Many of the patches are striaght forward and I expect to commit
> then in a week or so. Also keep in mind the commit order might
> be different when the commit is actually done.
> 
> The patches around those titled "autofs-5.1.2 - wait for master
> map available at start" and "autofs-5.1.2 - add master read wait
> option" have been around for quite a while and have been a problem
> in the past (which is why they haven't been committed yet) so I'm
> not sure about them yet.
> 
> The series to add browse support for amd maps is not yet complete
> so they will likely stay in the queue a bit longer. But I am keen
> to get this functionality into a release as I know it is something
> that at least a few people would like.

The patches up to and including
"autofs-5.1.2 - add sss master map wait config option"
plus one additional patch have been committed to the repository and pushed
to https://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.3/.

For anyone interested the additional patch is
"autofs-5.1.2 - fix quoted key handling in sanitize_path()"
a bug fix for quoting map keys in non-master map maps.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
