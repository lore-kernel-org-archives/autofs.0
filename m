Return-Path: <autofs-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B540CDB47E
	for <autofs@archiver.kernel.org>; Fri, 20 Oct 2023 09:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376708AbjJTJ5h (ORCPT <rfc822;autofs@archiver.kernel.org>);
        Fri, 20 Oct 2023 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376740AbjJTJ5g (ORCPT
        <rfc822;autofs@vger.kernel.org>); Fri, 20 Oct 2023 05:57:36 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A40D5E
        for <autofs@vger.kernel.org>; Fri, 20 Oct 2023 02:57:34 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-778a108ae49so117641585a.0
        for <autofs@vger.kernel.org>; Fri, 20 Oct 2023 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697795853; x=1698400653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaxbJPPE3rFAMH204LGMbjHaXXB+dNgwSRGAlzN+0DY=;
        b=TWGDyFTCGvIdL/7KuQn9klFCwxdSNXWQ4kgOpTYoUL++ZN8WITBFVGrKJeF7lP9pDa
         UaIk1znaOH6YFgoQ4GzvreTvJ1LvM08ZmXB1rrJ7kDIfN3ue7D0+naBuGzaloTXg5rzt
         LrMNOX5nrjKiE5NoBDj8YTUsr+Nf8M4NBujmSsi9vAhBm34edeAMjQeVvAndhpXj9DHD
         EDohpaXtl6HLpbPylLpt6UXIpSxuJhBJ3oMdE6jC7Wh7Z11eVTlZT74ESDDOUfPEFOa8
         zDJ1UKgFOCzJ40tpMsVR/MENWZcNg2JK/NGBTlXXaPGkGt3KSqi0wODeMeLFDqQaL63c
         atXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697795853; x=1698400653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaxbJPPE3rFAMH204LGMbjHaXXB+dNgwSRGAlzN+0DY=;
        b=QBUMhJK4sAbuNfESiTeIGiYwOMa5lg2Shss5tjhzpU7q+CBzu+G2GYFv/M2pgdzS6N
         h7HWvSs/6sYI4PmGAMbGezCqDbaCP1p3+ma1N/S7oemmejIy2PLwEytnaDrIgmcYG3bA
         Y+z6coL0/PCc4OtvX7zpugfAa+6oknxKm2EVQfN1MZHuKk+SzGufCKFwS0oOVTcH4Cin
         ri5OI0wrm0c7oFffqQcj4Yu8Lq1Bn60fgn3sWsujrO5ADjZHAKICRJiZcnEogyE3b7fV
         884nQQx2h0mfWvEy0kefCSC7uVR/XrFCOT+zV86KK9Cu+lf0JlphbfYtExFkpwuaQpBj
         mgyw==
X-Gm-Message-State: AOJu0Yy48k4W7HSZFzFJJ/0zpjrM/nQaOvT66xniwo8pvr6GWrRWyo0s
        GBStDrcJpGRQX/2+60I2L3bcVSnzX2eIL0cqmhueIg==
X-Google-Smtp-Source: AGHT+IEF1x89nhV2dTpKBvv/vtgC082DqTQEqOMGUDZ0q9v0tw+GzmkgHxunO/2VJvHy/Aa2HeP9jelsk4qRtZKePrY=
X-Received: by 2002:a05:620a:4407:b0:774:20b7:b88 with SMTP id
 v7-20020a05620a440700b0077420b70b88mr6932070qkp.0.1697795853355; Fri, 20 Oct
 2023 02:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com> <CA+G9fYtFqCX82L=oLvTpOQRWfz6CUKb79ybBncULkK2gK3aTrg@mail.gmail.com>
 <6dde13bc-590d-483c-950c-4d8aeee98823@app.fastmail.com>
In-Reply-To: <6dde13bc-590d-483c-950c-4d8aeee98823@app.fastmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 20 Oct 2023 11:57:22 +0200
Message-ID: <CADYN=9+O4ZGjewzkk90zis85+AQWKbNz6ttMKZiFravHuy4Vqw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <autofs.vger.kernel.org>
X-Mailing-List: autofs@vger.kernel.org

On Fri, 20 Oct 2023 at 11:02, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Oct 20, 2023, at 09:48, Naresh Kamboju wrote:
> > On Fri, 20 Oct 2023 at 12:07, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
> >> > The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootf=
s we call
> >> > it as compat mode boot testing. Recently it started to failed to get=
 login
