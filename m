From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: When ghosting is enabled, failed mounts by AutoFS leave broken directories
Date: Mon, 24 Sep 2012 17:14:22 -0300
Message-ID: <CAEySpB59DaMnK2Ge4r-kzZhA_mG-88Nz_sVpMv-tJDUM3CJ9-w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=k2Q90oy6hpARJ0+fgoJTiLGq0bv8yfXgQXAczwglfc8=;
        b=iJE9kZhRhoBaK8X0LoQyt117EbBN7QCjh6wcOn/Yf0qYAtego/FGrW+q3jNiDje2+u
         AcXtUstFu91+fur1uER9bfM1faop9b3CwY2PWKDyPvWopHbOkEA9XylEHYln1Ewra1jO
         tf983lFHVVoxyzjULTtVDxJXIsY6DViFneagNVH3fEp5wC1lJ8C3FUhSm7CKLhTBSNMW
         yOBPdYyUTM0xSN7wNGplOj6+Xw0PMUBzvCGhZmZziB3yZmDKmB8GV3sEoPBP2OpQKmjk
         dyZ5MBoSQIx7BsK2Q1iZnGwoUCxZIgAQMEsmAujBIgDSJx5xHGB8ZNXc+ZCbbXJzaM8w
         +NHQ==
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu

Hi,

If you try to access an automounted directory and the mount operation fails,
the attributes of the directory (owner, group, mode, access time) are lost.
This happens only when AutoFS' browse mode (ghosting) is enabled.

How to reproduce the problem:

Make sure you have BROWSE_MODE="yes" in /etc/sysconfig/autofs.

1. Add a simple indirect mount map (it's required that the server does NOT
   export the /notexported directory):

# cat /etc/auto.master
/nfs    /etc/auto.nfs

# cat /etc/auto.nfs
v2      server:/notexported

2. Restart AutoFS and try to access the directory:

# cd /nfs/v2
-bash: cd: /nfs/v2: No such file or directory

# ls -la /nfs
ls: cannot access /nfs/v2: No such file or directory
total 4
drwxr-xr-x  3 root root    0 Sep 24 21:43 .
drwxr-xr-x 28 root root 4096 Sep 24 21:25 ..
d?????????  ? ?    ?       ?            ? v2

This problem is reproducible on recent upstream kernels such as 3.6.0-rc6.
I found out that the last kernel version that does not exhibit the bug is
2.6.37. Between 2.6.37 and 2.6.38 there were quite some changes in
AutoFS/VFS and my attempts to bisect the problem were frustrated by
early crashes.

Any ideas?

Thanks,
Leonardo
