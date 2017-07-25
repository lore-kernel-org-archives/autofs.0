From: Ian Kent <raven@themaw.net>
Subject: Re: autofs startup issue
Date: Tue, 25 Jul 2017 14:01:50 +0800
Message-ID: <1ceb245b-809b-cdd9-ecd5-f8b09fa69ab5@themaw.net>
References: <CAH+JqnCXyQTQO8RQm_4J9mv3SZkRO1G4jgfBoZtE=dnQO5RGkA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=A5H/0bkydgyv8mVgSM
        sfUw3i4hU48Ky1/sptx5mazFY=; b=d66jEBHj/pVIG0eKsLDUDVhf24rHDWjp8q
        7Lysu37x3rtkfyL4s63qXF6/wtMfOCvN84xHo3Hh+VrbVABJPxeNQ6Xg9vD4PdxD
        1b+vqkqGHl62yGSn4xbRFHd3sO07X3VUT/Ywcd4ZifWGF53k+0Dvn9+IVVY7pnvL
        tA/d+m8qqAxCzRC3gCDkgStgGPvl6ospSVKUI0D7T9x1Zz/MvBmlytPVrmGoVTjc
        kwauHSnC6Am+FpIpvX8V5FiMnpkZ6Y3o860pnRnt8Jx3+uf/EbP+gANvgZiptaJF
        JCXeBbfSdTozjJUy8CHHY+hzsI/DcNZ3+xQcnl7iK9bmyDDQkUQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=A5H/0bkydgyv8mVgSMsfUw3i4hU48Ky1/sptx5mazFY=; b=GiMmFpL3
        s0ScNkJ1ErmCTPG+TTJBtHxIqO0emAX0JqVTKkEqENE3C52DnTgGiwQ5f4EUtjga
        XsY5CtJ3dEkbRb6tGCNp0ciSeupN0nalRAFwktUxE4AkrLXiGkMYpQxfAFFcB4kb
        +UDvDtEkQQOXwgJAfOTAh3ny74Ad3uDb1DsSgol34NvowWkxnynFjWZ87lSYWkJn
        8NBSkIHgNHD6Cnp9VBNuMulmN4x5L5HF7eYR8cNZJ9mZANGj6rANfSWhTdAzq+Ll
        PknVbsSv4E6JxbY77tyWFKm4KkiiA/Z7ViuKQr7zmpLeH41Jy2rIg5lgYBUpg/jB
        sKgscygD/Eou0w==
In-Reply-To: <CAH+JqnCXyQTQO8RQm_4J9mv3SZkRO1G4jgfBoZtE=dnQO5RGkA@mail.gmail.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: doron cohen <doron@weka.io>, autofs@vger.kernel.org

On 25/07/17 13:33, doron cohen wrote:
> Hi,
> 
> I encounterd an issue involving automount start.
> As part of our tests we reboot our machines and test their state after
> they have recovered. Sometimes these reboots include the --force flag
> and even --no-sync. At other times we are forces to use more drastic
> commands like "echo 1 > /proc/sys/kernel/sysrq; echo b >
> /proc/sysrq-trigger".
> Once in a while, after a reboot, we detect autofs is not running.
> After some investigating we discovered that the pid file in
> /run/autofs-running hasn't been cleaned before reboot and autofs
> reports it is already running:
> 
> [root@autofs-6 ~]# pidof automount
> [root@autofs-6 ~]# automount --debug
> automount: program is already running.
> [root@autofs-6 ~]# cat /run/autofs-running
> 3394
> [root@autofs-6 ~]# rm /run/autofs-running
> rm: remove regular file ‘/run/autofs-running’? y
> [root@autofs-6 ~]# automount --debug
> [root@autofs-6 ~]# pidof automount
> 6362
> [root@autofs-6 ~]# cat /run/autofs-running
> 6362
> 
> This seems very odd to me. Why doesn't automount check if the process
> is really running (like with pidof or any other way) and how do we
> solve this issue?
> some guesses to why this is happening include: an issue with the tmpfs
> /run directory or a mount race. We are trying to reproduce and collect
> some data.
> We are using autofs 5.1.2.

On what distribution?

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
