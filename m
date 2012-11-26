From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/2] autofs4: allow autofs to work outside the initial PID namespace
Date: Mon, 26 Nov 2012 08:38:58 -0600
Message-ID: <87boekzawt.fsf@xmission.com>
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
	<CAJfpegsqwd57NdHVhwfdNjauj8HKJb=x+2GAZtJQ8vLdt+A=sw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CAJfpegsqwd57NdHVhwfdNjauj8HKJb=x+2GAZtJQ8vLdt+A=sw@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 26 Nov 2012 09:05:46 +0100")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, Al Viro <viro@zeniv.linux.org.uk>

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Mon, Nov 26, 2012 at 3:29 AM, Ian Kent <raven@themaw.net> wrote:
>>> > > MS_UNBINDABLE says:  skip this mount when copying a mount tree, such
>>> > > as when the mount namespace is cloned.
>>> > >
>>> > > If you set MS_UNBINDABLE on autofs mounts then they will simply not
>>> > > appear in a cloned namespace.  Which sounds like a good idea,  no?
>>> >
>>> > Good point.  If the desire is for a mount to be managed by autofs
>>> > setting MS_UNBINDABLE seems required.
>>>
>>> Arrgh, I know that's something I should have looked into long ago.
>>> The fact is that autofs mounts are directly related to a specific path
>>> defined by automount maps that are associated with the daemon so bind
>>> mounting them elsewhere makes no sense.
>>
>> Except, AFAICS, they do appear in the clone.
>
> Hmm, yes, apparently the semantics of MS_UNBINDABLE only apply to
> actual bind mounts not to namespace cloning. Even though the two
> operations are closely related.  Not sure why this is so, but it is
> probably not a good idea to change the semantics at this point.

And for whatever reason this appears deliberate.

CL_COPY_ALL in copy_tree allows the copy.

The selected semantics of namespace sharing tend to mystify me.

So I don't know how much MS_UNBINDABLE helps over MS_PRIVATE.  Both
prevent propogation of changes to other namespaces.  I don't know how
much using MS_UNBINDABLE to also prevent bind mounts helps.

Eric

