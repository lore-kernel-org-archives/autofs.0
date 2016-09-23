From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Fri, 23 Sep 2016 08:55:41 +0800
Message-ID: <1474592141.3345.20.camel@themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
         <20160914061445.24714.68331.stgit@pluto.themaw.net>
         <20160917201000.omswgttgyzcu7jt6@mguzik>
         <1474248973.3204.14.camel@themaw.net>
         <87oa3iikgf.fsf@x220.int.ebiederm.org>
         <1474411462.22440.2.camel@themaw.net> <1474412413.22440.7.camel@themaw.net>
         <1474507987.12887.5.camel@themaw.net>
         <87k2e4c541.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=faHsKXuM9tJAPaF1uqo1JXmDuGU=; b=QAirgY
        jTJJV9ZYR9TCdR9v49T3Csbp6jx0Jw9o3Lfjwl1zMBnWxoiBvVu6QZDcEIRiUQfs
        uPbWW+ZUXT4ww3OGjscwaGow0caQFEa6ALH7toZHy4Yj6R8D8kpvKZ09/wjW2dv7
        J+aGYvbR1awR/f58b+czeMiyivkrQR1jCQ8pA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=faHsKXuM9tJAPaF
        1uqo1JXmDuGU=; b=Em09E9yjgoau4gvgvk63JFyqaQmXhFDBO8fzR/6QRHAQYV9
        FuQ/6SGmBMk2fdVaEQF/rY0dbYa/4XH036hcYvUjI3vdAC+21pmqDFNWa3Lzx7/7
        Q3gUV/Rsxv38Y2o59O6vIfCQpclTcf/wNoWUA40/0qZqgPY/lY1en/hZZIQc=
In-Reply-To: <87k2e4c541.fsf@x220.int.ebiederm.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Mateusz Guzik <mguzik@redhat.com>, NeilBrown <neilb@suse.com>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Thu, 2016-09-22 at 10:43 -0500, Eric W. Biederman wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > Eric, Mateusz, I appreciate your spending time on this and particularly
> > pointing
> > out my embarrassingly stupid is_local_mountpoint() usage mistake.
> > 
> > Please accept my apology for the inconvenience.
> > 
> > If all goes well (in testing) I'll have follow up patches to correct this
> > fairly
> > soon.
> 
> Related question.  Do you happen to know how many mounts per mount
> namespace tend to be used?  It looks like it is going to be wise to put
> a configurable limit on that number.  And I would like the default to be
> something high enough most people don't care.  I believe autofs is
> likely where people tend to use the most mounts.

That's a good question.

I've been thinking that maybe I should have used a lookup_mnt() type check as I
originally started out to, for this reason, as the mnt_namespace list looks to
be a linear list.

But there can be a lot of mounts, and not only due to autofs, so maybe that
should be considered anyway.

The number of mounts for direct mount maps is usually not very large because of
the way they are implemented, large direct mount maps can have performance
problems. There can be anywhere from a few (likely case a few hundred) to less
than 10000, plus mounts that have been triggered and not yet expired.

Indirect mounts have one autofs mount at the root plus the number of mounts that
have been triggered and not yet expired.

The number of autofs indirect map entries can range from a few to the common
case of several thousand and in rare cases up to between 30000 and 50000. I've
not heard of people with maps larger than 50000 entries.

The larger the number of map entries the greater the possibility for a large
number of active mounts so it's not hard to expect cases of a 1000 or somewhat
more active mounts.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
