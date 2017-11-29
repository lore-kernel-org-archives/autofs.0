From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 29 Nov 2017 10:28:56 +0800
Message-ID: <1be75afb-8702-d60c-5ecb-10ddd2edc062@themaw.net>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <20171127160147.GA27613@qualcomm.com>
 <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net>
 <20171128002935.GC27898@qualcomm.com>
 <87a7z5yjbs.fsf@notabene.neil.brown.name>
 <20171129021354.GB2873@qualcomm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=KOZE2jo1GSnq72qXNEpfPFRTorAce
        vsHkCLU4FOwgFA=; b=ATNYBpIDpjErCLimZm50q784/1YtOOouIIHRX6Nu3bzwl
        n82TTSVxJO4gJC1ise3wMRX1E9DNKQhhLasRNaeKMfdC3Iw5x8MBzuT4viyuFRSO
        0znaFaxQcAQG3HRFE4O8I681ZqenHzahlUv8LYDVh/2VeZGdhd6ZwldNHnoaAHpe
        /lZrIOrgue3CKa1BDaQ9BN+3wTaitWQcyvtMw+zZD7cgZxJSOh1v6FXgpCozP7zH
        f0pQh68ZV7wsdxu2c94Li1Ww/tE6ftPllrOOzd6Pckquv7zW4NTpc9px3fo8WHJ6
        bsDEgQGAn9d3Tl2SEZUr0WhTPXyd66JjBvVsN3G+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KOZE2j
        o1GSnq72qXNEpfPFRTorAcevsHkCLU4FOwgFA=; b=G3anOZM5sPPvdTugv5vUyf
        MQXViNZTlzPxHBeofuqUz897SQRoph0DK5PcZTcvl4Qy8NjAzmdmZD+N52aDdkHj
        9SkEYnXCrOgBlXR866MRsY61sdiP8H8PmXRWflQzHQe6UFvZ06uArkKkkLhNLhXe
        zQK9K/YAP7v3l4vWTIlH6PH0M1GeoijxuVbTlDwkuuUg3WPhmj78evz+3ypDpucy
        ZJaedCPbd294URDIuIm0LaMwdayXlW2Z7tBtPZhTsaFj4qDmjD62lMK03ZTKzlyA
        ZuNYNcWLGM+CXYZ4XnMaAuZuo2IQgKZgVOvktY9DjVGY9f8pbooHJMAMZy5oq0Lg
        ==
In-Reply-To: <20171129021354.GB2873@qualcomm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mike Marion <mmarion@qualcomm.com>, NeilBrown <neilb@suse.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 29/11/17 10:13, Mike Marion wrote:
> On Wed, Nov 29, 2017 at 12:17:27PM +1100, NeilBrown wrote:
> 
>> How big do people see /proc/self/mount* getting?  What size reads
>> does 'strace' show the various programs using to read it?
> 
> We already have line counts into 5 figures.  This wasn't an issue until 
> the change of /etc/mtab to a link.  The large count is due to our large
> direct automount maps.
> 

And, admittedly, the testing I was doing was with 15k+ size maps.

Of course it's necessary to have this number of mounts to see serious
problems which is easiest to do with large direct mount maps.

The thing that's different now is that before applications started
using /proc directly for mount table information using mount(2)
instead of mount(8) was enough to prevent the mount entries from
being added to the table seen by applications.

Ian
