From: Stef Bon <stef@bononline.nl>
Subject: Re: ldap and reloading
Date: Mon, 08 Jun 2009 17:03:46 +0200
Message-ID: <4A2D2852.6090501@bononline.nl>
References: <4A2B7C7B.7060909@bononline.nl>	<4A2C70C2.6060505@themaw.net>	<4A2CD536.8070907@bononline.nl>	<4A2CDADB.6080902@themaw.net>	<4A2CE517.3060207@s3group.cz>
	<4A2D0FB2.6000609@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A2D0FB2.6000609@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> Ondrej Valousek wrote:
>   
>> Talking about ldap maps reloading - maybe it is worth mentioning that if 
>> you configure automounter using the recently added DNS SRV support, 
>> automounter reloads itself as per zone TTL in DNS (that includes the 
>> master map, too) - right Ian?
>> Ondrej
>>
>>     
> Not quite.
>
> On re-load, if the last time we got the list of servers is greater than
> the ttl it will lookup there server list again before attempting to read
> from them. Map entry lookups them selves don't check this ttl so a
> re-load is only done if we think the map has changed.
>   

Well, this is all getting very complicated. Too complicated for me.

The only thing I'm using autofs for is creating a autofs managed 
directory in the homedirectory, for mounting local (USB) and remote (SMB 
shares) resources. To make this work, the autofs daemon has to reread 
the configuration of maps multiple times.

It would be so much easier if there is a sort of autofsctl utility for 
adding/removing mountpoints, and changing maps.

for example:

a. add a mounpoint and map.
b. delete a mountpoint

c. change a map.

Now when something changes, the global remounter gets a reload signal, 
which is still buggy. I'm still having problems here, but since I've 
upgraded the kernel to linux-2.6.29.4 I've got less problems.

Stef
