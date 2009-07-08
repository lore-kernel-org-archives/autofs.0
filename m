From: Ian Kent <raven@themaw.net>
Subject: Re: autofs stops working after a while with USE_MISC_DEVICE
Date: Wed, 08 Jul 2009 09:04:51 +0800
Message-ID: <4A53F0B3.4020603@themaw.net>
References: <alpine.LRH.2.00.0907021136230.2710@talon.lucasfilm.com>
	<4A4D8BC0.2010708@themaw.net>
	<alpine.LRH.2.00.0907022222180.2710@talon.lucasfilm.com>
	<alpine.LFD.2.00.0907041147080.28894@zeus.themaw.net>
	<alpine.LRH.2.00.0907032126150.2710@talon.lucasfilm.com>
	<alpine.LRH.2.00.0907071055370.8827@talon.lucasfilm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.2.00.0907071055370.8827@talon.lucasfilm.com>
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
To: Thomas Chan <tchan@ilm.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Wolfram Wagner <ww@mpi-inf.mpg.de>

Thomas Chan wrote:
> 
>>> I may have spotted this problem.
>>> Could you try this patch please.
>>>
>>> Ian
>>>
>>> autofs-5.0.4 - fix rpc fd leak
>>>
>>> From: Ian Kent <raven@themaw.net>
>>>
>>> Recent changes which introduced the ability to handle to cope with
>>> IPv6 addresses causes a file descriptor leak in the RPC library.
>>> ---
>>>
>>> lib/rpc_subs.c |   11 -----------
>>> 1 files changed, 0 insertions(+), 11 deletions(-)
>>>
>>>
>>> diff --git a/lib/rpc_subs.c b/lib/rpc_subs.c
>>> index d034b29..cafc775 100644
>>> --- a/lib/rpc_subs.c
>>> +++ b/lib/rpc_subs.c
>>> @@ -253,17 +253,6 @@ static CLIENT *rpc_do_create_client(struct
>>> sockaddr *addr, struct conn_info *inf
>>>         return NULL;
>>>     }
>>>
>>> -    if (!info->client) {
>>> -        *fd = open_sock(addr->sa_family, type, proto);
>>> -        if (*fd < 0)
>>> -            return NULL;
>>> -
>>> -        if (bind(*fd, laddr, slen) < 0) {
>>> -            close(*fd);
>>> -            return NULL;
>>> -        }
>>> -    }
>>> -
>>>     switch (info->proto->p_proto) {
>>>     case IPPROTO_UDP:
>>>         if (!info->client) {
>>>
>>
>> This looks good so far.  After restarting autofs, I don't see the
>> increasing open files any more.
>>
>> Thomas
>>
> 
> After a few days of running with this patch, everything looks to still
> be functioning as expected.  Thanks for the speedy fix!

Thanks, I get onto committing the fix.

Ian
