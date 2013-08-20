From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: Seperate option for install systemd unit file
Date: Tue, 20 Aug 2013 12:34:25 +0800
Message-ID: <CAF1ZMEdE-_W39NNnxA88qztpmGRSudmLQDqSMfbiJP1wEjBF7w@mail.gmail.com>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
	<1376969008.2426.3.camel@perseus.fritz.box>
	<1376970260.2426.11.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LCZYoUTGBenyhYVVRnNnVPbJ0zMJPaCMQEqEbmu0fsA=;
        b=Qw28uhINRJoJVxZBdZ2pmcf3mYLgPHASy1Bh/toedSkIhnI2Vjr6BpECkwL/Soz2+s
         Ddn4rVZWTBKjo9tJy7jvL7XApp/ROEbPAUEcS7rMnyNEb9n+EtxOHGUrcs5L/w7GCden
         SxLhysM3wCDE9yDzabO6ptLNjPwiOxwbldkYQTeHhfYTZMHs9Bsyx1qBwYVC9ax4lCTs
         LDs9GUgPXxpdVxy2+fE03FCaI2lyrw+VmQGbqaI1I334fLd69UufK+E5UmngxDV43c0L
         3L3MtMwR+0Sls8zOXfikGbBOnwMkN11TjVDIQ+YYzBU4u1eQlvi2DgeuZxKMwxLmCAdV
         U51w==
In-Reply-To: <1376970260.2426.11.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, Aug 20, 2013 at 11:44 AM, Ian Kent <raven@themaw.net> wrote:
> On Tue, 2013-08-20 at 11:23 +0800, Ian Kent wrote:
>> On Mon, 2013-08-19 at 14:23 +0800, Lan Yixun (dlan) wrote:
>> > those patches are very trivial changes which only instroduce a new --with-systemdsystemunitdir option
>> > to better control where we should install system unit file to
>> >
>> > 1) seperate --with-systemd opiton, but been kept now for future use (but it's useless now)
>> > 2) add new option --with-systemdsystemunitdir to manage the path where unit file will be installed
>> > 3) --with-systemd and --with-systemdsystemunitdir are two seperate option, so unit can be installed even systemd support is not enabled.
>> >
>> > downstream discussion: https://bugs.gentoo.org/show_bug.cgi?id=479492
>> >
>> > let me know whether this looks good to you..
>>
>> Looks OK but I'll need to spend some time on it in case it conflicts
>> with downstream usage I already have.
>
> After a very quick initial look ....
>
> It appears that the change does two things.
>
> Defines WITH_SYSTEMD for subsequent use, although applications usually
> don't need to know if they are being managed by systemd. Do you know of
> any cases where that is important?
>
No, no cases I know of,
So, I leave you to decide whether to keep it or not

> And changes the original --with-systemd configure option to
> --with-systemdsystemunitdir adding the ability to specify a unit
> directory explicitly.
>
> Why is it worthwhile changing the configure option as part of this
> change?
>
> Ian
>
>
As talked with gentoo @systemd team, it's conventional to use
"--with-systemdsystemunitdir"[1]
and I think it's would be slight better/explicitly to pass the unit
directory via  --with-systemdsystemunitdir=/my/unit/dir/?current logic
is "--with-systemd systemddir=/my/unit/dir/"

I would have no problem if you insist not to change anyway..

[1] https://bugs.gentoo.org/show_bug.cgi?id=479492#c11
