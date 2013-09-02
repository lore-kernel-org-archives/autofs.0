From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 2/2] introduce new '--with-systemdsystemunitdir'
Date: Mon, 2 Sep 2013 15:44:39 +0800
Message-ID: <CAF1ZMEdk0Di2h+nVHc1PVNhmWhSTq_GSBp6E2Yo3rS2eROfxfg@mail.gmail.com>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
	<1376893398-11765-3-git-send-email-dennis.yxun@gmail.com>
	<52241D5C.1050905@msgid.tls.msk.ru>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tppsxaDkE8QNJmg5fobHTsOPI0GREXwX0Je7VDXjSac=;
        b=V9KoW7nOJR8shCr7+33i3pUuRbcaHcVdYFM1GXIvbdWJd6OvXiPa4XRQua/Hv72jIU
         fRGHSWNqkwfWVvuk94irPd6qhuf4nUhFLuKU6cDqqYoo7uncGR1HcCTaMHAVu8Cn/k1b
         Z7NIrrxHSax1cMaGWS1R7WMnhEbODvfSJl0gZZVGV56RkZAEETPojO5F7o5ZqVk1uM1M
         ee3CaS4DWZdzBKpI9/CfLL3VXIR4tJCNCCYSHz6H1wbXYAdeP9OjtlzQKGwvO5XnaXIj
         sRbN4LZ0kuIDy8HZSjdAgwAdWc/6bOd+TlTbIdK683/ijkytWt8CBhDp5SUmExi8LOCC
         uo2Q==
In-Reply-To: <52241D5C.1050905@msgid.tls.msk.ru>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Mon, Sep 2, 2013 at 1:08 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
> 19.08.2013 10:23, Lan Yixun (dlan) wrote:
>>
>> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
>>
>> this option only control the path where the systemd unit file wll be
>> installed
>> and it's seperated from --with-systemd option, so it can be always
>> installed alone.
>>
>> use cases:
>> 1) if this option is not specificed, default option is
>> '--with-systemdsystemunitdir=yes'
>> will auto probe the directory of unit file
>> 2) --with-systemdsystemunitdir=no, or --without-systemdsystemunitdir
>> no unit file will be installed
>> 3) --with-systemdsystemunitdir=/my/unit/file/directory/
>> will install unit file into /my/unit/file/directory/
>> (gentoo linux goes the 3nd way)
>
>
> Out of curiocity, -- you haven't mentioned _why_ this option is needed to
> start with.  Does gentoo use an alternative directory for systemd units?
current, no, but maybe in future..  (from @gentoo-systemd team)

> If yes, again, out of curiocity, why?
I'm not systemd guru, and just forward the answers, thanks

>
> Thanks,
>
> /mjt
