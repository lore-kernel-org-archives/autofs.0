From: Ian Kent <raven@themaw.net>
Subject: Re: wait_for_lock() in mount
Date: Sat, 19 Apr 2008 11:35:46 +0800
Message-ID: <1208576146.3090.5.camel@raven.themaw.net>
References: <3307cdf90804180939t42fed2d7k8fc96304f8d01455@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3307cdf90804180939t42fed2d7k8fc96304f8d01455@mail.gmail.com>
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
To: Rajouri Jammu <rajouri.jammu@gmail.com>
Cc: autofs@linux.kernel.org


On Fri, 2008-04-18 at 09:39 -0700, Rajouri Jammu wrote:
> Hi,
> 
> 
> I'm trying to bring up a stacked file system on top of an NFS mount
> point both via automount.
> 
> 
> For example:
> On my client system I have two directories /data1 and /data2
> /data1/nfs_01
> /data2/nfs_01
> 
> 
> nfs_server:/data/nfs_01 is mounted on /data1/nfs_01 (type nfs)
> 
> 
> /data1/nfs_01 is mounted on /data2/nfs_01
> 
> 
> The automount config files look like:
> /etc/auto.data1:
> nfs_01   nfs_server:/data/nfs_01
> 
> 
> 
> /etc/auto.data2:
> nfs_01   -fstype=ecryptfs :/data1/nfs_01
> 
> 
> 
> 
> The problem:
> 
> 
> When I try to access /data2/nfs_01 it kicks in automount to
> mount /data1/nfs_01, which in turn kicks in automount again to mount
> nfs_server:/data/nfs_01 on /data1/nfs_01.
> 
> 
> The second mount waits for 10secs for a lock file held by the first
> mount in mount_nfs.c after mkdir_path().

So you're running version 4?

> 
> 
> Is there a way I can configure things such that the second mount
> doesn't wait?

There is a patch around to add a configure option
"--disable-mount-locking" but you need to be sure you're mount(8) is at
least reasonably up to date.

You may want to look in
http://www.kernel.org/pub/linux/daemons/autofs/v4/

> 
> 
> 
> The lock file is a single global.
> 
> Should the file be specific to the mount point?

No, it is meant help prevent corruption of /etc/mtab as the locking in
mount(8) was broken for a long time.

Ian
