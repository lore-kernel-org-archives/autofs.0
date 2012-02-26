From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] autofs4: fix compilation without CONFIG_COMPAT
Date: Sat, 25 Feb 2012 17:46:39 -0800
Message-ID: <4F498EFF.6040309@zytor.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com> <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com> <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com> <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com> <1329889428.2193.45.camel@perseus.themaw.net> <1329890027.2193.48.camel@perseus.themaw.net> <1329890251.2193.50.camel@perseus.themaw.net> <m2vcmuh8dg.fsf_-_@igel.home> <CA+55aFxH4_gucG7vpdV5NJPNHoXy5bSGtr0yHqmobvYO6PmjNw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFxH4_gucG7vpdV5NJPNHoXy5bSGtr0yHqmobvYO6PmjNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Ian Kent <raven@themaw.net>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On 02/25/2012 05:31 PM, Linus Torvalds wrote:
> On Sat, Feb 25, 2012 at 2:10 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> The compat_daemon stuff is only needed on x86-64, and is_compat_task is
>> only defined with CONFIG_COMPAT, so disable it for all other
>> configurations.
> 
> Ugh, I hate the proliferation of #ifdefs in code when they aren't
> really necessary.
> 
> How about this patch instead? It's small, simple, and clean. Maybe it
> would even allow a few other #ifdef's to be removed (I see one in
> kernel/seccomp.c, for example, although I suspect that
> 'mode1_syscalls_32' might also be a compat-only thing, so who knows)
> 
> And if you worry about the size of autofs_sb_info, I think that could
> be made denser by using 'char' or bitfields instead of the various
> ints that hold small values or flags instead.
> 

I think this patch could help clean up other places, too.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
