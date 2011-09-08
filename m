From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Thu, 08 Sep 2011 15:38:55 +0200
Message-ID: <87bouv17dc.fsf@tucsk.pomaz.szeredi.hu>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
	<17416.1315240659@redhat.com> <87hb4q9b3r.fsf@tucsk.pomaz.szeredi.hu>
	<1315281208.3210.26.camel@perseus.themaw.net>
	<87mxeixfaq.fsf@tucsk.pomaz.szeredi.hu>
	<1315319903.3210.51.camel@perseus.themaw.net>
	<87ipp5y912.fsf@tucsk.pomaz.szeredi.hu>
	<1315485406.3476.9.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=j0CxBTQdTzvRsIf5Fv5HeiktCHguXL1GItrtYiDhl6A=;
        b=VEQ9pmPo6Uq1SsOcA6DbRQJoIYJuXNBmaLPqaNUEsiU5QQzziSyXZx0kM7pgHRuDyE
         Bs10vDSQni/ayxq3ywq9lHjkjkJniziRsSbWjK7LP8/4A6nOTWZ62DTMautP2ks0zB3w
         0u5h56BNWPDxfHhdrxmve6xDZJZNScVVjSMxM=
In-Reply-To: <1315485406.3476.9.camel@perseus.themaw.net> (Ian Kent's message
	of "Thu, 08 Sep 2011 20:36:46 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org

Ian Kent <raven@themaw.net> writes:

> On Tue, 2011-09-06 at 17:39 +0200, Miklos Szeredi wrote:
>> Ian Kent <raven@themaw.net> writes:
>> 
>> > On Tue, 2011-09-06 at 10:09 +0200, Miklos Szeredi wrote:
>> >> Ian Kent <raven@themaw.net> writes:
>> >> 
>> >> > On Mon, 2011-09-05 at 19:02 +0200, Miklos Szeredi wrote:
>> >> >> 
>> >> >> If automounting on lstat(2) is the correct behavior (is it?  why?)  then at
>> >> >> least it should be enabled by a global switch or mount option, IMO.
>> >> >
>> >> > Ideally we wouldn't need to take special precautions for these
>> >> > operations at all but we can't, especially for GUI environments that
>> >> > constantly scan file systems on mount/umount activity.
>> >> >
>> >> > Historically for autofs, neither stat(2) or lstat(2) would trigger a
>> >> > mount. With the current implementation stat(2) now does but lstat(2)
>> >> > doesn't which is a step in the right direction IMHO. So, I recommend we
>> >> > continue to encourage user space to make the needed changes so we
>> >> > continue to move in the right direction, and yes, I acknowledge it is a
>> >> > pain but it'll never get done otherwise.
>> >> 
>> >> I'm not quite convinced.  What's the advantage of triggering automount
>> >> on stat(2)?
>> >
>> > You get the information of the directory of the mounted fs and for many
>> > peoples purposes automounting should be transparent so that would be
>> > best.
>> 
>> The same is true for lstat(2).
>> 
>> >  
>> >> 
>> >> Has anybody complained that stat(2) on the mountpoint doesn't cause an
>> >> automount?
>> >
>> > Yes, based on the reasoning above.
>> 
>> Would any of those complaints go away if stat(2) did cause an
>> automount and lstat(2) didn't?
>
> Ummm .... please forgive me, I'm confused over which of these cause an
> automount to occur, again.
>
> Much of what I've said previously is wrong because stat(2) does cause
> the automount and lstat(2) doesn't, which is, I think, the way it should
> be, semantically (see bug
> https://bugzilla.redhat.com/show_bug.cgi?id=692823 for example).
>
> I'll go back and check the code "again", just to be doubly sure, which I
> need to do given my constant confusion on this, oops!

Sloppy wording on my part is probably responsible for some of the
confusion.

Yes, 2.6.38 and later kernels do trigger on stat(2) but not on lstat(2).

My question is this:  does this behavior improve anything compared to
kernels before 2.6.38?  Because I don't see that it does, in fact it's
just causing regressions.

You say it's a step in the right direction but I don't see why.  Either
we want stat *and* lstat to both be correct and trigger the automount or
we are satisfied with the incorrect but well established practice of not
triggering on (l)stat.

The middle ground makes no sense IMO, there's nothing gained by the
differentiated behavior based on LOOKUP_FOLLOW.

Can you explain why it's better if stat() tiggers automounts and gives a
correct result but lstat() doesn't?

Thanks,
Miklos
