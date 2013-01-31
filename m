From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] parisc: unbreak automounter support on 64-bit kernel
 with 32-bit userspace
Date: Thu, 31 Jan 2013 13:46:11 -0800
Message-ID: <510AE623.7000609@zytor.com>
References: <20130131200110.GA6032@p100.box>  <1359664008.2468.5.camel@dabdike> <510AE21D.2090002@zytor.com> <1359668524.2468.12.camel@dabdike>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359668524.2468.12.camel@dabdike>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

On 01/31/2013 01:42 PM, James Bottomley wrote:
> On Thu, 2013-01-31 at 13:29 -0800, H. Peter Anvin wrote:
>> On 01/31/2013 12:26 PM, James Bottomley wrote:
>>> [adding autofs list and maintainer for their perusal and ack, although
>>> this is an obvious fix to me
>>>
>>> James]
>>
>> The #if list probably should be inverted, and only specific platforms
>> should have unsigned long...
> 
> The whitelist is 64 bit only platforms, like ia64, isn't it?  So yes,
> they're far less numerous.
> 

Correct.  It is basically the 64-bit platforms without any 32-bit
userspace, like Alpha and IA64.

	-hpa

