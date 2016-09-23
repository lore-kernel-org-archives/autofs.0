From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Thu, 22 Sep 2016 20:37:21 -0500
Message-ID: <877fa39z1q.fsf@x220.int.ebiederm.org>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
        <20160914061445.24714.68331.stgit@pluto.themaw.net>
        <20160917201000.omswgttgyzcu7jt6@mguzik>
        <1474248973.3204.14.camel@themaw.net>
        <87oa3iikgf.fsf@x220.int.ebiederm.org>
        <1474411462.22440.2.camel@themaw.net>
        <1474412413.22440.7.camel@themaw.net>
        <1474507987.12887.5.camel@themaw.net>
        <87k2e4c541.fsf@x220.int.ebiederm.org>
        <1474592141.3345.20.camel@themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1474592141.3345.20.camel@themaw.net> (Ian Kent's message of
        "Fri, 23 Sep 2016 08:55:41 +0800")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Mateusz Guzik <mguzik@redhat.com>, NeilBrown <neilb@suse.com>, Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

Ian Kent <raven@themaw.net> writes:

> On Thu, 2016-09-22 at 10:43 -0500, Eric W. Biederman wrote:
>> Ian Kent <raven@themaw.net> writes:
>> 
>> > Eric, Mateusz, I appreciate your spending time on this and particularly
>> > pointing
>> > out my embarrassingly stupid is_local_mountpoint() usage mistake.
>> > 
>> > Please accept my apology for the inconvenience.
>> > 
>> > If all goes well (in testing) I'll have follow up patches to correct this
>> > fairly
>> > soon.
>> 
>> Related question.  Do you happen to know how many mounts per mount
>> namespace tend to be used?  It looks like it is going to be wise to put
>> a configurable limit on that number.  And I would like the default to be
>> something high enough most people don't care.  I believe autofs is
>> likely where people tend to use the most mounts.
>
> That's a good question.
>
> I've been thinking that maybe I should have used a lookup_mnt() type check as I
> originally started out to, for this reason, as the mnt_namespace list looks to
> be a linear list.
>
> But there can be a lot of mounts, and not only due to autofs, so maybe that
> should be considered anyway.

There are two reasons for is_local_mountpoint being the way it is.

a) For the cases where you don't have the parent mount.
b) For the cases where you want to stop things if something is mounted
   on a dentry in the local mount namespace even if it isn't mounted
   on that dentry at your current mount parent. (Something that was
   important to not change the semantics of the single mount namespace case).

Both of those cases to apply to unlink, rmdir, and rename.  I don't think
either of those cases apply to what autofs is trying to do.  Certainly
not the second.

So if you have the parent mount I really think you want to be using some
variation of lookup_mnt().  The fact it is rcu safe may help with some
of those weird corner cases as well.

> The number of mounts for direct mount maps is usually not very large because of
> the way they are implemented, large direct mount maps can have performance
> problems. There can be anywhere from a few (likely case a few hundred) to less
> than 10000, plus mounts that have been triggered and not yet expired.
>
> Indirect mounts have one autofs mount at the root plus the number of mounts that
> have been triggered and not yet expired.
>
> The number of autofs indirect map entries can range from a few to the common
> case of several thousand and in rare cases up to between 30000 and 50000. I've
> not heard of people with maps larger than 50000 entries.
>
> The larger the number of map entries the greater the possibility for a large
> number of active mounts so it's not hard to expect cases of a 1000 or somewhat
> more active mounts.

Fair.  So at least 1000.  And there can be enough mounts that a limit of
100,000 might be necessary to give head room for the existings configurations.

Thank you.  Now I just need to wrap my head around fs/namespace.c again
and see how bad a count like that will be to maintain.

Eric

