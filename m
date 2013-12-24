From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet
 committed
Date: Tue, 24 Dec 2013 17:04:41 +0800
Message-ID: <1387875881.7351.12.camel@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	 <CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=PQKaqHplSIfvIJtQtdeePULfjH8=; b=UPmqbUH7EnjioQTHs/ZrUHqenP4r
	s4GZIyzoTECXYW13Ct7dERWdjg/22JTc2pKkCeaAwobD4wV47pwcT2L1ftPtseYR
	3tS9YrTQu31atWLd0VdYe6mludFtznnF0kSeMwG90q3pfQd6Oow1cyOhCvarxubq
	SYCOLgS7VdZG2Js=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=PQKaqHplSIfvIJtQtdeePU
	LfjH8=; b=lDkt//k+8msl7H3JZqpuTf/9R/9acpx0pi24658UfHkFuVUaXqek36
	BenSCjeQt7N1hn6W8cb+NwTC7rs/U5gLa86ixpTPZ92fbxMiljAwDaqq7b76GZsN
	BhTj8RMHXTCvy76WNInknzQpuTfTld2MLcAvSwUdf2pvYDcLRERZo=
In-Reply-To: <CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, 2013-12-24 at 16:38 +0800, Dennis Lan (dlan) wrote:
> Hi Ian:
>   Do you mind push a temporary branch into your git repo (if you don't
> want to queue other patches)?
> That would much convenient for me to test.

Try branch autofs-5.0.public.
As master and autofs-5.0 branches diverge the autofs-5.0 will be the
place for version 5.0.

>   Thanks.
> 
> Lan
> 
> On Tue, Dec 24, 2013 at 4:02 PM, Ian Kent <raven@themaw.net> wrote:
> > Let's try that again.
> >
> > Not certain yet what the problem is but today I investigated a problem
> > reported against host map not working and it was something quite different.
> >
> > There are a couple of patches here that are most likely needed in addition
> > to the currently committed patches.
> >
> > In paticualar
> > autofs-5.0.8 - fix fix ipv6 libtirpc getport
> > autofs-5.0.8 - fix rpc_portmap_getport() proto not set
> > and possibly
> > autofs-5.0.8 - get_nfs_info() should query portmapper if port is not given
> >
> > might be useful.
> >
> > ---
> >
> > Ian Kent (4):
> >       autofs-5.0.8 - fix ipv6 link local address handling
> >       autofs-5.0.8 - fix fix ipv6 libtirpc getport
> >       autofs-5.0.8 - fix rpc_portmap_getport() proto not set
> >       autofs-5.0.8 - fix options compare
> >
> > Scott Mayhew (1):
> >       autofs-5.0.8 - get_nfs_info() should query portmapper if port is not given
> >
> >
> >  include/automount.h    |    1 +
> >  lib/cat_path.c         |    9 +++++++++
> >  lib/rpc_subs.c         |   14 +++++++++-----
> >  modules/mount_autofs.c |   12 ++++++------
> >  modules/mount_bind.c   |    2 +-
> >  modules/mount_ext2.c   |    2 +-
> >  modules/mount_nfs.c    |   34 +++++++++++++++++-----------------
> >  modules/parse_sun.c    |   22 +++++++++++-----------
> >  modules/replicated.c   |    9 ++++++---
> >  9 files changed, 61 insertions(+), 44 deletions(-)
> >
> > --
> > Ian


