From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Tue, 06 Sep 2011 10:09:49 +0200
Message-ID: <87mxeixfaq.fsf@tucsk.pomaz.szeredi.hu>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
	<17416.1315240659@redhat.com> <87hb4q9b3r.fsf@tucsk.pomaz.szeredi.hu>
	<1315281208.3210.26.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EyfkGpBSEYBX+bER/QYw38DJsCOdz4+4GtIaSVnohl4=;
        b=TPPxzyWHYUu2JM19pXHOGdB57NT/QxZh6tfTrHQBqyXDyqqsVP7XNMkmxVigia3lzR
         jMfslPtIBBIaODSryECLGDZ+vzDLLm9tLT1vT5Lxd6dRAZrUMB+h9xIYmHDu/2KnjmOb
         /WRKfC8AoRVln8x/Sz4jRcFYcM6769po3tOBQ=
In-Reply-To: <1315281208.3210.26.camel@perseus.themaw.net> (Ian Kent's message
	of "Tue, 06 Sep 2011 11:53:28 +0800")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org

Ian Kent <raven@themaw.net> writes:

> On Mon, 2011-09-05 at 19:02 +0200, Miklos Szeredi wrote:
>> 
>> If automounting on lstat(2) is the correct behavior (is it?  why?)  then at
>> least it should be enabled by a global switch or mount option, IMO.
>
> Ideally we wouldn't need to take special precautions for these
> operations at all but we can't, especially for GUI environments that
> constantly scan file systems on mount/umount activity.
>
> Historically for autofs, neither stat(2) or lstat(2) would trigger a
> mount. With the current implementation stat(2) now does but lstat(2)
> doesn't which is a step in the right direction IMHO. So, I recommend we
> continue to encourage user space to make the needed changes so we
> continue to move in the right direction, and yes, I acknowledge it is a
> pain but it'll never get done otherwise.

I'm not quite convinced.  What's the advantage of triggering automount
on stat(2)?

Has anybody complained that stat(2) on the mountpoint doesn't cause an
automount?

Thanks,
Miklos

