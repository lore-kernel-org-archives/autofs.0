From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs-4.1.1 patch] free of ap.path happens too early
 in cleanup
Date: Thu, 18 Mar 2004 23:13:24 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403182311450.4571@raven.themaw.net>
References: <16471.29962.851785.48804@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0403172217060.18212@raven.themaw.net>
 <16472.30279.850790.756677@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0403180915210.28728@wombat.indigo.net.au>
 <16473.47196.897192.145902@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16473.47196.897192.145902@segfault.boston.redhat.com>
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
Cc: autofs@linux.kernel.org

On Thu, 18 Mar 2004, Jeff Moyer wrote:

> 
> Ugh.  Turns out I was actually looking at the 4.1.0 sources.  Terribly
> sorry.
> 
> -Jeff
> 
> [from the 4.1.0 - 4.1.1 diff]
> 
> -                               cleanup_exit(ap.path, 1);
> +                               cleanup_exit(path, 1);
> 

Oh yes. That was in the changelog.

I found it printing garbage on error exit.
There's probably no point in changing then.

Ian
