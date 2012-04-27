From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Thu, 26 Apr 2012 17:37:52 -0700
Message-ID: <CA+55aFxEP7-+N7vTPZ-4hD-UirZ=+YMJh2x3EjZvUmjjyOchtg@mail.gmail.com>
References: <1335447289-9909-1-git-send-email-mjt@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3KApSGOE3VUDV7rMJem77ueuR5rxPMMBKDJvu6IiCD0=;
        b=BgK7RCLw5OHOHe04UnAgb5srpIe4lQRdnhWk0rjEbMI0tJMckQ1xtuXArbTAcLHUY+
         xPtBd8i23cdh8YV2fOKUVF9VGtpqZSr0UFsyU8l079G9WsmCdoFUP4WZ5/7YE+yQOhKy
         r9gL5MRITJjH/bFGP6g3Ex32//PhURlgk/CNAAqBgrzTu5Rz41hHO6nGImeADj2hpO35
         8lk/nOOqvtoYP28hR/n8EU50dMNK2W/oZSsBeHbXlOzoOrjDfUFEXJOVFYpUny/3ng+N
         xGv9f84QzwvfkYdybm4y3Pm1dRFHJvabSTFUIM5pBRqH1b/1jIS7Ha8TG0ZOedJPjuIe
         TYFQ==
In-Reply-To: <1335447289-9909-1-git-send-email-mjt@msgid.tls.msk.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, stable@kernel.org

None of this fixes the fact that current 'systemd' binaries just use
'union autofs_v5_packet_union' and do a sizeof on it.

We're not breaking systemd either. You seem to not care about that,
but as long as you just blindly continue to not care, I'm going to
continue to not care about the patches.

It's that simple.

It is unfortunate that we have this idiocy with different packages
having different breakage due to the stupidity of the v5 packet, but
it's REALITY. A simple revert won't fix it, and saying "and here is
version 6" won't matter one whit to existing packages.

               Linus

On Thu, Apr 26, 2012 at 6:34 AM, Michael Tokarev <mjt@tls.msk.ru> wrote=
:
> This patch introduces a new autofs interface version, v6, which
> is exactly the same as v5 but uses better defined packet structure
> which does not change between architectures or platform bitness.
> Old interface is supported still.
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Cc: Ian Kent <raven@themaw.net>
> Cc: Thomas Meyer <thomas@m3y3r.de>
> Cc: stable@kernel.org
> ---
> =A0fs/autofs4/waitq.c =A0 =A0 =A0 | =A0 =A06 ++++--
> =A0include/linux/auto_fs4.h | =A0 31 +++++++++++++++++++++++++++----
> =A02 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> index da8876d..97866e8 100644
> --- a/fs/autofs4/waitq.c
> +++ b/fs/autofs4/waitq.c
> @@ -145,7 +145,7 @@ static void autofs4_notify_daemon(struct autofs_s=
b_info *sbi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Kernel protocol v5 packet for handling indirect an=
d direct
> + =A0 =A0 =A0 =A0* Kernel protocol v5/v6 packet for handling indirect=
 and direct
> =A0 =A0 =A0 =A0 * mount missing and expire requests
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0case autofs_ptype_missing_indirect:
> @@ -155,7 +155,9 @@ static void autofs4_notify_daemon(struct autofs_s=
b_info *sbi,
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct autofs_v5_packet *packet =3D &p=
kt.v5_pkt.v5_packet;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pktsz =3D sizeof(*packet);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pktsz =3D (sbi->version =3D=3D 5) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct autofs_v5=
_bad_packet) :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct autofs_v5=
_packet);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packet->wait_queue_token =3D wq->wait_=
queue_token;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packet->len =3D wq->name.len;
> diff --git a/include/linux/auto_fs4.h b/include/linux/auto_fs4.h
> index e02982f..fdef141 100644
> --- a/include/linux/auto_fs4.h
> +++ b/include/linux/auto_fs4.h
> @@ -20,11 +20,11 @@
> =A0#undef AUTOFS_MIN_PROTO_VERSION
> =A0#undef AUTOFS_MAX_PROTO_VERSION
>
> -#define AUTOFS_PROTO_VERSION =A0 =A0 =A0 =A0 =A0 5
> +#define AUTOFS_PROTO_VERSION =A0 =A0 =A0 =A0 =A0 6
> =A0#define AUTOFS_MIN_PROTO_VERSION =A0 =A0 =A0 3
> -#define AUTOFS_MAX_PROTO_VERSION =A0 =A0 =A0 5
> +#define AUTOFS_MAX_PROTO_VERSION =A0 =A0 =A0 6
>
> -#define AUTOFS_PROTO_SUBVERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> +#define AUTOFS_PROTO_SUBVERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>
> =A0/* Mask for expire behaviour */
> =A0#define AUTOFS_EXP_IMMEDIATE =A0 =A0 =A0 =A0 =A0 1
> @@ -126,7 +126,7 @@ union autofs_packet_union {
> =A0 =A0 =A0 =A0struct autofs_packet_expire_multi expire_multi;
> =A0};
>
> -/* autofs v5 common packet struct */
> +/* autofs v5/v6 common packet struct */
> =A0struct autofs_v5_packet {
> =A0 =A0 =A0 =A0struct autofs_packet_hdr hdr;
> =A0 =A0 =A0 =A0autofs_wqt_t wait_queue_token;
> @@ -138,6 +138,29 @@ struct autofs_v5_packet {
> =A0 =A0 =A0 =A0__u32 tgid;
> =A0 =A0 =A0 =A0__u32 len;
> =A0 =A0 =A0 =A0char name[NAME_MAX+1];
> +
> + =A0 =A0 =A0 /* padding to make
> + =A0 =A0 =A0 =A0* =A0 sizeof(autofs_v5_packet) % sizeof(__u64) =3D=3D=
 0
> + =A0 =A0 =A0 =A0* on all arches */
> + =A0 =A0 =A0 char _pad[4];
> +};
> +
> +/* earlier kernel interface used this structure for v5 packet,
> + * which is exactly the same as autofs_v5_packet above
> + * but does not have padding at the end. =A0The result was that
> + * sizeof it was 300 bytes on x86-32 and 304 bytes on x86-64.
> + * We keep it for compatibility with older userspace. */
> +struct autofs_v5_bad_packet {
> + =A0 =A0 =A0 struct autofs_packet_hdr hdr;
> + =A0 =A0 =A0 autofs_wqt_t wait_queue_token;
> + =A0 =A0 =A0 __u32 dev;
> + =A0 =A0 =A0 __u64 ino;
> + =A0 =A0 =A0 __u32 uid;
> + =A0 =A0 =A0 __u32 gid;
> + =A0 =A0 =A0 __u32 pid;
> + =A0 =A0 =A0 __u32 tgid;
> + =A0 =A0 =A0 __u32 len;
> + =A0 =A0 =A0 char name[NAME_MAX+1];
> =A0};
>
> =A0typedef struct autofs_v5_packet autofs_packet_missing_indirect_t;
> --
> 1.7.10
>
