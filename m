From: Ian Kent <raven@themaw.net>
Subject: Re: direct map limitations
Date: Mon, 19 Jan 2004 08:30:39 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0401190826350.27279-100000@wombat.indigo.net.au>
References: <C28780ABC637504896EB86B4FB75FFBF455461@MAANDMBX1.ets.enterasys.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C28780ABC637504896EB86B4FB75FFBF455461@MAANDMBX1.ets.enterasys.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Bahi, David" <dbahi@enterasys.com>
Cc: autofs@linux.kernel.org

On Sat, 17 Jan 2004, Bahi, David wrote:

> is it not possible to use direct mounts on / with
>
> /etc/auto.master:
>
>   /- /etc/auto.direct
>
> /etc/auto.direct:
>
>   /only host:/some/path/of/interest
>
> and with a running kernel that has
>
>
> http://kernel.org/pub/linux/daemons/autofs/v4/autofs4-2.4-module-2003120
> 1.tar.bz2
>
> applied to 2.4.24
> (messy as it is -
> cleaner patch attached -
> please check root.c in particular)
>
> and with an rpmbuild --rebuild of
>
>   http://kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.0-2.src.rpm
>
> on boot/startup of the autofs daemon (alias autofs autofs4 in
> modules.conf)
>
> /var/log/messages:
>
>   cache_ghost: entry in file:/etc/auto.direct not valid map format, key
> /only
>
> and of course 'ls /only' No such file or directory....

This is a limitation of the implementation.
It has been done this way largely because of the limit in the kernel on
the maximum number of anonymous mounts.

>
> looking at lib/cache.c it seems the logic is inverted so that the daemon
> must find a /dir/ pattern so the automount daemon can 'watch over'
> '/dir'
> when a direct daemon needs to be able to listen over '/' too, no?
>
> thanks for any feedback
>
> db
>
> ps i was going to try this - but figured it would just fail miserably

Yes. This will not work.

Sorry you'll have to wait for a new implementation.
I have no idea of when that may be.

Ian
