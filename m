From: Ian Kent <raven@themaw.net>
Subject: Re: Error in autofs man page
Date: Thu, 26 Oct 2017 10:26:12 +0800
Message-ID: <f0244eac-36a0-8514-ce54-a6454bf79ff6@themaw.net>
References: <1508939789.11045.31.camel@surrey.ac.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=Yl/tYUjLLleb8z3Ya2rvMMlFOrabx
        qdRe0DWxlCIp1I=; b=T3hevzS+ajdCpYKA+OmioXxI9d7O63uYkLwvW8h0zZQ80
        GCZXyv+7+ZjHgPOj4bKUYyd1Y7PgZQ9CPnjaH60ef1lsM9AjzhZ9u0kRpd8ILU5l
        MY5dSwx360SjwchYDJKk66jWhypVYZLHB2Haybs+YfOggba0DEED6liuc4WmxkEX
        7UVQVM+VkxvWclkU3NF2qKRY1QaOxFZjGJnuKK0Ahs3Va3DZONsDS1ost6NWpaQe
        c63SmvOMlQcZy3C9vvW8gYLzTmjWF9H7JZHRWYVOfx2ieKEpO8goPU4Hgl67zIMW
        7CEoWxGS8baL3c+k/t3yUjPlGHwIz5BLNMcBvxDug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Yl/tYU
        jLLleb8z3Ya2rvMMlFOrabxqdRe0DWxlCIp1I=; b=kIOWnk52TOI0OkZyNN5gOU
        b2vP1L/fJRbAWYlLmAneOrShoDEY5iUsVTPqPgAmmwI9g5Mb3dAMtVh/HUsJRKna
        r9EuRzZgeeLvn6iOqUXUXN0gX9xnKzbRRJIHEJRas8j6hAHykw9BT+T+GdpMxNMb
        r7GefcAcmhgicFVfRYyVClLRZjyjYuD2bUFExcZDBL9J2V5GWlV2Kf5oO50Q4vd3
        hQ/lqGusKTKU01ylXeBLCCXCe2gpg8jWBg6EZMbg2VDWL+THFjZBoD48YsnWsVnT
        gkGpjVP5hgxnbO9/bC78KR2d0KgyRqjgcgT6RsLManl/9FZxfZwXiQ9X+Br7n8WQ
        ==
In-Reply-To: <1508939789.11045.31.camel@surrey.ac.uk>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: b.king@surrey.ac.uk, autofs@vger.kernel.org

On 25/10/17 21:56, b.king@surrey.ac.uk wrote:
> Hi There
>=20
> Your man page (auto.master(5)) points to autofs.org which appears to
> now be an Arabic football site. =C2=A0Could this be corrected to the corr=
ect
> place to now look for AutoFS (automounter) related things, such as
> example auto.master files?

Can you be more specific about where you see this.

I can't see any reference to autofs.org in auto.master(5) in the current
source.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
