From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 08:20:15 -0800
Message-ID: <CA+55aFzGc7UmDK5OG7Vog0cQDuuP1MWmX1Xn=7Y+M_k+9+zHFg@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
 <1329889428.2193.45.camel@perseus.themaw.net> <1329890027.2193.48.camel@perseus.themaw.net>
 <1329890251.2193.50.camel@perseus.themaw.net> <1329903139.2193.66.camel@perseus.themaw.net>
 <1329912927.2193.68.camel@perseus.themaw.net> <1329914392.2193.71.camel@perseus.themaw.net>
 <1329914744.2193.73.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9a5Z3EVbiitgAkOdVo6QR1FPDyn9LLn4ZhiEUFkHo+M=;
        b=kogiFDSRnlSlURSUlQpyuUim4ftgUhp6Vm3htbV3LGqmgA/yCEPj8uLX/EjF+z1has
         x/vUaL6gaFd7osVZ3icNroZ+enXsZLn7EqUPH/EuUsN10VszWan/lg6DOCqlNkhJCQaR
         hdfjKkGxuU2EgQV/ObGlLHyiFY+4eH++vWvCM=
In-Reply-To: <1329914744.2193.73.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, Feb 22, 2012 at 4:45 AM, Ian Kent <raven@themaw.net> wrote:
> diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
> index 76741d8..85f1fcd 100644
> --- a/fs/autofs4/dev-ioctl.c
> +++ b/fs/autofs4/dev-ioctl.c
> @@ -385,6 +385,7 @@ static int autofs_dev_ioctl_setpipefd(struct file=
 *fp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sbi->pipefd =3D pipefd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sbi->pipe =3D pipe;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sbi->catatonic =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sbi->compat_daemon =3D is_compat_task()=
;
> =A0 =A0 =A0 =A0}
> =A0out:
> =A0 =A0 =A0 =A0mutex_unlock(&sbi->wq_mutex);

Yes, this part should do the reconnect correctly (assuming it's the
daemon that does that itself, but I assume it is).

But

> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> index e16980b..06858d9 100644
> --- a/fs/autofs4/inode.c
> +++ b/fs/autofs4/inode.c
> @@ -224,6 +225,7 @@ int autofs4_fill_super(struct super_block *s, voi=
d *data, int silent)
> =A0 =A0 =A0 =A0set_autofs_type_indirect(&sbi->type);
> =A0 =A0 =A0 =A0sbi->min_proto =3D 0;
> =A0 =A0 =A0 =A0sbi->max_proto =3D 0;
> + =A0 =A0 =A0 sbi->compat_daemon =3D is_compat_task();
> =A0 =A0 =A0 =A0mutex_init(&sbi->wq_mutex);
> =A0 =A0 =A0 =A0mutex_init(&sbi->pipe_mutex);
> =A0 =A0 =A0 =A0spin_lock_init(&sbi->fs_lock);

the above really is wrong, at least for the autofs sources I looked at.

Because autofs does "spawn()" to fork+exec the mount() system call,
the is_compat_task() check really will be checking the wrong binary.

Now, it's true that in *most* cases you'd hope that 'mount' and
'autofs' both come from the same distro, and have been the compiled
for the same model. So it probably works in practice, and might be
good enough.

But I could easily see somebody building their own 'autofs' tools (or
building their own 'mount', although that sounds less likely to me)
and if they started out with a 32-bit distro but are slowly  upgrading
(like they've upgraded the kernel) the above would get that wrong.

I could also imagine a 64-bit environment wanting to "cross" compile
(and test) a 32-bit binary, and trying that. In fact, I suspect that
is something that you could test yourself: I assume you build your own
'autofs' daemon on a system where you don't build everything else, and
just adding "-m32" to the build should do this and show the problem.

                           Linus
