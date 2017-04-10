From: Ian Kent <raven@themaw.net>
Subject: Re: Changes to special character escaping?
Date: Mon, 10 Apr 2017 15:49:38 +0800
Message-ID: <1491810578.4382.1.camel@themaw.net>
References: <CAFVxx_NaVK6J=tvfCa7AUQDaGLPE0ipZjpcqc1N55N4KrY5kKA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=QO8D+I/snoEkNCMEno
        rAsOzj12CJdTxOWn6t7G6/n9E=; b=RthqgzHHnxKiTIRav+5kJaHqHNVZYM45In
        cEyHTpcgk+dksilxzKAXxoD7nR5bZrEsKdV35e+wTG6hZTfT4vML1PgO1ADtQg7k
        xOWO6OlcFUpCES2q+zWRZs2FCxlg6fm7SCmztyAqCG0EoOW1FXAKxz2Qg8E5O1S9
        4UrsiOyo4MWmhqNnAu1VGlPVNAipPDsNi5ah2U25pXKAcQn9wA9O064ZTubJFM1Y
        Y48vxBGQ7mhBAbKiAx0F/9lL756LiGF5TLgBzZF/YCTHm86voo6OlI87P+beKt+D
        Bi4oWtgfqrmtMQed2E6NHGcngWbNofxtSMnN3/VdFY19zxt7mnfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=QO8D+I/snoEkNCMEnorAsOzj12CJdTxOWn6t7G6/n9E=; b=lAgRevuq
        QsZ+bYioIB16jflGZaGmhet8CXbXldj+tOQJErhF0w+fef9wv5E6rSNt/LGlb1bV
        OeEq80dgmX58rWyfeGlK1lL+ySEeGVBAl4n1b7WTX1reOX4u9agH778BM9elWoSz
        IvvGx0L7/+lgZYrgUAhP9s8ysPjoF6LM02DingqtSFmlGfarjZF79RrVrWABQfbg
        4bacy6SxHkdPjCrwCzVZbm/Izlx3yS17rRuOi/NyJtRqzd8vlQ+1ADePzGvRMC/W
        7rVfvPT3zb+nOxzuj2Bzdfp/0ouwxDJplVCWbX7T40GKSWjp2Mg4rw3pAAQp23YH
        KWcURpSGDioeuA==
In-Reply-To: <CAFVxx_NaVK6J=tvfCa7AUQDaGLPE0ipZjpcqc1N55N4KrY5kKA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Mark Fox <mfox@customdatacentre.com>, autofs@vger.kernel.org

On Fri, 2017-04-07 at 16:56 -0600, Mark Fox wrote:
> Has something changed regarding escaping of special characters? The
> methods used to deal with special characters in maps that are included
> in distributions (ie. Ubuntu 16.04.2, so automount 5.1.1) no longer
> seem to work.

There was at least one change related to escaping, didn't expect it to break
this though.

TBH, the escaping is difficult and this is probably an example of fixing one
thing and breaking another.

> 
> Without special characters, autofs works wonderfully on all sorts of
> CIFS shares. However, with a CIFS administrative share (C$), or a
> share with an ampersand, I've had no luck. The shares work fine
> through smbclient or when mounted by hand, but I haven't stumbled onto
> how to get it working under autofs.
> 
> My problem setup is simple:
> 
> --- /etc/auto.master ---
> +auto.master
> /cifs /etc/auto.cifs --timeout=300 --ghost
> ------
> 
> --- /etc/auto.cifs ---
> CDC1 -fstype=cifs,rw,noperm,credentials=/etc/creds/CDC1 \
>      "/C$" "://CDC1/C\$"
> ------
> 
> It doesn't work as configured above. The output from 'automount -f -v' is:

Can you get a full debug log of this please.
Use the -d instead of the -v.

> 
> ------
> attempting to mount entry /cifs/CDC1/C$
> > > Retrying with upper case share name
> > > mount error(6): No such device or address
> > > Refer to the mount.cifs(8) manual page (e.g. man mount.cifs)
> 
> mount(generic): failed to mount //CDC1/C\$ (type cifs) on
> /cifs/CDC1/C$
> failed to mount /cifs/CDC1/C$

That "/cifs/CDC1/C$" looks ok and the log entry says it's trying to mount
"//CDC1/C\$" which might have become the problem.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
