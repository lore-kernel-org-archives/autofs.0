From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: Seperate option for install systemd unit file
Date: Tue, 20 Aug 2013 16:06:04 +0800
Message-ID: <CAF1ZMEdndygLKvJs9i+K1evvJRjk=+HdTrmjCR0vxUO3qy92hA@mail.gmail.com>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
	<1376969008.2426.3.camel@perseus.fritz.box>
	<1376970260.2426.11.camel@perseus.fritz.box>
	<CAF1ZMEdE-_W39NNnxA88qztpmGRSudmLQDqSMfbiJP1wEjBF7w@mail.gmail.com>
	<1376983115.2426.33.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=u9v9BSQcnIJU5+85684eSn1SLgCwMGF0EFgaDWq9NEE=;
        b=jJcz8vmmaCQLBhsC9Vx9/lGDwx9qB1/p51Pj5JhyS4S72Rlt0x2roVhIyXZpEfGgRM
         2rVAVmAlDiXkU6rhXgx0+CS9axcqpgWu/md/jZYBRPUF02ajqjVPaz9N+6PMcw2NiUCK
         mzlVmQ46DlMLyG+JcTBvDZu82WiXcJW0Hx6+LDphgZ8trsl8e8RY6e30g3rAfSo9hkFP
         X5hTo149QqtimrdfsqwTIV4XBU++Yn2iFohyTr3vC3DoXiKXG6UnaI8n1H1CshzD+2YW
         BN5oLP/M76UriGuZboJltwJTr5xTK5/MY/WFwC1ZJIXYxfbIS1iStVoUze4NsDUMoaqi
         At4Q==
In-Reply-To: <1376983115.2426.33.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, systemd@gentoo.org

On Tue, Aug 20, 2013 at 3:18 PM, Ian Kent <raven@themaw.net> wrote:
> On Tue, 2013-08-20 at 12:34 +0800, Dennis Lan (dlan) wrote:
>> On Tue, Aug 20, 2013 at 11:44 AM, Ian Kent <raven@themaw.net> wrote:
>> > On Tue, 2013-08-20 at 11:23 +0800, Ian Kent wrote:
>> >> On Mon, 2013-08-19 at 14:23 +0800, Lan Yixun (dlan) wrote:
>> >> > those patches are very trivial changes which only instroduce a new --with-systemdsystemunitdir option
>> >> > to better control where we should install system unit file to
>> >> >
>> >> > 1) seperate --with-systemd opiton, but been kept now for future use (but it's useless now)
>> >> > 2) add new option --with-systemdsystemunitdir to manage the path where unit file will be installed
>> >> > 3) --with-systemd and --with-systemdsystemunitdir are two seperate option, so unit can be installed even systemd support is not enabled.
>> >> >
>> >> > downstream discussion: https://bugs.gentoo.org/show_bug.cgi?id=479492
>> >> >
>> >> > let me know whether this looks good to you..
>> >>
>> >> Looks OK but I'll need to spend some time on it in case it conflicts
>> >> with downstream usage I already have.
>> >
>> > After a very quick initial look ....
>> >
>> > It appears that the change does two things.
>> >
>> > Defines WITH_SYSTEMD for subsequent use, although applications usually
>> > don't need to know if they are being managed by systemd. Do you know of
>> > any cases where that is important?
>> >
>> No, no cases I know of,
>> So, I leave you to decide whether to keep it or not
>
> Yeah, but it may be needed to control whether the unit file is actuall
> installed. Seems a bit round of a round about way to do this.
>
This seems against @systemd gentoo's suggestion (to install the unit
file unconditionally)
because it will be controlled under --with-systemd option

>>
>> > And changes the original --with-systemd configure option to
>> > --with-systemdsystemunitdir adding the ability to specify a unit
>> > directory explicitly.
>> >
>> > Why is it worthwhile changing the configure option as part of this
>> > change?
>> >
>> > Ian
>> >
>> >
>> As talked with gentoo @systemd team, it's conventional to use
>> "--with-systemdsystemunitdir"[1]
>> and I think it's would be slight better/explicitly to pass the unit
>> directory via  --with-systemdsystemunitdir=/my/unit/dir/?current logic
>> is "--with-systemd systemddir=/my/unit/dir/"
>
> It amounts to changing the configure option name and adding the ability
> to specify a directory.
Yes, It is

>
> The discussion implies there's precedent for using this name, do your
> the systemd guys know of other packages that use this naming, what are
> they?
I will let gentoo @systemd team answer this..

>
> I get the request to be able to specify a directory, that's cool.
>
> The other thing I think I saw in the discussion was unconditional
> installation of the unit file.
yes

>The unit file has substitution done on it
> unconditionally but the macro paths are only set if the configure option
> is given. So there's no way to say, look for the systemd directories or
> use the given path but don't actually install the unit file. The actual
Yes, this is the original logic, but if you following my proposal patch,
we can install NO unit file by passing --with-systemdsystemunitdir=no
or --without-systemdsystemunitdir
for the original code, we need to pass --without-systemd, but it's a
little bit confusing (the disable install unit file)

> unconditional install is probably best done in the ebuild, simple
> enough.
yes, this would be another approach, but if goes this way, then
wouldn't I proposal this patch..

>
> Ian
>
>
>
>
Hi Ian:
  I don't have much knowledge about systemd, so let me CC gentoo @systemd team,
in case they have some inputs or my understanding is wrong/stupid..
 The discussions can be found here [1], the actual patches I proposal
can be found here [2],[3]

Dennis Lan (dlan)


[1] http://thread.gmane.org/gmane.linux.kernel.autofs/6703
[2] http://article.gmane.org/gmane.linux.kernel.autofs/6702
[3] http://article.gmane.org/gmane.linux.kernel.autofs/6704
