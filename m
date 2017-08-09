From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 9 Aug 2017 08:45:55 +0800
Message-ID: <3ef5b801-2a40-975e-3cfa-ef24cc3ad288@themaw.net>
References: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
 <1502197874.3935465.1066793424.598228B6@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=+l/qUocEZOGoD2njsW
        cfHyEcPc+K9w6YyjMWYOPgqEI=; b=j2BiOxX+rrTE4VCM+UgvYQ4wDT3jmqdZ7C
        Z0R1Gn4mrUSiMxwc0y0dF0UrKjiiL0ypo6N8R4zTonByXuDwDC00mAzGd/rkRHx0
        IpkTgKDVegqHV2dqpaXIQ5gNRl4xFxpORiD8rj/EcRCm+xNkkao9jfy5SFABZdDy
        OZjUp8c3FJlOwgcsHpdOvjhOHp1EaCmGVsLmjpqYDBiUcmlX7BQqaUqrKii+FCJA
        DF7dTTpxgbDc/0CAS3aoHuRy1pG7h15syeswHrWWw6EZL/VHlC3tJsMwFJufK4yC
        x2/oXhsetEY4EOc5WKmEuHRMTV9YoEbhm9W1E32oW2oMaHdVE8oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=+l/qUocEZOGoD2njsWcfHyEcPc+K9w6YyjMWYOPgqEI=; b=glWAAr/Q
        QO1Su7U2Z+rVA9dDb/ogupxoj08FyBCHRbHSXM5je/gLh2FSdFkumvC2QkprnXN7
        wqLjoV7v11Zv8aEOwQAonxatxN0fuXMCPbKeo4RJYHpt5RGRKyrnEkI4nYZTVrP1
        jnrWCnT/3+ccOtjgBOWY4pCQ/AEDaWX+ZmnnHQ1Lvvxac7t8FoAPpNVT8BWE3FCz
        cIYEeAZ7CZcVuVzecDwgC/+glnqjLRE2f0m4H09Uj3bz7zayX+uYM6SWQb3KYgv6
        1KmIFBQx2O3/AfNFR9znptYeX0EyPNxB4auBrslPlD+DtU+3SaTxPoxmCLSd2xCQ
        LSbPR42kTX7sKQ==
In-Reply-To: <1502197874.3935465.1066793424.598228B6@webmail.messagingengine.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Colin Walters <walters@verbum.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Ondrej Holy <oholy@redhat.com>, Colin Walters <walters@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 08/08/17 21:11, Colin Walters wrote:
> On Tue, Aug 8, 2017, at 12:26 AM, Ian Kent wrote:
> 
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -3022,8 +3022,7 @@ static inline int vfs_lstat(const char __user *name, struct kstat *stat)
>>  static inline int vfs_fstatat(int dfd, const char __user *filename,
>>  			      struct kstat *stat, int flags)
>>  {
>> -	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
>> -			 stat, STATX_BASIC_STATS);
>> +	return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
>>  }
>>  static inline int vfs_fstat(int fd, struct kstat *stat)
>>  {
> 
> This is reverting the fstatat() prat of
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=deccf497d804a4c5fca2dbfad2f104675a6f9102
> Which itself seems weird to me - it looks like we were unconditionally
> forcing on AT_NO_AUTOMOUNT regardless of what userspace passed?
> So perhaps a
> Fixes: deccf497d804a4c5fca2dbfad2f104675a6f9102
> is appropriate here?

David posted this at my request.

I asked him to do it because, when I saw this, I thought restoring the semantics
to what they were before they were changed needed to be done as quickly as possible.

That was so that I could then work on fixing the AT_NO_AUTOMOUNT not being honored
with fstatat(2).

> 
> I understand that for stat()/lstat() we didn't expose the option to userspace,
> so the behavior was...ah, there's this note in man-pages (man-pages-4.09-3.fc26.noarch):
> 
>> On Linux, lstat() will generally not trigger automounter action, whereas stat() will (but see fstatat(2)).
> 
> I have no idea of the history here, but maybe it makes sense to drop
> the AT_NO_AUTOMOUNT from the vfs_stat() too?
> 

I thought I had talked about the history in the patch description but I guess
it's not clear and isn't detailed enough for people that haven't been close to
the development over time.

Historically stat family calls were not supposed to trigger automounts because
that can easily lead to mount storms that are really bad for large autofs mount
maps. But the mount storm problem was mostly only evident for autofs maps that
used the "browse" option, the non-negative dentry case. The negative dentry
case always triggered an automount regardless of the system call.

Because of the move in user space to mostly always use proc filesystem mount
tables where there can be many more mount entries than were present in the
text based mount tables it's critical to not perform mount callbacks that
aren't absolutely essentially.

At this point that means to me going over the stat(2) system call behavior
and making sure it is only calling back where necessary. That's because that
is where it's expected automounts won't be triggered and so should have least
impact.

So it's the negative dentry handling in follow_automount() you should be
thinking about in terms of impact rather than the actual fstatat(2) change.
If man pages need to change then they need to change.

AFAICT, as I said in the patch description, this should not cause regressions
but I can't be certain. In any case it is in keeping with the historical "stat
family system calls shouldn't trigger automounts" mantra needed from the beginning.

Also notice that the negative dentry handling change should only affect autofs
as other kernel uses will be triggering automounts for positive dentrys.

Hopefully this doesn't sound to aggressive, I don't mean it to sound that way.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
