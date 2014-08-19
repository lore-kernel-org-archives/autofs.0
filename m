From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] RCU-walk support for autofs
Date: Tue, 19 Aug 2014 18:02:27 +0800
Message-ID: <1408442547.11314.9.camel@perseus.themaw.net>
References: <20140818062844.9860.43007.stgit@notabene.brown>
	 <1408350340.2533.3.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=RZgZzxb0cXtydNdOqH01/Z0nHMg=; b=b0OaII7tqMqSmuNoz0r4aJiOaSIB
	PF8NNEraaXPPdNk+5D4QtYmmLdncRI6SdIdaGhEODgMWgIve5kCl27z6pMnlxMS0
	smUhWbI1L0jiCHjnsG430jOcCL2HWahTSoN4mJR4X8Q7Sd/FrhQMc7YeeGdcamwE
	g4J/n5SSP4owkio=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=RZgZzxb0cXtydNdOqH01/Z
	0nHMg=; b=civuyFc9Ine70uuHvNGZ5bDRvkCSFUv858PruFMrJu3X/QdBi/DJb0
	3fgWzGCLYnoSCrAJ9lg6BBT8KbQekBxEaF/Rc9/toxc1EZg+oWuHJRo8VcZ0cSef
	rbEfbhJLc0kvfZjZ+K8dy7zGbLH+FyT9JhtEMlsWkeiIm+3VGEj9g=
In-Reply-To: <1408350340.2533.3.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2014-08-18 at 16:25 +0800, Ian Kent wrote:
> On Mon, 2014-08-18 at 16:33 +1000, NeilBrown wrote:
> > Hi Ian,
> >  Have you had a chance to run your tests in these patches yet?
> >  I've done what testing I can think of and cannot fault them.
> 
> I haven't, I've been plagued with illness so I'm not getting nearly
> enough done. I'll try to put a kernel together and run the test in the
> next week or so.

Just to let you know that I managed to spend some time on this. I built
a kernel (3.17.0-rc1) with the series and ran a couple of tests.

I'm not certain that the patches I used are identical to your posting, I
saw one difference, after the fact, that shouldn't matter, I'll have to
check that.

It isn't possible to test expire to mount races because the mounts in
the tree never expire.

At first I thought it was because so many processes were accessing the
tree all the time but manually constructing the maps and mounting the
mounts shows that nothing ever expires, at least for this tree.

However, issuing a shut down does expire all the mounts and shuts down
autofs cleanly.

So there is something not quite right with the expire check or my
patches have mistakes.

> 
> > 
> >  This set is against 3.17-rc1 and make use of the new -EISDIR handling
> >  for d_manage() and assumes the other patches which already went in
> >  through Andrew Morton.
> > 
> >  I've added a section to autofs4.txt about mount namespaces, but it is
> >  otherwise unchanged.
> > 
> >  If I could get an {Acked,Reviewed,Tested}-By in the next few weeks so
> >  I can send them on to Andrew I would really appreciate it.
> > 
> > Thanks,
> > NeilBrown
> > 
> > 
> > 
> > ---
> > 
> > NeilBrown (5):
> >       autofs4: allow RCU-walk to walk through autofs4.
> >       autofs4: factor should_expire() out of autofs4_expire_indirect.
> >       autofs4: avoid taking fs_lock during rcu-walk
> >       autofs4: d_manage() should return -EISDIR when appropriate in rcu-walk mode.
> >       autofs: the documentation I wanted to read
> > 
> > 
> >  Documentation/filesystems/autofs4.txt |  520 +++++++++++++++++++++++++++++++++
> >  fs/autofs4/autofs_i.h                 |    6 
> >  fs/autofs4/dev-ioctl.c                |    2 
> >  fs/autofs4/expire.c                   |  200 ++++++++-----
> >  fs/autofs4/root.c                     |   62 +++-
> >  5 files changed, 694 insertions(+), 96 deletions(-)
> >  create mode 100644 Documentation/filesystems/autofs4.txt
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


