From: raven@themaw.net
Subject: Re: automount 4.1.3: unmount timeout not working
Date: Wed, 26 Jan 2005 22:41:33 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501262240140.1716@donald.themaw.net>
References: <20050122215228.GA14303@tangens.sinus.cz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050122215228.GA14303@tangens.sinus.cz>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Pavel Troller <patrol@sinus.cz>
Cc: autofs@linux.kernel.org

On Sat, 22 Jan 2005, Pavel Troller wrote:

> Hello to all the list members,
>  I decided to write to this list after a lot of time spent by trying to
> find an answer for my question, but I didn't find any so I'm trying the luck
> here.
>  I'm using automount 4.1.3 with kernel 2.6.10, but the problem appeared
> formerly, with 2.6.7, and it's not directly related to the kernel, because it
> didn't appear with a kernel change, but with some other change in my system
> or setup, which I cannot track down.
>  The problem itself is that the autoumount doesn't unmount automatically after
> the timeout expires. Of course the mounted volume is not used anymore. Manual
> umnounting with umount /mnt/volume (by root) works. Forced unmounting by
> sending SIGUSR1 to automount works too.
>  When a verbose/debug mode is used, there is no message indicating that
> a timeout expired. It simply seems that the timeout is not triggered at all.
>
> I'm inserting an excerpt of the system log made by automount in debug mode:
>
> Jan 22 22:26:51 arcus automount[16106]: starting automounter version 4.1.3, path = /mnt, maptype = file, mapname = /etc/autofs/auto.mnt
> Jan 22 22:26:51 arcus automount[16106]: mount(bind): bind_works = 1
> Jan 22 22:26:51 arcus automount[16106]: using kernel protocol version 4.05
> Jan 22 22:26:51 arcus automount[16106]: using timeout 2 seconds; freq 1 secs
> Jan 22 22:26:52 arcus automount[16106]: sig 14 switching from 1 to 2
> Jan 22 22:26:52 arcus automount[16106]: get_pkt: state 1, next 2
> Jan 22 22:26:52 arcus automount[16106]: st_expire(): state = 1
> Jan 22 22:26:52 arcus automount[16106]: expire_proc: exp_proc=16118
> Jan 22 22:26:52 arcus automount[16106]: handle_child: got pid 16118, sig 0 (0), stat 0
> Jan 22 22:26:52 arcus automount[16106]: sigchld: exp 16118 finished, switching from 1 to 1
> Jan 22 22:26:52 arcus automount[16106]: get_pkt: state 2, next 1
> Jan 22 22:26:52 arcus automount[16106]: st_ready(): state = 2
> Jan 22 22:27:10 arcus automount[16106]: handle_packet: type = 0
> Jan 22 22:27:10 arcus automount[16106]: handle_packet_missing: token 24, name udfcd
> Jan 22 22:27:10 arcus automount[16106]: attempting to mount entry /mnt/udfcd
> Jan 22 22:27:10 arcus automount[16146]: lookup(file): udfcd -> -fstype=udf,rw,noatime,gid=32,umask=002^I:/dev/pktcdvd/0
> [Details about parsing map files and output from packet writing driver removed]
> Jan 22 22:27:14 arcus kernel: UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2004/11/15 17:24 (103c)
> Jan 22 22:27:14 arcus automount[16146]: mount(generic): mounted /dev/pktcdvd/0 type udf on /mnt/udfcd
> Jan 22 22:27:14 arcus automount[16106]: handle_child: got pid 16146, sig 0 (0), stat 0
> Jan 22 22:27:14 arcus automount[16106]: sig_child: found pending iop pid 16146: signalled 0 (sig 0), exit status 0
> Jan 22 22:27:14 arcus automount[16106]: send_ready: token=24
>

But you leave out the crucial log trace following the mount?

Can we see more of what follows here please.

Ian
