From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 2/2] introduce new '--with-systemdsystemunitdir'
Date: Mon, 2 Sep 2013 15:56:55 +0800
Message-ID: <CAF1ZMEek-7xcorE7dLzWBUuweHNgNcuART9MN3=mu7U5pW9TxQ@mail.gmail.com>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
	<1376893398-11765-3-git-send-email-dennis.yxun@gmail.com>
	<52241D5C.1050905@msgid.tls.msk.ru>
	<CAF1ZMEdk0Di2h+nVHc1PVNhmWhSTq_GSBp6E2Yo3rS2eROfxfg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BeKCAglYWMGQN2LwevhbyUc+3adQVg9a4wzsE5SnZbY=;
        b=g2Qz8b5N5SxEmf5bKn0Ql9h8YcIDa8Y1w3EMZYvrCribLzSyVaTLok1MGvDvVYJ7Zw
         XivznRkl93dx42hR1hHfZb0pPQjvfYo8HRxLeAsHOuivjgbfZcDnfPMhIevYut0pGTLe
         VUMZZJoxUPP3nmXyUgsQY1oVfbAOnbgVuNsoZyT1DFGLJkeX+PvKvciJ+DvT4smwqQoh
         AwYb/6icK7XcJHvccTTKO96NgCWnPEz+Dk7glYgxPw19Jd5+z0fCSddju99vkGRbiP1H
         +KK9XhbEHAAv5dRtKp36dOCwOfOgdfmibTnHgzBuK1I4qUHSBNsPPPEl1CIzI7XVFNzO
         98Ew==
In-Reply-To: <CAF1ZMEdk0Di2h+nVHc1PVNhmWhSTq_GSBp6E2Yo3rS2eROfxfg@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Mon, Sep 2, 2013 at 3:44 PM, Dennis Lan (dlan) <dennis.yxun@gmail.com> wrote:
> On Mon, Sep 2, 2013 at 1:08 PM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>> 19.08.2013 10:23, Lan Yixun (dlan) wrote:
>>>
>>> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
>>>
>>> this option only control the path where the systemd unit file wll be
>>> installed
>>> and it's seperated from --with-systemd option, so it can be always
>>> installed alone.
>>>
>>> use cases:
>>> 1) if this option is not specificed, default option is
>>> '--with-systemdsystemunitdir=yes'
>>> will auto probe the directory of unit file
>>> 2) --with-systemdsystemunitdir=no, or --without-systemdsystemunitdir
>>> no unit file will be installed
>>> 3) --with-systemdsystemunitdir=/my/unit/file/directory/
>>> will install unit file into /my/unit/file/directory/
>>> (gentoo linux goes the 3nd way)
>>
>>
>> Out of curiocity, -- you haven't mentioned _why_ this option is needed to
>> start with.  Does gentoo use an alternative directory for systemd units?
> current, no, but maybe in future..  (from @gentoo-systemd team)
>

I can think of those myself..
1) might be useful in gentoo-prefix environment
say, user can install autofs to /my/prefix/gentoo, then systemdunit
file will install to /my/prefix/gentoo/usr/lib/systemd/system

2) or for multilib support, usr may install to
/usr/lib64/systemd/system/ or /usr/lib32/systemd/system?


>> If yes, again, out of curiocity, why?
> I'm not systemd guru, and just forward the answers, thanks
>
>>
>> Thanks,
>>
>> /mjt
