From: jmoyer@redhat.com
Subject: Re: Unmount not working with 2.6.21  & 4.1.3/4.1.4
Date: Mon, 26 Mar 2007 15:29:18 -0400
Message-ID: <m3slbr952p.fsf@redhat.com>
References: <10913609.6901174935404793.JavaMail.root@holcus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <10913609.6901174935404793.JavaMail.root@holcus> (Jarl
	Stefansson's message of "Mon, 26 Mar 2007 18:56:44 +0000 (GMT)")
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
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4; Jarl Stefansson <jarl@marimo.is> adds:

jarl> Hey Jeff, Yes, I am 100% sure that there is nothing using the mounted
jarl> filesystems.  For debugging I have a system with just bare minimals,
jarl> kernel + glibc + base utilities so there really aren't any
jarl> applications which can interfere.

jarl> According to what I have read I should also be getting some debug
jarl> info in the log regarding the timeout period but I can't see any
jarl> mention of timeout or unmount.

  Mar 26 01:33:54 kidsq daemon.debug automount[3626]: expire_proc: 1 remaining in /mnt/auto 

This means that (in your case) the kernel thought that the mount point was
in use.  Could you humor me and up the timeout to something like 60 seconds
and see if that helps matters?

Thanks,

Jeff
