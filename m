From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 17:17:34 -0700
Message-ID: <CA+55aFxnksj5fL68XzkGPQ+aQc0pif+5jjxD=LjGcxKUt039xw@mail.gmail.com>
References: <20120427.151433.1007849975903946491.davem@davemloft.net>
 <20120427.151651.2274764174217164454.davem@davemloft.net> <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
 <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
 <4F9B050C.3000309@zytor.com> <CA+55aFz-1n=REkh9SzA1aEz5J_uGc=B_nKj+cP8J=PR6YSZD1w@mail.gmail.com>
 <4F9B2420.5030806@zytor.com> <CA+55aFyCpiU5_nG-3Nra5q9x0-71amAQVetZTxxP6waR1ueYNQ@mail.gmail.com>
 <4F9B33BF.908@zytor.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bjCp+vskLvV4sgPtYisjaKn11Vl6PfcXq0GdZA0fOvk=;
        b=rEynAVecyhJsA4Hys4zYbiamYySE3hGsGonZVHxeoiGyv9IlByEl245PEnkOi+MCqR
         08o3ErfNyB28atjy7la2SwnQq4jEvix9qLrjK47InEHFSeKd8md+NJWXJ0LjQPDPeWGK
         d8N7SZDpzyDMazYJLTcFNdSVGcTcNOGRbi5EBMY5V1a/fkZzs8CkDtPXAJw8XDBUWgX1
         IKAC8o/wo+IuWbPh5V4IludCf4AMNaOw9zxMtugWQtQWhUrxfopvfwGIsjALkj2c+V9H
         pvre57/qrq2EJbRkSNrULxv+n028Md/m97dFkR23yhfthTxEqbpWIPWD2hWCtUCHqlXg
         CqKQ==
In-Reply-To: <4F9B33BF.908@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Miller <davem@davemloft.net>, mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On Fri, Apr 27, 2012 at 5:03 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Still, I have to admit... we have a grand total of three users of thi=
s
> interface as far as we know (autofs, systemd, and am-utils if they ev=
er
> revved that one to v5.) =A0Would it really not be better to do the
> zero-eating user space fix?

Considering the sh*t that is in user space now, and how distributions
tend to take years (if ever) to actually update some programs, I don't
see how that would actually work in practice.

                   Linus
