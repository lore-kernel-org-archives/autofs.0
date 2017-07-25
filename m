From: Ian Kent <raven@themaw.net>
Subject: Re: autofs startup issue
Date: Tue, 25 Jul 2017 15:04:13 +0800
Message-ID: <417c55ee-23a2-a0a9-e48e-a21acabb1004@themaw.net>
References: <CAH+JqnCXyQTQO8RQm_4J9mv3SZkRO1G4jgfBoZtE=dnQO5RGkA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=7lCA2EqPUVO0cxy5Lj
        7Pn4Zb2cpDTqdAgUK9iMl33ZA=; b=k1yxU7DUHeuwbczo9G3YKJIDLA0gOpTSUr
        zS5TLxSt+mScPtsI40eMI7MLLKDX5ooz97oqjplG6KrTqiVsSWIte8vVN8APtPlg
        QavR3yF8ZaBj7E26fLO9zz7XqCOyEdjQRNf3gs0WGLapnEQ265/SaPLVP9BTCf/8
        OhOqXCMvYSHmXzra/EaMkkrvQsiaD17qzVA2qbU2SdkWXsjRi5h1WkdGpOVVuTki
        qFUki8lbukdeEc5N2V/A1QFMHyofM4nAC3svplGKKhIyc7skuIQ5ofIxAIDZq6xD
        670z/GvLQEhIJlCYVdrXqc1phSzgS5TdpFyRMkTKvrJg0uVMM8bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=7lCA2EqPUVO0cxy5Lj7Pn4Zb2cpDTqdAgUK9iMl33ZA=; b=fKfxQZFf
        HhGeuj9ikt9Py+6a6uc2hh6csUU/9K+t5d4gQ6Zr4dSoRMQS6EmF3yrtmg6QYTGT
        KgG8n9wNJeIwIQc+tq1w2ayfoCDN/JEdtzd1juP8org46RngwsrQlfFjQW7lauF7
        aIK++vw+m0zpKYj7pxjUMkoqsNJycGDUIdRKtBvz7pEp8QONkScCiTcjJdk977nv
        iZBwr+VRvMXmryYb+TeN0u3EdpTPZyZgBWWfC4snROwITr6BjBlR6pPyVX/ceQ7Y
        SC8mfJGGwAalQ5/Bu1Spi1fGS4MCJsBq55A7vp0bktPixdNCOmvGHl5dmyHltgLv
        yn9YP1A/j7Ve5w==
In-Reply-To: <CAH+JqnCXyQTQO8RQm_4J9mv3SZkRO1G4jgfBoZtE=dnQO5RGkA@mail.gmail.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: doron cohen <doron@weka.io>, autofs@vger.kernel.org

On 25/07/17 13:33, doron cohen wrote:
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

It's been a long time since I looked at this code.

It seems that if a pid file is found only the existence of a process
is checked. Whether that process is an automount process or not isn't
checked. So if some other process with that pid now exists but isn't
an automount process the check will get a false positive.

I'll need to fix that.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
