From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Thu, 8 Sep 2011 13:19:49 -0700
Message-ID: <CA+55aFzfXOi2xk1JVnTTzQPzoNH+iQkhtpT6cVEz+D7si8MAfw@mail.gmail.com>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu> <17416.1315240659@redhat.com>
 <87hb4q9b3r.fsf@tucsk.pomaz.szeredi.hu> <1315281208.3210.26.camel@perseus.themaw.net>
 <87mxeixfaq.fsf@tucsk.pomaz.szeredi.hu> <1315319903.3210.51.camel@perseus.themaw.net>
 <87ipp5y912.fsf@tucsk.pomaz.szeredi.hu> <1315485406.3476.9.camel@perseus.themaw.net>
 <87bouv17dc.fsf@tucsk.pomaz.szeredi.hu> <CA+55aFy3VN2Y-oadFUMdCaBVQtPT9Ae3fDQCw5vHfA6UvH8GiA@mail.gmail.com>
 <20110908195043.GV2203@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110908195043.GV2203@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, autofs@linux.kernel.org

On Thu, Sep 8, 2011 at 12:50 PM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> On Thu, Sep 08, 2011 at 10:42:28AM -0700, Linus Torvalds wrote:
>
>> > You say it's a step in the right direction but I don't see why. ?E=
ither
>> > we want stat *and* lstat to both be correct and trigger the automo=
unt or
>> > we are satisfied with the incorrect but well established practice =
of not
>> > triggering on (l)stat.
>> >
>> > The middle ground makes no sense IMO, there's nothing gained by th=
e
>> > differentiated behavior based on LOOKUP_FOLLOW.
>> >
>> > Can you explain why it's better if stat() tiggers automounts and g=
ives a
>> > correct result but lstat() doesn't?
>>
>> I have to say that this is a very cogent question.
>>
>> The one thing I've not seen in the thread yet is a description of th=
e
>> failure. What does the regression look like? Just "very slow 'ls' wi=
th
>> some versions of 'ls'" or what?
>>
>> I'm inclined to apply the patch as a regression fix, but I'll let th=
is
>> thread try to convince me for another day..
>
> IIRC, that matches traditional SunOS behaviour and it actually does m=
ake
> sense; you want wildcard expansion and ls -l to be doable even when t=
here's
> a stuck NFS server. =A0IOW, non-triggering lstat(2) is a matter of us=
ability...

non-triggering lstat() isn't the issue, afaik. We never trigger on lsta=
t.

nontriggering *stat()* is the issue. We didn't *use* to trigger on
stat() either. Now in 2.6.38+ we do.

                   Linus
