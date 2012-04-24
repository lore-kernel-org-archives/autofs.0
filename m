From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Breaking userspace? Re: 3.0.24 broke aufofs on mixed 32/64bit environment
Date: Tue, 24 Apr 2012 12:53:27 -0700
Message-ID: <CA+55aFw=cfYZO7PWDRRuZw1nYxvUk-63qfVVwfdJWevtmZoOig@mail.gmail.com>
References: <4F94222C.6080608@msgid.tls.msk.ru> <1335172741.2226.10.camel@perseus.themaw.net>
 <4F958352.7050106@msgid.tls.msk.ru> <4F95897B.2040103@msgid.tls.msk.ru>
 <4F959A5A.8070907@msgid.tls.msk.ru> <CA+55aFyQ4y9jyRXyejKwtf3yXJX52hQkLuwJ5=jfQM+yLkBNMw@mail.gmail.com>
 <4F96D0E7.9060000@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=m/IoZMh0rvs5iIJZWdyudec7CNJKAlwG/3uw0BvnQq0=;
        b=sAvDco/ZrHNZsvGneL44u3A1nS0f7oA8AlXl6Wo4nX7LQi63BbquhbkZCzmPTjFZuK
         XbETKXAJYoeIC1BMuZuZIFrtdMzW5GQMV9DpWmpeHNLg5KwySRc0ml62yx6ceIjNdqoY
         dWU8zCRylnOkaSOV+ev102kIh0EL3x4nrwF+R86OQaP9Opi/wJAgixPDJkcDqYdlVdFq
         zwT7whRiA25ZY8ZZnom5obHyvz2j4tLOdDEZS/jwM6ks025wlYig4+TU53jLK3MX1pZ1
         XVg3y7Yh/OS4SglcNZkgpyWCoHLU29jyGpSEBUtHvpHiBjoj7XGcC0SaIMqNE4G5+vq+
         Yjag==
In-Reply-To: <4F96D0E7.9060000@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Michael Tokarev <mjt@tls.msk.ru>, Thomas Meyer <thomas@m3y3r.de>
Cc: Ian Kent <raven@themaw.net>, "stable@kernel.org" <stable@kernel.org>, autofs@vger.kernel.org, Linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Apr 24, 2012 at 9:12 AM, Michael Tokarev <mjt@tls.msk.ru> wrote=
:
>
> The userspace is running debian stable (squeeze). =A0Debian has autof=
s
> package based on upstream 5.0.4 version. =A0That (upstream) version h=
as
> the "bug-compat" code in it, in daemon/automount.c:
>
> static size_t get_kpkt_len(void)
> {
> =A0 =A0 =A0 =A0size_t pkt_len =3D sizeof(struct autofs_v5_packet);
> =A0 =A0 =A0 =A0struct utsname un;
>
> =A0 =A0 =A0 =A0uname(&un);
>
> =A0 =A0 =A0 =A0if (pkt_len % 8) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (strcmp(un.machine, "alpha") =3D=3D=
 0 ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcmp(un.machine, "ia64") =3D=
=3D 0 ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcmp(un.machine, "x86_64") =3D=
=3D 0 ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strcmp(un.machine, "ppc64") =3D=
=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pkt_len +=3D 4;

Ugh.

So how did this break for Thomas Mayer (there was another person
involved too, I forget the details)? Is this code somehow
config-dependent so that it doesn't even get compiled for some cases?

                    Linus
