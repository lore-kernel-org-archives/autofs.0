From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Thu, 23 Nov 2017 10:46:30 +0800
Message-ID: <0672986d-0ede-95e7-b393-c4029766b58a@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <87375520qy.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=sVBXG3WWQrZApCIjUF+hFfvUYC1Qf
        YZk8n1fFbsPLos=; b=hJOQiRTFbjx2fjyNEEWRGAUoPdMfDixtgvfJ9elSQovRX
        CzcWA7jpCzphRIzElNuuEPkVX902GqPd1gi3bgTPeubLD1Fa4bK5DHHyiBUW2LLG
        +9e7PjJ6ZU9GNfW3r7YmSW9wcaO1aBVJn1tXHnYWB+70of8XG+4PKwFwZX9a6d9L
        1y1IUhc6RF4kFRVVBkvVgvbwNmPehEDRS6zgYIdSK8IhLMYVjTUop3uLRgllzrom
        d8qw1KHSuyqXMfJNhLgetWkDlELw/epEVhquOgcw18WXAlXarAd0pcK0ZRrIeKaC
        WaNSou2TamWWhfkFr+znYcKJtDAWfraTpPuUu7bgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sVBXG3
        WWQrZApCIjUF+hFfvUYC1QfYZk8n1fFbsPLos=; b=Vrg+BtZurlJgw9/74MAuPN
        nWwBHXXvfmE9lUkGl4UX4MW2230uv0fRdt2kmEXlHccPQm1HdQBKiqVL7aUSrfPu
        T01tlZWH/JI1114FhNuUA5V60ajg4qSPjB8yVft8dCB3YSqhi2OTX5pAJrDG89RB
        TeTrZKCl/2R9pwzU6M6uZWmfKdybI8ycCp5heLqmCR5ZwCU1QM4N9oHCMEX5URy0
        RdWyfdGMAU9O81cksAObURwwTicIXUV9jvXGYlemFhNZetg1Yp2t6ILcPa+xWAE7
        maRymzSkiZ4BN3w7oUrZtsg4w2ithau5Vk0mA52ZqhFXqKDrNn+Wi2dFaIXrI0ww
        ==
In-Reply-To: <87375520qy.fsf@notabene.neil.brown.name>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 23/11/17 10:21, NeilBrown wrote:
> On Thu, Nov 23 2017, Ian Kent wrote:
> 
>>
>> Hey Neil, I'm looking at this again because RH QE have complained about
>> a regression test failing with a kernel that has this change.
>>
>> Maybe I'm just dumb but I though a "find <base directory> <options>"
>> would, well, just look at the contents below <base directory> but an
>> strace shows that it reads and calls fstatat() on "every entry in the
>> mount table" regardless of the path.
> 
> weird ... I can only get find to look at the mount table if given the
> -fstyp option, and even then it doesn't fstatat anything that isn't in
> the tree it is searching.

It's probably the -xautofs (exclude autofs fs'es) that was used in
the test that requires reading the mount table to get info about
excluding autofs mounts but the fstatat() on all the entries,
regardless of path, that was a surprise to me.

find did use AT_SYMLINK_NOFOLLOW which historically behaved like
AT_NO_AUTOMOUNT.

> 
> 
>>
>> And with the move of userspace to use /proc based mount tables (one
>> example being the symlink of /etc/mtab into /proc) even modest sized
>> direct mount maps will be a problem with every entry getting mounted.
> 
> But the patch in question is only about indirect mount maps, isn't it?
> How is it relevant to direct mount maps?

The change here will cause fstatat() to trigger direct mounts on access
if it doesn't use AT_NO_AUTOMOUNT.

It's not a problem for browse indirect mounts because they are plain
directories within the autofs mount point not individual autofs mount
triggers.

> 
>>
>> Systems will cope with this fine but larger systems not so much.
>>
>> If find does this then the user space changes needed to accommodate
>> this sort of change are almost certainly far more than I expected.
>>
>> I think this is an example of the larger problem I'm faced with and
>> this change was was meant to be a starting point for resolution.
>>
>> The most obvious symptom of the problem is auto-mounts no longer able
>> to be expired due to being re-mounted immediately after expire. Another
>> symptom is unwanted (by the user) accesses causing unexpected auto-mount
>> attempts.
>>
>> I believe this monitoring of the mount table is what leads to excessive
>> CPU consumption I've seen, usually around six processes, under heavy
>> mount activity. And following this, when the mount table is large and
>> there is "no mount activity" two of the six processes continue to consume
>> excessive CPU, until the mount table shrinks.
>>
>> So now I'm coming around to the idea of reverting this change ..... and
>> going back to the drawing board.
> 
> I can well imaging that a large mount table could cause problems for
> applications that are written to expect one, and I can imagine that
> autofs could cause extra issues for such a program as it might change
> the mount table more often.  But I haven't yet worked out how this is
> related to the patch in question....
> 
> Thanks,
> NeilBrown
> 

