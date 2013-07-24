From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/9] Series short description
Date: Wed, 24 Jul 2013 18:14:25 +0800
Message-ID: <1374660865.2358.32.camel@perseus.fritz.box>
References: <20130724081610.722.84685.stgit@perseus.fritz.box>
	 <CAF1ZMEdmTPuUCP2dR-nxBEP+swm0Mqoxw0ve3rJx-9wn12FRXA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=xR1njOXXz5Jc/nmHBbK66a65lDo=; b=v4Mn5ExuxyLvZEY4MXMQbxittawz
	23ljQXiqkesnhNl7PUtNdw/g9YGCI/AoQf3CzTn0Im9dHrK5UemmArk3FlxOdn69
	mvSplf90bfxXwlcOM/5NjvATgvS6+F9deQzeCf7kvvYBbbsQ0QG1VfPITfx8x8t7
	PaqJNwP1UunPXO4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=xR1njOXXz5Jc/nmHBbK66a
	65lDo=; b=Og0E9YrpKS4AkEIbiGF3b52KjLBB0U/P5jfua7A+rTy0oM6GII44Td
	5LHyo9EcJa/2N7BeJJQlXWgubVQll0wUTXcdXNbFFdvkdGQ292+e/AeHUgTLEJ+6
	otqx1D4EfG0+Cp0jUxl39iTWOopxR4Vs2lsSh/iEfFHGdE3KT5zok=
In-Reply-To: <CAF1ZMEdmTPuUCP2dR-nxBEP+swm0Mqoxw0ve3rJx-9wn12FRXA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Wed, 2013-07-24 at 16:34 +0800, Dennis Lan (dlan) wrote:
> On Wed, Jul 24, 2013 at 4:17 PM, Ian Kent <raven@themaw.net> wrote:
> > The following series implements...
> >
> > ---
> >
> > Dustin Polke (1):
> >       autofs-5.0.7 - fix compilation of lookup_ldap.c without sasl
> >
> > Ian Kent (1):
> >       autofs-5.0.7 - use LIBS for link libraries
> >
> > Lan Yixun (dlan) (7):
> >       autofs-5.0.7 - fix typo forced-shutdown should be force-shutdown
> >       autofs-5.0.7 - fix hesiod check error and use correct $(LIBS) setting
> >       autofs-5.0.7 - fix dead LDAP symbolic link when LDAP support is disabled
> >       autofs-5.0.7 add missing libtirpc lib to mount_nfs.so when TIRPC enabled
> >       autofs-5.0.7 - use compiler determined by configure instead of hard-coded ones
> >       autofs-5.0.7 - remove hard-coded STRIP variable
> >       autofs-5.0.7 - unbundle NOTSTRIP from DEBUG so they wont depend on each other
> >
> >
> >  CHANGELOG             |    4 ++++
> >  Makefile.conf.in      |    3 +++
> >  Makefile.rules        |   30 +++++++++++++++---------------
> >  aclocal.m4            |   12 ++++++------
> >  configure             |   20 ++++++++++----------
> >  configure.in          |    2 +-
> >  daemon/Makefile       |    2 +-
> >  include/lookup_ldap.h |    4 ++--
> >  lib/Makefile          |    4 ++++
> >  modules/Makefile      |   20 ++++++++++++--------
> >  modules/lookup_ldap.c |   14 ++++++++++++--
> >  11 files changed, 70 insertions(+), 45 deletions(-)
> >
> > --
> > Signature
> 
> Hi Ian:
>   Thanks.
>   But I haven't seen the commits published, am I use the wrong repo url? [1]

This was a false start, as I replied to it later.

The posts to follow are what I have in the queue for the next time I
commit changes.

There are three types of patches in the queue of patches I have.

First are ones I will commit next time I do a commit, second are patches
that may on may not be applied depending on their state and which may or
may not be committed next commit, and third patches which I'm carrying
that I don't intend to commit, at least for the moment.

So I'd like to confirm I have what your hoping for before committing
anything and then there's the as yet unfinished patch ....

Ian

> 
> Dennis Lan (dlan)
> 
> 
> [1] git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git


