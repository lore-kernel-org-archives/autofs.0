From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix design
 error.
Date: Fri, 27 Apr 2012 13:37:12 -0700
Message-ID: <4F9B0378.70906@zytor.com>
References: <1335447289-9909-1-git-send-email-mjt@msgid.tls.msk.ru> <CA+55aFxEP7-+N7vTPZ-4hD-UirZ=+YMJh2x3EjZvUmjjyOchtg@mail.gmail.com> <4F9A6ABA.6050503@msgid.tls.msk.ru> <4F9ABF90.5060404@teksavvy.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F9ABF90.5060404@teksavvy.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mark Lord <kernel@teksavvy.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-kernel <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, Ian Kent <raven@themaw.net>, Thomas Meyer <thomas@m3y3r.de>, stable@kernel.org

On 04/27/2012 08:47 AM, Mark Lord wrote:
> On 12-04-27 05:45 AM, Michael Tokarev wrote:
> ..
>> Please note: the talk is about 32bit userspace on 64bit kernel,
>> which should be quite rare these days, or something of less
>> priority.
> 
> 
> I suspect 32bit-PAE is more common than 32/64,
> but both are valid and not uncommon in the wild.

32-on-64 is a very important use case, because it lets us get people off
32-bit kernels.

	-hpa
