From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: compat: autofs v5 packet size ambiguity - update
Date: Tue, 21 Feb 2012 22:02:24 -0800
Message-ID: <4F4484F0.9070501@zytor.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>  <20120221.221609.218135609185671883.davem@davemloft.net>  <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>  <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>  <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com> <1329889428.2193.45.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329889428.2193.45.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

On 02/21/2012 09:43 PM, Ian Kent wrote:
> 
> However, with the final "char name[NAME_MAX+1]" array at the end, the
> actual size of the structure ends up being not very well defined:
> because the struct isn't marked 'packed', doing a "sizeof()" on it will
> align the size of the struct up to the biggest alignment of the members
> it has.
> 

Note that it's really rather unfortunate that this transmits the entire
packet no matter what, which also means that the "len" field is actually
completely and totally pointless.

I have mentioned in the past that I consider it a design mistake on my
part to have used a pipe in the first place: it was "so easy", but
required an extra read for no good reason, or padding to fixed size
resulting in this problem.  The right thing really should have been to
use a Unix datagram socket; these days using SOCK_SEQPACKET - that way
the kernel would give you the right semantics by design.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
