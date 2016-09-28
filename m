From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Wed, 28 Sep 2016 18:18:22 +0800
Message-ID: <1475057902.3393.10.camel@themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
         <20160914061445.24714.68331.stgit@pluto.themaw.net>
         <20160917201000.omswgttgyzcu7jt6@mguzik>
         <1474248973.3204.14.camel@themaw.net>
         <87oa3iikgf.fsf@x220.int.ebiederm.org>
         <1474411462.22440.2.camel@themaw.net> <1474412413.22440.7.camel@themaw.net>
         <1474507987.12887.5.camel@themaw.net>
         <87k2e4c541.fsf@x220.int.ebiederm.org>
         <1474592141.3345.20.camel@themaw.net>
         <877fa39z1q.fsf@x220.int.ebiederm.org> <1474604774.3083.1.camel@themaw.net>
         <1474632042.3083.9.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=LlvKCiwCYCn4QvaNJRJ/AJs0A5E=; b=Hcj2c0
        3TR4uIXW4vOx1LICH3gBm3+Nz/wWmhz8VxKmbL254eLUDZtUnjpz0AfplybOBgYr
        SlCnX0+Yv3PcGdqjvsH4LM0BXZMPQIPWoNdbLHEiA0vVV9DhKQ+juq5clwF2ZuF8
        boaFmXafr0yxfaYz0f0htJMKMISykXj6vzn0g=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=LlvKCiwCYCn4Qva
        NJRJ/AJs0A5E=; b=M5DNmYu7rHZ7gxIwMEEWStNBpdt05yzQQfOYtLi5uZAf0mq
        UVl+HA//wxXd5CMkPMt8TuUiScc5gfcjpaxU86kNaK227Y4xlNGpD3W4gk1KhB3C
        dAbiJ5rbJ/hwCDZlXpIurAxh3Wxhb2I/iXGU/+FYwwNnr2djTKW/LdfktVb4=
In-Reply-To: <1474632042.3083.9.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Mateusz Guzik <mguzik@redhat.com>, NeilBrown <neilb@suse.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Fri, 2016-09-23 at 20:00 +0800, Ian Kent wrote:
> On Fri, 2016-09-23 at 12:26 +0800, Ian Kent wrote:
> > On Thu, 2016-09-22 at 20:37 -0500, Eric W. Biederman wrote:
> > > Ian Kent <raven@themaw.net> writes:
> > > 
> > > > On Thu, 2016-09-22 at 10:43 -0500, Eric W. Biederman wrote:
> > > > > Ian Kent <raven@themaw.net> writes:
> > > > > 
> > > > > > Eric, Mateusz, I appreciate your spending time on this and
> > > > > > particularly
> > > > > > pointing
> > > > > > out my embarrassingly stupid is_local_mountpoint() usage mistake.
> > > > > > 
> > > > > > Please accept my apology for the inconvenience.
> > > > > > 
> > > > > > If all goes well (in testing) I'll have follow up patches to correct
> > > > > > this
> > > > > > fairly
> > > > > > soon.
> > > > > 
> > > > > Related question.  Do you happen to know how many mounts per mount
> > > > > namespace tend to be used?  It looks like it is going to be wise to
> > > > > put
> > > > > a configurable limit on that number.  And I would like the default to
> > > > > be
> > > > > something high enough most people don't care.  I believe autofs is
> > > > > likely where people tend to use the most mounts.
> > 
> > Yes, I agree, I did want to try and avoid changing the parameters to
> > ->d_mamange() but passing a struct path pointer might be better in the long
> > run
> > anyway.
> > 
> 
> Andrew, could you please drop patches for this series.
> 
> I believe they are:
> fs-make-is_local_mountpoint-usable-by-others.patch
> fs-add-have_local_submounts.patch
> autofs-make-mountpoint-checks-namespace-aware.patch
> fs-remove-unused-have_submounts-function.patch
> 
> I'm going to have a go at what Eric and I discussed above rather than update
> this series.

There are a couple of problems I see preventing me from posting an updated
series.

It looks like this series was dropped from the mmotm tree but is still present
in the linux-next tree.

Hopefully this won't be pushed to the Linux tree, it's not likely to be what's
needed.

Also there are two commits in the Linus tree that will conflict with an updated
series which is worth a heads up.

They are:

commit 8ac790f312 from Al Viro
title: qstr: constify instances in autofs4

commit e698b8a436 from Miklos Szeredi
title: vfs: document ->d_real()

Is there anything I should do to help with this?
Ian
