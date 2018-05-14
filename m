From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 01/10] autofs4 - merge auto_fs.h and auto_fs4.h
Date: Mon, 14 May 2018 13:49:00 +0800
Message-ID: <5a7355b4-7bf1-c911-e010-263e3380794a@themaw.net>
References: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
 <20180514031509.GC30522@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=buRURQDPw+A1NIWS/vKYURwx14ibf
        iBmL4MLwjbertQ=; b=iDj4aA/dzQ3e5v+aTS/IP8D+Pl5S4tQk1rrdgXwA7u8Sd
        CItiCphmIX/DlTVu3c9jGI8Ly7EsZzr45kYIMMc/bEyP2QbxUSWllbWezJtJTtas
        QxIjfRFhJgyeQkScUPu83RhTPJCHaqIwm8GdfT0GBAYt7uFQKRnZ27Ql4iPDybkt
        WbzI2D2me5gDbt4C7qVfQrzp9gRa/FVv0B20jZKWOuMjjpcnOw86UV54xti9WpHX
        BjvfvSFiiz8pFEY47MAjsiNkF8Wd36FX8tKY1Ucs6zzMTxT2GwYZSGWhfht+xPbY
        LoCzBATj655jmOEN8qUlCYfQ/cQXkYe2AtYEw2GBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=buRURQ
        DPw+A1NIWS/vKYURwx14ibfiBmL4MLwjbertQ=; b=V81SebriaXmahs6I9yZ8BD
        HPTVBWwaUi3OgjpX0w7xMjFIJJyxeU6PL4B4S3O0AV1+MwDtoGoNBg51h9otFJca
        89lJo2Jf9pT1VsKG+tjh7Hr+9SHIvnHoNUaFgNctr30/zuTbADMz0CkY1mUrhPmP
        zUq2sKhrFWz6gB7YaDk1cvuM75LPzeXH0GuwxfAMMjSV1VcL2npswVDp2jfEcNOK
        /lUhT4N6q3RTjOaGfUdF2ub5SrMG+RA6MAtMOZpiTr2jjjTmIQs9KgodHjdWf61n
        iTxnsh1/mA0WtA40/UuF+jQVsscvx54fE+XX8t/jl7cdUq1zVUb2A0S5vlPv3Hsg
        ==
In-Reply-To: <20180514031509.GC30522@ZenIV.linux.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On 14/05/18 11:15, Al Viro wrote:
> On Mon, May 14, 2018 at 11:03:50AM +0800, Ian Kent wrote:
>> The autofs module has long since been removed so there's no need to have
>> two separate include files for autofs.
> 
> Umm...  Why does fs/compat_ioctl.c need either include, actually?
> 
>> --- a/fs/compat_ioctl.c
>> +++ b/fs/compat_ioctl.c
>> @@ -39,7 +39,6 @@
>>  #include <linux/if_pppox.h>
>>  #include <linux/mtio.h>
>>  #include <linux/auto_fs.h>
>> -#include <linux/auto_fs4.h>
>>  #include <linux/tty.h>
>>  #include <linux/vt_kern.h>
>>  #include <linux/fb.h>
> 
> AFAICS, we can just delete both.  Matter of fact, a *lot* of those includes are
> pointless nowadays...
> 

OK, I'll have a look at that and post a follow up patch.

Thanks for having a look at these Al.
