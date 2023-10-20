Return-Path: <autofs-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89507CDB47E
	for <autofs@archiver.kernel.org>; Fri, 20 Oct 2023 09:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376795AbjJTJ4M (ORCPT <rfc822;autofs@archiver.kernel.org>);
        Fri, 20 Oct 2023 05:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376740AbjJTJ4L (ORCPT
        <rfc822;autofs@vger.kernel.org>); Fri, 20 Oct 2023 05:56:11 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0267D5A
        for <autofs@vger.kernel.org>; Fri, 20 Oct 2023 02:56:08 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d76904928so4004526d6.2
        for <autofs@vger.kernel.org>; Fri, 20 Oct 2023 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697795768; x=1698400568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWFQiaCfCSJlroVxi8tTCVlq3J3aPdkjM7+lH81+pdU=;
        b=hdr6ofa4rDEClAeeio/YF2FtOGW83vm6O6Zp4lZxNkwCKIo8QbQ3HL7X+zzP7YJjUw
         Zv/hqbja0HhMXTy+hh/EaCnAkeXTzKRkAxH+OreDTjKj/2jm+gQVap7WST9K3j+hv209
         3/bmCCl/tyL4FexdURUTDqOkNwA2uVPwqAJPBOHltaurOQs8oWyTB7EMDzjBBMgmNLN7
         IX6q3INJQ3KkVSwvyNckCvEW+1IeN+y1K3UpLUZREjIq6lkzTzbpdrxN01z2vTB2W9Cq
         99bEsD8aPTLnu/4gGq/5tUn3PGeO6Be0tRS79PiyDd3fg2lxoVMU75DqKaZ3DQNsuD05
         gMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697795768; x=1698400568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWFQiaCfCSJlroVxi8tTCVlq3J3aPdkjM7+lH81+pdU=;
        b=FgwIUZJPQNW1ygQjocKE9tXwYdk964yDzVPo4vn9Vwq970w7+FeWxkKGUlMg5N3e5a
         Y9M3QR9I3i31HNEfLeCmL8LsRrvxWN1XZoiClorcJb4SqF1PDYirWXlkXwHhtnbd71SG
         IHHi83dZ8H4qnbMBe3ml+anTK+d6XRTl1NzAUrlcvnhExdkFtobSPdzWYpy1dvKfvmYp
         UJpaarK8UsEmtl0a9pDq7UJsqYii4R2RBII7/vuiZy3ElEneF3q4dGfgUNgIt/rN6L/C
         XY4CUFPqG4gHFO4rcAnB7pcI3MIsVsxA6kd88rBmwnxVzPYZXnN7NvflPytkZ4e0MJkC
         UsFw==
X-Gm-Message-State: AOJu0YyBsYlHuoUtnB7hiUKzLxkjz82rKdxp0hhUozrQ23tgn4pulDSX
        gPQowtTdJSuEDWJUADm/qh1nwn+5auPjjyYmW7XdUA==
X-Google-Smtp-Source: AGHT+IFfVuM4b2oWPlZVsGqOyBhZnphXp7n3tWSgnmT9tnohCaVzutuV804E/00C52kTI3LGQDoFXOQpUrXncjpQn04=
X-Received: by 2002:a05:6214:508f:b0:66d:55b7:e3d with SMTP id
 kk15-20020a056214508f00b0066d55b70e3dmr1612177qvb.28.1697795768031; Fri, 20
 Oct 2023 02:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
In-Reply-To: <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 20 Oct 2023 11:55:57 +0200
Message-ID: <CADYN=9+HDwqAz-eLV7uVuMa+_+foj+_keSG-TmD2imkwVJ_mpQ@mail.gmail.com>
Subject: Re: autofs: add autofs_parse_fd()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        autofs@vger.kernel.org, Ian Kent <raven@themaw.net>,
        "Bill O'Donnell" <bodonnel@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <autofs.vger.kernel.org>
X-Mailing-List: autofs@vger.kernel.org

On Fri, 20 Oct 2023 at 08:37, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
> > The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
> > it as compat mode boot testing. Recently it started to failed to get login
> > prompt.
> >
> > We have not seen any kernel crash logs.
> >
> > Anders, bisection is pointing to first bad commit,
> > 546694b8f658 autofs: add autofs_parse_fd()
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
>
> I tried to find something in that commit that would be different
> in compat mode, but don't see anything at all -- this appears
> to be just a simple refactoring of the code, unlike the commits
> that immediately follow it and that do change the mount
> interface.
>
> Unfortunately this makes it impossible to just revert the commit
> on top of linux-next. Can you double-check your bisection by
> testing 546694b8f658 and the commit before it again?

I tried these two patches again:
546694b8f658 ("autofs: add autofs_parse_fd()") - doesn't boot
bc69fdde0ae1 ("autofs: refactor autofs_prepare_pipe()") - boots

>
> What are the exact mount options you pass to autofs in your fstab?

cat /etc/fstab
# UNCONFIGURED FSTAB FOR BASE SYSTEM

Cheers,
Anders
