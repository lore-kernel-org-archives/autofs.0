From: Ian Kent <raven@themaw.net>
Subject: Re: autofs-5.0.8 - get_exports: lookup(hosts): exports lookup
 failed for $(hostname)
Date: Tue, 24 Dec 2013 16:51:37 +0800
Message-ID: <1387875097.7351.10.camel@perseus.fritz.box>
References: <CAF1ZMEcaxaTw5qVzdPgaeM90B0TTeG_nJgxXbOqGt7fLqK5i+g@mail.gmail.com>
	 <1387860260.7351.2.camel@perseus.fritz.box>
	 <CAF1ZMEdM8gWae1US0OeSnYYb33AZX5XW8jte18hvJmF1puRFhA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=fwGbwewxUYJ94FOwOrzvLoGD790=; b=y3ApRYzWjaIe8M1HjrscgUviOKup
	JxBXRfTQUhdFbTIFW4FLiJB4f3PlEyMChaWvNZ3HEMwIB7kFwq2DWqmfrOb7gIt1
	bSfq9KKlIMGP4LiNrjA06tY701w8ZQCdBIqIXtdkf9bRwqqayTGuu0XxZ9cebegN
	J1TRmlUAIC4M2NU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=fwGbwewxUYJ94FOwOrzvLo
	GD790=; b=IAvZvBfRDAnLUjs72EN8Ncrt4RyMbB4HjDj5kTHroU71b7176tl56a
	P+cmL5rApXTeoARtHaJxy3fwFl6CqSR/7HhkIh7PiX4Pg8473kh8w12hmKt87ZJh
	YFyek/OfsZiUulyd/Xp8HtZ2l1gzrsgDeZ5mtm4o5V/BRTv90Wc2o=
In-Reply-To: <CAF1ZMEdM8gWae1US0OeSnYYb33AZX5XW8jte18hvJmF1puRFhA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, 2013-12-24 at 12:54 +0800, Dennis Lan (dlan) wrote:
> On Tue, Dec 24, 2013 at 12:44 PM, Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2013-12-23 at 14:41 +0800, Dennis Lan (dlan) wrote:
> >> Hi Ian:
> >>   A user hit a bug[1] in autofs-5.0.8, while not in autofs-5.0.7,
> >> even it works with commit [2]
> >>   My best guess it could be introduced by commit[3] (but not sure),
> >> also I've seen you queued a few patches after 5.0.8, is there any
> >> relevant?
> >>   most obvious log can be found here [4], or check [1] for more information.
> >>   Thanks
> >
> > AFAICT the ongoing problem is, talking to newer NFS servers works with
> > the latest patches but breaks for older servers, and the reverse without
> > the patch.
> sorry, I didn't follow here..
> what do you mean of newer/older servers, do you mean the nfs server
> using nfsv2,nfsv3(old protocol), nfsv4( new protocol)?
> latest patches, do you mean those queued in git repository?

That was a bit misleading.

What I'm talking about is portmap vs rpcbind as it relates portmap
protocol versions together with using libtirpc. To make autofs work with
later protocol versions using libtirpc I had to make a fairly large
change. That's already available on kernel.org. I posted the patches not
yet committed (that are in my notional "queue") to the list so you'll
know what they are.

> 
> so, you know the problem? do you have any fix?

I think I have one in the patch series I sent.
Assuming you have the current patches available on kernel.org then the
patch for the protocol not being set likely fixes the current problem.
 
> 
> thanks
> 
> >
> >>
> >> Lan
> >>
> >>
> >> [1] https://bugs.gentoo.org/show_bug.cgi?id=488886
> >>
> >> [2] commit 3247f7cb7e779d2340bd673324045f7617e74ce4
> >> Author: Ian Kent <raven@themaw.net>
> >> Date:   Mon May 27 17:47:20 2013 +0800
> >>
> >>     autofs-5.0.7 - fix spelling error in last commit
> >>
> >> [3] commit 7acfa6cba07a3ad8cb7976046852ce2830bd2f7e
> >> Author: Ian Kent <ikent@redhat.com>
> >> Date:   Mon Sep 23 12:18:52 2013 +0800
> >>
> >>     autofs-5.0.7 - fix portmap lookup
> >>
> >>     The autofs RPC library has fallen behind some.
> >>
> >>     When using IPv6 (rpbbind) version 3 or 4 is available whereas with IPv4
> >>     (portmap) verions 2 and 3 are available.
> >>
> >>
> >> [4] error message
> >>
> >> Dec 21 09:10:43 impala automount[31374]: get_exports: lookup(hosts):
> >> exports lookup failed for caiman
> >> Dec 21 09:10:43 impala automount[31374]: key "caiman" not found in map
> >> source(s).
> >> Dec 21 09:13:06 impala automount[31374]: get_exports: lookup(hosts):
> >> exports lookup failed for caiman
> >> Dec 21 09:13:06 impala automount[31374]: key "caiman" not found in map
> >> source(s).
> >> Dec 21 09:13:35 impala automount[31374]: create_client: hostname lookup failed:
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe autofs" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >


