From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: fix undefined authtype_requires_creds error
Date: Mon, 28 Oct 2013 17:59:36 +0800
Message-ID: <CAF1ZMEfYrE_USvigHEpOvwidKDFjFvN=30mt_qnZM+HV5Rm4vQ@mail.gmail.com>
References: <CAF1ZMEc84Ep6cpEbnmYw4YJpuQJwrOVketBtNcgNZZTGTBHz_g@mail.gmail.com>
	<1382948864.2523.25.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RGeTdnTw6t9heeyD5qbnrtKfRP721HxU7QxD/Yn9VvA=;
        b=b9ddmlAIDMnlfNs0Rq5onggvt69XsF7ynKFPHPXltvy/8cajfRJVLekENmFYMq+I7P
         gPjQhI0VajaWCdf8bjxcarydtKh2RKRfbFOiKmRksDBjZ+HXb56geDtPqRR70iRoSboq
         XiHql9QVjT8bFSlTMdpgL8Nmzhw0jtGvIHzSk1JFWyxzapMisFfK7sUF+vf69hTG0b3q
         xZEqmp5dkF4aPUs4iVtSALgRQ938rCApw5tD0eptXORJ4pblVJq2zGNFCWLHSBHxGL63
         U32s1W8G3t6JrUuV4m2qZ5nyhAjKQpyA3Ea2jTfm7pHLZxSxZiTN8gPOmfSFoQsSED6x
         YgKg==
In-Reply-To: <1382948864.2523.25.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Mon, Oct 28, 2013 at 4:27 PM, Ian Kent <raven@themaw.net> wrote:
> On Thu, 2013-10-24 at 11:34 +0800, Dennis Lan (dlan) wrote:
>> HI Ian:
>>   here is simple patch for fixing undefined authtype_requires_creds
>> error while LDAP enabled but without SASL.
>>
>>   sorry for using attached file, since I have problem to use "git
>> send-email" in my office.
>>
>>   also the downstream bug here, https://bugs.gentoo.org/show_bug.cgi?id=489128
>
> Ahh ... something I missed in 5.0.8.
>
> I've added it to the pending patch queue in the autofs-5.0 and master
> branches.
>
> Not sure yet how I'll manage the two branches but I'll see how it goes
> and then decide.
>
> The master branch will eventually become autofs-5.1.
>
> Ian
>
>
HI Ian:
  Ok, I'm fine with this, just make sure you accept the patch ;-)
  And thanks a lot.

Dennis Lan (dlan)
