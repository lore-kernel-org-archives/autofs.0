From: "Cyril B." <cbay@excellency.fr>
Subject: automount subprocesses accumulate
Date: Thu, 10 Sep 2015 16:43:39 +0200
Message-ID: <55F1971B.1050301@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:From:Date:Message-ID; bh=ulbad726059xzuo0M7eU9PT5XOxGVhQlPGFon/MRQcw=;
	b=mgRoZZhUyAoFIa8iuz8DK7p/jxuKm0tjCA9mv3j9B64r4LFitHL6A6M8VK+853qOaAaO5xSwVTcBRH72GKqQHC3FvBOGvITWAdN3+J5+srigiptO5xoR07lDW61jna+YSj2B4NTlhEUemlhKcRhvsfbSDHbZrMrBN4W7AyJxWkP5vbRHB1vYsHhHh9dEBMWOWWn8EFsyzxBgAAApC2HdHFG6mQDfrLsw/kc0ZtOZ5QxC3PsgbW9jE3O91p+FtYEDurBdbKlq0K9iOKwXhvmKwFD2WwSCd7yi6y44RGTUM/InlPbffX8qu8Otvs7H4VUkieW43cYKLvZ6e38YwdyWug==;
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@vger.kernel.org

Hello,

I've been using autofs for a long time to mount NFS servers under /nfs, 
and recently started using it for mounting /home subdirectories as well 
(which point on /nfs/).

Since I've started automounting /home, I have automount subprocesses 
accumulating and never exiting:

root 1761264 0.0 0.0 205416 1478 ? Ssl 14:06 0:00 /usr/sbin/automount 
--pid-file /var/run/autofs.pid
root 1966587 0.0 0.0 209816 1564 ? S 14:45 0:00 \_ /usr/sbin/automount 
--pid-file /var/run/autofs.pid
root 2023507 0.0 0.0 209816 1652 ? S 15:00 0:00 \_ /usr/sbin/automount 
--pid-file /var/run/autofs.pid
root 2203212 0.0 0.0 215100 1900 ? S 15:45 0:00 \_ /usr/sbin/automount 
--pid-file /var/run/autofs.pid

My main automount was started at 14:06, and all subprocesses are stuck in a:

futex(0x56122035a5a0, FUTEX_WAIT_PRIVATE, 2, NULL

(same futex address for all of them).

There are typically a few new subprocesses each hour. I've already seen 
up to 20/25 subprocesses before I had to restart automount and kill them 
manually.

I have a lot of users on this server, so automount is serving many 
requests. Especially at round times (14:00, 14:15, 14:30, etc.), when 
cron starts many user processes. According to automount debug logs, up 
to 20 new home subdirectories can be mounted every second.

I'm using autofs 5.1.1 on Linux 4.1.4. My config:

/etc/auto.master:
--
/nfs program:/etc/auto.nfs
/home program:/etc/auto.home
--

/etc/auto.nfs is pretty standard, has been working fine for ages. It's 
basically returning:

-fstype=nfs4,noatime,nosuid,_netdev,soft,intr,timeo=1000 $1:/

/etc/auto.home:
--
#!/bin/sh

if [ ! -h /var/home/$1 ]
then
   exit 1
fi

echo -fstype=bind :$(readlink --no-newline /var/home/$1)
--

So for instance, /var/home/foo would be a symlink pointing to 
/nfs/serverX/foo.

autofs is compiled with --disable-mount-locking as recursive mounting 
wouldn't work otherwise.

Thanks!

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
