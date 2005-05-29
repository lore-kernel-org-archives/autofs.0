From: raven@themaw.net
Subject: Re: handle_packet_missing called with wrong path
Date: Sun, 29 May 2005 22:13:14 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505292212030.15718@donald.themaw.net>
References: <17041.64254.30905.109713@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0505240005230.3469@donald.themaw.net>
	<17042.4853.680049.888755@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0505292201560.9745@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0505292201560.9745@donald.themaw.net>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Sun, 29 May 2005 raven@themaw.net wrote:

> On Mon, 23 May 2005, Jeff Moyer wrote:
>
>> ==>  Regarding Re: [autofs] handle_packet_missing called with wrong path; 
>> ==>  raven@themaw.net adds:
>> 
>> raven>  On Mon, 23 May 2005, Jeff Moyer wrote:
>> > >  Hi, Ian, list,
>> > > 
>> > >  I have a user reporting a problem with autofs whereby his automounts
>> > >  fail for a period of time, and then start to work again.  The map 
>> > >  looks
>> > >  like this:
>> > > 
>> > >  soldyn2 -rsize=8192,wsize=8192 alexandria:/export/soldyn2 clouds2
>> > >  -rsize=8192,wsize=8192 alexandria:/export/clouds2 waves2
>> > >  -rsize=8192,wsize=8192 alexandria:/export/waves2 sw1
>> > >  -rsize=8192,wsize=8192 alexandria:/export/data1 radar3
>> > >  -rsize=8192,wsize=8192 alexandria:/export/radar3 bigmeadow
>> > >  -rsize=8192,wsize=8192 alexandria:/export/bigmeadow
>> > > 
>> > >  And here is a debug log trace that shows, when the problem occurs, 
>> > >  that
>> > >  the kernel passes on a missing packet with relative path of
>> > >  radar3/saber:
>> > > 
>> > >  automount[3488]: handle_packet: type = 0 automount[3488]:
>> > >  handle_packet_missing: token 250, name radar3/saber automount[3488]:
>> > >  attempting to mount entry /data/radar3/saber automount[14482]:
>> > >  lookup(yp): looking up radar3/saber automount[14482]: ret = 8
>> > >  automount[14482]: failed to mount /data/radar3/saber automount[14482]:
>> > >  umount_multi: path=/data/radar3/saber incl=1
>> 
>> raven>  I wish I new what caused this.  I thought I'd sorted this out long
>> raven>  ago but maybe it's a different problem.
>> 
>> raven>  This can happen if the lookup doesn't think that, for some reason,
>> raven>  radar3 is a mountpoint during the path walk. It is probably because
>> raven>  the subdirs list for the radar3 dentry is not empty when it should
>> raven>  be. Oddly enough this might not be due to directory create and
>> raven>  removal. It might be that a dentry from a path lookup hasn't been
>> raven>  cleaned up for some reason. Quite difficult to diagnose.
>> 
>
> Found it.
>
> This happens for browsable maps that request a mount at the same time as an 
> expire is happening. My understanding of the lookup was slightly incorrect in 
> that, when the directory exists the revalidate succeeds when it should fail, 
> in order to ensure that lookup is called. Instead lookup is called on the 
> next path component which should be whithin the mount. Unfortuneately, the 
> parent isn't mounted.
>
> This patch seems to fix the problem.
>
> diff -Nurp linux-2.6.12-rc5-mm1.orig/fs/autofs4/root.c 
> linux-2.6.12-rc5-mm1/fs/autofs4/root.c
> --- linux-2.6.12-rc5-mm1.orig/fs/autofs4/root.c	2005-05-29 14:46:30.000000000 
> +0800
> +++ linux-2.6.12-rc5-mm1/fs/autofs4/root.c	2005-05-29 14:47:04.000000000 
> +0800
> @@ -306,7 +306,14 @@ static int try_to_fill_dentry(struct den
>
> 		DPRINTK("expire done status=%d", status);
>
> -		return 0;
> +		/*
> +		 * If the directory still exists the mount request must
> +		 * continue otherwise it can't be followed at the right
> +		 * time during the walk.
> +		 */
> +		status = d_invalidate(dentry);
> +		if (status != -EBUSY)
> +			return 0;
> 	}
>
> 	DPRINTK("dentry=%p %.*s ino=%p",
>
>

Ooops again. That setting on my new version of pine is driving me crazy!

diff -Nurp linux-2.6.12-rc5-mm1.orig/fs/autofs4/root.c linux-2.6.12-rc5-mm1/fs/autofs4/root.c
--- linux-2.6.12-rc5-mm1.orig/fs/autofs4/root.c	2005-05-29 14:46:30.000000000 +0800
+++ linux-2.6.12-rc5-mm1/fs/autofs4/root.c	2005-05-29 14:47:04.000000000 +0800
@@ -306,7 +306,14 @@ static int try_to_fill_dentry(struct den

  		DPRINTK("expire done status=%d", status);

-		return 0;
+		/*
+		 * If the directory still exists the mount request must
+		 * continue otherwise it can't be followed at the right
+		 * time during the walk.
+		 */
+		status = d_invalidate(dentry);
+		if (status != -EBUSY)
+			return 0;
  	}

  	DPRINTK("dentry=%p %.*s ino=%p",
