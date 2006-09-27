From: Ian Kent <raven@themaw.net>
Subject: Re: Simple direct mout problem
Date: Wed, 27 Sep 2006 10:33:25 +0800
Message-ID: <1159324405.2897.27.camel@raven.themaw.net>
References: <45196B1C.5040303@onsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45196B1C.5040303@onsemi.com>
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
To: Dana Wellen <dana.wellen@onsemi.com>
Cc: autofs@linux.kernel.org

On Tue, 2006-09-26 at 14:02 -0400, Dana Wellen wrote:
> Hello,
> 
>    Trying to setup a simple direct map using nis and the autofs automounter:
> 
> automount -V
> Linux automount version 4.1.3-67

This version is way to old.
Update it.

> 
> /etc/auto.master
> 
> /-      yp:auto.linux
> 
> 
> ypcat -k auto.linux
> 
> /proj server2:/vol/proj/xx_proj

Nop.
There are an number of limitations with direct mounts in version 4.
Single level direct mounts is one.

> 
> This is documented in the readme file in 
> /usr/share/doc/aufofs-4.1.3/README.direct
> 
> When the autofs is started or restarted in the /var/log/messages I get :
> 
> automount[25461]: cache_ghost: entry in yp:auto.linux not valid map 
> format, key /proj
> 
> If I use indirect mounts it works however direct mounts would be a lot 
> easier for my users in that
> they will be able to see the directories in the mounted directory.  The 
> ghost function doesn't work
> well because it will only show the mounted directories or the 
> directories that have been mounted
> since the last restart of the autofs.

That's not correct.

> 
>   If I copy the file to the /etc directory it still has a similar error.

Huh ????

> 
> 
> aufofs-4.1.3/README.direct
> -- For example if we were using NIS we might have something like
> the map entries below.
> 
> In the master map:
> 
> /-      autofs.global
> 
> and in autofs.global:
> 
> /nfs/apps/mozilla       bogus:/usr/local/moxilla
> /nfs/data/budgets       tiger:/usr/local/budgets
> /tst/sbin               bogus:/usr/sbin
> 
> and so on.

Note that the RedHat package has a config entry that disables direct
mounts by default because of the limitations.

Change it if you wish to try using them (in /etc/sysconfig/autofs).

Ian
