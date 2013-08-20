From: Ian Kent <raven@themaw.net>
Subject: Re: Seperate option for install systemd unit file
Date: Tue, 20 Aug 2013 11:23:28 +0800
Message-ID: <1376969008.2426.3.camel@perseus.fritz.box>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=EmbzodkqIQG52u7q/9SPn4fVMD4=; b=uUQf+Z+FVHXBf/sGTylYybrTBPlN
	VXEB/V5XN2CCQmG4UGoyo8hOJ/jNAL4GeGnoN2s3nbxRd1PSHVwPX7iFTjFTJMNY
	k8uW2srUncGwGFwaYevfYq/qjX+QHJnVfuQ4uvfe+5G2RgqsYHnnRaCEpwq/k+Mk
	Y3ZSk8MvUk8eMSQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=EmbzodkqIQG52u7q/9SPn4
	fVMD4=; b=lBwC7Nxv2mNvg6/bYcTMx5RBHx0m4xiEfyEtSHmtA7mVC4C4dxo8qc
	4tdj1UWVKkxor/lUzQKEE3i2g/VtRLY0O0EteFneGFPrrljmSFzcW7KZTsgrjx5P
	GdoHeQXc/uad3eEpO6rybSP5aHwpuIUl+4Vyp3Do6FgSbpfnc3IEA=
In-Reply-To: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2013-08-19 at 14:23 +0800, Lan Yixun (dlan) wrote:
> those patches are very trivial changes which only instroduce a new --with-systemdsystemunitdir option
> to better control where we should install system unit file to
> 
> 1) seperate --with-systemd opiton, but been kept now for future use (but it's useless now)
> 2) add new option --with-systemdsystemunitdir to manage the path where unit file will be installed
> 3) --with-systemd and --with-systemdsystemunitdir are two seperate option, so unit can be installed even systemd support is not enabled.
> 
> downstream discussion: https://bugs.gentoo.org/show_bug.cgi?id=479492
> 
> let me know whether this looks good to you..

Looks OK but I'll need to spend some time on it in case it conflicts
with downstream usage I already have.

> 
> [PATCH 1/2] seperate option of --with-systemd from install systemd
> [PATCH 2/2] introduce new '--with-systemdsystemunitdir'
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


