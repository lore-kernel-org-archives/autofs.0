From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
 5} and bind mounts which point to other automount points
Date: Fri, 25 Aug 2006 09:29:51 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608250926270.6382@raven.themaw.net>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
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
To: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Cc: autofs@linux.kernel.org

On Thu, 24 Aug 2006, Matt Bernstein wrote:

> Hi,
> 
> We like to preconfigure an number of our (1000ish) users' applications. 
> Typically, this might necessitate hard-coding their home directories in 
> dot-files, so we specify their home directory in the passwd map as 
> /homes/$LOGNAME, and make this an (LDAP) automount map which might point 
> to ":/server/{servername}/{volumename}/$LOGNAME" (via a bind mount), where 
> /server/{servername}/{volumename} would be the "real" NFS mount.
> 
> This allows us to move the physical location of any user's home directory 
> without upsetting their application settings. (Some applications seem to 
> prefer using full paths.)
> 
> Our scheme all worked fine in autofs 3.
> 
> In autofs 4, it worked but with a 10 or 15s delay which we got around via 
> the following patch:
> 
> --- modules/mount_bind.c.orig   2004-10-29 14:46:11.000000000 +0100
> +++ modules/mount_bind.c        2004-11-01 12:49:54.000000000 +0000
> @@ -126,7 +126,10 @@
>                  }
> 
>                  debug(MODPREFIX "calling mount --bind %s %s", what, fullpath);
> -
> +/* 'what' may itself be on an automounted file system so we need to access it */
> +/* to ensure it gets mounted before calling wait_for_lock() inorder to avoid a*/
> +/* long delay */
> +               (void)access(what,F_OK);

That can lead to corruption of /etc/mtab.
That's why the lock was introduced.

In v5 the locking can be disabled as most people have updated mount(8) 
these days.

>                  wait_for_lock();
>                  err = spawnl(LOG_NOTICE, MOUNTED_LOCK,
>                               PATH_MOUNT, PATH_MOUNT, "--bind",
> 
> 
> In autofs 5, it doesn't work at all, claiming no hostname was supplied. Is 
> there any way we can achieve what we want? I can't find any documentation.

Someone else has reported that bind mounts aren't working with v5.
It would be good to resolve this but I need more info.
A debug log would be best.

Ian
