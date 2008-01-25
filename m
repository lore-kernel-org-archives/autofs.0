From: Ian Kent <raven@themaw.net>
Subject: Re: Transient chdir() failures: cd initially fails,
	where	ls works
Date: Fri, 25 Jan 2008 22:25:47 +0900
Message-ID: <1201267547.3040.68.camel@raven.themaw.net>
References: <920746F6DF728345915EF4D6DA610D0F04710E16@MAILSJ2.global.cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <920746F6DF728345915EF4D6DA610D0F04710E16@MAILSJ2.global.cadence.com>
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
To: Jim Dennis <jdennis@cadence.com>
Cc: autofs@linux.kernel.org


On Thu, 2008-01-24 at 15:37 -0800, Jim Dennis wrote:

>  The early automount lookup_read_master:lookup(nisplus) seems to to be something in the
>  initrd or very early in the boot process (it's not part of our configuration).

It is part of your configuration.
You have nisplus as an LDAP source, put there by another package install
no doubt, and you haven't bothered to remove it.

>  
>  The segfaults are worrisome --- and it's notable that they all occurred during the interval when I was
>  restarting autofs for reproducing the behavior here.
>  
>  I will try these tests with a fresh reboot and nscd disable.

nscd is nothing to do with autofs.

Ian
