From: Ian Kent <raven@themaw.net>
Subject: Re: statfs() and autofs
Date: Wed, 16 Jul 2008 11:43:12 +0800
Message-ID: <1216179794.22783.46.camel@raven.themaw.net>
References: <20080715204839.GU5858@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080715204839.GU5858@pixar.com>
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
To: Chris Walker <cwalker@pixar.com>
Cc: autofs@linux.kernel.org


On Tue, 2008-07-15 at 13:48 -0700, Chris Walker wrote:
> autofs 5.0.3
> linux 2.6.18
> 
> When statfs() is called on an automounted directory, it returns before
> the automount occurs. This results in output like this initially:

That may be because there are a group of system calls that don't trigger
a mount because we have to avoid mount storms for map entries that use
the browse option. In particular stat(2) and calls that use the same
kernel path lookup flags, such as statfs(2).

Basically, if the mount point directory exists in the autofs file system
but doesn't currently have a mount for some reason (perhaps it wasn't
removed at expire or the entry uses the browse option), these calls will
return the attributes of the autofs directory without performing a
mount.

> 
> % df /home/XXX
> Filesystem           1K-blocks      Used Available Use% Mounted on
> -                            0         0         0   -  /home
> 
> If df is run a second later,
> 
> % df /home/XXX
> Filesystem           1K-blocks      Used Available Use% Mounted on
> XXX:/home/XXX
>                       80634688  77952736   2681952  97% /home/XXX
> 
> Perhaps there are options of which I'm not aware to mitigate this
> behavior.
> 
> Apologies if the answer to my query lies elsewhere in the kernel.
> 
