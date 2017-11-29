From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 29 Nov 2017 11:14:11 +0800
Message-ID: <fe6a3021-30e8-d4cd-5aa7-7f3d854cdac2@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <20171127160147.GA27613@qualcomm.com>
 <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net>
 <20171128002935.GC27898@qualcomm.com>
 <87a7z5yjbs.fsf@notabene.neil.brown.name>
 <20171129021354.GB2873@qualcomm.com>
 <1be75afb-8702-d60c-5ecb-10ddd2edc062@themaw.net>
 <87tvxdx0jb.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=5qKLvIljWJnpG0ZydWK0xiFetboXz
        HR/O4LDBi1fX/Q=; b=fZEw/CAgO/4Vq6l/7/lRASAHNc6EfUFc1mz33NT1LK1FF
        35y2fE2u1f+zbUI4fE/6FAZ7W0C89dXwip+crxwDhiDelbVVX/BU5/Mm6k3FrFFB
        95zMbJ5RJK1t00LEgWoSLUVKnGz83GMxmhVsc37mVLPgUHFvitAXTWMLo32VOou0
        NYXP2XgT1ecV45EQu0FjDuxLxGR0g7MZRi8uwKbvm+4Gn2/H/VUEKfm9Qtm8CieC
        YWO+XMRWeQWJ8aBEu9VPsIo9LIF9gE9VVrSALkmsMjmwuvTXCc2vZFHxjkcjDmWd
        JOFw4aWLgjItKqOy4G9vISeleKQEHxCRLK3+u3EMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5qKLvI
        ljWJnpG0ZydWK0xiFetboXzHR/O4LDBi1fX/Q=; b=C0KFGKvXpxIYkQtqr3qtX2
        W70ybxe++dBf036mpIMzT5+POeeEVA5t0+ob41mnLzmTqaLvSHsAuPS11NDW5vtU
        j5bCifdCUlV5r9aHtUoUtrwJpILrE/Po4F5mOXj//sUDwoc2Jb0dh9Lz9rorbtoe
        2egFUpueknN3r1JZeRWZ8cYATH+GQxXtZjWwCI56948dYGGSHiD3p2czovQg7bqo
        ReCLGYlkmdoD2aIQNheS2FdTxR3d3mYEe8XkP2FX0MuxB2X7qkJu2UCcMrwgpLam
        7ZhXjPhPYa/nA/APq9gW9LkgQdhpw7qWN9Zaj8PDrGEDtO0kaU3p4uUi6NMIil+w
        ==
In-Reply-To: <87tvxdx0jb.fsf@notabene.neil.brown.name>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Mike Marion <mmarion@qualcomm.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 29/11/17 10:48, NeilBrown wrote:
> On Wed, Nov 29 2017, Ian Kent wrote:
> 
>> On 29/11/17 10:13, Mike Marion wrote:
>>> On Wed, Nov 29, 2017 at 12:17:27PM +1100, NeilBrown wrote:
>>>
>>>> How big do people see /proc/self/mount* getting?  What size reads
>>>> does 'strace' show the various programs using to read it?
>>>
>>> We already have line counts into 5 figures.  This wasn't an issue until 
>>> the change of /etc/mtab to a link.  The large count is due to our large
>>> direct automount maps.
>>>
> 
> So .... 90,000 lines with a length of may 120 chars or about 10Meg.
> Presumably these machines would have so many gigabytes of RAM that
> caching a 10M mountinfo file would go unnoticed?
> 
> Reading that in 128K chunks without generating bits on the fly will help
> a lot I suspect.
> 
> We could probably ensure proper alignment by searching backwards for
> '\n' when deciding how much to return for a read.
> 
>>
>> And, admittedly, the testing I was doing was with 15k+ size maps.
>>
>> Of course it's necessary to have this number of mounts to see serious
>> problems which is easiest to do with large direct mount maps.
>>
>> The thing that's different now is that before applications started
>> using /proc directly for mount table information using mount(2)
>> instead of mount(8) was enough to prevent the mount entries from
>> being added to the table seen by applications.
> 
> I wonder who would notice if untriggered direct mounts quietly disappeared from
> /proc/mounts...  I suspect systemd would, but there is a good chance it
> would fail-safe: assume that the mount worked.
> Alternately we could introduce /proc/self/mountinfo2 which doesn't list
> direct automounts and encourage problematic programs to use that where
> available.

Personally I think the proc filesystem tables should be a full representation
of the mounted mounts. That needs to available somewhere.

autofs still uses the proc mounts in one situation (there might be more I've
missed in eliminating this) and other applications probably do too (I have
patches to eliminate this one but they don't fit well with the current
implementation).

One approach I tried was to write a simple file system to mount over
/etc/mtab (et. al.) and filter entries returned based on simple filter
rules.

That file system is not complete by any means and I couldn't get a feel
for how effective it would be due to the direct access to the proc mount
tables done by applications.

OTOH, if applications could be persuaded to use /etc/(mtab|mounts|mountinfo)
and only consult the proc tables when absolutely necessary this pseudo file
system would be an ideal place for an entry cache ....

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
