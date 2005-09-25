From: Ian Kent <raven@themaw.net>
Subject: Re: nfs bindresvport: Address already in use
Date: Sun, 25 Sep 2005 08:47:37 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0509250837580.2070@donald.themaw.net>
References: <FB7BDBB2C6034E44B36CFDCF09256BCF029E982C@NYCPEXV003.na.blkint.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <FB7BDBB2C6034E44B36CFDCF09256BCF029E982C@NYCPEXV003.na.blkint.com>
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
To: "Breitman, Jason" <Jason.Breitman@blackrock.com>
Cc: autofs@linux.kernel.org

On Thu, 22 Sep 2005, Breitman, Jason wrote:

> rpm -q autofs
> autofs-4.1.3-131
> 
> uname -r
> 2.6.9-5.Elsmp
> 
> /etc/auto.master
> /usr/local              program:/usr/bin/autofs_local   --timeout=3600
> --debug
> 
> /var/log/messages
> Sep 22 09:41:18 bbc003 automount[4774]: >> nfs bindresvport: Address
> already in use
> Sep 22 09:41:18 bbc003 automount[4774]: mount(nfs): nfs: mount failure
> nfs:/clients/local/data on /usr/local/data
> Sep 22 09:41:18 bbc003 automount[4774]: failed to mount /usr/local/data
>

As Ryan says, mounting a good number of mounts quickly will cause a 
reserved port exhaustion. How bad the problem is depends partly on the 
patches applied to the version of mount in you distribution.

The other way that this can arise is if you are not returning a 
multi-mount entry in the right order from autofs_local. The order is 
important due to possible nesting of mounts.

The reserved port exhaustion problem lies in the RPC kernel subsystem.
It's quite a difficult problem to solve.

> Configured Mount Points:
> ------------------------
> /usr/sbin/automount --timeout=3600 --debug /usr/local program
> /usr/bin/autofs_local 
> 
> Active Mount Points:
> --------------------
> /usr/sbin/automount --timeout=3600 --debug /usr/local program
> /usr/bin/autofs_local
> 
> ps -ef | grep automount
> root      2175     1  0 09:38 ?        00:00:00 /usr/sbin/automount
> --timeout=3600 --debug /usr/local program /usr/bin/autofs_local
> 
> 
> Problem
> Automount fails to mount directories and application fail to run.
> 
> Bugzilla ID That appears to be similar
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128966
> 
> Jason Breitman
> jason.breitman@blackrock.com
> 
> 
> THE INFORMATION CONTAINED IN THIS MESSAGE AND ANY ATTACHMENT MAY BE PRIVILEGED, CONFIDENTIAL, PROPRIETARY OR OTHERWISE PROTECTED FROM DISCLOSURE. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution, copying or use of this message and any attachment is strictly prohibited. If you have received this message in error, please notify us immediately by replying to the message and permanently delete it from your computer and destroy any printout thereof.
