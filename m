From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH, RFC] autofs3: move to drivers/staging
Date: Mon, 04 Oct 2010 14:05:56 -0700
Message-ID: <4CAA41B4.5030902@zytor.com>
References: <201010042228.10642.arnd@arndb.de> <4CAA3A69.9040709@zytor.com> <20101004204057.GA28669@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101004204057.GA28669@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Greg KH <gregkh@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org

On 10/04/2010 01:40 PM, Greg KH wrote:
> On Mon, Oct 04, 2010 at 01:34:49PM -0700, H. Peter Anvin wrote:
>> On 10/04/2010 01:28 PM, Arnd Bergmann wrote:
>>> Nobody appears to be interested in fixing autofs3 bugs
>>> any more and it uses the BKL, which is going away.
>>>
>>> Move this to staging for retirement. Unless someone
>>> complains until 2.6.38, we can remove it for good.
>>>
>>> The include/linux/auto_fs.h header file is still used
>>> by autofs4, so it remains in place.
>>
>> I say we should just delete it.
> 
> Give it the 6 months period to phase out of the kernel, I'll handle this
> and if someone comes back and wants to maintain it, it can easily be
> added back.
> 

OK, feel free to add my

Acked-by: H. Peter Anvin <hpa@zytor.com>

... for both the move to staging and its eventual deletion.

	-hpa
