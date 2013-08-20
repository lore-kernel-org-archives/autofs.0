From: Ian Kent <raven@themaw.net>
Subject: Re: Seperate option for install systemd unit file
Date: Tue, 20 Aug 2013 11:44:20 +0800
Message-ID: <1376970260.2426.11.camel@perseus.fritz.box>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
	 <1376969008.2426.3.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=IDqtqE9IH53TsC/YJxBzUI4nJ5I=; b=sb9C2cxtv+9EBtQn480DAHY5y76j
	ttkJYT7LI8Rt2RHVAYmxBmT/0/l0AHNmK/qKWORqUdPLMVht7b1skgzjuuT9xhxI
	KxaNgJd3JZCelUM7mtbGB60qRP6cDz0K0WuPcaURpNjzv3QftekInxkAVWD+M32V
	Bh5GbnL69eXg+80=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=IDqtqE9IH53TsC/YJxBzUI
	4nJ5I=; b=XkngbjkrJnoVS9JZa6re7HKDmqUHh4M/kId2Q+hAueoNxJ1yvSCFLo
	caqdkuzQaG5V/Vw/R1eGwtaM50OV3hP5uZc/5VcRzD3jW6z2yV14AhQ6wHUhVQsD
	3GpQi/tfsi9js84LjEaU1jUQ2I7KKfAyNhq8O5zYofbGgjVhEV1P4=
In-Reply-To: <1376969008.2426.3.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Tue, 2013-08-20 at 11:23 +0800, Ian Kent wrote:
> On Mon, 2013-08-19 at 14:23 +0800, Lan Yixun (dlan) wrote:
> > those patches are very trivial changes which only instroduce a new --with-systemdsystemunitdir option
> > to better control where we should install system unit file to
> > 
> > 1) seperate --with-systemd opiton, but been kept now for future use (but it's useless now)
> > 2) add new option --with-systemdsystemunitdir to manage the path where unit file will be installed
> > 3) --with-systemd and --with-systemdsystemunitdir are two seperate option, so unit can be installed even systemd support is not enabled.
> > 
> > downstream discussion: https://bugs.gentoo.org/show_bug.cgi?id=479492
> > 
> > let me know whether this looks good to you..
> 
> Looks OK but I'll need to spend some time on it in case it conflicts
> with downstream usage I already have.

After a very quick initial look ....

It appears that the change does two things.

Defines WITH_SYSTEMD for subsequent use, although applications usually
don't need to know if they are being managed by systemd. Do you know of
any cases where that is important?

And changes the original --with-systemd configure option to
--with-systemdsystemunitdir adding the ability to specify a unit
directory explicitly.

Why is it worthwhile changing the configure option as part of this
change?

Ian


