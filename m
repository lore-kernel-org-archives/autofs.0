From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/2] autofs4: allow autofs to work outside the initial PID namespace
Date: Sat, 24 Nov 2012 14:35:17 -0800
Message-ID: <87lidqfx3u.fsf@xmission.com>
References: <87obipehbt.fsf@tucsk.pomaz.szeredi.hu>
	<1353642304.2309.25.camel@perseus.themaw.net>
	<1353672540.6699.18.camel@perseus.themaw.net>
	<874nkgwfw0.fsf@tucsk.pomaz.szeredi.hu>
	<1353723813.2348.48.camel@perseus.themaw.net>
	<1353724641.2348.56.camel@perseus.themaw.net>
	<878v9rmcgc.fsf@xmission.com>
	<CAJfpegvQGhzDvQt=OBf=GVQF2gDynTp6F+zO-dn5skFLtukFCQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CAJfpegvQGhzDvQt=OBf=GVQF2gDynTp6F+zO-dn5skFLtukFCQ@mail.gmail.com>
	(Miklos Szeredi's message of "Sat, 24 Nov 2012 22:12:58 +0100")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Sat, Nov 24, 2012 at 1:07 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Ian Kent <raven@themaw.net> writes:
>>
>>> On Sat, 2012-11-24 at 10:23 +0800, Ian Kent wrote:
>>>> On Fri, 2012-11-23 at 15:30 +0100, Miklos Szeredi wrote:
>
>>>> AFAICS autofs mounts mounted with MS_PRIVATE in the initial namespace do
>>>> propagate to the clone when it's created so I'm assuming subsequent
>>>> mounts would also. If these mounts are busy in some way they can't be
>>>> umounted in the clone unless "/" is marked private before attempting the
>>>> umount.

Subsequent mounts after the clone do not have a mechanism to propogate
with MS_PRIVATE.  As creating a new mount namespaces is essentially
an instance of mount --bind.  Those semantics are a little unintuitive
I have to admit.

>>> This may sound stupid but if there something like, say, MS_NOPROPAGATE
>>> then the problem I see would pretty much just go away. No more need to
>>> umount existing mounts and container instances would be isolated. But, I
>>> guess, I'm not considering the possibility of cloned of processes as
>>> well .... if that makes sense, ;)
>>
>> Something is very weird is going on.  MS_PRIVATE should be the
>> MS_NOPROPOGATE you are looking for.  There is also MS_UNBINDABLE.
>> which is a stronger form of MS_PRIVATE and probably worth play with.
>>
>
> MS_UNBINDABLE says:  skip this mount when copying a mount tree, such
> as when the mount namespace is cloned.
>
> If you set MS_UNBINDABLE on autofs mounts then they will simply not
> appear in a cloned namespace.  Which sounds like a good idea,  no?

Good point.  If the desire is for a mount to be managed by autofs
setting MS_UNBINDABLE seems required.

Eric

