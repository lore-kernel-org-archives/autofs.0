From: raven@themaw.net
Subject: Re: Badness in interruptible_sleep_on
Date: Sat, 8 May 2004 01:46:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405080144180.2550@donald.themaw.net>
References: <Pine.LNX.4.58.0405070532500.1979@fogarty.jakma.org>
 <16539.35237.785906.37376@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16539.35237.785906.37376@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Linux autofs <autofs@linux.kernel.org>, Paul Jakma <paul@clubi.ie>

On Fri, 7 May 2004, Jeff Moyer wrote:

> 
> ==> Regarding [autofs] Badness in interruptible_sleep_on; Paul Jakma <paul@clubi.ie> adds:
> 
> paul> Hi, I regularly get the following in my logs: Badness in
> paul> interruptible_sleep_on at kernel/sched.c:1923 Call Trace:
> 
>  [<c0120c9f>] interruptible_sleep_on+0x5a/0x230
>  [<c01205a7>] default_wake_function+0x0/0xc
>  [<d08ea491>] autofs4_wait+0x35d/0x509 [autofs4]
>  [<c01c33dd>] inode_has_perm+0x57/0x5f
>  [<d08e8572>] try_to_fill_dentry+0x39/0x25c [autofs4]
>  [<c0173b4c>] do_lookup+0x54/0x72
>  [<c01740e9>] link_path_walk+0x57f/0xcb1
>  [<c0174b7d>] __user_walk+0x21/0x36
>  [<c016f1ad>] vfs_lstat+0x11/0x37
> 
> You need to update to the latest kernel patches.
>     http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.6/

Caught again. Also a little out of date.

I was working on fixing that last night but have been sidetracked.

I'll reply to this mail when I've done it.

Ian
