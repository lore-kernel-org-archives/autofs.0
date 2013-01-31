From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] parisc: unbreak automounter support on 64-bit kernel
 with 32-bit userspace
Date: Thu, 31 Jan 2013 15:13:48 -0800
Message-ID: <510AFAAC.8020609@zytor.com>
References: <20130131200110.GA6032@p100.box> <1359668524.2468.12.camel@dabdike> <510AE623.7000609@zytor.com> <1470501.uiZyX6kBKo@donald.sf-tec.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1470501.uiZyX6kBKo@donald.sf-tec.de>
Sender: linux-parisc-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

On 01/31/2013 02:10 PM, Rolf Eike Beer wrote:
> H. Peter Anvin wrote:
>> On 01/31/2013 01:42 PM, James Bottomley wrote:
>>> On Thu, 2013-01-31 at 13:29 -0800, H. Peter Anvin wrote:
>>>> On 01/31/2013 12:26 PM, James Bottomley wrote:
>>>>> [adding autofs list and maintainer for their perusal and
>>>>> ack, although this is an obvious fix to me
>>>>> 
>>>>> James]
>>>> 
>>>> The #if list probably should be inverted, and only specific
>>>> platforms should have unsigned long...
>>> 
>>> The whitelist is 64 bit only platforms, like ia64, isn't it?
>>> So yes, they're far less numerous.
>> 
>> Correct.  It is basically the 64-bit platforms without any
>> 32-bit userspace, like Alpha and IA64.
> 
> Arm64? Should this be a CONFIG_ARCH_CAN_HAVE_32BIT_USERSPACE that
> would cover this? And may e.g. be used to remove compat_ioctl on
> those archs, too?
> 

compat_ioctl should be CONFIG_COMPAT.

	-hpa


