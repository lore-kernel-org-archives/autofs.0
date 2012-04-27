From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix design
 error.
Date: Fri, 27 Apr 2012 13:42:03 -0700
Message-ID: <4F9B049B.2000009@zytor.com>
References: <1335447289-9909-1-git-send-email-mjt@msgid.tls.msk.ru> <CA+55aFxEP7-+N7vTPZ-4hD-UirZ=+YMJh2x3EjZvUmjjyOchtg@mail.gmail.com> <4F9A6ABA.6050503@msgid.tls.msk.ru> <CA+55aFwud1nXRr+HpzH8rSkEWcZ_rJmoE7UtQt76D=A3qcb6GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwud1nXRr+HpzH8rSkEWcZ_rJmoE7UtQt76D=A3qcb6GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Linux-kernel <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, stable@kernel.org

On 04/27/2012 11:19 AM, Linus Torvalds wrote:
> 
> Btw, the whole autofs protocol is *full* of stuff like this. I just
> looked at some other places where the automount daemon does reads of
> fixed sizes, and one of them is a "sizeof(enum states)". Doing a
> sizeof() on an enum is a f*cking bad idea - it's not very well-defined
> at all (different compilers will consider the enum different sizes -
> seriously). But at least that one seems to be something that is purely
> internal to autofs - but it does show that the people involved did not
> think through and design the protocols they used in general - more of
> these kinds of "random sizes of random data structures that we don't
> understand".
> 

The really *really* damning thing with the v5 structure is that it
padded out the whole structure so it wouldn't have to do two read()
operations.  There is a header with a length field in it (which is still
there), and the daemon just ignores it...

	-hpa


P.S. This can still be fixed in user space, by reading the shorter
length, and then eating any additional zeroes.  The kernel does zero out
the extra pad.
