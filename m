From: Ian Kent <raven@themaw.net>
Subject: Re: [BUG] 5.0.0_beta1: does not auto-unmount
Date: Wed, 26 Sep 2007 23:26:47 +0800
Message-ID: <1190820407.12109.23.camel@raven.themaw.net>
References: <200709261123.41401.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709261123.41401.vda.linux@googlemail.com>
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
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-09-26 at 11:23 +0100, Denys Vlasenko wrote:
> Hi Ian,
> 
> I run automount like this:
> 
> # automount -f -s -v --timeout 15 /.local/var/service/automount/master.file
> 
> My master.file is one-liner:
> 
> /mnt/auto program:/.local/var/service/automount/mapper.sh
> 
> mapper.sh is attached.
> 
> This setup (with this exact mapper.sh) worked flawlessly
> with 4.1.4, but with 5.0.0_beta1 I have a problem:
> 
> # automount -f -s -v --timeout 15 /.local/var/service/automount/master
> Starting automounter version 5.0.0_beta1, master map /.local/var/service/automount/master
> using kernel protocol version 5.00
> using timeout 15 seconds; freq 4 secs
> 
> I do "cd /mnt/auto/vfat.sdb1" (sdb1 is my USB memory stick)
> and automount says:
> 
> attempting to mount entry /.local/mnt/auto/vfat.sdb1
> mounted /mnt/auto/vfat.sdb1
> 
> So far so good, mount shows:
> /dev/sdb1 on /mnt/auto/vfat.sdb1 type vfat (rw,nosuid,noexec,fmask=0000,dmask=0000,codepage=cp866,iocharset=koi8-r,shortname=win95,quiet,uni_xlate)
> 
> But it never auto-unmounts. I am 100% sure nothing
> is keeping files or directories busy on /dev/sdb1 (I cd'ed away
> from the directory). Automount is not saying anything,
> strace -p <PID> shows one line:

Strange, I'll try and duplicate this and see how far I get.
If you do want to make sure nothing is asking it to remount enable debug
and ensure facility daemon.* is being logged. If there are accesses
keeping it open the requesting pid will be logged.

> 
> rt_sigtimedwait(~[CHLD CONT RTMIN RT_1],
> 
> I killed 4 hours of my time making automount 5.0.0 even start on my machine,
> and it's 4:00 am here, so at this time I am a rather unhappy panda and
> probably I'll go back to 4.1.4 instead of chasing down yet another bug.

Ya but I'm getting there.
The change is huge to be sure, and many things do work well.

> 
> # size autofs*/sbin/*
>    text    data     bss     dec     hex filename
>   35143     916   10084   46143    b43f autofs-4.1.4_beta1/sbin/automount
>  118494    1344     884  120722   1d792 autofs-5.0.0_beta1/sbin/automount
> 
> During 4.1.4 -> 5.0.0 size has *tripled*. Uncool. :(

Not sure what I can do about that, sorry.
