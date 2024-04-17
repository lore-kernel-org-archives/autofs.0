Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1CC16FF52
	for <autofs@vger.kernel.org>; Wed, 17 Apr 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374942; cv=none; b=UF/i5XQGLrlzU2OWpxhC6RKGIp1NOCWQyobWNy1fzpzhR/lELC7hGYPkcCqv/C6aCNBxqRoBn4eUeRFqWUMCpFPEz7jJZLIm9TAeLbkYH7lfsn+LKS/Vprp7XCT+8iqIoJz4do7u+l00qCGBHVYN1JFngluOHQ+dWWc1+u19/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374942; c=relaxed/simple;
	bh=yhmuSFZ3V90djZdZbLI1//3EqLvz+6A8h1Dm/36yyp0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=vGleeMZjEBeYieNY0LdGADkDUUoWFiGxv9dCLkhB3da4jjDVOvrGesQz833YLeOvKvgioPlfzQtPotpVoa3hCny7fDqeYWCaJ9VzNbcWjr2GaDzAZPePw2EOa7rtFhbzOlbYhiayx58jtTIs7POsAx+tLd6VF/AymF8N2BebpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iRNJqdcv; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iRNJqdcv"
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A5CE63F16A
	for <autofs@vger.kernel.org>; Wed, 17 Apr 2024 17:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713374931;
	bh=CWRku+30OBAvnYDFWDPkHeo5MC0YsxvAc5r+Ig0dvMQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
	b=iRNJqdcv5eQGKuXEJNkkekI6KiElvMJ/zKi+oYLFIDwqyZE/oISH/vUkfW9KRCfpL
	 BK1YNQMUoKYCne444dN0/j5SUYebb7999iU8rPpdga81qxZHEoqP72BR89eCF/4LTa
	 1Ilyp35l9XwdaIgC2gMfipgDr30M3M7zrv7SJlEbWh3yndHgHckgc9D/vxp12DGN6+
	 M4VcsRIG9gG3fzMjgVwQzdcu7XvltJFOViRKkyBa8jRBwYSB7kRzJteO7wLf6tBd2i
	 0KNus5rPTH0gpo+1S6STd0RizqY2E4m4mi2f5YqBJx2qH9iewlx1p2MvlLoGC1IpVJ
	 vk7Nn8R70oSIA==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6183c4a6d18so85407527b3.3
        for <autofs@vger.kernel.org>; Wed, 17 Apr 2024 10:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374930; x=1713979730;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWRku+30OBAvnYDFWDPkHeo5MC0YsxvAc5r+Ig0dvMQ=;
        b=cYE3cGemNpdBaDjGlf7JH3aupwft+3R+AblRZeESvcgxAEmDFfpyPz5lnqOSXiNdmc
         Y9m2uBsztG3aSobdX4bRdfS+T/vvodSu8XCDlqz+SlO8I5HHfV0+lpjWDPrDv/fnPdP3
         0ZJiJY5Cfu947GBA9P52LuJVZ9m++oB8oN4GlNOlEstXAGRgwSePMOyCRDkfa6T5RxjG
         OBUKSi75zE7ptpGN9JCN40RBUxk5NKvWWNl04XfeK7QUlOF/vjZ/ExyJnOHeZ/PfkXvD
         TYlzJn4lRpCGWopjy7r+kQ/rIFBKa5Uw/2RlhG4mnTaTrQSERTyDCYLkALKu5MrfYdqW
         foIg==
X-Gm-Message-State: AOJu0YzeDa7C0xXHxGDqhM45vi2noCEMYkI7qhxJPYSQ3LyQ/VLQ1FgZ
	FLQ1B9+gRikGMROTtaLw3/d1RE1x3m/TSuLxS39gB5DsoPemB+VOxXCliYCIGliX4IDiP7m/bJj
	4bsHtWpnl0M613E6lFG0CpWwPNe0TuGQcKkPx/bB7ejIFIGRQB8z2GSVjGSPiWOVz4R0ZOQ4fRd
	bGEgkuWVKJQmfAsZZQZfsw1ZZlXPooZQG+l77RW6qqmcZLTtc6Po0dHQk=
