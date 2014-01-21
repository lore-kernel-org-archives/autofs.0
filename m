From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs-5.0.7 don't reset errno
Date: Tue, 21 Jan 2014 08:58:37 +0800
Message-ID: <1390265917.2541.51.camel@perseus.fritz.box>
References: <CAEySpB5qJqSennSmX_kxXxA2YXvL7UweqyhhvLOvMcHYQP_Rcw@mail.gmail.com>
	 <CAEySpB5C8gOhsCd3Mv+2C_4+wX+jHVGP227i9kuY1QPZ4FJTDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=3WRvqtkf/PLTKsTeEEoHqvDXNjs=; b=MyiGlOyhsHELQm10b8CnlNtVW6Mk
	Xp5NCWuGgtLNII8W2cr4MSZgs2WlV+WspPLj6r+oGtQGoh2jbAnSzRIVKCaUFo5c
	nHzLiH8eW3pSFAST6YihxHfBgdd44/HALnRaZAvMqcLjq8eZ0XDYyRewAjo13Yo1
	GbR/cstoNcknx3o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=3WRvqtkf/PLTKsTeEEoHqv
	DXNjs=; b=Lxnw4b2fACoesXC1rsPD/i7vl0pAz/PbTRK8R5pcqM4n1Il6m2c1QI
	uUBsrVE3Iu9DHjfb6LtLoVpGYSAQ3BqthFleOhcMWS2ElL8O3V/8SeL/UHX0yX2m
	X7JNwKt1Q9J6527ZYgI/gE/Q+gqJYN9avWYXb2SX6S4SgfVllotbw=
In-Reply-To: <CAEySpB5C8gOhsCd3Mv+2C_4+wX+jHVGP227i9kuY1QPZ4FJTDQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs <autofs@vger.kernel.org>

On Mon, 2014-01-20 at 11:45 -0200, Leonardo Chiquitto wrote:
> On Thu, Sep 20, 2012 at 12:35 PM, Leonardo Chiquitto
> <leonardo.lists@gmail.com> wrote:
> > Hello Ian,
> >
> > Please consider the patch below for inclusion.
> >
> > Thanks,
> > Leonardo
> >
> > From: Werner Fink <werner@suse.de>
> >
> > Do not reset the error code that might just have been set to ENOTDIR.
> >
> > Index: autofs/daemon/automount.c
> > ===================================================================
> > --- autofs.orig/daemon/automount.c
> > +++ autofs/daemon/automount.c
> > @@ -107,9 +107,9 @@ static int do_mkdir(const char *parent,
> >         /* If path exists we're done */
> >         status = stat(path, &st);
> >         if (status == 0) {
> > +               errno = EEXIST;
> >                 if (!S_ISDIR(st.st_mode))
> >                         errno = ENOTDIR;
> > -               errno = EEXIST;
> >                 return 0;
> >         }
> 
> Hi Ian,
> 
> Looks like this one has slipped through the cracks. Could you review
> and commit if appropriate?

Yep, will do.

Ian

