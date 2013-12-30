From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet committed
Date: Mon, 30 Dec 2013 15:44:57 +0800
Message-ID: <CAF1ZMEcWWeQkE6hVZhVxhd31Lk_6RE5Op7rD1x0TcHdexActxQ@mail.gmail.com>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	<CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	<1387875881.7351.12.camel@perseus.fritz.box>
	<CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	<1387881262.7351.15.camel@perseus.fritz.box>
	<CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
	<CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
	<CAF1ZMEdRhy5LcfEwUW3Os5M8nKXT1j2+M4oqOKgqF3sjLPyWpw@mail.gmail.com>
	<1388317008.26021.9.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=g9kLGfXlcqi6L7WSzLqpKJ80+1IEMSi8JR5XuuUi6hs=;
        b=nRB/qyCgHP96QZ7oGzrueGZjMfbR2jPhMGamZHqsMXflJaquAPyRm+jLrCfoHnMAar
         eRn0c+5MJlRMt720l7MYhNO0dUT0xp8+oPjSTXXGC3/5c22NOnjuCup9oeNHXSafOJxH
         AWEhL0fDzK8geGkCz8o8phywsx6/Pkgtk5EI7rnG0cDJu2EoJTnO6MfpIW+T+ESA3pqu
         YOxde3mXlEa3AoLJkx9m1Uxk/EcxpI+sBPjI4V5kqMZVK0b5nsr+6vDre/IIoGqPmvr2
         FYzGRUuNp3rHu9T+ZCV8UfhXe4s2ZaBVq0ToEQ7qxAu2Ym56fD6hp9lrc9yOfqcH88ll
         z0aA==
In-Reply-To: <1388317008.26021.9.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Sun, Dec 29, 2013 at 7:36 PM, Ian Kent <raven@themaw.net> wrote:
> On Fri, 2013-12-27 at 15:30 +0800, Dennis Lan (dlan) wrote:
>> sorry, I was not accurate about the failure cases.
>>
>> using commit ec267c2c406256e401540e5bc890b2e0c2ff6c35
>>
>> snip from file /etc/autofs/auto.misc
>> mkynfs -ro,soft,intr,nfsvers=3 192.168.90.12:/home/dennis
>> mkydns -ro,soft,intr,nfsvers=4 mickeycn:/home/dennis
>>
>> with libtirpc enabled (all other features disabled),[1]
>> "ls /mnt/misc/mkynfs" lead to automount segfault
>> "ls /mnt/misc/mkydns" automount fail (no crash), but report "no hosts available"
>>
>> with libtirpc disabled (all other features disabled)[2]
>> "ls /mnt/misc/mkynfs" automount fail (no crash), report "no hosts available"
>> "ls /mnt/misc/mkydns" works fine
>
> What exactly does "all other features disabled" mean from a configure
> POV. I always use --disable-mount-locking and --enable-ignore-busy,
> always.
>
  $ /var/tmp/portage/net-fs/autofs-9999/work/autofs-9999/configure
--prefix=/usr --build=x86_64-pc-linux-gnu --host=x86_64-pc-linux-gnu
--mandir=/usr/share/man --infodir=/usr/share/info --datadir=/usr/share
--sysconfdir=/etc --localstatedir=/var/lib --libdir=/usr/lib64
--docdir=/usr/share/doc/autofs-9999 --with-confdir=/etc/conf.d
--with-mapdir=/etc/autofs --with-dmalloc --with-openldap
--with-libtirpc --with-sasl --with-hesiod --disable-mount-locking
--disable-ext-env --enable-sloppy-mount --enable-force-shutdown
--enable-ignore-busy --with-systemd=/usr/lib/systemd/system
RANLIB=/usr/bin/x86_64-pc-linux-gnu-ranlib

 # automount --version

Linux automount version 5.0.8

Directories:
        config dir:     /etc/conf.d
        maps dir:       /etc/autofs
        modules dir:    /usr/lib64/autofs

Compile options:
  DISABLE_MOUNT_LOCKING ENABLE_FORCED_SHUTDOWN ENABLE_IGNORE_BUSY_MOUNTS
  WITH_HESIOD WITH_LDAP WITH_SASL WITH_DMALLOC LIBXML2_WORKAROUND
  WITH_LIBTIRPC

> Maybe that's something to do with the problem your seeing .....
>
> Ian
>
