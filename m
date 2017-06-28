From: Ian Kent <raven@themaw.net>
Subject: Re: fix cross-compile when libtirpc is used
Date: Wed, 28 Jun 2017 08:26:02 +0800
Message-ID: <1498609562.2740.4.camel@themaw.net>
References: <20170627192239.GC26922@waldemar-brodkorb.de>
         <1498609045.2740.3.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=aa2GlB+49La9/fgDe9
        kBN/V32dz5SXjPUGxe51u8hG8=; b=Ys9MjdRQy5LKUUlbDXVcHJ/kqAfTdmXq2L
        F9OU2f6d/aedh+i/TOju4BFT2FrP9I2spe7oy021M+V73shFE8bq5xy4Cc0vOM16
        4EAx7ffWPucpIdUgtBSMA3xqlc9+SmlMfKOxYQisMvIv1+N5tH4Kkor+OIJWest3
        0/SN9C12ahy/+bRiyGuf4PUDRkVv2QCd7GgeXvs2+GhD0dTvJmd1Idpe9IYzdiQL
        pQJPozfCm93xO+TRRxQYFsdel9U35CPVAdwmWk2wt95NQx3jGNFthiv/QF5UKItY
        37xxovHiN1TatHosydqKilbWHBdCVc0XeL0yq3VCjF28kKkxRdYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=aa2GlB+49La9/fgDe9kBN/V32dz5SXjPUGxe51u8hG8=; b=hCrXDbBD
        MMgib7SzWFNf4dD7I0kiMkrHz2jBrMKA05aetxe6vjEL/iwsdiQ+O7zd766h9t5Z
        RYU+zzKcXS8htGlCRWoWtKAOE/uimdwWr85mEhMHGSCD7ZytNsERTN/uiLFJSpgz
        Sb60IwOzjqMFMwhud7ujVBaX3G8k6IPop1DepDBlcdOVj+9ZLQNsJVQoyAx/uD45
        M7LxO6HFV0kWRxGShm7qoA0traMk52u2wf7mhLrOw9JKB3YpMLlPnns61n1AAR0O
        OPzNLm7KldurAqktaZjw1jdNojZ0tdwsK5MDPxm0kwAxsN0AqJ4R5PcVqDmUMpsS
        yYBjrFxjxH01Fw==
In-Reply-To: <1498609045.2740.3.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Waldemar Brodkorb <wbx@openadk.org>, autofs@vger.kernel.org

On Wed, 2017-06-28 at 08:17 +0800, Ian Kent wrote:
> On Tue, 2017-06-27 at 21:22 +0200, Waldemar Brodkorb wrote:
> > Hi,
> >=20
> > I would like to suggest following patch, which uses pkg-config
> > to find libtirpc headers and libraries.
> > This allows to cross-compile autofs. The patch was suggested=C2=A0
> > on the buildroot mailinglist, too.
>=20
> Where is the patch description?
> What happens if a pkg config package is not installed?
>=20
> And how are WITH_LIBTIRPC and TIRPC_WORKAROUND defined?

And another small detail.

[raven@pluto autofs-dev.git]$ make configure
autoconf
/usr/bin/m4:configure.in:15: cannot open `pkg.m4': No such file or directory
autom4te: /usr/bin/m4 failed with exit status: 1
Makefile:52: recipe for target 'configure' failed
make: *** [configure] Error 1


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
