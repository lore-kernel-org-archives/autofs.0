From: Arun Sharma <arun.sharma@intel.com>
Subject: Re: [NFS] VFS: Busy inodes after unmount on 2 way SMP
Date: Mon, 15 Sep 2003 14:42:30 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F663246.7010806@intel.com>
References: <Pine.LNX.4.44.0309122013380.9830-100000@moisil.badula.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309122013380.9830-100000@moisil.badula.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ion Badulescu <lists@cs.columbia.edu>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

Ion Badulescu wrote:
> On Fri, 12 Sep 2003, Arun Sharma wrote:
> 
> 
>>Ion Badulescu wrote:
>>
>>>I don't know if it's the same issue, but I've seen it many many times 
>>>while testing amd's autofs functionality. It occurs when a non-empty 
>>>autofs filesystem is unmounted, e.g. if it has some leftover 
>>>subdirectories from previous mounts. Therefore I'd say it's quite 
>>>clearly an autofs issue, at least in my case.
>>
>>Do you have a case that can deterministically reproduce the issue ? 
> 
> 
> Oh yeah, easily. Kill the automounter while some things are mounted,
> unmount everything by hand but do not rmdir the mountpoints. When you
> unmount the autofs filesystem itself, you will get the self destruct
> message.
> 

Thanks. This reproduces the problem I'm chasing very well. I think this is clearly an unacceptable kernel bug.

	-Arun

Sep 15 13:58:57 arun-desktop kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...

<snip>

Sep 15 14:00:00 arun-desktop kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Sep 15 14:00:00 arun-desktop kernel:  printing eip:
Sep 15 14:00:00 arun-desktop kernel: c015c738
Sep 15 14:00:00 arun-desktop kernel: *pde = 00000000
Sep 15 14:00:00 arun-desktop kernel: Oops: 0000
Sep 15 14:00:00 arun-desktop kernel: ide-cd cdrom emu10k1 ac97_codec sound soundcore nfs lockd sunrpc parport_pc lp parport autofs iptable_filter ip_tables
e100 keybdev mousedev hid input usb-uhc
Sep 15 14:00:00 arun-desktop kernel: CPU:    0
Sep 15 14:00:00 arun-desktop kernel: EIP:    0060:[<c015c738>]    Not tainted
Sep 15 14:00:00 arun-desktop kernel: EFLAGS: 00010246
Sep 15 14:00:00 arun-desktop kernel:
Sep 15 14:00:00 arun-desktop kernel: EIP is at destroy_inode [kernel] 0x28 (2.4.20-8)
Sep 15 14:00:00 arun-desktop kernel: eax: 00000000   ebx: cee44c80   ecx: 00000000   edx: cee44c80
Sep 15 14:00:00 arun-desktop kernel: esi: cb32ee00   edi: cee44c80   ebp: 000003c6   esp: cff87f84
Sep 15 14:00:01 arun-desktop kernel: ds: 0068   es: 0068   ss: 0068
Sep 15 14:00:01 arun-desktop kernel: Process kswapd (pid: 5, stackpage=cff87000)
Sep 15 14:00:01 arun-desktop kernel: Stack: cee44c80 cb32ee00 cb32ee18 c015b563 cee44c80 cb0ff180 cff86000 00000000
Sep 15 14:00:01 arun-desktop kernel:        000001d0 00000000 c015b904 0000057c c013cd5b 00000006 000001d0 cff86000
Sep 15 14:00:01 arun-desktop kernel:        cff86000 00000000 cff86305 00000000 c013d023 000001d0 00000002 000001d0
Sep 15 14:00:01 arun-desktop kernel: Call Trace:   [<c015b563>] prune_dcache [kernel] 0xc3 (0xcff87f90))
Sep 15 14:00:01 arun-desktop kernel: [<c015b904>] shrink_dcache_memory [kernel] 0x24 (0xcff87fac))
Sep 15 14:00:01 arun-desktop kernel: [<c013cd5b>] do_try_to_free_pages_kswapd [kernel] 0x1b (0xcff87fb4))
Sep 15 14:00:01 arun-desktop kernel: [<c013d023>] kswapd [kernel] 0x83 (0xcff87fd4))
Sep 15 14:00:01 arun-desktop kernel: [<c013cfa0>] kswapd [kernel] 0x0 (0xcff87fe4))
Sep 15 14:00:01 arun-desktop kernel: [<c010742d>] kernel_thread_helper [kernel] 0x5 (0xcff87ff0))
