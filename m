From: raven@themaw.net
Subject: Re: handle_packet_missing called with wrong path
Date: Tue, 24 May 2005 00:33:13 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0505240005230.3469@donald.themaw.net>
References: <17041.64254.30905.109713@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17041.64254.30905.109713@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 23 May 2005, Jeff Moyer wrote:

> Hi, Ian, list,
>
> I have a user reporting a problem with autofs whereby his automounts fail for
> a period of time, and then start to work again.  The map looks like this:
>
> soldyn2 -rsize=8192,wsize=8192  alexandria:/export/soldyn2
> clouds2 -rsize=8192,wsize=8192  alexandria:/export/clouds2
> waves2 -rsize=8192,wsize=8192   alexandria:/export/waves2
> sw1 -rsize=8192,wsize=8192      alexandria:/export/data1
> radar3 -rsize=8192,wsize=8192   alexandria:/export/radar3
> bigmeadow -rsize=8192,wsize=8192        alexandria:/export/bigmeadow
>
> And here is a debug log trace that shows, when the problem occurs, that the
> kernel passes on a missing packet with relative path of radar3/saber:
>
> automount[3488]: handle_packet: type = 0
> automount[3488]: handle_packet_missing: token 250, name radar3/saber
> automount[3488]: attempting to mount entry /data/radar3/saber
> automount[14482]: lookup(yp): looking up radar3/saber
> automount[14482]: ret = 8
> automount[14482]: failed to mount /data/radar3/saber
> automount[14482]: umount_multi: path=/data/radar3/saber incl=1

I wish I new what caused this.
I thought I'd sorted this out long ago but maybe it's a different problem.

This can happen if the lookup doesn't think that, for some reason, radar3 
is a mountpoint during the path walk. It is probably because the subdirs 
list for the radar3 dentry is not empty when it should be. Oddly enough 
this might not be due to directory create and removal. It might be that a 
dentry from a path lookup hasn't been cleaned up for some reason. Quite 
difficult to diagnose.

I would really like to see a log of the debug output from the kernel 
module. Rather a lot of output unfortuneatly.

>
> Then, when things work, the logs look like so:
>
> automount[3488]: handle_packet: type = 0
> automount[3488]: handle_packet_missing: token 251, name radar3
> automount[3488]: attempting to mount entry /data/radar3
> automount[14504]: lookup(yp): looking up radar3
> automount[14504]: ret = 1
> automount[14504]: lookup(yp): radar3 -> -rsize=8192,wsize=8192	alexandria:/export/radar3
> automount[14504]: parse(sun): expanded entry: -rsize=8192,wsize=8192	alexandria:/export/radar3
> automount[14504]: parse(sun): dequote("rsize=8192,wsize=8192") -> rsize=8192,wsize=8192
> automount[14504]: parse(sun): gathered options: intr,,rsize=8192,wsize=8192
> automount[14504]: parse(sun): dequote("alexandria:/export/radar3") -> alexandria:/export/radar3
> automount[14504]: parse(sun): core of entry: options=intr,,rsize=8192,wsize=8192, loc=alexandria:/export/radar3
> automount[14504]: parse(sun): mounting root /data, mountpoint radar3, what alexandria:/export/radar3, fstype nfs, options intr,rsize=8192,wsize=8192
> automount[14504]: mount(nfs):  root=/data name=radar3 what=alexandria:/export/radar3, fstype=nfs, options=intr,rsize=8192,wsize=8192
> automount[14504]: mount(nfs): nfs options="intr,rsize=8192,wsize=8192", nosymlink=0
> automount[14504]: mount(nfs): is_local_mount: alexandria:/export/radar3
> automount[14504]: mount(nfs): from alexandria:/export/radar3 elected alexandria:/export/radar3
> automount[14504]: mount(nfs): calling mkdir_path /data/radar3
> automount[14504]: mount(nfs): calling mount -t nfs -s  -o intr,rsize=8192,wsize=8192 alexandria:/export/radar3 /data/radar3
> kernel: SELinux: initialized (dev 0:19, type nfs), uses genfs_contexts
> automount[14504]: mount(nfs): mounted alexandria:/export/radar3 on /data/radar3
>
> Ian, any ideas on this?  The user was even kind enough to attach a
> reproducer (though I believe it takes a good deal of run-time to trigger
> the problem):
>
> #!/usr/bin/perl
> while (1) {
>   open(IN,"< /data/radar3/saber/SABER_SPECTRA_2002_090_130M.DAT") or print `date` . ": Failed to open\n";
>   close(IN);
>   sleep(70);
> }
>
> The version of the automounter is autofs-4.1.4-8, and the kernel is FC3's
> latest, which is based off of 2.6.11.10, with the addition of the expiry
> race patch.

I can't see how the expiry race patch could cause this but I'll keep it in 
mind when I'm looking.

>
> Here is some additional information from the user that may be useful:
>
>  We automount NFS directories in /data from various NFS servers using NFSv4.
>  It appears that since adding NFSv4 capability (to /etc/exports) to the
>  servers, this is much less reliable.  All machines are up to date FC3.

Interesting. I wonder if/how NFS might affect this.

Ian
