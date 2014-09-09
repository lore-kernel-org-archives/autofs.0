From: Rufe Glick <rufe.glick@gmail.com>
Subject: Difference between '/net -hosts' and '/net /etc/auto.net' auto.master entries?
Date: Tue, 9 Sep 2014 15:16:42 -0400
Message-ID: <CAK2T3rox0jyPQYxH60RoOLiWDOTvGYRs3Y4uZmEzgs5YaGUUyg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2q4qSsTnkTTEu2dwEHT9honS/5jUwJ0hhXq8AMY+2cA=;
        b=a4vvpHB1BokS508brU7MyZ3qaIGudegvpXGaSzlBTvrzcuZ/iyOz7f0cKpXzpdqlyc
         X1sTjSLuAZ40Iq6ASU3IpQew7/4STp8nOESShP4sfjWu2SAsBAj9bZaKWTQAsLUHx5MS
         urGMpwmvx0kQQXzt+lD1Kpm7xc4+iAvrOEPaTTwFKwAXCBbqDLT3RTeWytH2R84BiEXy
         oSNca40vsr7157skj1io2sauBx+c/k+dngP93bakc/YxGQPNUeAdxmTyjQxds63HXAWf
         UbtFzegD+WlNc747z/OBDaMPwIsjqqdmlNjRmj10Ujolvt6puLWQS/OTLGuOPNsv5BpF
         +PhA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hello,

In my /etc/auto.master file I add the following two entries:
    /net   -hosts
    /net2  /etc/auto.net

After starting the autofs service I can now access the same remote NFS
share under either of these paths:
    ls  /net/192.168.0.50/
    ls  /net2/192.168.0.50/

Is there any difference between those two ways of achieving the same
result? Is -hosts option just a shortcut for the auto.net script?

Linux distribution: CentOS v7.0.1406
Autofs package version: autofs-5.0.7-40.el7.x86_64


Thank you,
Rufe
