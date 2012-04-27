From: Stef Bon <stefbon@gmail.com>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 22:13:39 +0200
Message-ID: <CANXojcy2CinBrBY2+ZRoD_4PzZDj5dELsaa57_byQpwmmHpk+g@mail.gmail.com>
References: <20120427.151433.1007849975903946491.davem@davemloft.net>
	<20120427.151651.2274764174217164454.davem@davemloft.net>
	<CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com>
	<20120427.152404.2292425516870981391.davem@davemloft.net>
	<CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2Ld3OVPgvtmFKdoK2jUMYsCr1K3jnto2DqMpcFpjODo=;
        b=D1VM5a4NMjSAb4/sMKp3rf6Dcs3GKroruL2/sMXFbrOEyr7znzY+45y96pKLdqsPZu
         ZSgO1rkjBBuv6SkUlbDyAXV4GYaHXGDbKK9HjWEedeF0igMYh6jlBq1+KCGUp4/DRaC8
         COD0qU9N4WkYV4WkELhfTjE3rB0YgG6LEP2tgMIz/uH+jHDmKAIvqxuPu6G56fqUqsJf
         XMfBlOZYYQ0FyBhTRR5TgZs1VWb0a+jpL4r+VXtuwgIQ7fQzHgyng2ZHxSpDGpBaM37j
         EjIEJtp7gp+mQmbsdf7wXmt2kPqoJmxAQTBUsCEkxloOkowG9VahQjZDbJiKbqS6hio/
         AhNA==
In-Reply-To: <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: autofs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

I do not have any solution to the issue discussed here, but mentioned
is that automount and systemd are the only packages using autofs. I'm
thinking about creating a FUSE filesystem which will make use of
autofs (direct) mounting, where the FUSE fs will do something what now
automount does.  Indirect mounts are not necessary anymore, the
browsable maps will be created in the FUSE fs.

Stef Bon

2012/4/27 Linus Torvalds <torvalds@linux-foundation.org>:
> On Fri, Apr 27, 2012 at 12:24 PM, David Miller <davem@davemloft.net> =
wrote:
>>
>> If you can pull that off, it would certainly work and be the best
>> solution.
>>
>> BTW, this has happened before, we had this same problem passing data
>> over netlink sockets. =C2=A0And since it's packetized already we had=
 a
>> slightly easier time dealing with it.
>
> Ok, so here's a fairly quick hack.
>
> NOTE! I haven't actually tested this, because I don't use autofs
> (well, not knowingly - maybe I have a machine that actually does).
>
> What it does is add a new "packetized" flag to pipes, which does two
> simple things:
> =C2=A0- do not merge write data in pipe buffers when writing
> =C2=A0- when reading, consider a pipe buffer to be "spent" when any o=
f the
> data has been read
>
> Of course, if you write more than PIPE_BUFFER bytes, the packetizatio=
n
> doesn't work, but hey, if you do that, it's your own damn problem.
>
> Then, this just makes (for debugging!) autofs always write eight extr=
a
> bytes of garbage (NOTE NOTE NOTE! This will write uninitialized data,
> so this is literally just for debugging this particular issue), so
> that if the whole "kernel writes a few bytes extra" approach with pip=
e
> packetization doesn't work, you would see it even on native 32-bit or
> 64-bit mode, without having to even test the special case of "32-bit
> automount binary on a 64-bit kernel". So *anybody* who uses autofs ca=
n
> test this patch and see if autofs still works for them despite the
> extra padding on the write.
>
> So note the "+8" in autofs_v5_packet_size(). It's there on purpose,
> but it needs to be removed for actual final results if this works for
> testing.
>
> Comments? The patch looks fairly simple. The "packetized pipe" might
> even be useful for other users and maybe we might want to expose it a=
s
> an actual pipe fcntl, but right now the only thing that sets that fla=
g
> is autofs.
>
> Does this even work? I might well have missed some obvious thing, thi=
s
> was put together pretty quickly, but I think the *concept* may be the
> right approach to this whole mess.
>
> (And yes, we could probably just pack the "struct pipe_inode_info"
> better. We don't really need 32 bits for the pipe writer count etc.
> But to make the patch simple, I just added a whole new bitfield, whic=
h
> will just grow that silly structure).
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 Linus
