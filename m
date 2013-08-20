From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: Seperate option for install systemd unit file
Date: Tue, 20 Aug 2013 11:33:54 +0800
Message-ID: <CAF1ZMEehKNZ3bLR-RKS86AnEL2xe_yVyYYy5PepdSZerd45TkQ@mail.gmail.com>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
	<1376969008.2426.3.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KJuq+oit/3YuExVbqhy7Ero2ATeNL+jhX7R6EpnWiTw=;
        b=sjZMSsSZYY1tkpAUhy78mrWTqX9EQ8M4FC8wIxl1VhmxXxGhQT8j2FAP6JHuk3ccn4
         cIbdA3Yobi7hcTgFjPnyFAWvuoo3K+Sp1p095KzdsFsNoWcxa+IGfIawQ1fNExsvGixu
         EnMUPAzZ6ohYuHve5w/TOLHCKhm/IjfHfunxex325VH92J+bpPtaEpuLmMUN5z8JrqPb
         AK4vy6XXCAC3OLIBDPbyMPZH1NtUJCA5jJcoeJ79r4/i1Ky5c0wW/sbIaumBgBY2QHVu
         RRA5txXwfgUeMmCklUg+0C5zPqD1Cyanwo4GqZz56SPew3glRrQ1dWE7Hm+SAUxCwBhW
         Lo+A==
In-Reply-To: <1376969008.2426.3.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Tue, Aug 20, 2013 at 11:23 AM, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2013-08-19 at 14:23 +0800, Lan Yixun (dlan) wrote:
>> those patches are very trivial changes which only instroduce a new --with-systemdsystemunitdir option
>> to better control where we should install system unit file to
>>
>> 1) seperate --with-systemd opiton, but been kept now for future use (but it's useless now)
>> 2) add new option --with-systemdsystemunitdir to manage the path where unit file will be installed
>> 3) --with-systemd and --with-systemdsystemunitdir are two seperate option, so unit can be installed even systemd support is not enabled.
>>
>> downstream discussion: https://bugs.gentoo.org/show_bug.cgi?id=479492
>>
>> let me know whether this looks good to you..
>
> Looks OK but I'll need to spend some time on it in case it conflicts
> with downstream usage I already have.
>
>>
>> [PATCH 1/2] seperate option of --with-systemd from install systemd
>> [PATCH 2/2] introduce new '--with-systemdsystemunitdir'
>> --
>> To unsubscribe from this list: send the line "unsubscribe autofs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

Hi Ian:
  No problem, I tried to keep the changes minimal.
thanks for taking care of this
(I was afraid this would introduce noise instead improvement ;-)

Dennis Lan (dlan)
