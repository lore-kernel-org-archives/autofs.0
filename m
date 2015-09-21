From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v5 8/8] autofs-5.1.1 - remove unused function elapsed()
Date: Mon, 21 Sep 2015 16:45:28 +0800
Message-ID: <1442825128.6123.8.camel@themaw.net>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box>
	 <20150918093516.29311.58158.stgit@pluto.fritz.box>
	 <CAA1QoHSmAeB34Xb7Q5HXx5+usu56fQ6J51ewHngkckxEXf=PmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Qtuy0FK0R/XrBip1i0iy3Nrvx5g=; b=HhE9D/
	/6hVyW5uELac3Ly8Q2iZdqqTCBimsIxQpfQXAYLMyFBFGaTi0/+k4vp+wTwbh/RE
	5R0bSIjlxeK8nX/gSAb8B/GB4R8RR05rRwsbTFTPxe/8T5K3KHGrLCC1DN6IdT8O
	XDCCcAQLaSOABvMkc31JKC9pLcekcDXmMsStg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Qtuy0FK0R/XrBip
	1i0iy3Nrvx5g=; b=cAG8hrp6N5Xd5cRez3y38o0X60mVCVXAMZjS/72emCLdW1J
	sB98bJZFwpy6/wNFSo9Gs+MWj4EFBOdGnMfluDynAtpLOrNBY5aNoz3kfw+j0u70
	93at+l59Rdhz00cXds8DWhvHrGmA5QGzVeK+vp81VL31x6YMXn43aI2Sgz3g=
In-Reply-To: <CAA1QoHSmAeB34Xb7Q5HXx5+usu56fQ6J51ewHngkckxEXf=PmQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ning Yu <ning.yu@canonical.com>
Cc: Yu Ning <ning.yu@ubuntu.com>, autofs mailing list <autofs@vger.kernel.org>

On Mon, 2015-09-21 at 13:25 +0800, Ning Yu wrote:
> On Fri, Sep 18, 2015 at 5:35 PM, Ian Kent <raven@themaw.net> wrote:
> > Now that the monotonic clock source is used the elapsed() function
> > is no longer used, remove it.
> >
> > Signed-off-by: Ian Kent <raven@themaw.net>
> > ---
> >  lib/rpc_subs.c |    8 --------
> >  1 file changed, 8 deletions(-)
> 
> Oh, I think we also need to remove the declaration of elapsed() in
> include/rpc_subs.h

Ha, indeed we do.

> 
> >
> > diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
> > index 2364744..3d99f56 100644
> > --- a/lib/rpc_subs.c
> > +++ b/lib/rpc_subs.c
> > @@ -1078,14 +1078,6 @@ int rpc_ping(const char *host, long seconds, long micros, unsigned int option)
> >         return status;
> >  }
> >
> > -double elapsed(struct timeval start, struct timeval end)
> > -{
> > -       double t1, t2;
> > -       t1 =  (double)start.tv_sec + (double)start.tv_usec/(1000*1000);
> > -       t2 =  (double)end.tv_sec + (double)end.tv_usec/(1000*1000);
> > -       return t2-t1;
> > -}
> > -
> >  double monotonic_elapsed(struct timespec start, struct timespec end)
> >  {
> >         double t1, t2;
> >


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
