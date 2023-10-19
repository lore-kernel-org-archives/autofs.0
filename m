Return-Path: <autofs-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C20CDB465
	for <autofs@archiver.kernel.org>; Thu, 19 Oct 2023 15:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbjJSP2I (ORCPT <rfc822;autofs@archiver.kernel.org>);
        Thu, 19 Oct 2023 11:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345550AbjJSP2H (ORCPT
        <rfc822;autofs@vger.kernel.org>); Thu, 19 Oct 2023 11:28:07 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88A512A
        for <autofs@vger.kernel.org>; Thu, 19 Oct 2023 08:28:05 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7b625ed7208so3404272241.1
        for <autofs@vger.kernel.org>; Thu, 19 Oct 2023 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697729285; x=1698334085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ePdjmTFlmWfaU2E17cd2rM20Zga7y8maCxRmtdGFBCc=;
        b=Zg4/aLh6AhTSDdo7KIdqEZgb4FAOnWiw4lafqI37kOB7W3Pl5eu4zSI4jMu1MXIVj0
         tBzG0LMB6tbXmSjcKkTSRf/ZxqBYxDJDUNDuZZB09T6HfA9x3Ooy7SGehpamTE9rtuJ7
         cGSsgZ7Nd+N1vntrIEKyFBn3nBSg6f8urI/5AEIbbnQ6Hr7a7vsIpD7GSjEoLU7x+xai
         P8GdgWo8oeIe2Z70ALxZcmQAoyTVrwqMW2VFHvDDejG2M3rQaYDBZSMYFmtO3+9e/7SY
         MO1YDKKbUWQ+SkTjUsojbIwpBr4Refge4Rt+efkrdvrWCSHOlf9bA1pWsyeu1cmMf2bn
         p2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729285; x=1698334085;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ePdjmTFlmWfaU2E17cd2rM20Zga7y8maCxRmtdGFBCc=;
        b=d0qeqTelqQZ0acIBtyJtiek5OIiiSs7ISFIZIRHV5V2T0AZurrepddEw/6Z2NuzsYh
         0IngNppWTzF5sit2Kmt+/20zORxUHuCY8kWzVDE0gYtxNRARwFJuIlNIrtgBMgCXGzzA
         CLsZvB5oXF+4Hp1fPCR5s9dOA2V1HNMwNhVwmOBaIngL6PnrC1jTWx7KWQLJdGF8Pt/R
         HrDJ+14zFbE97Qwx/jOk1uGFgo00n2aiODFa0pkGI3X2dxKZjTlbpqiQpUXzx50OenI3
         qvY5jnTvMxlrAZiuKcrB9eXmtDwcGQ3C+bagooo+op3v9zKZimjUAna8UqxVTDEkbZuS
         LiCg==
X-Gm-Message-State: AOJu0YzBY0jIT1Ax/LqXDnh3jXCb5tDnPhm2gCezrqygCpO5RQm1b5zT
        EoqVajF0Fy/s/odUcLzQBaos0A/RXp6zH1tyrYuSmQ==
X-Google-Smtp-Source: AGHT+IFRtisHRQ8llbCtMKcbt98E2rge5LFbQnavaVa23CCczzG4eiu/FxAW29PkAGxdTosFN9IPxLiigCvq1crVf+A=
X-Received: by 2002:a05:6102:1009:b0:457:ce8f:ded8 with SMTP id
 q9-20020a056102100900b00457ce8fded8mr2492151vsp.3.1697729284825; Thu, 19 Oct
 2023 08:28:04 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 19 Oct 2023 20:57:53 +0530
Message-ID: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
Subject: re: autofs: add autofs_parse_fd()
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        autofs@vger.kernel.org
Cc:     Ian Kent <raven@themaw.net>,
        "Bill O'Donnell" <bodonnel@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <autofs.vger.kernel.org>
X-Mailing-List: autofs@vger.kernel.org

The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
it as compat mode boot testing. Recently it started to failed to get login
prompt.

We have not seen any kernel crash logs.

Anders, bisection is pointing to first bad commit,
546694b8f658 autofs: add autofs_parse_fd()

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>

steps to reproduce:
----------------
# To install tuxrun to your home directory at ~/.local/bin:
# pip3 install -U --user tuxrun==0.49.2
#
# Or install a deb/rpm depending on the running distribution
# See https://tuxmake.org/install-deb/ or
# https://tuxmake.org/install-rpm/
#
# See https://tuxrun.org/ for complete documentation.
#

tuxrun --runtime podman --device qemu-x86_64 --boot-args rw --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2WyQyyM0OvXnnbI0d84HL0v1J56/bzImage
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2WyQyyM0OvXnnbI0d84HL0v1J56/modules.tar.xz
--rootfs https://storage.tuxboot.com/debian/bookworm/i386/rootfs.ext4.xz
--parameters SKIPFILE=skipfile-lkft.yaml --parameters SHARD_NUMBER=10
--parameters SHARD_INDEX=3 --image
docker.io/linaro/tuxrun-dispatcher:v0.49.2 --tests ltp-cve --timeouts
boot=15 --overlay
https://storage.tuxboot.com/overlays/debian/bookworm/i386/ltp/20230929/ltp.tar.xz


Please find related links to test and results comparison.

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231019/testrun/20695093/suite/boot/test/gcc-13-lkftconfig-compat/history/?page=1
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230926/testrun/20125035/suite/boot/test/gcc-13-lkftconfig-compat/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WyR2MGbyTalC8rGugHIZXPMldC/reproducer
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2WyR2MGbyTalC8rGugHIZXPMldC
--
Linaro LKFT
https://lkft.linaro.org