X-Received: by 2002:a81:f00a:0:b0:618:9587:f37b with SMTP id p10-20020a81f00a000000b006189587f37bmr11698671ywm.37.1713374930510;
        Wed, 17 Apr 2024 10:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3UbvWsh0cA1VQCEVGOW4K0V2oOzOmXax/GEtmQkom7DikEvQpExt77zSTac4qHqs5BYTZK+rlYlEWE3vqDxY=
X-Received: by 2002:a81:f00a:0:b0:618:9587:f37b with SMTP id
 p10-20020a81f00a000000b006189587f37bmr11698657ywm.37.1713374930241; Wed, 17
 Apr 2024 10:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andreas Hasenack <andreas@canonical.com>
Date: Wed, 17 Apr 2024 14:28:39 -0300
Message-ID: <CANYNYEEpJabu=qiQ2VUde6J4HUC9mQSgCGksbLQqGsr1-w5NYg@mail.gmail.com>
Subject: autofs 5.1.9 snprintf() crash with -D_FORTIFY_SOURCE=3
To: autofs mailing list <autofs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

in Ubuntu we are building most packages with -D_FORTIFY_SOURCE=3
nowadays, and we just got a bug report that 5.1.9 was crashing with a
buffer overflow warning. When rebuilt with -D_FORTIFY_SOURCE=2, it
does not crash.

Here is a small reproducer using a loop device. This is on kernel 6.8.0:

/etc/auto.master:
/- file,sun:/etc/auto.mp strictexpire

"strictexpire" is what triggers the crash.

/etc/auto.mp:
/mp defaults :/dev/loop0

# automount -f -d3
Starting automounter version 5.1.9, master map /etc/auto.master
using kernel protocol version 5.05
lookup_nss_read_master: reading master file /etc/auto.master
do_init: parse(sun): init gathered global options: (null)
lookup_read_master: lookup(file): read entry /-
master_do_mount: mounting /-
reading file map /etc/auto.mp
do_init: parse(sun): init gathered global options: (null)
*** buffer overflow detected ***: terminated
Aborted (core dumped)

gdb show this being in the snprintf call in lib/mounts.c when
",strictexpire" is being added to the autofs mount options string:
#9  0x00007ffff7dbaab4 in snprintf (__fmt=0x7ffff7dca232 "%s", __n=93,
__s=0x7fffec002c1c "") at
/usr/include/x86_64-linux-gnu/bits/stdio2.h:54
No locals.
#10 make_options_string (path=0x5555555b7d50 "/-", pipefd=6,
type=type@entry=0x7ffff7dca02b "direct", flags=2560) at
/usr/src/autofs-5.1.9-1ubuntu3/lib/mounts.c:764
        kver_major = <optimized out>
        kver_minor = 5
        options = 0x7fffec002bf0
"fd=6,pgrp=22935,minproto=5,maxproto=5,direct"
        max_len = 93
        len = 44
        new = <optimized out>
        __FUNCTION__ = "make_options_string"

lib/mounts.c:760
    /* maybe add ",strictexpire" */
    if (flags & MOUNT_FLAG_STRICTEXPIRE) {
        new = snprintf(options + len,
                   max_len, "%s", ",strictexpire");

I don't think this is actually overflowing options in this particular
case, but the max_len argument doesn't seem right, as that was the
original max size for options.

This patch stopped the crash, but there is a lot of C string
manipulation going on here and I would appreciate more eyes on this. I
 *think* the truncated and error checks are still ok after this:

--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -760,7 +760,7 @@ char *make_options_string(char *path, int pipefd,
    /* maybe add ",strictexpire" */
    if (flags & MOUNT_FLAG_STRICTEXPIRE) {
        new = snprintf(options + len,
-                  max_len, "%s", ",strictexpire");
+                  max_len - len, "%s", ",strictexpire");
        if (new < 0)
               goto error_out;
        len += new;
@@ -774,7 +774,7 @@ char *make_options_string(char *path, int pipefd,
    /* maybe add ",ignore" */
    if (flags & MOUNT_FLAG_IGNORE) {
        new = snprintf(options + len,
-                  max_len, "%s", ",ignore");
+                  max_len - len, "%s", ",ignore");
        if (new < 0)
               goto error_out;
        len += new;
