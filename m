From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet
 committed
Date: Fri, 27 Dec 2013 16:50:51 +0800
Message-ID: <1388134251.2623.3.camel@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
	 <CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
	 <1387875881.7351.12.camel@perseus.fritz.box>
	 <CAF1ZMEeUDS8wunF9AHXwQ=xf0OW6_ucmyfQicfbpP7sVavpaSw@mail.gmail.com>
	 <1387881262.7351.15.camel@perseus.fritz.box>
	 <CAF1ZMEcfVTYS=6sfVhSbO8MVaMxcU2v8qV_7O6ACMCRHLxMXeA@mail.gmail.com>
	 <CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=5imNCCOGdM+h/XCDA2IXe0oRKXM=; b=vUo0wEx2EN9+vuKWSmzbzcqJyNHj
	Y86ni0FhWlv0JsgLTDqLj83ULUg7hgYyWj5ufbAJCJzCf0fIxR7GsSC6L/m3pFU+
	ep8Elw1rWR9Aq2SWv/S9rXFmkkcobMJcRckR4eOYGVzhay1wimLaGn3rYwvvyg5L
	YxJMhsSSdXxK5j4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=5imNCCOGdM+h/XCDA2IXe0
	oRKXM=; b=Uxwr6iINJ6Wlm03WXIJhtfIQj+RJNEBCrY3QkSTBRdgdJbBZChtB/s
	3FBr/AGl8V/MPXq/LEI0eWQ7bFrxNN9zg234XCGv9ubhFWvV5fYjmH0MeuCVjl2n
	UcmzdOyqKboCSO81/gcBCmlAij9PrnGWNPNDRFJywiLbSUGDO9fTk=
In-Reply-To: <CAF1ZMEfbrpZ_=GxYTNS-sfus9-QTBD-WCMaZR-ZaEpShPbFdBg@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Fri, 2013-12-27 at 14:36 +0800, Dennis Lan (dlan) wrote:
> Hi Ian
>   I've tested with various USE combinations,  still got segfault err.
> wi all USE="-dmalloc -hesiod -ldap -libtirpc -mount-locking -sasl"
> disabled, with libtirpc en/disabled.
> 
>  Next, I may need a few more time to setup gdb to investigate this..
> 
> also this patch needed to fix compile error while with libtirpc disabled,

Umm .. libtirpc disabled!
That's going to need work I think.

All of what's going on atm. is specifically for libtirpc so let me fix
that and then we can address side effects of the case when libtirpc is
disabled.

> 
> diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
> index aeece1e..a003074 100644
> --- a/lib/rpc_subs.c
> +++ b/lib/rpc_subs.c
> @@ -235,7 +235,8 @@ static int rpc_do_create_client(struct sockaddr
> *addr, struct conn_info *info, i
>         return 0;
>  }
>  static int rpc_getport(struct conn_info *info,
> -                      struct pmap *parms, CLIENT *client)
> +                      struct pmap *parms, CLIENT *client,
> +                                 unsigned short *port)
>  {
> 
> 
> [1] commit 076adfb0718e4b8a15ec11bf62597371ceb92399
> Author: Ian Kent <ikent@redhat.com>
> Date:   Mon Nov 18 12:15:52 2013 +0800
> 
>     autofs-5.0.8 - fix ipv6 libtirpc getport

I'll check this anyway ....

Ian


