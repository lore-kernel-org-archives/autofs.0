From: raven@themaw.net
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Sun, 6 Jun 2004 11:13:06 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406061111350.2275@donald.themaw.net>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
 <16576.51269.311121.121046@segfault.boston.redhat.com>
 <16576.60526.394177.533027@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0406051327020.12824@donald.themaw.net>
 <16578.35042.873671.838640@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16578.35042.873671.838640@segfault.boston.redhat.com>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

On Sat, 5 Jun 2004, Jeff Moyer wrote:

> 
> Yes, that looks correct to me.  I tested it with the same test case I was
> using before, and all is well.  One thing:
> 
>   mount_nfs.c: In function `get_best_mount':
>   mount_nfs.c:232: warning: implicit declaration of function `icmp_ping_host'
> 
> You forgot to #include "ping.h"!  Maybe between the two of us we'll get
> this right.  ;)

Ha! Missed that.

I'll fix it in mine and commit it.

Ian
