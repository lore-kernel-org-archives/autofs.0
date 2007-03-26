From: Ian Kent <raven@themaw.net>
Subject: Re: Unmount not working with 2.6.21  & 4.1.3/4.1.4
Date: Mon, 26 Mar 2007 22:16:24 +0800
Message-ID: <1174918584.3667.1.camel@raven.themaw.net>
References: <5620634.6651174844304991.JavaMail.root@holcus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <5620634.6651174844304991.JavaMail.root@holcus>
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
To: Jarl Stefansson <jarl@marimo.is>
Cc: autofs@linux.kernel.org

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
