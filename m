From: raven@themaw.net
Subject: Re: [PATCH 1/3] autofs4 - expiring filesystem from under process
Date: Mon, 23 May 2005 20:38:11 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505232005550.8361@donald.themaw.net>
References: <Pine.LNX.4.62.0504102044140.5212@donald.themaw.net>
 <16986.44640.269893.824019@segfault.boston.redhat.com>
 <Pine.LNX.4.62.0504202227130.8800@donald.themaw.net>
 <16998.50065.652052.980908@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <16998.50065.652052.980908@segfault.boston.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, autofs mailing list <autofs@linux.kernel.org>, Michael Blandford <michael@kmaclub.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Sorry to take so long to get back to this Jeff.

On Wed, 20 Apr 2005, Jeff Moyer wrote:
> ==> Regarding Re: [PATCH 1/3] autofs4 - expiring filesystem from under process; raven@themaw.net adds:
>
> raven> On Mon, 11 Apr 2005, Jeff Moyer wrote:
>>> ==> Regarding [PATCH 1/3] autofs4 - expiring filesystem from under
>>> process; raven@themaw.net adds:
>>>
>>> Could also please explain how the following is handled:
>>>
>>> expire process runs and issues AUTOFS_EXPIRE_MULTI, which sets
>>> AUTOFS_INF_EXPIRING in flags.  While the expire is in progress, another
>>> process access the directory in question, causing a call to
>>> try_to_fill_dentry.  try_to_fill_dentry sees the AUTOFS_INF_EXPIRING
>>> flag is set, and so calls autofs4_wait with notify set to NFY_NONE.
>>> However, when we take the wq sem, we find that the expire has finished,
>>> and thus create a new wq entry.  Because NFY_NONE is set, we don't tell
>>> the daemon.
>>>
>>> So how will this process ever get woken up?
>>>
>
> raven> I've thought about this for quite a while and I think all that's
> raven> needed is to recognise that we're about to expire a dentry that's
> raven> not mounted anymore.
>
> raven> Can you think of a case for which this patch fails?
>
> I don't see how the patch you provided addresses the race between an expire
> event and a lookup.  The real issue here is that the checking of
> AUTOFS_INF_EXPIRING and the list operations associated therewith need to
> happen atomically.  Until this happens, we will have races.

I don't think that's quite how this process works.

In this case, since the the directory exists, we always come to 
autofs4_wait via autofs4_revalidate and only during an expire. If the 
expire finishes and we attempt to create a new wait as you describe then 
all that needs to be done is to return a fail instead of waiting and rely 
on the subsequent autofs4_lookup call to perform the requested mount.

For the normal case, when the process waits and then returns at expire 
completion has the same semantics. So for a NFY_NONE wait request, 
checking if the dentry is a mountpoint and returning -ENOENT is sufficient 
(in fact the return code itself is not significant). Please check 
do_lookup in namei.c and I think you will see what I mean.

Ian
