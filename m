From: raven@themaw.net
Subject: Re: automount hung
Date: Sun, 20 Mar 2005 13:26:30 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0503201325470.5127@donald.themaw.net>
References: <423B33E0.3020109@bnl.gov>
Mime-Version: 1.0
In-Reply-To: <423B33E0.3020109@bnl.gov>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Sev Binello <sev@bnl.gov>
Cc: autofs@linux.kernel.org

On Fri, 18 Mar 2005, Sev Binello wrote:

>
> Has anyone had the experience where the automount daemon seems to freeze ?
> It will not expire anything, nor mount anything new ?

More info?

distro?
autofs version?
kernel?
debug log?

>
> An strace on automount shows thats it's stuck on the following line....
>
> # strace -p 3719
> Process 3719 attached - interrupt to quit
> futex(0x24720c, FUTEX_WAIT, 2, NULL
>
>
> Tried to activate strace by accessing automatically mounted
> filesystems, but saw now activity in automount using strace.
> Also, no entry appeared in /etc/mtab.
>
>
> Thanks
> -Sev
>
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
