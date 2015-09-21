From: Ning Yu <ning.yu@canonical.com>
Subject: Re: [PATCH v5 8/8] autofs-5.1.1 - remove unused function elapsed()
Date: Mon, 21 Sep 2015 13:25:58 +0800
Message-ID: <CAA1QoHSmAeB34Xb7Q5HXx5+usu56fQ6J51ewHngkckxEXf=PmQ@mail.gmail.com>
References: <20150918092704.29311.84246.stgit@pluto.fritz.box> <20150918093516.29311.58158.stgit@pluto.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20150918093516.29311.58158.stgit@pluto.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Yu Ning <ning.yu@ubuntu.com>, autofs mailing list <autofs@vger.kernel.org>

On Fri, Sep 18, 2015 at 5:35 PM, Ian Kent <raven@themaw.net> wrote:
> Now that the monotonic clock source is used the elapsed() function
> is no longer used, remove it.
>
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  lib/rpc_subs.c |    8 --------
>  1 file changed, 8 deletions(-)

Oh, I think we also need to remove the declaration of elapsed() in
include/rpc_subs.h

>
> diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
> index 2364744..3d99f56 100644
> --- a/lib/rpc_subs.c
> +++ b/lib/rpc_subs.c
> @@ -1078,14 +1078,6 @@ int rpc_ping(const char *host, long seconds, long micros, unsigned int option)
>         return status;
>  }
>
> -double elapsed(struct timeval start, struct timeval end)
> -{
> -       double t1, t2;
> -       t1 =  (double)start.tv_sec + (double)start.tv_usec/(1000*1000);
> -       t2 =  (double)end.tv_sec + (double)end.tv_usec/(1000*1000);
> -       return t2-t1;
> -}
> -
>  double monotonic_elapsed(struct timespec start, struct timespec end)
>  {
>         double t1, t2;
>
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
