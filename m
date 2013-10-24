From: Colin Coe <colin.coe@gmail.com>
Subject: autofs not releasing mounts
Date: Thu, 24 Oct 2013 11:17:30 +0800
Message-ID: <CANvHAxTfGZ9jXskeNJ2T_QXs3eY=VuxkSzLvrU8UKJTNr7SidA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=bdb8UVfvkZQzlTeyCmOch/mQ0zf6BX+IwMrZssnlyF0=;
        b=qpbmkabiz3l/EoOYSVMsi6B1iJh7HJO3dJ3ACV2sJjHu4vy64f+eBRKmeor3h6SIKd
         UDPGp/k5f8pJVBZtzyj7BaVbJ0pCsKrcwjBTeSr0wCyAgdcTVKQCsdKOGFQDt2ae/epl
         b+LlcyTHyjOJCyyQDEOVXOCxwHaoQM+WrLREFXA1YKZTTJONqeF4OIJLRcSNZTkGiL/3
         cVLHE86dG8ilbXkrlwtI0H1ybsQ2QMoD6PgBKSxufFjkdhzo3/m/tWmQIBsEP7V+cVnF
         4FgQhKqhU2HTJSWA5B7/hsQJpxSV0TYD31QN+6GM+U9ImQFSaQnv4RL54qU1kjzXkzBo
         SgYA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

Hi all

We are using a pair of Windows 2012 Servers to provide CIFS and NFS
shares to a mix of Windows and RHEL clients.  These servers are
geographically diverse and use DFS-R to replicate content.

I'm finding that the RHEL clients are not releasing the mounts after
the 300 second time out specified in /etc/sysconfig/autofs.

I logged into a node and my home dir auto mounted.
I logged out
From the console where I logged in as root I ran 'lsof /home/myhome'
and nothing was returned
From console tail -f /var/log/messages I see
---
Oct 24 10:17:55 benadm1p automount[19980]: Starting automounter
version 5.0.5-75.el6_4, master map auto.master
Oct 24 10:17:55 benadm1p automount[19980]: using kernel protocol version 5.02
Oct 24 10:17:55 benadm1p automount[19980]: mounted direct on
/fileshare with timeout 300, freq 75 seconds
Oct 24 10:17:55 benadm1p automount[19980]: mounted indirect on /home
with timeout 300, freq 75 seconds
Oct 24 10:17:55 benadm1p automount[19980]: ghosting enabled
Oct 24 10:36:31 benadm1p automount[19980]: attempting to mount entry
/home/h086629
Oct 24 10:36:31 benadm1p automount[19980]: mount(nfs): mounted
benfil2p:/home/h086629 on /home/h086629
Oct 24 10:36:31 benadm1p automount[19980]: mounted /home/h086629
Oct 24 10:37:12 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:38:27 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:39:42 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:40:57 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:42:12 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:43:27 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:44:42 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:45:57 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:47:12 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:48:27 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:49:11 benadm1p automount[19980]: attempting to mount entry /fileshare
Oct 24 10:49:11 benadm1p automount[19980]: mount(nfs): mounted
benfil2p:/fileshare on /fileshare
Oct 24 10:49:11 benadm1p automount[19980]: mounted /fileshare
Oct 24 10:49:36 benadm1p automount[19980]: 1 remaining in /-
Oct 24 10:49:42 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:50:51 benadm1p automount[19980]: 1 remaining in /-
Oct 24 10:50:57 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:52:06 benadm1p automount[19980]: 1 remaining in /-
Oct 24 10:52:12 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:53:21 benadm1p automount[19980]: 1 remaining in /-
Oct 24 10:53:27 benadm1p automount[19980]: 1 remaining in /home
Oct 24 10:54:36 benadm1p automount[19980]: 1 remaining in /-
Oct 24 10:54:42 benadm1p automount[19980]: 1 remaining in /home
---
/etc/auto.master
/-              /etc/auto.hp --ghost
/home     /etc/auto.home --ghost

/etc/auto.hp
/fileshare      -rw,vers=3,tcp,nolock benfil2p,karfil2p:/fileshare

/etc/auto.home
*       -rw,vers=3,tcp,nolock        benfil2p,karfil2p::/home/&

/etc/sysconfig/autofs (with comment and blank lines stripped out)
TIMEOUT=300
BROWSE_MODE="no"
MOUNT_NFS_DEFAULT_PROTOCOL=3
LOGGING="verbose"
USE_MISC_DEVICE="yes"


Thanks in advance

CC

-- 
RHCE#805007969328369
