From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix design
 error.
Date: Fri, 27 Apr 2012 21:10:55 +0400
Message-ID: <4F9AD31F.8080109@msgid.tls.msk.ru>
References: <1335447289-9909-1-git-send-email-mjt@msgid.tls.msk.ru> <CA+55aFxEP7-+N7vTPZ-4hD-UirZ=+YMJh2x3EjZvUmjjyOchtg@mail.gmail.com> <4F9A6ABA.6050503@msgid.tls.msk.ru> <20120427.122207.795060203454499065.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120427.122207.795060203454499065.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, thomas@m3y3r.de, stable@kernel.org

On 27.04.2012 20:22, David Miller wrote:
> From: Michael Tokarev <mjt@tls.msk.ru>
> Date: Fri, 27 Apr 2012 13:45:30 +0400
> 
>> Please note: the talk is about 32bit userspace on 64bit kernel,
>> which should be quite rare these days, or something of less
>> priority.
> 
> You're talking about %99 of powerpc and sparc systems.

Nope.  Only about x86 32 on 64 bits, and only with 3.3 kernel.
The original problem does not exist on ppc, at least as far as
I understand.

/mjt
