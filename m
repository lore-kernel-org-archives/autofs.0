From: Ian Kent <raven@themaw.net>
Subject: Re: autofs does not umount
Date: Fri, 28 Aug 2009 13:41:40 +0800
Message-ID: <4A976E14.7000301@themaw.net>
References: <20090827222825.GA23043@merfinllc.com>
	<20090827232753.GA26300@merfinllc.com>
	<4A971D47.3050503@themaw.net>
	<20090828001545.GA28811@merfinllc.com>
	<alpine.LFD.2.00.0908281018420.21701@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LFD.2.00.0908281018420.21701@zeus.themaw.net>
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
To: Aaron Straus <aaron@merfinllc.com>
Cc: autofs@linux.kernel.org, viro@zeniv.linux.org.uk

Ian Kent wrote:
> On Thu, 27 Aug 2009, Aaron Straus wrote:
> 
>> Hi,
>>
>> On Aug 28 07:56 AM, Ian Kent wrote:
>>> That commit certainly looks OK, a straight conversion to use struct path.
>>>
>>> How about a debug log from autofs so we can try to find out what bit is
>>> actually going wrong.
>> Sure.
>>
>> This is auto.master:
>> /home	/etc/auto.home
>>
>> This is auto.home:
>> aaron	:/srv/home/aaron
>>
>> This is the syslog with the -d option to automount.  Below you'll see me
>> sending a USR1 signal to the automount process, but the umount not
>> happening.  After this I just umount /home/aaron by hand and then stop
>> automounter...
>>
>> Aug 27 17:11:01 catfish automount[8460]: sig 10 switching from 1 to 3
>> Aug 27 17:11:01 catfish automount[8460]: get_pkt: state 1, next 3
>> Aug 27 17:11:01 catfish automount[8460]: st_prune(): state = 1 
>> Aug 27 17:11:01 catfish automount[8460]: signal_children: send 10 to process group 8460
>> Aug 27 17:11:01 catfish automount[8460]: expire_proc: exp_proc=8469
>> Aug 27 17:11:01 catfish automount[8469]: expire_proc: 1 remaining in /home 
>> Aug 27 17:11:01 catfish automount[8460]: handle_child: got pid 8469, sig 0 (0), stat 1 
>> Aug 27 17:11:01 catfish automount[8460]: sigchld: exp 8469 finished, switching from 3 to 1
> 
> Right, it isn't seeing the mount as expirable.
> 
> It's likely due to a missed case in the conversion to use struct path.
> 
> Could you test with this patch please.
> 
> autofs4 - 2.6.31-rc8 fix
> 
> From: Ian Kent <raven@themaw.net>
> 
> Looks like we missed one case when we converted to use struct path.
> ---
> 
>  fs/autofs4/expire.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index aa39ae8..1294704 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -77,7 +77,7 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
>  	}
>  
>  	/* Update the expiry counter if fs is busy */
> -	if (!may_umount_tree(mnt)) {
> +	if (!may_umount_tree(&path.mnt)) {

My bad, sorry.
I think that really should be path.mnt not &path.mnt.

Ian
