From: Ian Kent <raven@themaw.net>
Subject: Re: Badness in interruptible_sleep_on
Date: Fri, 7 May 2004 14:42:37 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405071426500.11299@wombat.indigo.net.au>
References: <Pine.LNX.4.58.0405070532500.1979@fogarty.jakma.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405070532500.1979@fogarty.jakma.org>
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
To: Paul Jakma <paul@clubi.ie>
Cc: Linux autofs <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>


Not sure what needs to be done about this Paul.

I eliminated the interruptible_sleep_on in my autofs4 patches long ago. 
The current updates are in 2.6.6-rc3-mm2.

As for autofs4 and 2.4 I have the impression that my changes have little 
chance of being accepted and so haven't put the needed effort into 
preparing them.

However, if you are looking to use the current patches please wait a 
couple of days for the latest update.

On Fri, 7 May 2004, Paul Jakma wrote:

> Hi,
> 
> I regularly get the following in my logs:
> Badness in interruptible_sleep_on at kernel/sched.c:1923
> Call Trace:
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
> regards,
> -- 
> Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
> 	warning: do not ever send email to spam@dishone.st
> Fortune:
> Interchangeable parts won't.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
