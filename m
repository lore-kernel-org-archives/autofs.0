From: "Badics, Alex" <alex.badics@balabit.com>
Subject: Autofs + shared mount namespaces
Date: Tue, 12 Sep 2017 15:17:43 +0200
Message-ID: <CAJsjXgryH912APrqk3rzECB=MHKdDg_ROfa6mjTETKKBrW7mmg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=balabit-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=an/nWUHBEPRUbAdxsRffFh2WiBicGu5LVdTZWgvoERc=;
        b=V21oMNQ0yqdFyz8bOtBSoJ6+NiGGsYQXj4zTQ+Y8uTkXk2FpZoNIvUVNGb0149h3i1
         RCIGTsRZJedkITsxyF4pWBvak7aLkx2MUXTwacff3BTEokhKEy5SQFPflOPdvI7nnbOu
         wZ6m+bp+leKsg6CrktROm5pKpnIwee8nUXnbtxTsXBeOKOx65UZiUv43DReP3NcNm6m7
         WPlnOTI58H2mMW/Coytsz5iPBG81btsagiEc3KURcQj/R+WbkpTHUd9GssVuubkH21dx
         lchbgT53vfGm0tIIpY+t301PxzAej4BY9trtyZ75cQHHGI9nHze6OxfPsM9zYcV0t4bh
         Ag6g==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hi,

We've been trying out autofs with both systemd-automount and the
autofs userspace daemon, and it seems like it incorrectly marks a
mountpoint as "expired" even though it's still in use in a different
mount namespace. Am I doing something wrong? Are mount namespaces
supported by the autofs driver?

Reproduction:
/etc/autofs/auto.master:
/mnt/test   /etc/autofs/auto.test.nfs --timeout 10

/etc/autofs/auto.test.nfs:
test  -rw,soft,intr server.domain:/exports/nfs

On one tab, I start autofs:
# automount -f -v

On another, I unshare a namespace, and cd into the test directory:
# cd /mnt
# unshare -m --propagation shared
# cd test/test

And just wait. The mount correctly happens, but after 10 seconds, the
autofs daemon gets an expired message and tries to umount hte nfs
mount, and fails, because it's busy. It retries until I cd out of the
nfs directory, then it of course succeeds:

Starting automounter version 5.1.3, master map auto.master
using kernel protocol version 5.02
mounted indirect on /mnt/test with timeout 10, freq 3 seconds
attempting to mount entry /mnt/test/test
mounted /mnt/test/test
1 remaining in /mnt/test
1 remaining in /mnt/test
1 remaining in /mnt/test
expiring path /mnt/test/test
>> umount.nfs4: /mnt/test/test: device is busy
>> umount.nfs4: /mnt/test/test: device is busy
>> umount.nfs4: /mnt/test/test: device is busy
Unable to update the mtab file, /proc/mounts and /etc/mtab will differ
expired /mnt/test/test
1 remaining in /mnt/test
1 remaining in /mnt/test
1 remaining in /mnt/test
1 remaining in /mnt/test
expiring path /mnt/test/test
expired /mnt/test/test

Thanks,
Alex Badics
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
