From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: more than 1024 mounts ==>hangs
Date: Fri, 05 Dec 2008 11:06:34 -0500
Message-ID: <x493ah261yt.fsf@segfault.boston.devel.redhat.com>
References: <4937D794.6040908@itwm.fraunhofer.de>
	<1228403765.3038.118.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1228403765.3038.118.camel@zeus.themaw.net> (Ian Kent's message
	of "Fri, 05 Dec 2008 00:16:05 +0900")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent <raven@themaw.net> writes:

> On Thu, 2008-12-04 at 14:13 +0100, Martin Vogt wrote:
>> 
>> Hello list,
>> 
>> I'm currently experimenting with autofs on SuSE 11.1 rc1
>> 
>> -autofs-5.0.3-82.19
>
> I don't know what this means in terms of patches applied, but ok.
>
>> 
>> Around the 1024th mount, autofs hangs and the machine needs a reboot -f.
>> 
>> I have here >2000 mount points which usually look like this:
>> 
>> /homes/vogt0001 --fstype=bind :/net/fsA/home/user/vogt0001
>> /homes/vogt0002 --fstype=bind :/net/fsB/home/user/vogt0002
>> [..]
>> /homes/vogt2000 --fstype=bind :/net/fsC/home/user/vogt2000
>
> So a direct map?
> With many active real mounts, is that what you're saying?
>
>> 
>> 
>> Further debugging revealed:
>> 
>> pxe1:/home/demo1 # lsof -p <automount pid>
>> [...]
>> automount 5111 root 1022r   DIR  0,228        0  13029 /u/itwm/hinojosa
>> automount 5111 root 1023r   DIR  0,561        0  13362 /u/itwm/andrejs
>> automount 5111 root 1024r  FIFO    0,7      0t0  26910 pipe
>> 
>> The 1024 really looks like some limit, which is hit by the automount
>> process.
>
> Quite possibly, but I don't think there is anything autofs can do about
> it since in autofs we see:
> ...
> #define MAX_OPEN_FILES          10240
> ...
> 	rlim.rlim_cur = MAX_OPEN_FILES;
>         rlim.rlim_max = MAX_OPEN_FILES;
>         res = setrlimit(RLIMIT_NOFILE, &rlim);
>         if (res)
>                 warn(logging,
>                      "can't increase open file limit - continuing");
>
> Unless I've not got this correct in some way the open file limit should
> be much higher. But there are ways the OS configuration can limit this.

I'm pretty sure root processes bypass the max open fds check.

[snip]

>> Ah, the behavoir by autofs is:
>> 
>> - It hangs on duing a mount operation:
>> 
>> root      5111  0.0  0.1  97200  2936 pts/0    Sl+  13:30   0:01
>> /usr/sbin/automount -d -f -t 600 -p /var/run/automount.pid -O ro
>> root      9541  0.0  0.0      0     0 pts/0    Z+   13:31   0:00 [mount]
>> <defunct>
>
> So maybe mount(8) and its relatives are the problem, not sure I can do
> much about that either.

Yeah, strange.  Can we figure out what the mount commandline was for
this zombie?

-Jeff
