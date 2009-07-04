From: Thomas Chan <tchan@ilm.com>
Subject: Re: autofs stops working after a while with USE_MISC_DEVICE
Date: Fri, 3 Jul 2009 21:32:06 -0700 (PDT)
Message-ID: <alpine.LRH.2.00.0907032126150.2710@talon.lucasfilm.com>
References: <alpine.LRH.2.00.0907021136230.2710@talon.lucasfilm.com>
	<4A4D8BC0.2010708@themaw.net>
	<alpine.LRH.2.00.0907022222180.2710@talon.lucasfilm.com>
	<alpine.LFD.2.00.0907041147080.28894@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0907041147080.28894@zeus.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Wolfram Wagner <ww@mpi-inf.mpg.de>


On Sat, 4 Jul 2009, Ian Kent wrote:

> On Thu, 2 Jul 2009, Thomas Chan wrote:
>
>>
>>>> lsof shows that automount has 10288 files open, of which most of these
>>>> are like:
>>>>
>>>> automount 15539      root *217u     sock                0,4 595374 can't
>>>> identify protocol
>>>> automount 15539      root *218u     sock                0,4 595376 can't
>>>> identify protocol
>>>> automount 15539      root *219u     sock                0,4 595378 can't
>>>> identify protocol
>>>> automount 15539      root *220u     sock                0,4 595380 can't
>>>> identify protocol
>>>>
>>>> Upon restarting autofs, these open files are cleared out and automount
>>>> works, but the open files gradually build up again.
>>>>
>>>> After setting USE_MISC_DEVICE=no, I no longer get the open file issue,
>>>> but we are trying to remedy the autofs lazy unmount / cwd issue.
>>>
>>> Mmm .. that's not good.
>>> I'll have a look and see what I can see.
>>>
>>> Ian
>>
>> Sorry about the initial red herring, but it looks like I'm getting the
>> increasing open files even with USE_MISC_DEVICE=no.  I must have previously
>> done a grep for autofs instead of automount.
>>
>> In any case, after a restart of autofs:
>> [root@talon ~]# /etc/init.d/autofs restart
>> Stopping automount:                                        [  OK  ]
>> Starting automount:                                        [  OK  ]
>> [root@talon ~]# lsof |grep automount | grep sock
>> automount   309      root   52u     sock                0,4 3230868911 can't
>> identify protocol
>> automount   309      root   54u     sock                0,4 3230868918 can't
>> identify protocol
>> automount   309      root   55u     sock                0,4 3230868920 can't
>> identify protocol
>> automount   309      root   56u     sock                0,4 3230868922 can't
>> identify protocol
>> automount   309      root   57u     sock                0,4 3230868924 can't
>> identify protocol
>> automount   309      root   59u     sock                0,4 3230868930 can't
>> identify protocol
>> automount   309      root   61u     sock                0,4 3230868937 can't
>> identify protocol
>> automount   309      root   62u     sock                0,4 3230868939 can't
>> identify protocol
>> automount   309      root   63u     sock                0,4 3230868941 can't
>> identify protocol
>> automount   309      root   64u     sock                0,4 3230868943 can't
>> identify protocol
>> automount   309      root   66u     sock                0,4 3230868949 can't
>> identify protocol
>> automount   309      root   68u     sock                0,4 3230868956 can't
>> identify protocol
>> automount   309      root   69u     sock                0,4 3230868958 can't
>> identify protocol
>> automount   309      root   70u     sock                0,4 3230868960 can't
>> identify protocol
>> automount   309      root   71u     sock                0,4 3230868962 can't
>> identify protocol
>> automount   309      root   73u     sock                0,4 3230868968 can't
>> identify protocol
>> automount   309      root   75u     sock                0,4 3230868975 can't
>> identify protocol
>> automount   309      root   76u     sock                0,4 3230868977 can't
>> identify protocol
>> automount   309      root   77u     sock                0,4 3230868979 can't
>> identify protocol
>> automount   309      root   78u     sock                0,4 3230868981 can't
>> identify protocol
>> [root@talon ~]#
>>
>> This gradually increases with every new mount until automount has 10288 files
>> open.
>
> I may have spotted this problem.
> Could you try this patch please.
>
> Ian
>
> autofs-5.0.4 - fix rpc fd leak
>
> From: Ian Kent <raven@themaw.net>
>
> Recent changes which introduced the ability to handle to cope with
> IPv6 addresses causes a file descriptor leak in the RPC library.
> ---
>
> lib/rpc_subs.c |   11 -----------
> 1 files changed, 0 insertions(+), 11 deletions(-)
>
>
> diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
> index d034b29..cafc775 100644
> --- a/lib/rpc_subs.c
> +++ b/lib/rpc_subs.c
> @@ -253,17 +253,6 @@ static CLIENT *rpc_do_create_client(struct sockaddr *addr, struct conn_info *inf
> 		return NULL;
> 	}
>
> -	if (!info->client) {
> -		*fd = open_sock(addr->sa_family, type, proto);
> -		if (*fd < 0)
> -			return NULL;
> -
> -		if (bind(*fd, laddr, slen) < 0) {
> -			close(*fd);
> -			return NULL;
> -		}
> -	}
> -
> 	switch (info->proto->p_proto) {
> 	case IPPROTO_UDP:
> 		if (!info->client) {
>

This looks good so far.  After restarting autofs, I don't see the 
increasing open files any more.

Thomas
