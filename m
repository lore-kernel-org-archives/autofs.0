From: Jarl Stefansson <jarl@marimo.is>
Subject: Re: Unmount not working with 2.6.21  & 4.1.3/4.1.4
Date: Mon, 26 Mar 2007 16:36:56 +0000 (GMT)
Message-ID: <9573979.6871174927016112.JavaMail.root@holcus>
References: <1174918584.3667.1.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1174918584.3667.1.camel@raven.themaw.net>
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

Hi Ian,

This is a brand new box so no.

The automount app is standard gentoo 4.1.3-R7, I also tried 4.1.4 but I had issues getting it to run (with the same config as 4.1.3 it simply would not start)

I googled for two days and verified that all known issues/race conditions seem to be patched in 4.1.3-R7 so I'm at a loss as to what the problem might be.

Yours

Jarl

----- Original Message -----
From: Ian Kent <raven@themaw.net>
To: Jarl Stefansson <jarl@marimo.is>
Cc: autofs@linux.kernel.org
Sent: Monday, March 26, 2007 2:16:24 PM GMT Africa/Casablanca
Subject: Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4

On Sun, 2007-03-25 at 17:38 +0000, Jarl Stefansson wrote:
> I'm working on a custom Gentoo build and autofs seems to completely ignore all timeout/unmount attempts.
> 
> My configuration is 2.6.21-rc3-mm2 with 4.1.3-R7.
> 
> The mounting works well but devices never get unmounted, even sending SIGUSR1 or killing does not have any effect.
> There is no relevant logging to /var/log/messages even when running with debug enabled.

On second thoughts, before we go down the kernel path, maybe I should
ask a bit more about the history.

Have you had autofs up and running OK on this setup before?

Ian
