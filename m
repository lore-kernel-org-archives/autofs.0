From: raven@themaw.net
Subject: Re: [Patch 2/6] Bind Mount Extensions 0.06
Date: Fri, 25 Feb 2005 21:15:12 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502252105260.1921@donald.themaw.net>
References: <20050222121129.GC3682@mail.13thfloor.at> <20050223230105.GD21383@infradead.org>
 <20050224211727.GD4981@mail.13thfloor.at>
Mime-Version: 1.0
In-Reply-To: <20050224211727.GD4981@mail.13thfloor.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Linux Kernel ML <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org

On Thu, 24 Feb 2005, Herbert Poetzl wrote:

> On Wed, Feb 23, 2005 at 11:01:05PM +0000, Christoph Hellwig wrote:
>> On Tue, Feb 22, 2005 at 01:11:29PM +0100, Herbert Poetzl wrote:
>>>
>>>
>>> ;
>>> ; Bind Mount Extensions
>>> ;
>>> ; This part adds the required checks for touch_atime() to allow
>>> ; for vfsmount based NOATIME and NODIRATIME
>>> ; autofs4 update_atime is the only exception (ignored on purpose)
>>
>> and that purpose is?
>
> this is based on a statement from Al Viro:
>
> | autofs4 use - AFAICS there we want atime updated unconditionally,
> | so calling update_atime() (update atime after checking
> | noatime/nodiratime/readonly flags) is wrong.
>
> agreed, maybe a proper fix would be better ...
>
>> Did you discuss this with the autofs maintainers?

I've had a look at the patch and I can't see any problem.

autofs4 doesn't use the inode atime for expire purposes but does update it 
in sync with its dentry info struct field that is used for this purpose.

So AFAICS the atime is an external view of expire status, 
but only when updated within the autofs4 module VFS callbacks.

I haven't yet looked at the v3 (autofs) module.
I'll get back if I see an issue there.

Ian
