From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix
 design error.
Date: Fri, 27 Apr 2012 15:08:49 -0400 (EDT)
Message-ID: <20120427.150849.187285510481819228.davem@davemloft.net>
References: <CA+55aFwud1nXRr+HpzH8rSkEWcZ_rJmoE7UtQt76D=A3qcb6GQ@mail.gmail.com>
	<20120427.143402.1028957981042061092.davem@davemloft.net>
	<CA+55aFwvFaxBT8Mdp5s4-6Gxy7nM4WVzbWna4RF_OUK3hnx+jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwvFaxBT8Mdp5s4-6Gxy7nM4WVzbWna4RF_OUK3hnx+jQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: Text/Plain; charset="iso-8859-1"
To: torvalds@linux-foundation.org
Cc: mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Apr 2012 11:42:58 -0700

> On Fri, Apr 27, 2012 at 11:34 AM, David Miller <davem@davemloft.net> =
wrote:
>>
>> If systemd wants to use version 5 of this thing, it has to have the
>> same workaround code automountd has. =A0It is systemd (and now the
>> kernel) which is broken.
>=20
> There's no question that systemd is broken.
>=20
> But those broken binaries are out in the wild. End of story.

And my point is that automountd was out there longer, and encoded
the "broken" structure size into the resulting binaries.

>> We should have never touched version 5 of the data-structure. =A0Hav=
ing
>> 5 years of workaround precedence in userspace proves this.
>=20
> Umm. The thing is, those broken binaries *work* on 32-bit.  They were
> *tested* on 32-bit. They were *shipped* on 32-bit.

As were the automount binaries.

systemd coded to an interface which did not exist in reality, and if
they had used the automountd sources as a reference (the only other
user of this interface) they would have seen this.

Look, I can almost guarantee that whoever wrote the automountd
workaround code looked at this situation and said "yeah, it's
impossible to get this right in the kernel for all cases for v5, so
let's just do it where we _can_ be absolutely certain and that's here
in this userland routine doing the autofs stuff"

And you know what, whoever that guy was, he was right.
