From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Fri, 23 Sep 2016 20:00:42 +0800
Message-ID: <1474632042.3083.9.camel@themaw.net>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=6IPNYjCClMbIxAv4THHiSHmWmBs=; b=D6E92k
        KvIZN315ERe/zxS2LdCCyoHF3L7KjjMqUHQqIvbJ00DV2iDXGj1n/8Ub+LG2hZoT
        zBKt9MVaFUaDv/riAiW5htAjVcabjvj3bSMPP7QrMKhnQhoTg5gjvjzGSQaB+1pU
        NNgpV8K0Y22qlWS5sXFjwEqA5e9O1wKf1SEWs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=6IPNYjCClMbIxAv
        4THHiSHmWmBs=; b=Ekygs4TOyfYBga+WM7fEkamAK8om8IqvjbzPie5Tt0n2dQD
        KGxejdJqaNYPy+YWeKmW8F9yGHOy64NQ5qGVxdEoE/XFiT3yv3pRcQbyyjaAskFg
        368cb2znEmteclmLtSGZzdQgYzAHXyG7Kobi/Tok14foCgCZkouzHHjw6vG4=
In-Reply-To: <1474604774.3083.1.camel@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Mateusz Guzik <mguzik@redhat.com>, NeilBrown <neilb@suse.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Fri, 2016-09-23 at 12:26 +0800, Ian Kent wrote:
> On Thu, 2016-09-22 at 20:37 -0500, Eric W. Biederman wrote:
> > Ian Kent <raven@themaw.net> writes:
> > 
> > > On Thu, 2016-09-22 at 10:43 -0500, Eric W. Biederman wrote:
> > > > Ian Kent <raven@themaw.net> writes:
> > > > 
> > > > > Eric, Mateusz, I appreciate your spending time on this and
> > > > > particularly
> > > > > pointing
> > > > > out my embarrassingly stupid is_local_mountpoint() usage mistake.
> > > > > 
> > > > > Please accept my apology for the inconvenience.
> > > > > 
> > > > > If all goes well (in testing) I'll have follow up patches to correct
> > > > > this
> > > > > fairly
> > > > > soon.
> > > > 
> > > > Related question.  Do you happen to know how many mounts per mount
> > > > namespace tend to be used?  It looks like it is going to be wise to put
> > > > a configurable limit on that number.  And I would like the default to be
> > > > something high enough most people don't care.  I believe autofs is
> > > > likely where people tend to use the most mounts.
> 
> Yes, I agree, I did want to try and avoid changing the parameters to
> ->d_mamange() but passing a struct path pointer might be better in the long
> run
> anyway.
> 

Andrew, could you please drop patches for this series.

I believe they are:
fs-make-is_local_mountpoint-usable-by-others.patch
fs-add-have_local_submounts.patch
autofs-make-mountpoint-checks-namespace-aware.patch
fs-remove-unused-have_submounts-function.patch

I'm going to have a go at what Eric and I discussed above rather than update
this series.

Ian
