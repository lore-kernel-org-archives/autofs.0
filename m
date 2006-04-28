From: Ian Kent <raven@themaw.net>
Subject: Re: automount lock
Date: Fri, 28 Apr 2006 10:25:06 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0604281018580.2678@raven.themaw.net>
References: <20060427144018.GA14670@obs.unige.ch>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060427144018.GA14670@obs.unige.ch>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cedric BRINER <work@infomaniak.ch>
Cc: autofs@linux.kernel.org

On Thu, 27 Apr 2006, Cedric BRINER wrote:

> Debian/Sarge i386
> hi,
> 
> I'm having some problems with autofs.
> 1) is this map entry allowed for auto.master ?
>   /home/epfl auto_home_vaud
>   /home/vaud auto_home_vaud
> 
> 2) I'm getting in this situtation
> ps -efH
>   ...
>   root      6947     1  0 Feb13 ?        00:00:01   /usr/sbin/automount --pid-file=/var/run/autofs/_home_vaud.pid --timeout=300 --ghost /home/vaud yp auto_home_vaud
>   root     32357  6947  0 09:44 ?        00:00:00     /usr/sbin/automount --pid-file=/var/run/autofs/_home_vaud.pid --timeout=300 --ghost /home/vaud yp auto_home_vaud
>   root     32359 32357  0 09:44 ?        00:00:00       [mount] <defunct>
>   root     15406  6947  0 11:29 ?        00:00:00     /usr/sbin/automount --pid-file=/var/run/autofs/_home_vaud.pid --timeout=300 --ghost /home/vaud yp auto_home_vaud
>   ...
> 
> more /var/lock/autofs
> 32357

I see, a stale lock file.
There have been some issues with the locking code.

I don't know the status of the version you are running but there are two 
alternatives you can investigate.

Ensure that mount is patched to perform mtab locking correctly and 
disable locking using a configure option after apply the patch (the patch 
has an example of changes needed for mount):

http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-configureable-locking.patch 

or

Apply the patch

http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-locking-fix-1.patch

and see if it helps.

> 
> is this normal to have more than one automount process by auto.master entry ?

Yep.

> 
> 
> and now when I try to launch an other automount
> /usr/sbin/automount -v --debug --pid-file=/var/run/autofs/_unige.pid --timeout=300 --ghost /unige yp auto_unige_linux
> 
> tail /var/log/daemon.log
> Apr 27 16:35:05 obsdw19 automount[5500]: aquire_lock: can't lock lock file timed out: /var/lock/autofs
> Apr 27 16:35:05 obsdw19 automount[5500]: failed to mount autofs path /unige
> Apr 27 16:35:05 obsdw19 automount[5500]: /unige: mount failed!
> Apr 27 16:35:05 obsdw19 automount[5500]: failed to remove dir /unige: No such file or directory
> Apr 27 16:35:09 obsdw19 automount[5598]: starting automounter version 4.1.4_beta2, path = /unige, maptype = yp, mapname = auto_unige_linux
> Apr 27 16:35:09 obsdw19 automount[5598]: mount(bind): bind_works = 1
> 
> the fact is that /home/vaud is the home directory for the user on this machine. So how can I restart the autofs without asking the user to logoff ?
> 
> Ced.
> 
> -- 
> 
> Cedric BRINER
> Geneva - Switzerland
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
