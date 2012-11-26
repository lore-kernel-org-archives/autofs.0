From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 1/2] autofs4: allow autofs to work outside the initial PID namespace
Date: Mon, 26 Nov 2012 09:05:46 +0100
Message-ID: <CAJfpegsqwd57NdHVhwfdNjauj8HKJb=x+2GAZtJQ8vLdt+A=sw@mail.gmail.com>
References: <87obipehbt.fsf@tucsk.pomaz.szeredi.hu>
	<1353642304.2309.25.camel@perseus.themaw.net>
	<1353672540.6699.18.camel@perseus.themaw.net>
	<874nkgwfw0.fsf@tucsk.pomaz.szeredi.hu>
	<1353723813.2348.48.camel@perseus.themaw.net>
	<1353724641.2348.56.camel@perseus.themaw.net>
	<878v9rmcgc.fsf@xmission.com>
	<CAJfpegvQGhzDvQt=OBf=GVQF2gDynTp6F+zO-dn5skFLtukFCQ@mail.gmail.com>
	<87lidqfx3u.fsf@xmission.com>
	<1353885956.2323.4.camel@perseus.themaw.net>
	<1353896968.2323.7.camel@perseus.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aKIFtCjQJ3pJyXuLFdTo/d5zdljuiOrOzBZ8QLRnF+k=;
        b=UcyjXgNXJOiRA8W+yoYUMcPXg3QV63JI9SFR0ir+LCfYEj6v/xIh1BnpgJOrAD+ykn
         Hp0k7uyBcIn2wkFbELUufMAayUOawXJL5vO7W4y8Hv3a5MCbmIJ70mpJa0950F3C6Pof
         GRzpgicm5lcnfdxAKJaL0pAUq40I74rEJahqg=
In-Reply-To: <1353896968.2323.7.camel@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, Al Viro <viro@zeniv.linux.org.uk>

On Mon, Nov 26, 2012 at 3:29 AM, Ian Kent <raven@themaw.net> wrote:
>> > > MS_UNBINDABLE says:  skip this mount when copying a mount tree, such
>> > > as when the mount namespace is cloned.
>> > >
>> > > If you set MS_UNBINDABLE on autofs mounts then they will simply not
>> > > appear in a cloned namespace.  Which sounds like a good idea,  no?
>> >
>> > Good point.  If the desire is for a mount to be managed by autofs
>> > setting MS_UNBINDABLE seems required.
>>
>> Arrgh, I know that's something I should have looked into long ago.
>> The fact is that autofs mounts are directly related to a specific path
>> defined by automount maps that are associated with the daemon so bind
>> mounting them elsewhere makes no sense.
>
> Except, AFAICS, they do appear in the clone.

Hmm, yes, apparently the semantics of MS_UNBINDABLE only apply to
actual bind mounts not to namespace cloning. Even though the two
operations are closely related.  Not sure why this is so, but it is
probably not a good idea to change the semantics at this point.

Thanks,
Miklos
