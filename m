From: Ian Kent <raven@themaw.net>
Subject: Re: Fwd: Converting to New Syntax
Date: Wed, 03 May 2017 09:09:31 +0800
Message-ID: <1493773771.2831.5.camel@themaw.net>
References: <CA+onWPdMOVqgvW7rhyDCQ8u4xJ+RTQptPtEjTRj4yja4tF9CnA@mail.gmail.com>
         <CA+onWPcDEfabovjUriMRTDVnOo8tx8rLf4PxJA13Xt_By5J4bQ@mail.gmail.com>
         <1493686697.2579.1.camel@themaw.net>
         <CA+onWPdL-dj_P=8d5-FqXZVHifQJdR7N6DH+uXh5DNc23yMqQw@mail.gmail.com>
         <1493772767.2831.3.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=1FSwxwnHyuoJHReLCZ
        LvVPdZjkR5b3GDpdONwsKm3Uw=; b=B1XARExj/c6gt+hjFWNlk47Jq52OimAhmV
        9JrQIAoWFxtnp06XhOB3JUzVkB+NlhL63t1F6z1Nwz4UM3Ky4fqknBeotPR7io8h
        2ek9dEktpeqKaxINJSBGoSvHTONhlFcmL6FQzOhoKPkHJlEreLwT6G5KaMClt507
        iGC7zUCZQuMdu+y2XLGYcvC/rUJgPHikmMetnvmwdudSYP6lZlt++hnTg0815aHu
        aQaHoKce50iWWgkNDjSQkNuhwBYQKVOZxUlBiGf0JBp/GmRk4Jc8FSZ/Fjbd/msb
        DVjUYEi+xOAXLCXHoihYCnSGh/l2jNa2vFKg3vAG1Zrg4BoxabKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=1FSwxwnHyuoJHReLCZLvVPdZjkR5b3GDpdONwsKm3Uw=; b=MbvOv8J9
        ub1VkuGp0qS51/jwi/1a0LhJsfc0uMVnb/qhSalZBLBBly9tmt2wqeAnjIBGRZU7
        bnAq8wHPPPHjEfEd5xeg9JVihC4eJyAeWb5h8zJ6IjHc7yk6JMcGAu4RRkcgiVDU
        KJDbD7RATZ2Zz5PdCs/KJy5eBvptY5hEj7l/NXAGudVPsDDrmYDFiB/5ud2+RMrG
        hDHb9/ZxFTUveKsS8Ix0ypeUD/paZvtqdu/rnaGYEE8uinyhe9nqGTl55Adm4TGv
        8uFgK037fDas1NIsRliPSFSZNe7OZ1ItzztCVIkpNE/IlLtx7JhBjOz0wQ4Vs0pZ
        IpvTpuldyzPC+g==
In-Reply-To: <1493772767.2831.3.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jamie Jackson <jamiejaxon@gmail.com>
Cc: autofs@vger.kernel.org

On Wed, 2017-05-03 at 08:52 +0800, Ian Kent wrote:
> 
> > > Personally I always use the autofs configuration to enable debug logging.
> > 
> > I take that to mean that i should remove the `--debug` option from the
> > master map, and add `LOGGING=debug` to auto.master. (Done.)
> 
> Mmm .. oldish syntax .. what version, OS?
> It shouldn't matter though.

Oh, ok, that's probably RHEL-6 based on the bug you mentioned.

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
