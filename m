From: Stef Bon <sbon@bononline.nl>
Subject: Re: Looking for a per user submount...
Date: Tue, 29 Jan 2008 16:26:59 +0100
Message-ID: <479F45C3.8000800@bononline.nl>
References: <20080128101153.GE5803@mithrandir>	<1201570926.3072.17.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1201570926.3072.17.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org

Ian Kent wrote:
> On Mon, 2008-01-28 at 11:11 +0100, Francesco P. Lovergine wrote:
>   
>> I was looking for some sort of automounting for per-user subtrees.
>> Essentially I need to bind-mount on demand some per user (users are sql-based)
>> subdir like /path/<user>/mount_point, where /path/<user> is a true dir. 
>> I'm missing something or it cannot be performed using autofs without
>> adding each entry explicitly for every users ?
>>     
>
> Try something like.
>
> In the master map:
> /topdir		/etc/auto.users
>
> In auto.users:
> *	:/path/&
>
> Clearly, the automount entries for future mounts aren't known until they
> are triggered, so they can't be seen no matter what options you use.
>
> Ian
>   
I've been working on a construction to achieve mounts on a per-user basis.
It's based on a few things:

- a tree in the homedirectory of the logged in user, representing the
Windows network. The shares are
symlinks pointing to the automount path: /mnt/autofs/network/:

/home/sbon/Global Network/Windows Network/BONONLINE/LFS20060812/public ->

    /mnt/autofs/network/smb:%%u_sbon@LFS20060812@BONONLINE%public


Now this autofs directory/key (/smb::%%u_sbon@LFS20060812@BONONLINE%public)
does have all the information in it necessary to do a cifs mount.
I can do this because the automounter does not understand the smb
protocol. It just passes the parameters
to the mount program.

Earlier I've been working with a construction where the automounter had
to be started for every user. This new construction does not need this.

Futher this Windows Network representation is build by scripts which
discover the network periodically.

- my auto file looks like:

* -fstype=network :/&

Very short and simple!
Earlier I've been working with submounts ( Ian do you remember this?)

Look at the filesystem network. It does not exist, but I've created a
mount.network wrapper:

- a mount.network wrapper. It's just possible to use this wrapper in
stead of a "normal" filesystem!!
This wrapper does find all the information necessay out of the key
(/smb::%%u_user@HOST@WORKGROUP%share)  to call the real mounter mount.cifs!

The automounter is started at boottime with a rc script.
There is only one point which is difficult: for which users the network
representation has to be build.
Any advice appreciated. I'm using a special module in PAM for that
purpose right now, but maybe
there are other ways to do this.

My most recent howto is on:

http://linux.bononline.nl/linux/automountsmbshares/automountsmbshares-page01a.php

An older version is available at:

http://www.howtoforge.com/automatic_discovery_mounting_smb_networkshares

This latest version I will update as soon as I'm ready with the
documentation on my own website.

This construction is working very good. Try it. If you need any help you
can contact me.

Stef Bon




>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
>   
