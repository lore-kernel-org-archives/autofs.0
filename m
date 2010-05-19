From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/8] autofs: Pushdown the bkl from ioctl
Date: Wed, 19 May 2010 13:04:47 -0700
Message-ID: <4BF4445F.9040104@zytor.com>
References: <1274289855-10001-1-git-send-regression-fweisbec@gmail.com> <1274289855-10001-3-git-send-regression-fweisbec@gmail.com> <4BF4279C.2000805@zytor.com> <20100519180832.GA9752@nowhere> <4BF42A5E.6060503@zytor.com> <20100519190307.GC9752@nowhere>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100519190307.GC9752@nowhere>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Autofs <autofs@linux.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, John Kacur <jkacur@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Ian Kent <raven@themaw.net>

On 05/19/2010 12:03 PM, Frederic Weisbecker wrote:
>>
>> But it's not ... it is locked at that point.  It's not lock*ing*, but it
>> is not *unlocked*, either.  Furthermore, it is directly contradicting
>> the naming scheme of the ops structure.
>>
> 
> Would you prefer me to resend a patch?
> 

Yes, that would be my preference.

We really need to set a date to kill off autofs3 completely -- I don't
care if we rename anything or not -- and add it to feature-removal.txt.

	-hpa
