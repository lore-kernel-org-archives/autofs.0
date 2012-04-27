From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix design
 error.
Date: Fri, 27 Apr 2012 13:45:18 -0700
Message-ID: <4F9B055E.6030404@zytor.com>
References: <CA+55aFwud1nXRr+HpzH8rSkEWcZ_rJmoE7UtQt76D=A3qcb6GQ@mail.gmail.com> <20120427.143402.1028957981042061092.davem@davemloft.net> <CA+55aFwvFaxBT8Mdp5s4-6Gxy7nM4WVzbWna4RF_OUK3hnx+jQ@mail.gmail.com> <20120427.150849.187285510481819228.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120427.150849.187285510481819228.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, mjt@tls.msk.ru, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On 04/27/2012 12:08 PM, David Miller wrote:
>>
>> Umm. The thing is, those broken binaries *work* on 32-bit.  They were
>> *tested* on 32-bit. They were *shipped* on 32-bit.
> 
> As were the automount binaries.
> 
> systemd coded to an interface which did not exist in reality, and if
> they had used the automountd sources as a reference (the only other
> user of this interface) they would have seen this.
> 
> Look, I can almost guarantee that whoever wrote the automountd
> workaround code looked at this situation and said "yeah, it's
> impossible to get this right in the kernel for all cases for v5, so
> let's just do it where we _can_ be absolutely certain and that's here
> in this userland routine doing the autofs stuff"
> 
> And you know what, whoever that guy was, he was right.

The workaround in automount is a mistake too, though.  The better
solution would have been to swallow the extra zero field; data driven.

	-hpa
