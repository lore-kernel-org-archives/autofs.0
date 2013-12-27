From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet committed
Date: Fri, 27 Dec 2013 14:36:07 +0800
Message-ID: <CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	<CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	<1387875881.7351.12.camel@perseus.fritz.box>
	<CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	<1387881262.7351.15.camel@perseus.fritz.box>
	<CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+58sE7HLzOhaOWUjyWtCOg5KfeVQiXgiNdkb3cFMAPA=;
        b=iNbnBSIPlIrIs06DBQnYCnD5uzNUnC/e23wp0aUvF5esfKRTXWiFEeHe5HCAkdhE9f
         3Zhs+XYd6ZAPhRITkKQFKcEreniTp/Ul1ioaMVlMJnSt6/Bt79F8v5lNmMCJGNRVPcax
         ATkps6rnJ6qf7EwdZshIPLyI2jECCFgaXejib8qFYn6ckazXgq6tNmizo6BF7JXUIC5h
         3ab9etae3PbD8hKJ6ttrSUODK+YlIcAwh/OTvC9xpyCsWboHcQue+9WRneOemWebX3vI
         6BQHlbG9b5X0gKL+aPC/ybAi8gal90YIZ4YEggc91rqTiJzSEnGs95p9PZ1npKOnBusb
         Od/w==
In-Reply-To: <CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

Hi Ian
  I've tested with various USE combinations,  still got segfault err.
wi all USE="-dmalloc -hesiod -ldap -libtirpc -mount-locking -sasl"
disabled, with libtirpc en/disabled.

 Next, I may need a few more time to setup gdb to investigate this..

also this patch needed to fix compile error while with libtirpc disabled,

diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
index aeece1e..a003074 100644
--- a/lib/rpc_subs.c
+++ b/lib/rpc_subs.c
@@ -235,7 +235,8 @@ static int rpc_do_create_client(struct sockaddr
*addr, struct conn_info *info, i
        return 0;
 }
 static int rpc_getport(struct conn_info *info,
-                      struct pmap *parms, CLIENT *client)
+                      struct pmap *parms, CLIENT *client,
+                                 unsigned short *port)
 {


[1] commit 076adfb0718e4b8a15ec11bf62597371ceb92399
Author: Ian Kent <ikent@redhat.com>
Date:   Mon Nov 18 12:15:52 2013 +0800

    autofs-5.0.8 - fix ipv6 libtirpc getport
