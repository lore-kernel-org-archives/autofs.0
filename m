From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 1/2] autofs4: allow autofs to work outside the initial PID namespace
Date: Sat, 24 Nov 2012 22:12:58 +0100
Message-ID: <CAJfpegvQGhzDvQt=OBf=GVQF2gDynTp6F+zO-dn5skFLtukFCQ@mail.gmail.com>
References: <87obipehbt.fsf@tucsk.pomaz.szeredi.hu>
	<1353642304.2309.25.camel@perseus.themaw.net>
	<1353672540.6699.18.camel@perseus.themaw.net>
	<874nkgwfw0.fsf@tucsk.pomaz.szeredi.hu>
	<1353723813.2348.48.camel@perseus.themaw.net>
	<1353724641.2348.56.camel@perseus.themaw.net>
	<878v9rmcgc.fsf@xmission.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Gu6toKpxXvBX1jxWK66vfzcx7j9IWISVwkdPxyzOCw8=;
        b=n7PK35LJvJu53lLI/R3m4FTzAD2K4FBEZy8PwPRKibBtsPbPYAONgQ1lSfI3frEqIV
         U0JQjqLMwW+NYw2Cv87oSRlhJ4nVbV2JAWO+NKtjRvquweBaQiddkEzRHnAnLLasPF++
         W51V09ZBTqNERrQuL1iKJI7L1ABPgmbEyA0/g=
In-Reply-To: <878v9rmcgc.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com

On Sat, Nov 24, 2012 at 1:07 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Ian Kent <raven@themaw.net> writes:
>
>> On Sat, 2012-11-24 at 10:23 +0800, Ian Kent wrote:
>>> On Fri, 2012-11-23 at 15:30 +0100, Miklos Szeredi wrote:

>>> AFAICS autofs mounts mounted with MS_PRIVATE in the initial namespace do
>>> propagate to the clone when it's created so I'm assuming subsequent
>>> mounts would also. If these mounts are busy in some way they can't be
>>> umounted in the clone unless "/" is marked private before attempting the
>>> umount.
>>
>> This may sound stupid but if there something like, say, MS_NOPROPAGATE
>> then the problem I see would pretty much just go away. No more need to
>> umount existing mounts and container instances would be isolated. But, I
>> guess, I'm not considering the possibility of cloned of processes as
>> well .... if that makes sense, ;)
>
> Something is very weird is going on.  MS_PRIVATE should be the
> MS_NOPROPOGATE you are looking for.  There is also MS_UNBINDABLE.
> which is a stronger form of MS_PRIVATE and probably worth play with.
>

MS_UNBINDABLE says:  skip this mount when copying a mount tree, such
as when the mount namespace is cloned.

If you set MS_UNBINDABLE on autofs mounts then they will simply not
appear in a cloned namespace.  Which sounds like a good idea,  no?

Thanks,
Miklos
