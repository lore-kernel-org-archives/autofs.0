From: Ian Kent <raven@themaw.net>
Subject: Re: (subset) [PATCH v2 3/8] autofs: set ctime as well when mtime
 changes on a dir
Date: Thu, 15 Jun 2023 18:14:55 +0800
Message-ID: <ebad4167-6fec-b603-9be8-54457b2a32fd@themaw.net>
References: <20230612104524.17058-1-jlayton@kernel.org>
 <20230612104524.17058-4-jlayton@kernel.org>
 <20230614-marmeladen-blechnapf-873c26e176cb@brauner>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686824113; x=1686910513; bh=jvOa0kUu39x3GQIUZew1mtO2AZHY76muWFu
        JjSogrbo=; b=EPuJmmgzGiJ225PcqtobDHqYGSJ9FbMR2/HM25N5yJWC19vNsWc
        Mc6g6a+7u+xOngvo9ql+gTvTIpzuGWBoP/5w/homxwocEszbS2BY66xEYK6rhU39
        fKC/2J9A/tppqgMokw04lHq9ClAM1NidgPPF8XwPFb8brMaJ+yC9q3lx2oIXOqxk
        NwLzZE/EEO50omOBh8TzBe3YSIduGwMWsqcNQv/QxRuOtVG1aQhGmfZDS7sPfd2L
        ivZT6v6WRn+ar6/Ercj4MGKWKcxqfmYJxSQn9HNqtGrfvghNPb7RO/tPUhDvWwyc
        AMWwvLlS+hTH2y5s8+UvqcROZ9GavRIlJjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686824113; x=1686910513; bh=jvOa0kUu39x3GQIUZew1mtO2AZHY76muWFu
        JjSogrbo=; b=WQJvt4ZbovTVmVpd9nLF3ZaQUs0YTu6cciUQMWaCHlkUVtF3OXV
        BWs4+jr1+AQmOje/HwT59Uc+gCIA11iaI+HKQgg1BQI7sTScTCZe5aMc5Lf00ImL
        QDpPl/Z5yXuNtNsNhoruSIK8Cot14nLIGVBTkr3kM9F5w/zLjQQXCcCm3wqRDJm2
        HeWiDlna/Wo0l7rNZ01teWvAvYCqAbsjWmH0BfmI4FUBZcNogxXmZuNoaQmWIcoC
        YVUfDU4KdHqT7PrUPo6RaUGRnMnVFM5UYZZEwh9IGjmkuLSVwVR7KWHfNcqZIgQY
        s3tbtsbhHV1NfiIcQHLDi22Z7h98FbB3k5w==
Content-Language: en-US
In-Reply-To: <20230614-marmeladen-blechnapf-873c26e176cb@brauner>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Brad Warrum <bwarrum@linux.ibm.com>, Ritu Agarwal <rituagar@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Ruihan Li <lrh2000@pku.edu.cn>, Seb

On 14/6/23 16:30, Christian Brauner wrote:
> On Mon, 12 Jun 2023 06:45:19 -0400, Jeff Layton wrote:
>> When adding entries to a directory, POSIX generally requires that the
>> ctime also be updated alongside the mtime.
>>
>>
> Can't find a tree for this patch, so picking this patch up unless told otherwise.

There's relatively few changes to autofs and Linus asked me to send

changes via. Al or Andrew so there's no point in maintaining a tree

anyway.


Ian

>
> ---
>
> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.misc
>
> [3/8] autofs: set ctime as well when mtime changes on a dir
>        https://git.kernel.org/vfs/vfs/c/9b37b3342a98
