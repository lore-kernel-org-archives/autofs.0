From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Sat, 24 Sep 2016 08:11:09 +0800
Message-ID: <1474675869.3078.3.camel@themaw.net>
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
         <87oa3e8m2v.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=Kz6kEzglPSEEfc9kBlaQT249bUs=; b=fEsfrm
        oX3qkP/mZZ/a+XvBFKoJGoN49MtubHqhTJVCj2JbSGXQXOUp3w3yYGr8P4vmgkH2
        9PJOiap8meH9WyFP5Inf+S9snlnfQSpRAtjWeYATvUk1/2jQWnt0w21RvM3o1O4m
        fNEt1DxtXgeIpEM+c3ECCoytP1KVtLCwQYAg0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Kz6kEzglPSEEfc9
        kBlaQT249bUs=; b=J5poU3JzcnT69rV4Ft5NfQXK4GrXsre6ZpVJJZggmvufiR0
        8jOlt7nzbC7H1X0jV2Ss2WBJJMbCRo8r94CJhLXqzeO/gKjZrqdwnO99PSuMHqoU
        pnPtY878odC8ZHqGdfRsNxFg4DPa6N6WFmWHyk2YYHfV1xb7SwmYgMGOu8TE=
In-Reply-To: <87oa3e8m2v.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mateusz Guzik <mguzik@redhat.com>, NeilBrown <neilb@suse.com>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Fri, 2016-09-23 at 14:15 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> 2> On Thu, 2016-09-22 at 20:37 -0500, Eric W. Biederman wrote:
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
> 
> Given that there is exactly one implementation of d_manage in the tree I
> don't imagine it will be disruptive to change that.

Yes, but it could be used by external modules.

And there's also have_submounts().

I can update that using the existing d_walk() infrastructure or take it (mostly)
into the autofs module and get rid of have_submounts().

I'll go with the former to start with and see what people think.

> 
> Eric
