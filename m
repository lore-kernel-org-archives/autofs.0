From: Ian Kent <raven@themaw.net>
Subject: Re: Seeing autofs-5.0.2 core dumping
Date: Fri, 21 Dec 2007 20:34:16 +0900
Message-ID: <1198236856.3488.11.camel@raven.themaw.net>
References: <20071221023024.GB10904@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20071221023024.GB10904@cornholio.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-12-20 at 18:30 -0800, Mike Marion wrote:
> In the last 2 days we're seeing our autofs 5.0.2 daemon dumping core,
> and it seems to be triggerd by a kill -HUP call to it to make it re-read
> the maps.  Using all LDAP maps (and if HUP isn't needed there, we can
> turn it off) and it only seems to trigger if the daemon has been running
> for a least a few hours, as I can send it numerous HUP signals after
> restarting it and it won't crash.

When it rains it pours.
Second SEGV report today.

> 
> It looks like the HUP is making it try to shut down a subset of the
> paths (and I see this in syslog sometimes without segfaulting too)..
> where it does several entries of:
> 
>  automount[2475]: umounted direct mount <path>
> followed by the same paths in the same order:
>  automount[2475]: rmdir_path: lstat of <path> failed
> and then it core dumps:
> automount[7419]: segfault at 00002aaaac141e08 rip 0000000000410d63 rsp
> 0000000040627030 error 4

There was a bug that caused the direct map to be pruned out of existence
when a server connection failed for some reason. I don't remember seeing
a SEGV although I wasn't paying attention to that when I worked on it.

> 
> Sometimes that happens after 1 of the above failed rmdir_path lines,
> sometimes after most or all.
> 
> gdb shows them all crashing at the same point:
> #0  lookup_prune_cache (ap=0x54ace0, age=1198202622) at lookup.c:1014
> 
> Unfortunately I don't have the exact same patched copy of lookup.c, or
> at least it didn't line up to a line with anything in it (was blank)
> when I ran the build again and then used the file after rpm patched it.
> 
> This has only cropped up in the last few days.. 
> 
> Running SLES9-SP3 hosts with 2.6.16.21-0.8 kernel from sles10 built on
> it (using src.rpm) with autofs5 patch added.  Autofs-5.0.2 with patches 
> as of June of this year (I believe).

I'm not quite sure what that means but this doesn't sound like a kernel
problem so far.

> 
> First possible thing that comes to mind:
> - Are our maps just too big now?  We have huge maps now, a typical
>   /proc/mounts has values like so:
> $ grep ^auto. /proc/mounts  |wc
>    6940   41640  815531
> 
> Yes.. we have almost 7000 mounts in the maps.  Those are all direct
> mounts.  We have > 25,000 mounts in our homedir map, but that's an
> indirect map.

That shouldn't be a problem except that expires and map reads will take
much longer. If there are problems with synchronization I expect you
will see them before most others.

> 
> If one of the newer patches in the last few months might address this,
> I'll be happy to patch up.  

There are a lot of patches, about 62 now.
I need to consolidate and release 5.0.3 but I'm still testing and now
have a couple more bugs.

I would prefer to work from fully patched source if possible.

Ian
