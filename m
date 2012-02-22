From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Wed, 22 Feb 2012 10:20:56 -0800
Message-ID: <4F453208.7040902@zytor.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com> <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com> <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com> <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com> <1329889428.2193.45.camel@perseus.themaw.net> <4F4484F0.9070501@zytor.com> <CA+55aFwUvuaGdnpwVQLQLF=DdqROmKqz65v+_DXHbebNhPqkLg@mail.gmail.com> <4F4529D4.6070008@zytor.com> <CA+55aFzKet5sASgrD==8iZ5m1+-FDpznfuqcNDS5ZyCocwzAbg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzKet5sASgrD==8iZ5m1+-FDpznfuqcNDS5ZyCocwzAbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ian Kent <raven@themaw.net>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On 02/22/2012 10:16 AM, Linus Torvalds wrote:
>
> Because that padding word for size is just random data.
> 
> In fact, we probably should clear it. I suspect we leak kernel stack
> contents to autofs. Not that it matters (system daemon with root
> privileges and all that), but it's another case of the whole "packing
> data structures" issue.
> 

Fortunately this is not true -- there is a memset(0) of the entire
packet before the packet is built in kernel space.  Otherwise we'd have
a security hole.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
