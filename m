From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 09/18] autofs4: Add d_manage() dentry operation [ver #4]
Date: Sat, 15 Jan 2011 02:46:02 +1100
Message-ID: <AANLkTin0YuRx9gRXLLJKOu4BOXYxOMnWmSsRLxAzXzdo@mail.gmail.com>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
	<20110113215448.19406.58770.stgit@warthog.procyon.org.uk>
	<1295013099.2794.6.camel@perseus>
	<AANLkTin7GaJq6RuQdWkzY7XnH12-=8Gebr24Pyy+fWG+@mail.gmail.com>
	<5326.1295019354@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LiHelfEmUnt9Ydot7I1TzwnIUV0R8ad+Yq5qUT2CeoI=;
        b=Hb9z34btf/mZath7yk9zTfYlVRjJW7UiCAMkoK/uEKamfWNp1Bb6g3boejr3ilny47
         ajDCcyNsrzj0zRiuJadV+JlCITl2u1P3hDVAQGJd9qSiA9QOL616u9e9D9N3KDcYIMai
         I4pNM7Bj4FHjYr7yLy6P4g2isLPCDvuVGPK4Y=
In-Reply-To: <5326.1295019354@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Howells <dhowells@redhat.com>
Cc: Ian Kent <raven@themaw.net>, viro@zeniv.linux.org.uk, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Sat, Jan 15, 2011 at 2:35 AM, David Howells <dhowells@redhat.com> wr=
ote:
> Nick Piggin <npiggin@gmail.com> wrote:
>
>> > On Thu, 2011-01-13 at 21:54 +0000, David Howells wrote:
>> >> From: Ian Kent <raven@themaw.net>
>> >> + =A0 =A0 //spin_lock(&dcache_lock); =A0/////////////// JUST DELE=
TE THIS LOCK?
>> >> + =A0 =A0 if (!d_mountpoint(dentry) && list_empty(&dentry->d_subd=
irs)) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&dentry->d_lock);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(dentry->d_flags & DCACHE_MANAGE_T=
RANSIT) &&
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(dentry->d_flags & DCACHE_NE=
ED_AUTOMOUNT))
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __managed_dentry_set_tr=
ansit(path->dentry);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&dentry->d_lock);
>> >> + =A0 =A0 }
>> >> + =A0 =A0 //spin_unlock(&dcache_lock);
>> >
>> > In this case I think the dcache_lock needs to be deleted and the d=
_lock
>> > moved out of the if to protect the d_subdirs access.
>>
>> Right. If you follow the vfs-scale-working git branch series of
>> patches leading up to dcache_lock removal, it gives a pretty
>> good template of how to convert old dcache_lock using code
>> to new locking.
>>
>> Although you can also just look at locking in fs/dcache.c and
>> convert code from that.
>>
>> Any time you are dealing with just a *single* dentry, then
>> ->d_lock would be enough to replace dcache_lock (it
>> actually protects more than dcache_lock alone did).
>
> Does it make sense to leave the lock where it is and repeat the outer=
 test
> after we've taken the lock?

I'll make the usual suggestion to make the locking simple, and
even avoiding all unlocked-load-then-recheck type of access,
unless there is a good reason to need it.

Many cases of ordering bugs I've found are due to these
seemingly simple and obvious optimisations.

It's up to you of course, is it worth having to think a little bit
harder about? Ian and yourself could probably answer that
better than me.
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
