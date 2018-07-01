From: tomas <tomasbortoli@gmail.com>
Subject: [PATCH upstream] KASAN: slab-out-of-bounds Read in getname_kernel
Date: Mon, 2 Jul 2018 00:04:10 +0200
Message-ID: <38c5a8ad-c192-74b9-b2ff-9eb2a3386930@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=UDGViSBvKFUNRlIlOw8lpNEcWlpqy/qfV0Lh51l3Dfw=;
        b=CGPmqUsGTd7+5g6QGIrgS+GM/PHV68WVXHjIM257/YQen7surhanGo7D58X6ujkhH8
         N+z5bRuqQRp35F49l787/pGUxS4nZl98ST3KHiWFikytwFxXU/jkQr+5nL3Xf5POL75+
         jIDyhmKsYWWNK5MRorVBeVd44IA8ACRV9nTEY7p+mdBuLMSkv59JgKgMOPSvrR7enxkQ
         A5+QOVtxFgLG3XETu0Brv8toH93YxjvqMSPmIGuHsKGAWVWeyUv77k+002nU1KC90WBY
         mr8Z7BHE3wqAKd+4Veosoy3eJGMG8gUF0CdJV0sqORqjuIiqRIvA5e4aisTvh5t4p8Nd
         tCoA==
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: raven@themaw.net, autofs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com

Hi,

I've looked into this issue found by Syzbot and I made a patch:

https://syzkaller.appspot.com/bug?id=3Dd03abd8b42847f7f69b1d1d7f97208ae42=
5b1163


The autofs subsystem does not check that the "path" parameter is present
within the "param" struct passed by the userspace in case the
AUTOFS_DEV_IOCTL_OPENMOUNT_CMD command is passed. Indeed, it assumes a
path is always provided (though a path is not always present, as per how
the struct is defined:
https://github.com/torvalds/linux/blob/master/include/uapi/linux/auto_dev=
-ioctl.h#L89).
Skipping the check provokes an oob read in "strlen", called by
"getname_kernel", in turn called by the autofs to assess the length of
the non-existing path.

To solve it, modify the "validate_dev_ioctl" function to check also that
a path has been provided if the command is AUTOFS_DEV_IOCTL_OPENMOUNT_CMD=
=2E


--- b/fs/autofs/dev-ioctl.c=C2=A0=C2=A0=C2=A0 2018-07-01 23:10:16.0597286=
21 +0200
+++ a/fs/autofs/dev-ioctl.c=C2=A0=C2=A0=C2=A0 2018-07-01 23:10:24.3117921=
33 +0200
@@ -136,6 +136,9 @@ static int validate_dev_ioctl(int cmd, s
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto out;
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 /* AUTOFS_DEV_IOCTL_OPENMOUNT_CMD without path */
+=C2=A0=C2=A0=C2=A0 else if(_IOC_NR(cmd) =3D=3D AUTOFS_DEV_IOCTL_OPENMOUN=
T_CMD)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0 err =3D 0;
=C2=A0out:


Tested and solves the issue on Linus' main git tree.

Tomas


