From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Breaking userspace? Re: 3.0.24 broke aufofs on mixed 32/64bit environment
Date: Tue, 24 Apr 2012 21:08:54 -0700
Message-ID: <CA+55aFyhTj2TjQ46ewruKXGF=x0ng2HAOfMDSC96WH3UTt=B5Q@mail.gmail.com>
References: <4F94222C.6080608@msgid.tls.msk.ru> <1335172741.2226.10.camel@perseus.themaw.net>
 <4F958352.7050106@msgid.tls.msk.ru> <4F95897B.2040103@msgid.tls.msk.ru>
 <4F959A5A.8070907@msgid.tls.msk.ru> <CA+55aFyQ4y9jyRXyejKwtf3yXJX52hQkLuwJ5=jfQM+yLkBNMw@mail.gmail.com>
 <4F96D0E7.9060000@msgid.tls.msk.ru> <CA+55aFw=cfYZO7PWDRRuZw1nYxvUk-63qfVVwfdJWevtmZoOig@mail.gmail.com>
 <1335300159.1393.13.camel@localhost.localdomain> <CA+55aFx9hATsnANWYSoagycc2HnXO=5Oa3gtqBjMr9eoe1obpA@mail.gmail.com>
 <4F9777FB.8050109@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rKRnfhWU/1BtrGHSsLsLMSpk2lz3wVShY2R2Crt9QT0=;
        b=txJfijYt2NR2zDMzbH4zVmmfFCOL47t56ZGBo2s99TuUHY1gDm/NR3sL64FNAwu1aB
         FKJUFFgC0tpzChzan45tosP2xlyEzB2QwNBgwTPz63uAaop4TMFRG06pvSDh9Pk+qVsJ
         PJtFmNwPwM49qqpXW/LUoNvjGmcDVFhmDTlzFtnoQgYZXZ8kgcIo0smG8BqCUpsb6EYo
         oPwcCGTkuW74hAovAskpf06tfQwyjqkdRYOF+Z1hyq32VeIHmyLHJqPygEjA/PLswk6B
         yRKa4gE1G/j8zFWQCPircud2x7CTQP7QnuMUr2CkAqkiNEjS6NE0XjX46kqeSTXErpbj
         jqXw==
In-Reply-To: <4F9777FB.8050109@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Meyer <thomas@m3y3r.de>, Ian Kent <raven@themaw.net>, "stable@kernel.org" <stable@kernel.org>, autofs@vger.kernel.org, Linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Apr 24, 2012 at 9:05 PM, Michael Tokarev <mjt@tls.msk.ru> wrote=
:
>
> How about something like
>
> =A0 =A0 sbi->compat_daemon =3D is_compat_task() && strcmp(task->comm,=
 "automount") !=3D 0
>
> instead? =A0(This task->comm is a pseudocode, just to show the idea, =
I don't
> know where this info can be found in kernel)

Thomas, does that work for you?

                Linus
