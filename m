From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 4/7] autofs4 - fix indirect mount pending expire race
Date: Fri, 18 Jul 2008 15:14:14 -0400
Message-ID: <x49ljzzc8e1.fsf@segfault.boston.devel.redhat.com>
References: <20080718023651.12802.59107.stgit@raven.themaw.net>
	<20080718023717.12802.80763.stgit@raven.themaw.net>
	<x49r69rc9ea.fsf@segfault.boston.devel.redhat.com>
	<1216407362.18371.10.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1216407362.18371.10.camel@raven.themaw.net> (Ian Kent's message
	of "Sat, 19 Jul 2008 02:56:01 +0800")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

Ian Kent <raven@themaw.net> writes:

> On Fri, 2008-07-18 at 14:52 -0400, Jeff Moyer wrote:
>> Ian Kent <raven@themaw.net> writes:
>> >  		} else {
>> > +			/* Path walk currently on this dentry? */
>> > +			ino_count = atomic_read(&ino->count) + 1;
>> > +			if (atomic_read(&dentry->d_count) > ino_count)
>> > +				goto next;
>> > +
>> >  			expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
>> >  			if (expired) {
>> >  				dput(dentry);
>
> The expired dentry may be a different dentry!
>
>> >  found:
>> >  	DPRINTK("returning %p %.*s",
>> >  		expired, (int)expired->d_name.len, expired->d_name.name);
>> > +	ino = autofs4_dentry_ino(expired);
>> 
>> If we get here, ino is already set to the autofs4_dentry_ino(expired),
>> so this statement is redundant.
>
> Almost but see above.

Ah, you're right, I missed that.

Cheers,

Jeff
