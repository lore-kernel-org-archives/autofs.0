From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Tue, 06 Sep 2011 17:39:53 +0200
Message-ID: <87ipp5y912.fsf@tucsk.pomaz.szeredi.hu>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
	<17416.1315240659@redhat.com> <87hb4q9b3r.fsf@tucsk.pomaz.szeredi.hu>
	<1315281208.3210.26.camel@perseus.themaw.net>
	<87mxeixfaq.fsf@tucsk.pomaz.szeredi.hu>
	<1315319903.3210.51.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ijGg9dflXKyb5Y8TbHrb1p0D6lW0t0tn0a7eqSkBd5c=;
        b=GYP4QJiI/hjRnOmvhMi2StFeqL2hOOQyczoS3ebfSh1CdOvjsf9+PMxigjz1lsXs9f
         zTxt/hhNilUvNHzhlcZjIusl0JCcnw64+4QlMLvpzTHlm620Z5/TfSooBiaysZNKXrQC
         KSViXA7T8lTfGI5uV/WfKas5kxOwb5EcH9PyM=
In-Reply-To: <1315319903.3210.51.camel@perseus.themaw.net> (Ian Kent's message
	of "Tue, 06 Sep 2011 22:38:23 +0800")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org

Ian Kent <raven@themaw.net> writes:

> On Tue, 2011-09-06 at 10:09 +0200, Miklos Szeredi wrote:
>> Ian Kent <raven@themaw.net> writes:
>> 
>> > On Mon, 2011-09-05 at 19:02 +0200, Miklos Szeredi wrote:
>> >> 
>> >> If automounting on lstat(2) is the correct behavior (is it?  why?)  then at
>> >> least it should be enabled by a global switch or mount option, IMO.
>> >
>> > Ideally we wouldn't need to take special precautions for these
>> > operations at all but we can't, especially for GUI environments that
>> > constantly scan file systems on mount/umount activity.
>> >
>> > Historically for autofs, neither stat(2) or lstat(2) would trigger a
>> > mount. With the current implementation stat(2) now does but lstat(2)
>> > doesn't which is a step in the right direction IMHO. So, I recommend we
>> > continue to encourage user space to make the needed changes so we
>> > continue to move in the right direction, and yes, I acknowledge it is a
>> > pain but it'll never get done otherwise.
>> 
>> I'm not quite convinced.  What's the advantage of triggering automount
>> on stat(2)?
>
> You get the information of the directory of the mounted fs and for many
> peoples purposes automounting should be transparent so that would be
> best.

The same is true for lstat(2).

>  
>> 
>> Has anybody complained that stat(2) on the mountpoint doesn't cause an
>> automount?
>
> Yes, based on the reasoning above.

Would any of those complaints go away if stat(2) did cause an
automount and lstat(2) didn't?

With AT_NO_AUTOMOUNT I can agree with, that's a flag specifically about
not automounting.  Unlike AT_SYMLINK_NOFOLLOW which is about following
symlinks and hasn't got a lot to do with automounts.

Thanks,
Miklos
