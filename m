From: raven@themaw.net
Subject: Re: Re: debug failed automount
Date: Sun, 1 May 2005 21:46:41 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505012144150.2824@donald.themaw.net>
References: <11101302050428071921ec8bb7@mail.gmail.com>
	<11101302050429222770e0df9d@mail.gmail.com>
	<Pine.LNX.4.62.0504302318540.2229@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504302318540.2229@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Robert Swan <rswanster@gmail.com>
Cc: autofs@linux.kernel.org

On Sat, 30 Apr 2005 raven@themaw.net wrote:

My response was a bit hasty I think.

> On Sat, 30 Apr 2005, Robert Swan wrote:
>
>> > 
>> >  One point is that the remote host is accessed through a VPN tunnel.
>> 
>>  so as it turns out, this is the problem. The rpc_time call fails (I
>>  assume this is because it is not supported by the VPN) and this marks
>>  my only host as dead and automount does not attempt to mount. Even
>>  though the mount actually works fine.
>
> Why? The rpc_ping connects to port 2049 on the target host.

You may be seeing a bug with the autofs mount code not trying a longer 
timeout if it fails to get a response in time.

The latest RedHat rpms may have the fix? Jeff, Chris?

There's a patch on kernel.org for it as well.

>
>> 
>>  I made myself a little patch to overcome the problem. I think someone
>>  suggested that the rpc_ping stuff should be used to to rank the hosts,
>>  and that mount should try all of them before giving up. Seems like a
>>  good idea.
>
> Mount will only try the hosts that autofs gives it.
>
> We are going full circle. Before there were complaints about mounting taking 
> to long so a heap of work was done on that. Just when that's almost working 
> OK it looks like people are asking for the opposite.
>
> If autofs can't connect to the RPC null procedure on the NFS port of the 
> target host autofs won't ask mount to mount it.
>
> Ian
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