> >> > prompt.
> >> >
> >> > We have not seen any kernel crash logs.
> >> >
> >> > Anders, bisection is pointing to first bad commit,
> >> > 546694b8f658 autofs: add autofs_parse_fd()
> >> >
> >> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> >>
> >> I tried to find something in that commit that would be different
> >> in compat mode, but don't see anything at all -- this appears
> >> to be just a simple refactoring of the code, unlike the commits
> >> that immediately follow it and that do change the mount
> >> interface.
> >>
> >> Unfortunately this makes it impossible to just revert the commit
> >> on top of linux-next. Can you double-check your bisection by
> >> testing 546694b8f658 and the commit before it again?
> >
> > I will try your suggested ways.
> >
> > Is this information helpful ?
> > Linux-next the regression started happening from next-20230925.
> >
> > GOOD: next-20230925
> > BAD: next-20230926
> >
> > $ git log --oneline next-20230925..next-20230926 -- fs/autofs/
> > dede367149c4 autofs: fix protocol sub version setting
> > e6ec453bd0f0 autofs: convert autofs to use the new mount api
> > 1f50012d9c63 autofs: validate protocol version
> > 9b2731666d1d autofs: refactor parse_options()
> > 7efd93ea790e autofs: reformat 0pt enum declaration
> > a7467430b4de autofs: refactor super block info init
> > 546694b8f658 autofs: add autofs_parse_fd()
> > bc69fdde0ae1 autofs: refactor autofs_prepare_pipe()
>
> Right, and it looks like the bottom five patches of this
> should be fairly harmless as they only try to move code
> around in preparation of the later changes, and even the
> other ones should not cause any difference between a 32-bit
> or a 64-bit /sbin/mount binary.
>
> If the native (full 64-bit or full 32-bit) test run still
> works with the same version, there may be some other difference
> here.
>
> >> What are the exact mount options you pass to autofs in your fstab?
> >
> > mount output shows like this,
> > systemd-1 on /proc/sys/fs/binfmt_misc type autofs
> > (rw,relatime,fd=3D30,pgrp=3D1,timeout=3D0,minproto=3D5,maxproto=3D5,dir=
ect,pipe_ino=3D1421)
>
> This is only the binfmt-misc mount, which should not
> prevent your rootfs from getting mounted, but it's possible
> that failure to mount this prevents you from running
> 32-bit binaries.
>
> I see this comes from the "proc-sys-fs-binfmt_misc.automount"
> service in systemd.  I see this is defined in
> https://github.com/systemd/systemd/blob/main/units/proc-sys-fs-binfmt_mis=
c.automount
> but I don't know exactly what its purpose is here. On a
> 64-bit system, you normally use compat_binfmt_elf.ko to run
> 32-bit binaries, and this does not require any specific mount
> points. Alternatively, you could use binfmt_misc.ko with
> the procfs mount to configure running arbitrary binary
> formats such as arm32 on x86_64 with qemu-user emulation.
>
> I double-checked your rootfs image from
> https://storage.tuxboot.com/debian/bookworm/i386/rootfs.ext4.xz
> to ensure that this indeed contains i386 executables rather than
> arm32 ones, and that is all fine.
>
> I also see in your log file at
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230926/=
testrun/20125035/suite/boot/test/gcc-13-lkftconfig-compat/log
> that it is running the i386 binaries from the rootfs, but
> it does get stuck soon after trying to set up the binfmt-misc
> mount at the end of the log:
>
> [[0;32m  OK  [0m] Reached target [0;1;39mlocal-fs.target[0m - Local File =
Systems.
>          Starting [0;1;39msystemd-binfmt.se=C3=A2=E2=82=AC=C2=A6et Up Add=
itional Binary Formats...
>          Starting [0;1;39msystemd-tmpfiles-=C3=A2=E2=82=AC=C2=A6 Volatile=
 Files and Directories...
>          Starting [0;1;39msystemd-udevd.ser=C3=A2=E2=82=AC=C2=A6ger for D=
evice Events and Files...
> [   15.869404] igb 0000:01:00.0 eno1: renamed from eth0 (while UP)
> [   15.883753] igb 0000:02:00.0 eno2: renamed from eth1
> [   20.053885] (udev-worker) (175) used greatest stack depth: 12416 bytes=
 left
>  quit
>
> I'm a bit out of ideas at that point, my best guess now is
> that your bisection points to something in autofs that makes
> it hang while setting up autofs, but that neither autofs
> nor binfmt-misc are actually being used otherwise.
>
> Maybe you can try to modify your rootfs to disable or remove
> the systemd-binfmt.service, to confirm that autofs is not
> actually needed here but does cause the crash?

I removed systemd-binfmt.service from the rootfs and booted
546694b8f658 ("autofs: add autofs_parse_fd()") and now it booted fine.

Cheers,
Anders
